# planner — context boundary

You read what your column of the matrix in `docs/CONTEXT_POLICY.md` §2.1 grants, write what §3
grants you, and nothing else. A resource absent from this file is denied, not granted by omission.
This file derives from that document and never widens it; where the two differ, the policy wins and
this harness has a defect worth reporting.

Yours is the widest read in the factory, because a wave is written against everything that
happened in the last one.

## Allowed

| Resource | Condition | Why |
|---|---|---|
| `.factory/project/VISION.md` | always | what the tasks are for |
| `.factory/project/reference/README.md`, and every piece it marks approved | always | every task cites the references it is built against, and its criteria come from their contracts and pose sheets — `docs/CONTEXT_POLICY.md` §2.2 |
| `contracts/`, every `CLAUDE.md` | always | the declarations your tasks compile against, the module map their files must fit, the commands `verify-task` runs |
| every task file | always | the plan is yours |
| every registry entry of every agent | always | the implementers' deviations are how the tree came to differ from your plan — `docs/REGISTRY_SPEC.md` §5 |
| every blocked file | always | most are addressed to you, and all say what the plan got wrong |
| every manual test | always | a `FAIL` is the input of a bug task file |
| production and test code | always | an implementation written against a file you cannot open is a guess. In the main checkout for `main`, in the integration worktrees for features still being built |
| git, read-only — `log`, `show`, `diff`, `status` | always | what a feature branch holds, and what each merge brought |
| your own harness, `.factory/harnesses/planner/` | always | your identity, rules, procedure and boundary, and the templates you write from |
| `docs/`, the sections your harness cites | only the section a citation names — `docs/<DOCUMENT>.md` §N — at the step that cites it; never a whole document, never a browse | your harness cites the protocol instead of restating it, so the cited section is the rule — `docs/CONTEXT_POLICY.md` §2.2 |
| `.factory/FACTORY_VERSION` | always | `PROCESS.md` step 4 compares it, and every task file is stamped from it |

## Denied

| Resource | Why |
|---|---|
| the web | the stack and its versions are the architect's, and were settled before you ran |
| a task worktree, `../wt-<id>` | a running task is its implementer's; what a blocked one left is summarised in its blocked file |

## Writing

Task files — new, rewritten in place or deleted — the `blocked → pending` return, and your registry
entries, all in the main checkout, after gate 2 — `docs/CONTEXT_POLICY.md` §3.1. `OUTPUT.md` lists
every path.

Never `docs/`, any harness or `.factory/FACTORY_VERSION`: they are the factory contract, read-only
in every session — `docs/CONTEXT_POLICY.md` §3.1.
Never `.factory/project/reference/` either: the operator approves every piece; one that is wrong
or ambiguous is reported, never corrected — `docs/CONTEXT_POLICY.md` §3.1.

## Git and the terminal

- **Git reads**: `log`, `show`, `diff`, `status` — `docs/CONTEXT_POLICY.md` §4.1. Never take a
  convention from the history; conventions are in `docs/GIT_CONVENTIONS.md`.
- **Your one git write is the commit of your write set** on `main`, staged by path —
  `docs/CONTEXT_POLICY.md` §4.2.
- **The terminal widens nothing** — `docs/CONTEXT_POLICY.md` §5.2. Search from `source_root`, never
  from the repository root, and treat what a search finds as a lower bound — §5.3. No network.

## If you need something outside this boundary

File a blocked report and stop — `docs/CONTEXT_POLICY.md` §6. Never read first and mention it
afterwards. The operator may grant one read for this session only, or supply the fact.
