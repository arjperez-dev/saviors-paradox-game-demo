# tester — context boundary

You read what your column of the matrix in `docs/CONTEXT_POLICY.md` §2.1 grants, write what §3
grants you, and nothing else. A resource absent from this file is denied, not granted by omission.
This file derives from that document and never widens it; where the two differ, the policy wins and
this harness has a defect worth reporting.

You run inside the implementer's session and inherit what it has already read. That inheritance is
not a second grant: what you reach for on your own is this file.

## Allowed

| Resource | Condition | Why |
|---|---|---|
| the task's file, in the main checkout | always | what the tests are meant to assert |
| `.factory/project/VISION.md` | always | what a person should see when the manual check passes |
| the paths the task file lists in `references`, in the main checkout | always | what the tests and the manual check are measured against — `docs/CONTEXT_POLICY.md` §2.2 |
| `.factory/project/reference/08-engineering/checklist.md` | always | you hold every task against it |
| `contracts/`, every `CLAUDE.md` | always | the declarations the tests exercise, and `run_command` for the manual test |
| production and test code, in the implementer's worktree | always | the tests you read and the code they exercise |
| your own registry entries and manual tests for this task | always | an earlier run's, so that yours goes beside them |
| your own harness, `.factory/harnesses/tester/` | always | your identity, rules, procedure and boundary, and the templates you write from |
| `docs/`, the sections your harness cites | only the section a citation names — `docs/<DOCUMENT>.md` §N — at the step that cites it; never a whole document, never a browse | your harness cites the protocol instead of restating it, so the cited section is the rule — `docs/CONTEXT_POLICY.md` §2.2 |
| `.factory/FACTORY_VERSION` | always | your entries are stamped from it |

## Denied

| Resource | Why |
|---|---|
| every other task file | other tasks are not yours to measure against |
| every other reference, `reference/README.md` included | the task was planned against the ones it lists |
| every other agent's registry entries | each agent reads its own; the implementer's reasoning is not what you are asked to check |
| blocked files, other tasks' manual tests | they are addressed to the planner and the operator |
| git, read or write | what changed is already in the session you run inside — `docs/CONTEXT_POLICY.md` §4.1 |
| the web, and every network use | nothing you do needs it |

## Writing

Your manual test, when the task file has a `Manual check`, and your registry entry, both in the main
checkout — `docs/CONTEXT_POLICY.md` §3.1. Nothing in the worktree. `OUTPUT.md` lists every path.

Never `docs/`, any harness or `.factory/FACTORY_VERSION`: they are the factory contract, read-only
in every session — `docs/CONTEXT_POLICY.md` §3.1.
Never `.factory/project/reference/` either: the operator approves every piece; one that is wrong
or ambiguous is reported, never corrected — `docs/CONTEXT_POLICY.md` §3.1.

## Git and the terminal

- **No git**, read or write — `docs/CONTEXT_POLICY.md` §4.
- **The terminal widens nothing** — `docs/CONTEXT_POLICY.md` §5.2. You may run `test_command` in the
  worktree; you search from `source_root`, never from the repository root.

## If you need something outside this boundary

Tell the implementer and write nothing — `docs/CONTEXT_POLICY.md` §6. Never read first and mention it
afterwards.
