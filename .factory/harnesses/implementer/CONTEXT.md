# implementer — context boundary

You read what your column of the matrix in `docs/CONTEXT_POLICY.md` §2.1 grants, write what §3
grants you, and nothing else. A resource absent from this file is denied, not granted by omission.
This file derives from that document and never widens it; where the two differ, the policy wins and
this harness has a defect worth reporting.

## Allowed

| Resource | Condition | Why |
|---|---|---|
| your task's file, in the main checkout | always | it is your input, and the only instruction you act on |
| `.factory/project/VISION.md` | always | what the thing you build is for; where it contradicts the task file, you stop |
| every approved piece of `.factory/project/reference/08-engineering/`, in the main checkout | always | how every line of code is written — the architecture, the patterns, the standards, the tests and the checklist your tester holds you to; each piece states its status in its first lines — `docs/CONTEXT_POLICY.md` §2.2 |
| the paths your task file lists in `references`, in the main checkout | always | what the thing must look, sound and behave like, with its numbers; where it and the code disagree, the reference wins — `docs/CONTEXT_POLICY.md` §2.2 |
| `contracts/`, every `CLAUDE.md` | always | the declarations your code compiles against, the module map the gradient reads |
| production and test code, in your worktree | always | the tree your task changes |
| your own registry entries, `.factory/registry/implementer/` | always | an agent reads its own entries freely |
| your task's blocked files | when the task was blocked before | what the earlier attempt left, and why it stopped |
| git, read-only — `status`, `diff`, `log`, `show` | always | what your task changed, and what an earlier attempt left |
| your own harness, `.factory/harnesses/implementer/` | always | your identity, rules, procedure and boundary, and the templates you write from |
| `docs/`, the sections your harness cites | only the section a citation names — `docs/<DOCUMENT>.md` §N — at the step that cites it; never a whole document, never a browse | your harness cites the protocol instead of restating it, so the cited section is the rule — `docs/CONTEXT_POLICY.md` §2.2 |
| `.factory/FACTORY_VERSION` | always | the task file's stamp is checked against it, and your entries are stamped from it |

## Denied

| Resource | Why |
|---|---|
| every other task file | other tasks are other implementers' work, and reading them only offers things you must not act on |
| every reference your task file does not list, `08-engineering/` aside, `reference/README.md` included | the planner chose what your task is built against; a reference you went looking for is one nobody checked your task against |
| other agents' registry entries | each agent reads its own |
| other tasks' blocked files, manual tests | they are addressed to the planner and the operator |
| other worktrees, and `main`'s code as a branch | your task was cut from its feature branch, and that is the tree you build on |
| the web, and every network use | the launcher installed your dependencies before you started — `docs/CONTEXT_POLICY.md` §5.4 |

## Writing

| What | Where |
|---|---|
| the code and tests of your task, within the file gradient — `docs/TASK_FILE_SPEC.md` §3.2 | your worktree |
| your registry entry; a blocked file and the `blocked` status when you stop | the main checkout |

Nothing else — `docs/CONTEXT_POLICY.md` §3.1. `OUTPUT.md` lists every path.

Never `docs/`, any harness or `.factory/FACTORY_VERSION`: they are the factory contract, read-only
in every session — `docs/CONTEXT_POLICY.md` §3.1.
Never `.factory/project/reference/` either: the operator approves every piece; one that is wrong
or ambiguous is reported, never corrected — `docs/CONTEXT_POLICY.md` §3.1.

## Git and the terminal

- **Git reads**: `status`, `diff`, `log`, `show` — `docs/CONTEXT_POLICY.md` §4.1.
- **Your one git write** is the commit of your task on `task/<id>`, after `verify-task` passes —
  `docs/CONTEXT_POLICY.md` §4.2. Pushing, pulling, fetching and rebasing are denied by the launcher's
  tool list as well as by this file.
- **The terminal widens nothing** — `docs/CONTEXT_POLICY.md` §5.2. Search from `source_root`, never
  from the repository root, and treat what a search finds as a lower bound — §5.3.

## If you need something outside this boundary

Stop: a blocked file with `needs: planner` — the task file should have supplied what was missing — or
`needs: architect` when the need is to write outside your module. See `docs/CONTEXT_POLICY.md` §6.
Never read first and mention it afterwards.
