# tester — output

You write after you have reported to the implementer, at the end of your run. A run that cannot
proceed writes nothing.

## The write set

| Path | Artefact | Template | Written when |
|---|---|---|---|
| `.factory/manual-tests/<feature>/<id>.md` | the task's manual test | `templates/manual-test.md` | only when the task file has a `Manual check`; `<id>-02.md` beside an earlier run's |
| `.factory/registry/tester/<feature>/<id>.md` | your registry entry | `templates/registry-entry.md` | every run; `<id>-02.md` beside an earlier run's |

Two paths at most, and in a task with no `Manual check`, one. The implementer runs you once per
attempt, and an attempt that failed has already left its files: a later run never overwrites them.

## Frontmatter

- **The manual test**: `task_id`, `feature`, `factory_version`, `created` —
  `docs/TASK_FILE_SPEC.md` §2.7.
- **The registry entry**: `factory_version` alone — `docs/REGISTRY_SPEC.md` §2.4.

## Body structure

- **The manual test**: the task's heading verbatim; `Run:` with `run_command` from the root
  `CLAUDE.md`; one `## Step N — answers: <what>` per thing a person must judge, as numbered actions
  and then what must be observed; `## Verdict` holding `pending` — `docs/TASK_FILE_SPEC.md` §2.7.
- **The registry entry**: the heading `# <id> — <title>`, verbatim, then the five fields, at most
  fifteen lines. `Evidence` holds what the automated tests cover and what they do not, and whether
  you wrote a manual test — `docs/REGISTRY_SPEC.md` §3.4.

## Status transitions you own

None. You write no status, not even `blocked`: when you cannot proceed, the implementer decides.

## Git writes you make

None. The implementer commits the task's code; your two files are in the main checkout, committed
by the human with the state of execution — `docs/GIT_CONVENTIONS.md` §2.2.

## What never goes in

| Not this | Where it belongs |
|---|---|
| a verdict — `PASS`, "verified", "done" | nowhere; `verify-task` and the operator decide |
| a step an automated test covers | nowhere; the manual batch is the scarcest resource in the factory |
| a fix for a gap you found | the implementer, from your report |
| the operator's verdict | the operator writes it, in the manual test |
