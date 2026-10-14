# architect — definition of done

Every item below is answerable yes or no by the operator, from the conversation and the drafts
alone. A satisfied checklist is not approval — see `docs/APPROVAL_PROTOCOL.md` §3. The count you
report at gate 1 covers the `Work` block only.

## Work — verified before gate 1

- [ ] Every tool in the stack has a version confirmed on the web today, with its source, and none was chosen from a technical preference the vision stated on the client's behalf.
- [ ] The commands include `install_command`, `test_command` and `lint_command`, and `run_command` if the game can be run; `source_root`, `test_root` and `contracts_root` are set.
- [ ] Every module has every root it owns, no two roots overlap, `contracts/` is nobody's root, and `tooling` is not in the map.
- [ ] A module exists for the tests that exercise several modules, with its root under `test_root`.
- [ ] No module needs another module's code: everything one takes from another is a contract.
- [ ] Every contract is one declaration in one file, under `events/`, `state/` or `ports/`, with no behaviour and no explanatory comment; every `kernel/` type is a value with value semantics only and no game rule.
- [ ] Every module has its kind; no `shared` module holds a game rule or depends on a `feature` module.
- [ ] Every contract a module implements, owns or emits has a stub inside that module's roots, named in the module's `CLAUDE.md`.
- [ ] Every stub returns the most neutral value its signature allows and never throws.
- [ ] Every rule in the root and module `CLAUDE.md` files derives from an approved piece of `08-engineering/` and names it; none is invented there.
- [ ] Every module that answers for a character, zone, item or piece of UI links its approved contract in `References`, and links nothing unapproved.
- [ ] On a `change-NN` session: every task file that depends on the changed contract, every file that implements it and every open feature branch has been named to the operator, as a lower bound.

## Write set — verified before gate 2

- [ ] Every path I will write, rewrite or delete appears in the gate-2 report table, and no other.
- [ ] Every path rewritten in place or deleted carries its rewrite preview.
- [ ] Every artefact follows its template, and carries `factory_version` read from `.factory/FACTORY_VERSION`.
- [ ] Every registry entry carries all five fields and fits 15 lines.
- [ ] I claim no status transition this harness does not own.
- [ ] The commit stages exactly these paths, by path, never with `git add -A`.
- [ ] The report is at most 40 lines, the previews aside.
- [ ] There is one registry entry per decision — the stack, the modules, each contract — not one per session.
- [ ] Contracts, stubs and `CLAUDE.md` files carry no `factory_version`; only the registry entries do.
- [ ] On a `change-NN` session, every feature branch `main` will be merged into is named in the report.
- [ ] Nothing has been written to disk yet.
