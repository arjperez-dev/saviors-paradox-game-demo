# planner — output

Nothing in this file is written before gate 2 is approved — not a draft, not a partial file, not a
registry entry.

## The write set

| Path | Artefact | Template | Written when |
|---|---|---|---|
| `.factory/tasks/<feature>/T###.md` | a task file | `templates/task.md` | `wave-NN`: new. `replan-NN`: new, rewritten in place, or deleted |
| `.factory/tasks/<feature>/B###.md` | a bug task file | `templates/bug.md` | `replan-NN` |
| `.factory/registry/planner/<wave-NN \| replan-NN>/<decision>.md` | one registry entry per decision | `templates/registry-entry.md` | every session |

`<decision>` is a kebab-case slug naming the decision — `player-control-cut`,
`drop-t014` — `docs/REGISTRY_SPEC.md` §2.3.

## Frontmatter

- **A task file**: every field of `docs/TASK_FILE_SPEC.md` §2.2, in its order. `status: pending`,
  `priority: normal`, `wave` the wave this session writes — `0` for the `tooling` tasks of the first
  session. `[]` written out on an empty `depends_on_contract`, `depends_on_task` or
  `shared_file_notes`. `factory_version` from `.factory/FACTORY_VERSION`, and `created` today; a
  rewrite sets both again.
- **A bug task file**: the same, plus `origin`, with `type: bug` and `priority: high` —
  `docs/TASK_FILE_SPEC.md` §8.2.
- **A registry entry**: `factory_version` alone — `docs/REGISTRY_SPEC.md` §2.4.

## Body structure

- **A task file**: `# <id> — <title>`, then `Description`, `Preconditions`, `Constraints`,
  `Interfaces`, `Implementation`, `Acceptance criteria`, `Manual check` — the optional ones left
  out when they do not apply, never written empty. `docs/TASK_FILE_SPEC.md` §2.3–§2.7.
- **A bug task file**: `# <id> — <title>`, then `Reproduction`, `Expected / Observed`, and the rest
  as above. At least one criterion reproduces the failure.
- **A scaffolding task**: `Test file` and `Test name` are `—`, and each assertion names a command and
  its expected outcome. `Implementation` carries every configuration file whose lines are choices.
- **A registry entry**: `# <the decision, in a few words>`, then the five fields; `Evidence` holds the
  alternative rejected. On a replanning, one entry says what was wrong with the plan, what changed,
  which tasks were dropped, and which `task/` branches are reused or discarded.

## Status transitions you own

Every task file you write or rewrite carries `status: pending`, and that is the one transition you
own: `blocked → pending`, on replanning a task — `docs/TASK_FILE_SPEC.md` §5.1. You change no other
status, and never the status of a file you are not rewriting.

## Git writes you make

One commit on `main` holding exactly the paths your gate-2 report named — deletions included —
staged by path, with the message of `docs/GIT_CONVENTIONS.md` §2.3 for your session.

## What never goes in

| Not this | Where it belongs |
|---|---|
| why the work was cut this way, what was rejected | your registry entry |
| the body of a test | the implementer, against your assertion |
| an instruction to the implementer as a reader — "be careful with…" | a `Constraint`, if it binds; otherwise nowhere |
| a new contract, a changed module root | the architect |
| a path under `contracts/`, a shared file, in `files` | nowhere; the second goes in `shared_file_notes` |
| a status, in a registry entry | the task file |
