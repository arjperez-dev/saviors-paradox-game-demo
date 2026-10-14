# integrator — process

One session: one task integration, or one feature close. The steps are numbered continuously and
are not comparable with the steps of another harness.

## Session start

1. Your launch prompt says which session this is, and gives you: the feature; the main checkout; the
   feature's integration worktree, which is your working directory, on `feat/<feature>`. For a task
   integration, also the task id, the path of its task file, and the task's worktree. You hold the
   feature's lock for the whole session.
2. Compare the `factory_version` field in `AGENT.md` against `.factory/FACTORY_VERSION`, and keep the
   answer for the last line of the session. It never blocks. See `docs/HARNESS_SPEC.md` §8.1.

**A task integration is steps 3 to 16; a feature close is steps 17 to 20.**

## The work — a task integration

3. Read the task file whole, in the main checkout. Check its `factory_version` and its form —
   `docs/TASK_FILE_SPEC.md` §7.1–§7.2 — and that its status is `implemented`. If not, stop.
4. Read the implementer's registry entry for the task, `.factory/registry/implementer/<feature>/`
   — `<id>.md`, or the latest `<id>-replan-NN.md`. Its decisions and deviations are the *why* of your
   message.
5. Run `git status --porcelain` in the integration worktree. It must print nothing. If it prints
   anything, stop before merging: list the paths in the blocked file, and commit, stage, stash or
   discard none of them.
6. `git merge --no-ff --no-commit task/<id>`. A conflict is a stop.
7. Apply the task's `shared_file_notes`, one at a time, exactly as each `instruction` says, then stage
   that note's `file` by path — `git add -- <file>`. A note that cannot be applied as written is a
   stop.
8. If the merge or a note changed the package manifest, run `install_command`, and stage by path each
   file it rewrote. A failure is a stop.
9. Run `test_command` — the whole suite, not the task's tests. A failure is a stop. Keep the command
   and its summary line for your entry.
10. Run `git diff --name-only`. It must print nothing: a path it prints is a change your commit would
    leave out. If it prints a note's `file`, stage it by path and run it again; any other path is a
    stop.
11. Write the message from `templates/commit-message.md` — `docs/GIT_CONVENTIONS.md` §3.2 — and commit
    the merge with `git commit -F -`.
12. Check the commit, in the integration worktree: `git status --porcelain` prints nothing, and
    `git show --stat HEAD` lists every `file` of the task's `shared_file_notes`. Keep both results
    for your entry. If either fails, go to step 22.

## Write — a task integration

13. Your registry entry, in the main checkout, from `templates/registry-entry.md`, at
    `.factory/registry/integrator/<feature>/<id>.md`.
14. `git worktree remove ../wt-<id>`, then `git branch -d task/<id>`.

## Session end — a task integration

15. End with one line: the task id, the merge commit — and, if step 2 found one, the harness version
    mismatch.
16. The integration script now checks your merge commit as step 12 did and sets the task
    `integrated`. You do not.

## The work — a feature close

17. Read the feature's history: `git log --merges --first-parent feat/<feature>` for each merge
    commit's type, subject and `Task:` footer, and the task commits' subjects for each task's title.
    List the names of `.factory/manual-tests/<feature>/`, without opening them. Run `test_command`
    once for the summary line.
18. Write the pull request body from `templates/pr-body.md` — `docs/GIT_CONVENTIONS.md` §5.3 — and
    its title, `<feature>: <summary>`, one line saying what the feature delivers — §5.2.

## Write — a feature close

19. `.factory/registry/integrator/<feature>/pr.md`, from `templates/pr-entry.md`, in the main
    checkout. If `pr.md` exists — a bug was integrated after it — write `pr-02.md` beside it, and so
    on, never over it.

## Session end — a feature close

20. End with one line: the feature and the path of the body.

## If you must block

21. A task integration stops at the first failure of steps 3 to 10. If a merge is in progress — steps
    6 to 10 — run `git merge --abort`, so that `feat/<feature>` is exactly as it was.
22. If the check of step 12 fails, the merge commit is already on `feat/<feature>`: leave it, and the
    worktree, as they are — never amend, reset or commit again.
23. Write the blocked file in the main checkout, from `templates/blocked-file.md`, at
    `.factory/blocked/<feature>/<id>.md` — or `<id>-02.md` beside an earlier one — with
    `agent: integrator` and `needs: planner`. On step 5 or step 12, list the paths
    `git status --porcelain` printed and, on step 12, the note files `git show --stat HEAD` lacks.
    See `docs/APPROVAL_PROTOCOL.md` §5.5 and `docs/TASK_FILE_SPEC.md` §7.3.
24. Then change the task's `status` line to `blocked`, and nothing else in the file.
25. End the session. Write no registry entry, and leave the task's branch and worktree as they are.

A feature close that cannot be written — a history that does not match the plan — writes no body and
ends with one line saying why. It blocks no task.
