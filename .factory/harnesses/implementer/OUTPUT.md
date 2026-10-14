# implementer — output

A session that finishes writes the code, the commit and the registry entry, in that order, and only
after `verify-task` has passed. A session that stops writes the blocked file and the status, and
nothing else.

## The write set

| Path | Artefact | Template | Written when |
|---|---|---|---|
| the paths in the task's `files`, and unlisted paths inside your module's roots | code and tests | none | during the work, in your worktree |
| `.factory/registry/implementer/<feature>/<id>.md` | your registry entry | `templates/registry-entry.md` | after the commit; `<id>-replan-NN.md` when the task was rebuilt after a replanning |
| `.factory/blocked/<feature>/<id>.md` | a blocked file | `templates/blocked-file.md` | when you stop; `<id>-02.md` beside an earlier one |
| `.factory/tasks/<feature>/<id>.md`, its `status` line | `blocked` | none | when you stop, after the blocked file |

## Frontmatter

- **The registry entry**: `factory_version` alone, from `.factory/FACTORY_VERSION` —
  `docs/REGISTRY_SPEC.md` §2.4.
- **The blocked file**: `task_id`, `needs`, `agent: implementer`, `factory_version`, `created` —
  `docs/APPROVAL_PROTOCOL.md` §5.5.

## Body structure

- **The registry entry**: the heading `# <id> — <title>`, verbatim from the task file — with the
  entry's `replan-NN` suffix after the id on a rebuild — then the five fields, at most fifteen
  lines — `docs/REGISTRY_SPEC.md` §3. `Deviations` names every file you touched that the task did
  not list, and every way the tree differed from what the task assumed.
  `Evidence` names what you adapted from `Implementation` and why, and the files actually touched.
  The integrator takes the commit's *why* from this entry, and the planner writes the next wave
  against it.
- **The blocked file**: `Asked to`, `Blocked because` with its evidence, `Needs`, and `State of the
  work` — what is in the worktree and whether anything was committed.

## Status transitions you own

`in_progress → blocked`, when you stop — `docs/TASK_FILE_SPEC.md` §5.1. `implemented` is written by
`verify-task`, never by you.

## Git writes you make

One commit on `task/<id>`, after `verify-task` passes: every change in your worktree, subject
`<id>: <title>`, no body, no footer — `docs/GIT_CONVENTIONS.md` §3.1.

## What never goes in

| Not this | Where it belongs |
|---|---|
| a Conventional type, a body, a `Task:` footer, in your commit | the integrator's merge commit |
| a status, in your registry entry | the task file |
| the task's instructions restated, in your registry entry | nowhere; the task file has them |
| the journey — attempts, what failed first | nowhere; git keeps one commit, and your entry records decisions |
| why you stopped, in a registry entry | the blocked file |
| a change to a shared file, a dependency installed | the integrator, from `shared_file_notes`; missing, it is a stop |
