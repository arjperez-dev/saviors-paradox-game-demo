# architect — output

Nothing in this file is written before gate 2 is approved — not a draft, not a partial file, not a
registry entry.

## The write set

| Path | Artefact | Template | Written when |
|---|---|---|---|
| `contracts/events/<file>.<ext>`, `contracts/state/<file>.<ext>`, `contracts/ports/<file>.<ext>`, under `contracts_root` | one contract per file | none — code, `docs/CONTRACT_SPEC.md` §1–§2 | `project`; changed or added in `change-NN` |
| the stub path a module's `CLAUDE.md` names, inside that module's roots | a stub | none — code, `docs/CONTRACT_SPEC.md` §3 | with its contract |
| an implementation that replaced a stub | the same file, revised | none | `change-NN` only, when a signature it implements changed |
| `CLAUDE.md` | the root facts: stack, commands, paths, module map | `templates/claude-root.md` | `project`; rewritten in `change-NN` when the map or a command moves |
| `<root>/CLAUDE.md`, one per module | the module's facts | `templates/claude-module.md` | `project`; rewritten in `change-NN` when a role or a stub path moves |
| `.factory/registry/architect/<scope>/<entry>.md` | one registry entry per decision | `templates/registry-entry.md` | every session |
| the merge of `main` into `feat/<feature>` | a merge commit, in `../wt-feat-<feature>` | none | `change-NN` only, one per open feature branch |

`<scope>` is `project` or `change-NN`. `<entry>` is `stack`, `modules`, or a contract id with its
`/` replaced by `-`, such as `events-PlayerJumped` — `docs/REGISTRY_SPEC.md` §2.3.

## Frontmatter

- **Contracts, stubs and `CLAUDE.md` files**: none. They are the game's code and facts, not factory
  artefacts, and carry no stamp — `docs/CONTRACT_SPEC.md`.
- **Each registry entry**: `factory_version` alone — `docs/REGISTRY_SPEC.md` §2.4.

## Body structure

- **A contract**: the declaration and nothing else — no behaviour, no comment explaining the shape.
  A `kernel/` type is complete: construction, validation, equality and the value's own arithmetic,
  and no stub.
- **A stub**: the file the implementation will live in, importing its contract, with the correct
  signature, returning the most neutral value, and a one-line comment saying it is not implemented.
- **The root `CLAUDE.md`**: `Stack`, `Commands`, `Paths`, `Modules`, and `Rules` if there are any, in
  that order — `docs/CONTRACT_SPEC.md` §5.1.
- **A module's `CLAUDE.md`**: `What it is`, `Contracts`, `Roots`, `Not here` —
  `docs/CONTRACT_SPEC.md` §5.2. A module holding only tests has no `Contracts` section.
- **A registry entry**: the heading of `docs/REGISTRY_SPEC.md` §3.2 — `# Stack`, `# Modules`,
  `# Contract events/PlayerJumped` — then the five fields. `Evidence` holds the rejected alternative
  and, for the stack, the source each version was checked against.

## Status transitions you own

None. You fix contracts and set the status of no task; the planner returns a blocked task to
`pending` after you — `docs/TASK_FILE_SPEC.md` §5.1.

## Git writes you make

- One commit on `main` holding exactly the paths your gate-2 report named, staged by path, with the
  message of `docs/GIT_CONVENTIONS.md` §2.3 for your session.
- After a `change-NN` commit, `git merge main` in the integration worktree of each open feature
  branch the report named — `docs/GIT_CONVENTIONS.md` §1.5.

## What never goes in

| Not this | Where it belongs |
|---|---|
| why a contract has its shape, what was rejected | your registry entry for that contract |
| behaviour of any kind, in a contract or a stub | the task that replaces the stub |
| the package manifest, configuration, linter, test runner, build | wave 0, planned as tasks |
| an instruction to an agent, a read boundary | the harnesses |
| a count of tests that must pass, beside a command | nowhere; what passing means is each task's criteria |
| a status, a change to a task file | the planner |
