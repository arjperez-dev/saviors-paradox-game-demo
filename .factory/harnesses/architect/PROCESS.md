# architect — process

One session, from the vision or a blocked file to the commit. The steps are numbered continuously and
are not comparable with the steps of another harness.

## Session start

1. Confirm the session is running the model named in `AGENT.md` — Opus 5.5. If it is not, say so and
   stop.
2. Establish which session this is, and say which in chat:
   - **`project`** — the first session. `.factory/project/VISION.md` exists and `contracts/` does not.
     Your input is the vision.
   - **`change-NN`** — a contract change, or a module boundary that has to move. Your input is the
     blocked files with `needs: architect` the operator points you to, or the operator's own
     request. `NN` is one more than the last `change-NN` under `.factory/registry/architect/`.
3. Read your input whole. A vision that contradicts itself, or a blocked file that does not say what
   would unblock it, is a blocked condition — `docs/APPROVAL_PROTOCOL.md` §5.1. Then read
   `.factory/project/reference/README.md`, every approved piece of `08-engineering/`, and the
   approved contracts the modules will answer for — `docs/CONTEXT_POLICY.md` §2.2. A reference that
   contradicts the vision is a blocked condition too.
4. Compare the `factory_version` field in `AGENT.md` against `.factory/FACTORY_VERSION`. A
   difference means this harness text predates the current factory contract: mention it in the
   gate-1 report and continue. It never blocks. See `docs/HARNESS_SPEC.md` §8.1.

## The work

Iteration with the operator here is unlimited and expected. See `docs/APPROVAL_PROTOCOL.md` §1.2.
Present one part at a time, iterate on it until the operator confirms it, and only then open the
next.

**On a `project` session, steps 5 to 9.**

5. **The stack.** Derive it from the client constraints in the vision and from what the operator
   specifies — never from a technical choice the vision states on the client's behalf. Confirm each
   tool's current stable version on the web, against its official documentation or package registry,
   and keep the version and the source for the registry. Name the rejected alternative.
6. **The commands and paths**: `install_command`, `test_command`, `lint_command`, `run_command`, and
   `build_command` where building is a separate step; `source_root`, `test_root` and
   `contracts_root`, which sits under `source_root` when the stack cannot import from outside it —
   `docs/CONTRACT_SPEC.md` §2. Each command as the operator would type it, with nothing beside it —
   `docs/CONTRACT_SPEC.md` §5.1. They need not work yet: wave 0 makes them.
7. **The modules.** Cut the game into modules along the lines the vision's mechanics suggest, each
   one a bounded context in the sense of `08-engineering/architecture.md`, with the layers that
   document fixes. Give each its kind — `feature`, or `shared` for code many modules import that
   holds no game rule — and every root it owns, code and tests alike, and add the `integration`
   module. Draw them so that no feature module needs another feature's code —
   `docs/CONTRACT_SPEC.md` §4–§4.1.
8. **The contracts.** Every event, shared state and port two modules meet through, one declaration
   per file, with the module that implements, owns or emits each one; and the shared kernel's value
   types under `kernel/`, written whole. Hold each against
   `docs/CONTRACT_SPEC.md` §1–§2 as you write it.
9. **The stubs and the `CLAUDE.md` files.** A stub for every contract a module does not merely
   consume, at a path inside that module's roots; the root file; one file per module. Derive the
   root `Rules`, and each module's, from `08-engineering/` — every rule a fact the code must satisfy,
   ending with the path it comes from — and never write a rule there that the engineering references
   do not support. Give each module a `References` section linking the approved contract of every
   character, zone, item or piece of UI it answers for — `docs/CONTRACT_SPEC.md` §5.1–§5.2.

**On a `change-NN` session, steps 10 to 13.**

10. Read the contract the input names, its stub or the implementation that replaced it, and every
    task file whose `depends_on_contract` names it. Read the code on the open feature branches, in
    their integration worktrees, to see what has been built against it.
11. State to the operator what is wrong with the contract, and what the change reaches: every task
    file that depends on it, every file that implements it, every open feature branch. What a search
    finds is a lower bound — `docs/CONTEXT_POLICY.md` §5.3 — and say so.
12. Revise the contract and its stub together, or the replacing implementation where there is one,
    and every `CLAUDE.md` whose roles, stub paths, rules or references moved. A boundary problem may be answered by a
    changed module map rather than a changed contract.
13. List the open feature branches — `git branch --list 'feat/*'` — that `main` will be merged into.

14. Verify the `Work` block of `CHECKLIST.md`.

## Gate 1

15. File the report, naming the decisions in the order the operator confirmed them.

```text
Gate 1 — file a work report and wait. See `docs/APPROVAL_PROTOCOL.md` §4.1.
```

## Draft the write set

16. Read `OUTPUT.md` and draft every artefact: contracts, stubs, `CLAUDE.md` files from their
    templates, and one registry entry per decision. Write nothing to disk. Prepare the rewrite
    preview of every file a `change-NN` session rewrites in place — `docs/APPROVAL_PROTOCOL.md` §3.

## Gate 2

17. Verify the `Write set` block of `CHECKLIST.md`, then file the report. On a `change-NN` session
    it names every feature branch `main` will be merged into.

```text
Gate 2 — file a write-set report and wait. See `docs/APPROVAL_PROTOCOL.md` §4.2.
```

## Write and commit

Write exactly the approved paths, in this order, and nothing else.

18. The contracts, under `contracts/`.
19. The stubs, or the revised implementations, at the paths the module files name.
20. The root `CLAUDE.md`, then each module's.
21. `.factory/registry/architect/<project | change-NN>/<entry>.md` — one file per decision.
22. Stage exactly those paths, by path, and commit them on `main` with the message
    `docs/GIT_CONVENTIONS.md` §2.3 gives this session. Never `git add -A`.
23. On a `change-NN` session, for each feature branch the report named: in `../wt-feat-<feature>`,
    `git merge main`. A conflict stops you here, in front of the operator: resolve it with them, in
    that worktree, as part of the merge — or abort it and block.

## Session end

24. State in chat what was written, the commit, and each merge. Then one line on what the operator
    does next: after a `project` session, a planner session for waves 0 and 1; after a `change-NN`
    session, a planner replanning of the tasks the change reached. Nothing further happens here.

## If you must block

25. File a blocked report and produce nothing — `docs/APPROVAL_PROTOCOL.md` §5.1–§5.3. Blocking is
    available at every step, and how it resolves is `docs/APPROVAL_PROTOCOL.md` §5.4. A need the
    four folders of `contracts/` cannot hold is a block, not a fifth folder.
