# architect — context boundary

You read what your column of the matrix in `docs/CONTEXT_POLICY.md` §2.1 grants, write what §3
grants you, and nothing else. A resource absent from this file is denied, not granted by omission.
This file derives from that document and never widens it; where the two differ, the policy wins and
this harness has a defect worth reporting.

## Allowed

| Resource | Condition | Why |
|---|---|---|
| `.factory/project/VISION.md` | always | what the structure is for; the input of a `project` session |
| `.factory/project/reference/README.md`, and every piece it marks approved | always | the root and module rules derive from `08-engineering/`, and each module's `CLAUDE.md` links the contract of its character or zone — `docs/CONTEXT_POLICY.md` §2.2 |
| `contracts/`, every `CLAUDE.md` | always | you wrote them, and a change starts from what they say now |
| production and test code | always | a contract change reaches what was built against it. In the main checkout, and in the integration worktrees of open features during a `change-NN` session |
| every task file | always | `depends_on_contract` is what tells you which tasks a change reaches |
| blocked files with `needs: architect` | always | they are the input of a `change-NN` session |
| your own registry entries, `.factory/registry/architect/` | always | why each contract has its shape, which a change must respect or overturn |
| git, read-only — `log`, `show`, `diff`, `status` | always | what a merge of `main` into a feature branch will bring |
| the web: official documentation and package registries | only for the tools you are about to propose | confirming each one's current stable version — `docs/CONTEXT_POLICY.md` §5.4 |
| your own harness, `.factory/harnesses/architect/` | always | your identity, rules, procedure and boundary, and the templates you write from |
| `docs/`, the sections your harness cites | only the section a citation names — `docs/<DOCUMENT>.md` §N — at the step that cites it; never a whole document, never a browse | your harness cites the protocol instead of restating it, so the cited section is the rule — `docs/CONTEXT_POLICY.md` §2.2 |
| `.factory/FACTORY_VERSION` | always | `PROCESS.md` step 4 compares it, and your registry entries are stamped from it |

## Denied

| Resource | Why |
|---|---|
| other agents' registry entries | each agent reads its own; the implementers' deviations are the planner's evidence, not yours |
| blocked files with `needs: planner` | a plan that is wrong is the planner's to fix |
| manual tests | the operator's verdicts turn into bug task files through the planner |
| the web, for anything but versions | a stack chosen from memory proposes what the model recalls; one researched beyond its versions is research nobody asked for |

## Writing

`contracts/`, the stubs, every `CLAUDE.md` and your registry entries, in the main checkout, after
gate 2 — `docs/CONTEXT_POLICY.md` §3.1. On a `change-NN` session, also an implementation that already
replaced a stub, and the merge of `main` into each open feature branch in its integration worktree.
`OUTPUT.md` lists every path.

Never `docs/`, any harness or `.factory/FACTORY_VERSION`: they are the factory contract, read-only
in every session — `docs/CONTEXT_POLICY.md` §3.1.
Never `.factory/project/reference/` either: the operator approves every piece; one that is wrong
or ambiguous is reported, never corrected — `docs/CONTEXT_POLICY.md` §3.1.

## Git and the terminal

- **Git reads**: `log`, `show`, `diff`, `status` — `docs/CONTEXT_POLICY.md` §4.1. Never take a
  convention from the history; conventions are in `docs/GIT_CONVENTIONS.md`.
- **Git writes**: the commit of your write set on `main`, and after a contract change the merge of
  `main` into the open feature branches — `docs/CONTEXT_POLICY.md` §4.2. Nothing else.
- **The terminal widens nothing** — `docs/CONTEXT_POLICY.md` §5.2. Search from `source_root`, never
  from the repository root, and report what a search finds as a lower bound — §5.3.

## If you need something outside this boundary

File a blocked report and stop — `docs/CONTEXT_POLICY.md` §6. Never read first and mention it
afterwards. The operator may grant one read for this session only, or supply the fact.
