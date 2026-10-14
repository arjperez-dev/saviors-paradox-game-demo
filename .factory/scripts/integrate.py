#!/usr/bin/env python3
"""integrate.py — start the integrator, under the feature's lock.

    python .factory/scripts/integrate.py <task-id>          integrate one implemented task
    python .factory/scripts/integrate.py --feature <slug>   write the feature's pull request body

The launcher runs the first form as soon as an implementer session ends with its task
`implemented`; a person may run either by hand. Integrations into one feature are serialised by
the lock at .factory/locks/<feature>.lock, and two features integrate in parallel.
See docs/GIT_CONVENTIONS.md §3.3 and §4.

The script does not start the integrator while the feature's integration worktree has anything
uncommitted: it belongs to no task, and the script neither commits nor discards it. After the
integrator's session the script checks, mechanically, that `feat/<feature>` holds a merge commit
carrying `Task: <task-id>`, that the commit changes every file of the task's shared_file_notes, and
that the integration worktree has nothing left uncommitted, and only then sets the task
`integrated`: a success status is written by a script, never by an agent. When that makes every
task of the feature `integrated`, it starts one more integrator session, under the same lock, to
write the pull request body.

Exit codes, which the launcher reads:
    0  integrated
    1  could not run — nothing was changed
    3  not integrated, and nobody wrote a blocked file; the reason is on stderr
    4  the integrator stopped and wrote a blocked file
"""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

sys.dont_write_bytecode = True  # nothing may appear under .factory/ that a person did not write

import factory_lib as lib  # noqa: E402

INTEGRATOR_TOOLS = ["Read", "Edit", "Write", "Glob", "Grep", "Bash"]

INTEGRATOR_PROMPT = """\
You are the integrator. Read AGENT.md, RULES.md, PROCESS.md and CONTEXT.md, in that order, under \
{main}/.factory/harnesses/integrator/. Operate under them for this session and follow PROCESS.md \
from step 1.

{session}

The main checkout is {main}. The feature's integration worktree, and your working directory, is \
{feature_worktree}. You hold the lock of feature {feature} for the whole of this session.\
"""

TASK_SESSION = """\
This is a task integration. Integrate task {task_id} of feature {feature} into feat/{feature}. \
Its task file is {task_file}. Its branch is task/{task_id}, checked out in {task_worktree}.\
"""

FEATURE_SESSION = """\
This is a feature close. Every task of feature {feature} is integrated into feat/{feature}. \
Write the feature's pull request body.\
"""


class NotIntegrated(Exception):
    pass


def run_session(main: Path, feature: str, session: str, log_name: str) -> int:
    worktree = lib.feature_worktree(main, feature)
    prompt = INTEGRATOR_PROMPT.format(
        main=main, session=session, feature_worktree=worktree, feature=feature
    )
    command = [
        *lib.claude_command(),
        "-p", prompt,
        "--model", lib.SONNET,
        "--add-dir", str(main),
        "--allowedTools", *INTEGRATOR_TOOLS,
        "--disallowedTools", *lib.DISALLOWED_TOOLS,
    ]
    log = lib.logs_dir(main) / log_name
    with log.open("a", encoding="utf-8") as out:
        return subprocess.run(
            command, cwd=worktree, stdout=out, stderr=out, stdin=subprocess.DEVNULL
        ).returncode


def implementer_entry_exists(main: Path, task: lib.Task) -> bool:
    folder = main / ".factory" / "registry" / "implementer" / task.feature
    return (folder / f"{task.id}.md").is_file() or any(folder.glob(f"{task.id}-replan-*.md"))


def uncommitted(worktree: Path) -> list[str]:
    """The paths `git status --porcelain` lists in a worktree, untracked files included."""
    return [line[3:] for line in lib.git("status", "--porcelain", cwd=worktree).splitlines() if line]


def left_out_of_merge(main: Path, task: lib.Task) -> list[str]:
    """What the task's merge commit should hold and does not: anything left uncommitted in the
    integration worktree, and every shared_file_notes file the merge did not change."""
    missing = [f"uncommitted {path}" for path in uncommitted(lib.feature_worktree(main, task.feature))]
    merge = lib.git(
        "log", f"feat/{task.feature}", "--merges", "-1", "--format=%H", f"--grep=^Task: {task.id}$",
        cwd=main,
    ).strip()
    changed = set(lib.git("diff", "--name-only", f"{merge}^1", merge, cwd=main).splitlines())
    for note in task.meta.get("shared_file_notes") or []:
        file = lib.normalise(note.get("file", "")) if isinstance(note, dict) else ""
        if file not in changed:
            missing.append(f"{file or 'a note with no file'} not in {merge[:7]}")
    return missing


def ready_to_integrate(main: Path, task: lib.Task) -> None:
    """The facts the integrator is entitled to assume, checked before it is started."""
    if task.status != "implemented":
        raise lib.FactoryError(f"{task.id} is `{task.status}`; only an implemented task integrates")
    worktree = lib.feature_worktree(main, task.feature)
    if not worktree.is_dir():
        raise lib.FactoryError(f"no integration worktree at {worktree}")
    dirty = uncommitted(worktree)
    if dirty:
        raise lib.FactoryError(
            f"{worktree} has uncommitted changes that belong to no task: {', '.join(dirty)}. "
            f"Commit or discard them by hand, then run integrate.py {task.id} again"
        )
    if not lib.branch_exists(main, f"task/{task.id}"):
        raise NotIntegrated(f"the branch task/{task.id} does not exist")
    ahead = lib.git("rev-list", "--count", f"feat/{task.feature}..task/{task.id}", cwd=main).strip()
    if ahead == "0":
        raise NotIntegrated(f"task/{task.id} has no commit: the implementer never committed the task")
    if not implementer_entry_exists(main, task):
        raise NotIntegrated(f"the implementer wrote no registry entry for {task.id}")


def feature_complete(main: Path, feature: str) -> bool:
    tasks = [t for t in lib.load_plan(main).values() if t.feature == feature]
    return bool(tasks) and all(t.status == "integrated" for t in tasks)


def close_feature(main: Path, feature: str) -> int:
    session = FEATURE_SESSION.format(feature=feature)
    code = run_session(main, feature, session, f"{feature}-pr.log")
    print(f"integrate: the pull request session of {feature} ended with exit code {code}")
    return 0 if code == 0 else 1


def integrate(main: Path, task_id: str) -> int:
    task = lib.find_task(main, task_id)
    with lib.Lock(main, task.feature):
        task = lib.find_task(main, task_id)
        ready_to_integrate(main, task)
        session = TASK_SESSION.format(
            task_id=task.id,
            feature=task.feature,
            task_file=task.path,
            task_worktree=lib.task_worktree(main, task.id),
        )
        run_session(main, task.feature, session, f"{task.id}-integration.log")

        task = lib.find_task(main, task_id)
        if task.status == "blocked":
            print(f"integrate: the integrator stopped on {task.id}; see .factory/blocked/{task.feature}/")
            return 4
        if not lib.integrated_on(main, f"feat/{task.feature}", task.id):
            raise NotIntegrated(
                f"the integrator's session ended without a merge commit carrying `Task: {task.id}` "
                f"on feat/{task.feature}, and without a blocked file"
            )
        left_out = left_out_of_merge(main, task)
        if left_out:
            raise NotIntegrated(
                f"the merge commit of {task.id} on feat/{task.feature} leaves part of the "
                f"integration out: {'; '.join(left_out)}"
            )
        lib.set_status(task, ("implemented",), "integrated")
        print(f"integrate: {task.id} is integrated into feat/{task.feature}")

        if feature_complete(main, task.feature):
            close_feature(main, task.feature)
    return 0


def main() -> int:
    lib.require_python()
    parser = argparse.ArgumentParser(description="Start the integrator under the feature's lock.")
    parser.add_argument("task_id", nargs="?", help="the implemented task to integrate")
    parser.add_argument("--feature", help="write this feature's pull request body instead")
    args = parser.parse_args()
    if bool(args.task_id) == bool(args.feature):
        parser.error("give a task id, or --feature <slug>, and not both")

    main_dir = lib.main_checkout()
    try:
        if args.feature:
            if not feature_complete(main_dir, args.feature):
                raise lib.FactoryError(f"not every task of {args.feature} is integrated")
            with lib.Lock(main_dir, args.feature):
                return close_feature(main_dir, args.feature)
        return integrate(main_dir, args.task_id)
    except NotIntegrated as reason:
        print(f"integrate: {reason}", file=sys.stderr)
        return 3
    except (lib.FactoryError, json.JSONDecodeError) as error:
        print(f"integrate: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
