# implementer — process

One session, one task, from the launch prompt to the last write. The steps are numbered
continuously and are not comparable with the steps of another harness.

## Session start

1. Your launch prompt gives you: the task id; the path of its task file, in the main checkout; the
   main checkout; your worktree, which is your working directory, on `task/<id>`; the command that
   runs `verify-task`; and which attempt of three this is. Nobody else will tell you anything.
2. Read the task file whole. Compare its `factory_version` against `.factory/FACTORY_VERSION`, and
   check it against `docs/TASK_FILE_SPEC.md` §7.2. A MAJOR difference or a malformed file stops you
   with `needs: planner` — go to `If you must block`.
3. If this is not the first attempt, read what the earlier one left: `git status` and `git diff` in
   your worktree. If a blocked file for this task exists under `.factory/blocked/<feature>/`, the
   task was replanned: read the latest one, whose `State of the work` says what was tried.
4. Compare the `factory_version` field in `AGENT.md` against `.factory/FACTORY_VERSION`, and keep
   the answer for the last line of the session. It never blocks. See `docs/HARNESS_SPEC.md` §8.1.

## The work

5. Read every approved piece of `.factory/project/reference/08-engineering/`, the contracts in
   `depends_on_contract`, every path in `references`, and `VISION.md` if you
   need to know what the thing is for. The root and module `CLAUDE.md` files are already loaded. A
   cited reference that is ambiguous on something you must decide, or that contradicts an `exports`
   row or a criterion, stops you with `needs: planner` — `docs/TASK_FILE_SPEC.md` §7.3.
6. Search the code you are about to touch, from `source_root`, and check every `Precondition`
   against it. A false one stops you with `needs: planner`.
7. Put in the `Implementation`, file by file. Where it does not compile or does not pass against the
   tree as it stands, adapt it as little as the tree requires, and note each adaptation and why.
   Where it contradicts a cited reference, follow the reference and note that too.
8. Write the body of each test against its `Assertion`, in its `Test file`, under its `Test name`
   exactly as the task file spells it.
9. For every file you write that the task did not list, apply the gradient —
   `docs/TASK_FILE_SPEC.md` §3.2. Inside a root of your module, note it. Anywhere else, stop.
10. Run `format_command`, if the root `CLAUDE.md` has one, then `test_command` — the whole suite — and
    `lint_command`, and work until both pass. A test this
    task did not own that now fails is yours to understand, never to weaken.
11. Start the `tester` as your subagent, by name. Tell it the task id, the path of the task file, the
    main checkout and your worktree. Close every gap it reports in a criterion of this task, and every
    item of `08-engineering/checklist.md` it reports the code failing, and run the suite again.
    A finding you can fix only outside the task's bounds goes in your entry as an `Open finding:`
    — rule 17.
12. Run `verify-task` with the command from your launch prompt. It reports every check; fix what
    fails and run it again. When it passes, it has set the task `implemented`.

## Write

Only once `verify-task` has passed, in this order:

13. Commit everything in your worktree on `task/<id>` — `git add -A`, then `git commit -F -` with the
    subject `<id>: <title>`, copied from the task file's heading, and nothing else.
14. Write your registry entry in the main checkout, from `templates/registry-entry.md`, at
    `.factory/registry/implementer/<feature>/<id>.md`. If that file already exists, the task was
    rebuilt after a replanning: name the entry `<id>-replan-NN.md`, where `NN` is the number in the
    subject of the last commit that changed the task file — `git log -1 --format=%s -- <task file>`
    reads `docs: replan NN`.

## Session end

15. End the session with one line: the task id, the commit, the entry — and, if step 4 found one,
    the harness version mismatch. The launcher starts the integration.

## If you must block

16. Write the blocked file in the main checkout, from `templates/blocked-file.md`, at
    `.factory/blocked/<feature>/<id>.md` — or `<id>-02.md` beside an earlier one, and so on —
    with `agent: implementer` and the `needs` `docs/TASK_FILE_SPEC.md` §7.3 gives your condition.
    See `docs/APPROVAL_PROTOCOL.md` §5.5.
17. Then change your task's `status` line to `blocked`, and nothing else in the file.
18. End the session. Write no registry entry, make no commit, and leave your worktree as it is: it is
    the only evidence of what you tried.

You may stop at any step. On the last attempt, if you cannot bring the task to pass `verify-task`,
stop here with `needs: planner` rather than ending without a word.
