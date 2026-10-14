# integrator — output

A task integration that succeeds writes the merge commit, checks it, then writes your registry entry,
then removes the task's worktree. One that stops writes the blocked file and the status, and nothing
else. A feature close writes one file.

## The write set

| Path | Artefact | Template | Written when |
|---|---|---|---|
| the shared files the task's `shared_file_notes` name | the entries the task needs | none | inside the merge, staged by path, in the integration worktree |
| the merge commit on `feat/<feature>` | the task's Conventional message | `templates/commit-message.md` | once the suite passes |
| `.factory/registry/integrator/<feature>/<id>.md` | your registry entry for the task | `templates/registry-entry.md` | after the commit, once its check passes |
| `.factory/registry/integrator/<feature>/pr.md` | the pull request title and body | `templates/pr-entry.md`, holding `templates/pr-body.md` | feature close; `pr-02.md` beside an earlier one |
| `.factory/blocked/<feature>/<id>.md` | a blocked file | `templates/blocked-file.md` | when an integration stops; `<id>-02.md` beside an earlier one |
| `.factory/tasks/<feature>/<id>.md`, its `status` line | `blocked` | none | when an integration stops, after the blocked file |

## Frontmatter

- **Registry entries, `pr.md` included**: `factory_version` alone — `docs/REGISTRY_SPEC.md` §2.4.
- **The blocked file**: `task_id`, `needs: planner`, `agent: integrator`, `factory_version`,
  `created` — `docs/APPROVAL_PROTOCOL.md` §5.5.

## Body structure

- **The merge message**: `<type>[(<scope>)]: <subject>`, a blank line, the body wrapped at 72
  columns, a blank line, `Task: <id>` — `docs/GIT_CONVENTIONS.md` §3.2. The type from its table:
  `feat` for an implementation task, `fix` for a bug, `build` for a `tooling` task, `test` for a task
  that only adds tests.
- **The task entry**: the heading `# <id> — <title>`, then the five fields, at most fifteen lines.
  `Evidence` holds the suite command and its summary line, which notes you applied, and the check of
  the commit: `git status --porcelain` empty, and the note files `git show --stat HEAD` lists.
- **`pr.md`**: `# PR — <feature>`, the five fields, `Outcome` holding the pull request title exactly
  — `<feature>: <summary>` — and `Evidence` holding the body, fenced, verbatim. The fenced block does
  not count toward the fifteen lines — `docs/REGISTRY_SPEC.md` §4.2.
- **The pull request body**: `Summary`, `Tasks`, `Testing evidence`, `Scrutinise`, in that order —
  `docs/GIT_CONVENTIONS.md` §5.3. `Tasks` lists every task and bug of the feature with the type of
  its merge commit.
- **The blocked file**: `Asked to`, `Blocked because` — which step failed, with the conflict, the
  note or the failing tests, or the paths left over or left out — `Needs`, and `State of the work`:
  the merge was aborted, or no merge was attempted, or the merge commit stands without what it left
  out; and the task's branch and worktree are kept.

## Status transitions you own

`implemented → blocked`, when an integration stops — `docs/TASK_FILE_SPEC.md` §5.1.
`implemented → integrated` is the integration script's, never yours.

## Git writes you make

`git merge --no-ff --no-commit task/<id>`, `git add -- <file>` for each file the notes name or the
install rewrote, the commit of that merge, `git merge --abort` when it fails,
`git worktree remove ../wt-<id>` and `git branch -d task/<id>` after it succeeds —
`docs/GIT_CONVENTIONS.md` §3.3.

## What never goes in

| Not this | Where it belongs |
|---|---|
| how — a diff, a file list, a line count — in a message body | nowhere; the diff says it |
| the journey — attempts, escalation, what failed first | nowhere; the history holds one commit per task |
| a second footer, an issue reference, `BREAKING CHANGE:`, an attribution trailer | nowhere in a game repository — `docs/GIT_CONVENTIONS.md` §7 |
| the feature slug as a scope | the task's module is the scope |
| a status, in an entry or a body | the task file |
| a manual test's verdict, in the body | the manual tests, committed on `main` |
