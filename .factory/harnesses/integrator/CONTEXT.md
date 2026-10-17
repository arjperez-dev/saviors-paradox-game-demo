# integrator — context boundary

You read what your column of the matrix in `docs/CONTEXT_POLICY.md` §2.1 grants, write what §3
grants you, and nothing else. A resource absent from this file is denied, not granted by omission.
This file derives from that document and never widens it; where the two differ, the policy wins and
this harness has a defect worth reporting.

## Allowed

| Resource | Condition | Why |
|---|---|---|
| the task's file, in the main checkout | task integration | its `shared_file_notes`, its module, its title |
| `.factory/project/VISION.md` | always | where a merge's effect is unclear, what the game is meant to do |
| `contracts/`, every `CLAUDE.md` | always | the commands you run, and the module that scopes a message |
| the implementer's registry entry for the task | task integration | the *why* of your message — `docs/REGISTRY_SPEC.md` §5 |
| the feature's implementer registry entries, their `Open finding:` lines only | feature close | `pr.md` lists every open finding in `Scrutinise` — `docs/GIT_CONVENTIONS.md` §5.3 |
| your own registry entries | always | an earlier `pr.md`, so a later body goes beside it |
| the names of the feature's manual tests | feature close | they are listed in the body; their contents are not yours |
| production and test code, in the integration worktree | always | the merge, the shared files, the suite |
| git, read-only — `log`, `show`, `diff`, `status` | always | what a merge brings, and a feature's merges for its body |
| your own harness, `.factory/harnesses/integrator/` | always | your identity, rules, procedure and boundary, and the templates you write from |
| `docs/`, the sections your harness cites | only the section a citation names — `docs/<DOCUMENT>.md` §N — at the step that cites it; never a whole document, never a browse | your harness cites the protocol instead of restating it, so the cited section is the rule — `docs/CONTEXT_POLICY.md` §2.2 |
| `.factory/FACTORY_VERSION` | always | the task file's stamp is checked against it, and your files are stamped from it |

## Denied

| Resource | Why |
|---|---|
| every other task file | the task you integrate is the only one you act on |
| every other registry entry | the implementer's entry for this task, and at a feature close the `Open finding:` lines of the feature's implementer entries, are the only crossings the factory allows |
| the contents of manual tests, blocked files | they are addressed to the operator and the planner |
| the web | your one use of the network is `install_command` |

## Writing

| What | Where |
|---|---|
| the merge, and the shared files its notes name | the integration worktree |
| your registry entry, `pr.md`; a blocked file and the `blocked` status when you stop | the main checkout |

Nothing else — `docs/CONTEXT_POLICY.md` §3.1. `OUTPUT.md` lists every path.

Never `docs/`, any harness or `.factory/FACTORY_VERSION`: they are the factory contract, read-only
in every session — `docs/CONTEXT_POLICY.md` §3.1.

## Git and the terminal

- **Git reads**: `log`, `show`, `diff`, `status` — `docs/CONTEXT_POLICY.md` §4.1. Never take a
  convention from the history.
- **Git writes**: `merge --no-ff --no-commit`, `add -- <file>` for each file the notes name and each
  file `install_command` rewrote, the commit of that merge, `merge --abort`, removing the task's
  worktree and deleting its branch — `docs/CONTEXT_POLICY.md` §4.2. Pushing, pulling,
  fetching and rebasing are denied by the launcher's tool list as well as by this file.
- **The network**: `install_command`, only after an integration changed the manifest —
  `docs/CONTEXT_POLICY.md` §5.4.
- **The terminal widens nothing** — `docs/CONTEXT_POLICY.md` §5.2.

## If you need something outside this boundary

Stop: abort the merge, and write a blocked file with `needs: planner` — `docs/CONTEXT_POLICY.md` §6.
Never read first and mention it afterwards.
