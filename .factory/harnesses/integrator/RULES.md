# integrator — rules

These are hard rules, not guidance, and none of them is weighed against the work. Every rule here
is checkable by a person from the session log, the files written and the commits alone. Where a
rule and a document under `docs/` appear to disagree, the document wins and this harness has a
defect worth reporting.

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

10. Integrate exactly the task, or close exactly the feature, your launch prompt names.
11. Before a task integration, check its task file — `docs/TASK_FILE_SPEC.md` §7.1–§7.2 — and that
    its status is `implemented`. Anything else is a stop.
12. Integrate in the order of `docs/GIT_CONVENTIONS.md` §3.3: merge with `--no-ff --no-commit`,
    apply the notes and stage each by path, install if the manifest changed, run the suite, check
    nothing is left unstaged, commit, check the commit.
13. Apply each `shared_file_notes` entry exactly as its `instruction` says, one by one, stage its
    `file` by path, and change nothing else in a shared file.
14. Run `install_command` in the integration worktree when, and only when, the merge or a note
    changed the package manifest.
15. Run `format_command`, if there is one, then `test_command` — the whole suite — and `lint_command`
    after the notes, and commit only if both pass.
16. Write the merge message by `docs/GIT_CONVENTIONS.md` §3.2: the type its table gives, the module
    as scope, an imperative subject of at most 72 characters with no `and`, a body saying what
    changed and why — the why taken from the implementer's registry entry — and the one footer
    `Task: <id>`. Pass it whole with `git commit -F -` — §3.4.
17. When the merge, a note, the install, the suite or the check for unstaged changes fails:
    `git merge --abort`, write the blocked file with `needs: planner`, set the task `blocked`, and
    end — `docs/GIT_CONVENTIONS.md` §3.3. Leave the task's branch and worktree as they are.
18. After the commit, check it — `git status --porcelain` prints nothing, and `git show --stat HEAD`
    lists every `file` of the task's `shared_file_notes` — and only then write your registry entry,
    remove the task's worktree and delete its branch. If the check fails, write the blocked file
    with `needs: planner`, set the task `blocked`, and leave the commit, the worktree and the task's
    branch as they are — `docs/GIT_CONVENTIONS.md` §3.3.
19. In a feature close, write the pull request body by `docs/GIT_CONVENTIONS.md` §5.3, with its title
    line, into `pr.md` — or `pr-02.md` beside an earlier one, never over it.

## 3. Must-nots

20. Never set a task `integrated`. The integration script writes it, from your merge commit.
21. Never change a file of the game other than what the merge brings and the shared files the notes
    name. A failing test is a stop, never something you fix.
22. Never commit a merge whose suite failed, never squash, never rebase, never amend.
23. Never take a convention from the history. Earlier merge messages are not the rule;
    `docs/GIT_CONVENTIONS.md` is.
24. Never put in a message or a body the journey — attempts, escalation, what failed first — a
    status, or the task file's instructions restated.
25. Never read another agent's registry but the implementer's entry for the task you integrate, and
    never the contents of a manual test.
26. Never write under `.factory/` in a worktree. Your factory writes go to the main checkout.
27. Never stage with `git add -A`, `git add .`, `git add -u` or `git commit -a`. Stage by path exactly
    the files the notes name and those `install_command` rewrote.
28. Never merge into an integration worktree where `git status --porcelain` prints anything, and
    never commit, stage, stash or discard what you find there. It belongs to no task: list it in a
    blocked file.
29. Never record a note as applied unless `git show --stat HEAD` lists its `file`.
