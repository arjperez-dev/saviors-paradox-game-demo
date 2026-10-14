#!/usr/bin/env python3
"""launch.py [--max N] — keep up to N implementers running until nothing is left to start.

Run by the human operator, in the main checkout, on `main`. For each task the dispatcher says is
ready, the launcher:

  1. cuts feat/<feature> from main in ../wt-feat-<feature>, if it does not exist yet, and runs
     install_command in it;
  2. cuts task/<id> from feat/<feature> in ../wt-<id>, and runs install_command in it;
  3. sets the task `in_progress`;
  4. starts an implementer session, non-interactively, with the tester defined as its subagent;
  5. when the session ends with the task `implemented`, starts the integration (integrate.py).

A session that ends with the task still `in_progress` is a failed attempt. Two attempts run on
Sonnet 5 and the third on Opus 5.5, in the same worktree; when the third fails too, the launcher
writes the blocked file itself, with `needs: planner`. Every slot that frees is refilled from the
dispatcher, so a task whose dependency has just integrated starts without anybody re-running this.

No feature branch other than feat/tooling is cut while a `tooling` task has not reached `main`.
No step is ever retried within one run: a task that could not start is reported and left alone.
See docs/GIT_CONVENTIONS.md §1 and docs/TASK_FILE_SPEC.md §5.

Sessions log to ../logs/<id>-attempt-<n>.log and ../logs/<id>-integration.log.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import threading
from concurrent.futures import FIRST_COMPLETED, ThreadPoolExecutor, wait
from pathlib import Path

sys.dont_write_bytecode = True  # nothing may appear under .factory/ that a person did not write

import factory_lib as lib  # noqa: E402
from dispatch import ready  # noqa: E402

ATTEMPTS = (lib.SONNET, lib.SONNET, lib.OPUS)

IMPLEMENTER_TOOLS = ["Read", "Edit", "Write", "Glob", "Grep", "Bash", "Agent"]
TESTER_TOOLS = ["Read", "Edit", "Write", "Glob", "Grep", "Bash"]

IMPLEMENTER_PROMPT = """\
You are the implementer. Read AGENT.md, RULES.md, PROCESS.md and CONTEXT.md, in that order, under \
{main}/.factory/harnesses/implementer/. Operate under them for this session and follow PROCESS.md \
from step 1.

Your task is {task_id}. Its task file is {task_file}. The main checkout is {main}. Your worktree, \
and your working directory, is {worktree}, on the branch task/{task_id}. Run verify-task with:
{python} {main}/.factory/scripts/verify-task.py {task_id}

This is attempt {attempt} of 3.{earlier}\
"""

EARLIER_ATTEMPT = """ An earlier attempt ended without the task passing verify-task, and its work \
is still in this worktree: read it with git status and git diff before you continue."""

LAST_ATTEMPT = """ It is the last attempt, on Opus 5.5: if you cannot bring the task to pass \
verify-task, write a blocked file with `needs: planner` before you end."""

TESTER_DESCRIPTION = (
    "The tester. Use it once per task, after the task's tests pass and before verify-task: it "
    "reports what the automated tests cover and what they do not, and writes the task's manual "
    "test when the task file has a Manual check."
)

TESTER_PROMPT = """\
You are the tester. Read AGENT.md, RULES.md, PROCESS.md and CONTEXT.md, in that order, under \
{main}/.factory/harnesses/tester/. Operate under them and follow PROCESS.md from step 1. The \
implementer that started you names the task; the main checkout is {main}.\
"""


class Launcher:
    def __init__(self, main: Path, slots: int):
        self.main = main
        self.slots = slots
        self.facts = lib.ProjectFacts(main)
        # One `git worktree add` at a time: concurrent ones in the same repository race on
        # its config and ref locks.
        self.git_guard = threading.Lock()
        self.outcomes: dict[str, str] = {}
        self.waiting_for_tooling: set[str] = set()

    # ---- worktrees -----------------------------------------------------------------------------

    def install(self, worktree: Path, name: str) -> None:
        log = lib.logs_dir(self.main) / f"{name}-install.log"
        code = lib.run_command(self.facts.command("install_command"), worktree, log)
        if code != 0:
            raise lib.FactoryError(f"install_command exited {code} in {worktree}; see {log}")

    def feature_worktree(self, feature: str) -> None:
        worktree = lib.feature_worktree(self.main, feature)
        with self.git_guard:
            if worktree.is_dir():
                return
            if lib.branch_exists(self.main, f"feat/{feature}"):
                lib.git("worktree", "add", str(worktree), f"feat/{feature}", cwd=self.main)
            else:
                lib.git("worktree", "add", str(worktree), "-b", f"feat/{feature}", "main", cwd=self.main)
            if feature != "tooling":
                self.install(worktree, f"feat-{feature}")

    def task_worktree(self, task: lib.Task) -> None:
        worktree = lib.task_worktree(self.main, task.id)
        with self.git_guard:
            if worktree.is_dir():
                return
            if lib.branch_exists(self.main, f"task/{task.id}"):
                lib.git("worktree", "add", str(worktree), f"task/{task.id}", cwd=self.main)
            else:
                lib.git(
                    "worktree", "add", str(worktree), "-b", f"task/{task.id}",
                    f"feat/{task.feature}", cwd=self.main,
                )

    # ---- sessions ------------------------------------------------------------------------------

    def implementer(self, task: lib.Task, attempt: int, model: str) -> None:
        worktree = lib.task_worktree(self.main, task.id)
        earlier = EARLIER_ATTEMPT if attempt > 1 else ""
        if attempt == len(ATTEMPTS):
            earlier += LAST_ATTEMPT
        prompt = IMPLEMENTER_PROMPT.format(
            main=self.main, task_id=task.id, task_file=task.path, worktree=worktree,
            python=sys.executable, attempt=attempt, earlier=earlier,
        )
        agents = {
            "tester": {
                "description": TESTER_DESCRIPTION,
                "prompt": TESTER_PROMPT.format(main=self.main),
                "model": "sonnet",
                "tools": TESTER_TOOLS,
            }
        }
        command = [
            *lib.claude_command(),
            "-p", prompt,
            "--model", model,
            "--add-dir", str(self.main),
            "--agents", json.dumps(agents),
            "--allowedTools", *IMPLEMENTER_TOOLS,
            "--disallowedTools", *lib.DISALLOWED_TOOLS,
        ]
        env = {**os.environ, "MAIN": str(self.main), "TASK": task.id}
        log = lib.logs_dir(self.main) / f"{task.id}-attempt-{attempt}.log"
        with log.open("a", encoding="utf-8") as out:
            subprocess.run(
                command, cwd=worktree, env=env, stdout=out, stderr=out, stdin=subprocess.DEVNULL
            )

    def block(self, task: lib.Task, expected: tuple[str, ...], because: str, needs_text: str) -> str:
        worktree = lib.task_worktree(self.main, task.id)
        state = "nothing"
        if worktree.is_dir():
            status = lib.git("status", "--short", cwd=worktree, check=False).strip()
            commits = lib.git(
                "rev-list", "--count", f"feat/{task.feature}..task/{task.id}", cwd=self.main,
                check=False,
            ).strip()
            state = (
                f"The worktree {worktree} is kept. Uncommitted changes:\n\n"
                f"```text\n{status or '(none)'}\n```\n\n"
                f"Commits on task/{task.id} not on feat/{task.feature}: {commits or 'unknown'}."
            )
        path = lib.write_blocked(
            self.main, task, agent="launcher", needs="planner",
            asked_to=f"Implement and integrate {task.id} — {task.title}.",
            because=because, needs_text=needs_text, state=state,
        )
        lib.set_status(task, expected, "blocked")
        return f"blocked by the launcher: {path.relative_to(self.main).as_posix()}"

    # ---- one task ------------------------------------------------------------------------------

    def work(self, task_id: str) -> str:
        task = lib.find_task(self.main, task_id)
        self.feature_worktree(task.feature)
        self.task_worktree(task)
        lib.set_status(task, ("pending",), "in_progress")

        if task.feature != "tooling":
            try:
                self.install(lib.task_worktree(self.main, task.id), task.id)
            except lib.FactoryError as error:
                return self.block(
                    task, ("in_progress",), f"The launcher could not install dependencies: {error}",
                    "The install fixed — the manifest, the lockfile or the network — and the task "
                    "returned to pending.",
                )

        for attempt, model in enumerate(ATTEMPTS, start=1):
            self.implementer(task, attempt, model)
            task = lib.find_task(self.main, task_id)
            if task.status == "blocked":
                return "blocked by the implementer"
            if task.status == "implemented":
                break
            if task.status != "in_progress":
                return f"left {task.status} by its session; nothing more was done"
        else:
            logs = ", ".join(f"../logs/{task.id}-attempt-{n}.log" for n in range(1, 4))
            return self.block(
                task, ("in_progress",),
                "Three implementer sessions — two on Sonnet 5, one on Opus 5.5 — ended without the "
                f"task passing verify-task and without a blocked file. Their logs: {logs}.",
                "A replanning of the task: the task file asks for something three sessions could "
                "not deliver, and the logs say where each one stopped.",
            )

        integration = subprocess.run(
            [sys.executable, str(Path(__file__).with_name("integrate.py")), task.id],
            cwd=self.main, capture_output=True, text=True, encoding="utf-8",
        )
        if integration.returncode == 0:
            return "integrated"
        if integration.returncode == 4:
            return "blocked by the integrator"
        reason = integration.stderr.strip() or f"integrate.py exited {integration.returncode}"
        if integration.returncode == 3:
            return self.block(
                lib.find_task(self.main, task_id), ("implemented",),
                f"The integration did not happen: {reason}",
                "A replanning of the task, or the missing step done by hand and "
                f"`integrate.py {task.id}` run again.",
            )
        return f"implemented, not integrated — {reason}. Run integrate.py {task.id} by hand."

    # ---- the loop ------------------------------------------------------------------------------

    def tooling_on_main(self, plan: dict[str, lib.Task]) -> bool:
        tooling = [t for t in plan.values() if t.feature == "tooling"]
        return all(lib.integrated_on(self.main, "main", t.id) for t in tooling)

    def startable(self, task: lib.Task, tooling_done: bool) -> bool:
        if task.feature == "tooling" or tooling_done:
            return True
        if lib.branch_exists(self.main, f"feat/{task.feature}"):
            return True
        self.waiting_for_tooling.add(task.id)
        return False

    def run(self) -> None:
        running = {}
        attempted: set[str] = set()
        with ThreadPoolExecutor(max_workers=self.slots) as pool:
            while True:
                plan = lib.load_plan(self.main)
                tooling_done = self.tooling_on_main(plan)
                for task in ready(plan):
                    if len(running) >= self.slots:
                        break
                    if task.id in attempted or not self.startable(task, tooling_done):
                        continue
                    attempted.add(task.id)
                    self.waiting_for_tooling.discard(task.id)
                    print(f"launch: starting {task.id} — {task.title}", flush=True)
                    running[task.id] = pool.submit(self.work, task.id)
                if not running:
                    return
                wait(running.values(), return_when=FIRST_COMPLETED)
                for task_id, future in list(running.items()):
                    if not future.done():
                        continue
                    try:
                        outcome = future.result()
                    except lib.FactoryError as error:
                        outcome = f"not started — {error}"
                    self.outcomes[task_id] = outcome
                    print(f"launch: {task_id} {outcome}", flush=True)
                    del running[task_id]

    def summary(self) -> None:
        print("\nlaunch: nothing left to start.")
        for task_id in sorted(self.outcomes):
            print(f"  {task_id}  {self.outcomes[task_id]}")
        if self.waiting_for_tooling:
            waiting = ", ".join(sorted(self.waiting_for_tooling))
            print(f"  waiting for feature tooling to reach main: {waiting}")
        if not self.outcomes and not self.waiting_for_tooling:
            print("  no task was ready.")


def main() -> int:
    lib.require_python()
    parser = argparse.ArgumentParser(description="Run implementers on every ready task.")
    parser.add_argument("--max", type=int, default=3, help="implementers at once (default 3)")
    args = parser.parse_args()
    if args.max < 1:
        parser.error("--max must be at least 1")

    main_dir = lib.main_checkout()
    single = lib.Lock(main_dir, "_launcher")
    if not single.acquire(wait=False):
        print("launch: another launcher is already running in this repository.", file=sys.stderr)
        return 1
    try:
        branch = lib.git("rev-parse", "--abbrev-ref", "HEAD", cwd=main_dir).strip()
        if branch != "main":
            raise lib.FactoryError(f"the main checkout is on `{branch}`; the launcher runs on main")
        launcher = Launcher(main_dir, args.max)
        launcher.run()
        launcher.summary()
        return 0
    except lib.FactoryError as error:
        print(f"launch: {error}", file=sys.stderr)
        return 1
    finally:
        single.release()


if __name__ == "__main__":
    sys.exit(main())
