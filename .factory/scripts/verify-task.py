#!/usr/bin/env python3
"""verify-task.py <task-id> — the mechanical checks a task must pass to become `implemented`.

Run by the implementer when it has finished, from anywhere; it works on the task's worktree,
../wt-<task-id>. It spends no tokens and asks nobody. When every check passes it sets the task
`implemented` in the main checkout, and it is the only thing that ever does.
See docs/TASK_FILE_SPEC.md §5.2.

    1  test_command exits 0
    2  every Test file named in Acceptance criteria exists               skipped on scaffolding
    3  every Test name appears, verbatim, in its Test file               skipped on scaffolding
    4  every Test file references at least one Symbol of Interfaces      skipped on scaffolding
    5  the diff touches nothing outside `files` and the module's roots   `files` alone on tooling
    6  lint_command exits 0

Exit 0 when the task is now `implemented`, 1 when a check failed, 2 when it could not run.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

sys.dont_write_bytecode = True  # nothing may appear under .factory/ that a person did not write

import factory_lib as lib  # noqa: E402


def changed_files(worktree: Path, feature: str) -> list[str]:
    """Everything the task changed against the point it was cut from: committed, staged,
    unstaged and untracked alike."""
    base = lib.git("merge-base", "HEAD", f"feat/{feature}", cwd=worktree).strip()
    tracked = lib.git("diff", "--name-only", base, cwd=worktree).splitlines()
    untracked = lib.git("ls-files", "--others", "--exclude-standard", cwd=worktree).splitlines()
    return sorted({lib.normalise(p) for p in tracked + untracked if p.strip()})


def references(text: str, symbol: str) -> bool:
    return re.search(rf"(?<![A-Za-z0-9_$]){re.escape(symbol)}(?![A-Za-z0-9_$])", text) is not None


def verify(main: Path, task: lib.Task) -> list[tuple[int, str, str]]:
    """Every check, in order, as (number, outcome, detail). Outcome is pass, FAIL or skip."""
    worktree = lib.task_worktree(main, task.id)
    facts = lib.ProjectFacts(worktree)
    scaffolding = task.meta["task_type"] == "scaffolding"
    results = []

    code = lib.run_command(facts.command("test_command"), worktree)
    results.append((1, "pass" if code == 0 else "FAIL", f"test_command exited {code}"))

    criteria = lib.parse_table(lib.section(task.body, "Acceptance criteria") or "")
    symbols = [r.get("Symbol", "") for r in lib.parse_table(lib.section(task.body, "Interfaces") or "")]
    symbols = [s for s in symbols if s and s not in ("—", "-")]
    test_files = sorted({lib.normalise(r.get("Test file", "")) for r in criteria})

    if scaffolding:
        for number in (2, 3, 4):
            results.append((number, "skip", "scaffolding task"))
    else:
        missing = [f for f in test_files if not (worktree / f).is_file()]
        if not criteria:
            results.append((2, "FAIL", "Acceptance criteria has no rows"))
        elif missing:
            results.append((2, "FAIL", "missing: " + ", ".join(missing)))
        else:
            results.append((2, "pass", f"{len(test_files)} test file(s)"))

        absent = []
        for row in criteria:
            path = worktree / lib.normalise(row.get("Test file", ""))
            name = row.get("Test name", "")
            if not path.is_file() or not name or name not in path.read_text(encoding="utf-8"):
                absent.append(f"{name!r} in {row.get('Test file', '')}")
        results.append((3, "FAIL" if absent else "pass", "; ".join(absent) or "every name found"))

        vacuous = []
        if not symbols:
            vacuous.append("Interfaces declares no symbol")
        for relative in test_files:
            path = worktree / relative
            text = path.read_text(encoding="utf-8") if path.is_file() else ""
            if not any(references(text, s) for s in symbols):
                vacuous.append(relative)
        results.append(
            (4, "FAIL" if vacuous else "pass",
             "no Interfaces symbol referenced: " + ", ".join(vacuous) if vacuous
             else "every test file references the task's interfaces")
        )

    allowed_files = {lib.normalise(f) for f in task.files}
    roots = [] if task.module == "tooling" else facts.modules.get(task.module)
    if roots is None:
        results.append((5, "FAIL", f"module `{task.module}` is not in the module map"))
    else:
        outside = [
            f for f in changed_files(worktree, task.feature)
            if f not in allowed_files and not any(lib.under(f, r) for r in roots)
        ]
        results.append(
            (5, "FAIL" if outside else "pass",
             "outside the task's bounds: " + ", ".join(outside) if outside
             else "every changed file is inside the task's bounds")
        )

    code = lib.run_command(facts.command("lint_command"), worktree)
    results.append((6, "pass" if code == 0 else "FAIL", f"lint_command exited {code}"))
    return results


def main() -> int:
    lib.require_python()
    if len(sys.argv) != 2:
        print("usage: verify-task.py <task-id>", file=sys.stderr)
        return 2
    main_dir = lib.main_checkout()
    try:
        task = lib.find_task(main_dir, sys.argv[1])
        if task.status != "in_progress":
            raise lib.FactoryError(f"{task.id} is `{task.status}`; verify-task runs on in_progress")
        if not lib.task_worktree(main_dir, task.id).is_dir():
            raise lib.FactoryError(f"no worktree at {lib.task_worktree(main_dir, task.id)}")
        results = verify(main_dir, task)
    except lib.FactoryError as error:
        print(f"verify-task: {error}", file=sys.stderr)
        return 2

    print(f"\nverify-task {task.id}")
    for number, outcome, detail in results:
        print(f"  check {number}  {outcome:<4}  {detail}")

    if any(outcome == "FAIL" for _, outcome, _ in results):
        print(f"{task.id} stays in_progress.")
        return 1
    lib.set_status(task, ("in_progress",), "implemented")
    print(f"{task.id} is now implemented. Commit the task, write your registry entry, and end.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
