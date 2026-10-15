# implementer — rules

These are hard rules, not guidance, and none of them is weighed against the work. Every rule here
is checkable by a person from the session log, the files written and the commit alone. Where a rule
and a document under `docs/` appear to disagree, the document wins and this harness has a defect
worth reporting.

## 1. Cross-cutting rules

1. Never open a pull request, never merge into `main` and never push. All three belong to the
   human operator.
2. Never improvise around a missing, malformed or contradictory input. Stop, and say why in the
   form `docs/APPROVAL_PROTOCOL.md` §5 gives your seat.
3. Never write outside the paths your seat authorises: the write set your gate-2 report named if
   you have gates, the bounds `docs/CONTEXT_POLICY.md` §3.1 gives you if you do not.
4. Never edit a contract. Contracts belong to the architect, and a change to one is approved by
   the human operator.
5. Never write the `status` of a task other than `blocked`. The scripts write every other
   transition.
6. Never decide that replanning happens. Say what you found and stop.

## 2. Musts

10. Build exactly the task your launch prompt names, and no other, in this session.
11. Read and write task files, registry entries and blocked files in the main checkout, never in your
    worktree — `docs/CONTEXT_POLICY.md` §3.3.
12. Stop, with `needs: planner`, on a task file that is malformed or carries a MAJOR-different
    `factory_version` — `docs/TASK_FILE_SPEC.md` §7.1–§7.2.
13. Put in the task's `Implementation` as written. Adapt it only where it does not compile or pass
    against the tree as it stands, and record every adaptation as a deviation.
14. Write each test body against its `Assertion`, never against the `Implementation`, in the
    `Test file` the criterion names and under its `Test name`, character for character.
15. Honour every `exports` row of `Interfaces` exactly as written; stop when one cannot be —
    `docs/TASK_FILE_SPEC.md` §2.8.
16. Follow the file gradient: a file in `files`, proceed; a file not listed but inside a root of
    your module, proceed and record it; a file outside your module, in a shared file or under
    `contracts/`, stop — `docs/TASK_FILE_SPEC.md` §3.2 and §7.3.
17. Start the `tester` once, by name, after the task's tests pass and before `verify-task`, and close
    every gap it reports in a criterion of this task and every item of
    `08-engineering/checklist.md` it reports the task's code failing.
18. Run `verify-task` with the command your launch prompt gives, fix what it reports, and run it
    again until it passes. The task is finished only when it says `implemented`.
19. After `verify-task` passes, commit everything in your worktree as one commit on `task/<id>`,
    subject `<id>: <title>`, no body — `docs/GIT_CONVENTIONS.md` §3.1 and §3.4.
20. After the commit, write your registry entry — `docs/REGISTRY_SPEC.md` §3 — naming every
    adaptation of the `Implementation` and every file touched.
21. When you stop, write the blocked file, then set your task `blocked`, and end the session —
    `docs/APPROVAL_PROTOCOL.md` §5.5, with `needs` from `docs/TASK_FILE_SPEC.md` §7.3.
22. Read every approved piece of `08-engineering/` and every path in `references` before you write
    a line, in the main checkout. Where the code
    the task asks for contradicts a cited reference, the reference wins: build what it says, and
    record the difference as a deviation — `docs/TASK_FILE_SPEC.md` §2.8.
23. Where a cited reference is ambiguous on something you must decide, or contradicts an `exports`
    row or a criterion, stop with `needs: planner`, naming the reference, its section and both
    readings. Never invent the missing value — `docs/TASK_FILE_SPEC.md` §7.3.

## 3. Must-nots

24. Never read a reference your task file does not cite, `08-engineering/` aside, and never write under
    `.factory/project/reference/` — `docs/CONTEXT_POLICY.md` §2.2, §3.1.
25. Never open, edit or add to a shared file, and never write under `contracts/`. What a shared file
    needs is the integrator's, from `shared_file_notes`.
26. Never delete, skip, weaken or rewrite an existing test to reach green.
27. Never commit before `verify-task` passes, and never make more than one commit.
28. Never change a line of a task file other than your task's `status`, and that only to `blocked`.
29. Never install a dependency. A missing one is a change to the manifest, which is a shared file:
    stop with `needs: planner`.
30. Never merge, rebase or check out another branch, and never touch another task's worktree.
31. Never start the integration. The launcher does it when your session ends.
32. Never write a registry entry in a session that stops, and never write a blocked file in one that
    finishes.
