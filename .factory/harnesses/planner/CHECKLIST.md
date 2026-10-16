# planner — definition of done

Every item below is answerable yes or no by the operator, from the conversation and the drafts
alone. A satisfied checklist is not approval — see `docs/APPROVAL_PROTOCOL.md` §3. The count you
report at gate 1 covers the `Work` block only.

## Work — verified before gate 1

- [ ] On the first session, wave 0 is the `tooling` feature, all `scaffolding`, in `module: tooling`.
- [ ] Every title is imperative, at most 72 characters, and needs no `and` to be accurate.
- [ ] Every task is complete: reading only it, the references it cites, the contracts and the `CLAUDE.md` files, two implementers would produce the same files.
- [ ] Every `implementation` task has an `Interfaces` table and at least one criterion with a `Test file` in `files` and a verbatim `Test name`.
- [ ] Every path in `files` is inside a root of the task's module — `tooling` excepted — and none is under `contracts/` or a shared file.
- [ ] Every change a task needs in a shared file is one directed instruction in `shared_file_notes`.
- [ ] No file appears in the `files` of two tasks that could be alive at the same time.
- [ ] No `depends_on_task` names a task of another feature, and no cycle exists.
- [ ] Every task that imports a `shared` module uses only code already on `main`, and says so in `Preconditions`.
- [ ] Every feature has a task whose tests exercise several modules together.
- [ ] Every `Implementation` was written against the code as it stands, after reading the implementers' deviations.
- [ ] Every `Open finding:` in an implementer's entry since my last session is planned in a task that names it, or declined in a registry decision that says why.
- [ ] Every `Manual check` names something only a person can judge.
- [ ] Every `exports` row names its `Building block`, each type is exactly one block, and every aggregate root's task states its invariants and the domain events it records.
- [ ] Every task lists in `references` exact paths of approved pieces only, and every task that writes code cites `08-engineering/coding-standards.md`.
- [ ] Every value a cited reference fixes is copied into a criterion as the reference gives it, with its source named; none contradicts a reference.
- [ ] On a replanning: no `integrated` task file is rewritten, no id is reused, and every blocked task has a decision on its `task/` branch.
- [ ] On a bug: the failure is classified, the bug has `origin`, `priority: high` and a reproducing criterion, and its id is in the `depends_on_task` of every pending task relying on the failed behaviour.

## Write set — verified before gate 2

- [ ] Every path I will write, rewrite or delete appears in the gate-2 report table, and no other.
- [ ] Every path rewritten in place or deleted carries its rewrite preview.
- [ ] Every artefact follows its template, and carries `factory_version` read from `.factory/FACTORY_VERSION`.
- [ ] Every registry entry carries all five fields and fits 15 lines.
- [ ] I claim no status transition this harness does not own.
- [ ] The commit stages exactly these paths, by path, never with `git add -A`.
- [ ] The report is at most 40 lines, the previews aside.
- [ ] Every task file carries `status: pending` and every field of `docs/TASK_FILE_SPEC.md` §2.2, with `[]` on empty lists.
- [ ] The report's `Scrutinise` block names every file two tasks of the plan share.
- [ ] Nothing has been written to disk yet.
