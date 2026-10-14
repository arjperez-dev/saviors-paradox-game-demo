#!/usr/bin/env python3
"""dispatch.py — which tasks can start now.

A task is ready when its status is `pending` and every task in its `depends_on_task` is
`integrated`. `priority: high` comes first, then the id. That is the whole of scheduling: the
dispatcher does not look at `wave`, does not compare `files`, and does not validate the plan.
See docs/TASK_FILE_SPEC.md §4.2.

    python .factory/scripts/dispatch.py            the ready tasks, one line each, with their titles
    python .factory/scripts/dispatch.py --ids      the ready ids alone, for scripts
    python .factory/scripts/dispatch.py --status   every task of the plan, grouped by status
"""

from __future__ import annotations

import argparse
import sys

sys.dont_write_bytecode = True  # nothing may appear under .factory/ that a person did not write

import factory_lib as lib  # noqa: E402


def ready(plan: dict[str, lib.Task]) -> list[lib.Task]:
    def satisfied(task: lib.Task) -> bool:
        return all(
            dep in plan and plan[dep].status == "integrated" for dep in task.depends_on_task
        )

    found = [t for t in plan.values() if t.status == "pending" and satisfied(t)]
    return sorted(found, key=lambda t: (t.priority != "high", t.id))


def main() -> int:
    lib.require_python()
    parser = argparse.ArgumentParser(description="List the tasks that can start now.")
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--ids", action="store_true", help="print the ready ids alone")
    group.add_argument("--status", action="store_true", help="print the whole plan by status")
    args = parser.parse_args()

    try:
        plan = lib.load_plan(lib.main_checkout())
    except lib.FactoryError as error:
        print(f"dispatch: {error}", file=sys.stderr)
        return 1

    if args.status:
        for status in lib.STATUSES:
            tasks = sorted((t for t in plan.values() if t.status == status), key=lambda t: t.id)
            print(f"{status} ({len(tasks)})")
            for task in tasks:
                print(f"  {task.id}  {task.feature:<20}  {task.title}")
        return 0

    for task in ready(plan):
        print(task.id if args.ids else f"{task.id}  {task.feature:<20}  {task.title}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
