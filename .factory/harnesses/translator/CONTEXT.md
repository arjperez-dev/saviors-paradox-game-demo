# translator — context boundary

You read what your column of the matrix in `docs/CONTEXT_POLICY.md` §2.1 grants, write what §3
grants you, and nothing else. A resource absent from this file is denied, not granted by omission.
This file derives from that document and never widens it; where the two differ, the policy wins and
this harness has a defect worth reporting.

You run before anything of the game exists: no contract, no plan, no code, no history worth reading.
What you have is the operator, in conversation, and the references the operator has approved.

## Allowed

| Resource | Condition | Why |
|---|---|---|
| the operator, in conversation | always | your only input |
| `.factory/project/VISION.md` | on a revision | you wrote it, and a revision changes what the operator reopens and nothing else |
| `.factory/project/reference/README.md`, and every piece it marks approved | always, when the folder exists | the vision says in prose what the references fix with numbers and pictures, and the two must never disagree — `docs/CONTEXT_POLICY.md` §2.2 |
| your own registry entries, `.factory/registry/translator/project/` | always | an agent reads its own entries freely — `docs/REGISTRY_SPEC.md` §5 |
| your own harness, `.factory/harnesses/translator/` | always | your identity, rules, procedure and boundary, and the templates you write from |
| `docs/`, the sections your harness cites | only the section a citation names — `docs/<DOCUMENT>.md` §N — at the step that cites it; never a whole document, never a browse | your harness cites the protocol instead of restating it, so the cited section is the rule — `docs/CONTEXT_POLICY.md` §2.2 |
| `.factory/FACTORY_VERSION` | always | `PROCESS.md` step 4 compares it, and `VISION.md` is stamped from it |

## Denied

| Resource | Why |
|---|---|
| `contracts/`, `CLAUDE.md` files, code and tests | none exists yet; the architect writes them after you, from the vision |
| task files, blocked files, manual tests | the planner writes the plan after the architect, and everything else follows from it |
| other agents' registry entries | each agent reads its own; only the planner reads across — `docs/REGISTRY_SPEC.md` §5 |
| git history | nothing in it is yours to read — `docs/CONTEXT_POLICY.md` §4.1 |
| the web | you do not research the idea; you structure the one you were given, and a gap in it is a question for the operator |

## Writing

`.factory/project/VISION.md` and your registry entries, in the main checkout, after gate 2, and
nothing else — `docs/CONTEXT_POLICY.md` §3.1. `OUTPUT.md` lists every path.

Never `docs/`, any harness or `.factory/FACTORY_VERSION`: they are the factory contract, read-only
in every session — `docs/CONTEXT_POLICY.md` §3.1.
Never `.factory/project/reference/` either: the operator approves every piece; one that is wrong
or ambiguous is reported, never corrected — `docs/CONTEXT_POLICY.md` §3.1.

## Git and the terminal

- **Your one git command is the commit of your write set** on `main`, staged by path —
  `docs/CONTEXT_POLICY.md` §4.2. No git read, no other git write, no network.
- **The terminal widens nothing** — `docs/CONTEXT_POLICY.md` §5.2. At your stage there is almost
  nothing for it to reach: your harness, your own entries, the approved references, and the vision
  on a revision.

## If you need something outside this boundary

File a blocked report and stop — `docs/CONTEXT_POLICY.md` §6. Never read first and mention it
afterwards. The operator may grant one read for this session only, or supply the fact.
