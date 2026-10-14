# Context Policy

This document defines what each [agent](GLOSSARY.md#agent) may read, what it may write, which git
commands it may run, and what it may use to do any of that. Every [harness](GLOSSARY.md#harness) has a
`CONTEXT.md` stating its own boundary; all six derive from this document, and none of them widens
what is granted here.

Narrow boundaries do two jobs. They keep every session cheap — and at parallel width a line of
context is paid once per running task, not once per project. And they keep an agent's work inside
the part of the game it answers for, which is what lets N of them run at once without stepping on
each other. Reads are bounded mostly for the first reason; writes are bounded for the second, and
those are the boundaries a script checks.

Vocabulary is fixed by [`GLOSSARY.md`](GLOSSARY.md); paths by
[`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md); the file gradient by
[`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §3; the module map and `CLAUDE.md` by
[`CONTRACT_SPEC.md`](CONTRACT_SPEC.md) §5; registry reads by
[`REGISTRY_SPEC.md`](REGISTRY_SPEC.md) §5, which defers to this document where the two touch; git by
[`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md).

---

## 1. The baseline rule

> **An agent reads what its column of the matrix grants, writes what §3 grants, and nothing else.**

A resource that does not appear is not granted by omission — it is denied, and an agent that needs it
stops (§6). The rule is written as a list of grants rather than of prohibitions on purpose: a list of
prohibitions would have to anticipate every file an agent might reach for, and would grant by silence
everything nobody thought of.

---

## 2. Reading

### 2.1 The matrix

| Resource | `translator` | `architect` | `planner` | `implementer` | `tester` | `integrator` |
|---|---|---|---|---|---|---|
| its own [harness](GLOSSARY.md#harness) | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| `docs/` | ○ cited sections | ○ cited sections | ○ cited sections | ○ cited sections | ○ cited sections | ○ cited sections |
| `.factory/FACTORY_VERSION` | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| [`VISION.md`](GLOSSARY.md#vision-visionmd) | ✓ writes it | ✓ | ✓ | ✓ | ✓ | ✓ |
| [references](GLOSSARY.md#reference), `.factory/project/reference/` | ✓ approved pieces | ✓ approved pieces | ✓ approved pieces | ○ its task's `references` | ○ its task's `references`, and `08-engineering/checklist.md` | ✗ |
| `contracts/` | — | ✓ writes it | ✓ | ✓ | ✓ | ✓ |
| every `CLAUDE.md` | — | ✓ writes them | ✓ | ✓ | ✓ | ✓ |
| [task files](GLOSSARY.md#task-file) | — | ✓ | ✓ writes them | ○ its task's | ○ its task's | ○ its task's |
| own [registry](GLOSSARY.md#registry) entries | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| other agents' registry entries | ✗ | ✗ | ✓ all | ✗ | ✗ | ○ the implementer's entry for its task |
| [blocked files](GLOSSARY.md#blocked-file) | — | ○ those with `needs: architect` | ✓ | ○ its task's, if relaunched | ✗ | ✗ |
| [manual tests](GLOSSARY.md#manual-test) | — | ✗ | ✓ | ✗ | ✓ writes its task's | ○ its feature's, names only |
| production code | — | ✓ | ✓ | ✓ | ✓ | ✓ |
| test code | — | ✓ | ✓ | ✓ | ✓ | ✓ |
| git, read-only (§4.1) | ✗ | ✓ | ✓ | ✓ | ✗ | ✓ |
| the web (§5.4) | ✗ | ○ versions of its stack only | ✗ | ✗ | ✗ | ✗ |

**Legend.** ✓ permitted · ✗ denied · ○ permitted under the stated condition · — the resource does
not exist yet when the agent runs.

The [tester](GLOSSARY.md#tester) runs inside the implementer's [session](GLOSSARY.md#session), as a
subagent, and inherits what that session has already read. Its column says what it may reach for on
its own; what it inherits is the implementer's, and is not a second grant.

### 2.2 Notes on the rows

**The factory contract is read, never written.** An agent reads its own harness whole — it is its
instructions — and no other agent's ([`HARNESS_SPEC.md`](HARNESS_SPEC.md) §8.3). A harness cites a
protocol instead of restating it ([`HARNESS_SPEC.md`](HARNESS_SPEC.md) §2.2), so an agent reads
`docs/` too, and **only the sections its harness cites**: a citation such as
`docs/APPROVAL_PROTOCOL.md` §4.1 grants that section, at the step that cites it — not the whole
document, and not a browse of the directory. What an agent needs from `docs/` is what its harness
points it at, and a section it was not pointed at is a read it was not granted. `.factory/FACTORY_VERSION`
is read by all six: every artefact is stamped from it, and a task file's stamp is checked against it.
None of the three is ever written by an agent (§3.1).

**`VISION.md` is readable by every agent.** A task file says what to build; the vision says what the
thing being built is for. Where the two contradict each other the agent stops rather than choosing.

**References are read whole by who designs, and by path by who builds.** `.factory/project/reference/`
holds what the vision cannot say in prose: the engineering standards, the art direction, the
contract of each character, zone, item and piece of UI, their pose sheets and their playable
sandboxes. The translator, the architect and the planner read it as a standing grant: the vision
is kept faithful to it, and the module map, the code rules and every task are derived from it. The implementer and the tester read exactly the paths
their task file lists in `references` ([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §2.2) — the tester
also `08-engineering/checklist.md`, which it holds every task against. **Only a piece that
`reference/README.md` marks approved exists for an agent**: the translator, the architect and the
planner read that index first, and a task file that cites an unapproved piece is malformed. Where a cited reference and
the code disagree, the reference wins; where a reference is ambiguous, the agent stops rather than
choosing.

**`CLAUDE.md` files are read without being asked for.** Claude Code loads them from the directory a
session works in and from every parent, so every agent reads the root file and its module's. That is
why they carry facts and nothing else ([`CONTRACT_SPEC.md`](CONTRACT_SPEC.md) §5.3). **Where a
`CLAUDE.md` and a harness's `CONTEXT.md` disagree, `CONTEXT.md` wins**, and the `CLAUDE.md` has a
defect for the architect.

**An agent working on a task reads that task's file and no other.** The rest of the plan is other
agents' work, and reading it would only offer a session things it must not act on. The planner reads
every task file because the plan is its own; the architect reads them to see what a contract change
reaches before it makes one.

**Registries.** Each agent reads its own. The planner reads every agent's, because a wave is written
against what the previous one actually did, and a replanning is a judgement about what went wrong —
both live in the implementers' deviations. The integrator reads exactly one other entry, the
implementer's for the task it is integrating, because that entry holds the *why* its commit message
needs. Nothing else crosses.

**The implementer's registry is no longer closed to the tester.** In `3.x` that was the most
important line of this document: the tester was a separate session whose whole value was an
independent verdict, and the implementer's confident account of why its code was right was the one
thing that could spoil it. In `4.0.0` the tester is a subagent inside the implementer's session and
issues no verdict; the independence is gone on purpose, and what replaced it is mechanical —
`verify-task`, which reads no registry at all ([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §5.2).

**Blocked files are read by who has to act on them.** The planner reads all of them, since most carry
`needs: planner`; the architect reads those addressed to it. An implementer relaunched on a task that
was blocked before reads that task's blocked file, whose `State of the work` says what the previous
attempt left in the worktree.

**Manual tests are read by the planner**, which turns a `FAIL` into a bug task file, and by the
integrator only to list a feature's manual tests in `pr.md` — their names, not their contents.

**Code is read in the checkout where it is.**

| Agent | Reads code in |
|---|---|
| architect | the main checkout, and the integration worktrees of open features during a contract change |
| planner | the main checkout, for what is in `main`, and the integration worktrees, for features still being built |
| implementer, tester | the task's own worktree |
| integrator | the feature's integration worktree |

**Every search is bounded by `source_root`**, never run from the repository root (§5.3).

---

## 3. Writing

### 3.1 What each agent writes

| Agent | Writes | Where |
|---|---|---|
| `translator` | `VISION.md`, its registry entries | the main checkout |
| `architect` | `contracts/`, the stubs, every `CLAUDE.md`, its registry entries | the main checkout; after a contract change, the merge of `main` into open feature branches |
| `planner` | task files — new, rewritten or deleted — the `blocked → pending` status, its registry entries | the main checkout |
| `implementer` | the code and tests of its task; the `blocked` status and a blocked file when it stops; its registry entry | code in its worktree; everything under `.factory/` in the main checkout |
| `tester` | its manual test, when the task file has a `Manual check`; its registry entry | the main checkout |
| `integrator` | the merge, shared files, `pr.md`, the `blocked` status and a blocked file when it stops, its registry entry | the merge and shared files in the integration worktree; everything under `.factory/` in the main checkout |

**The three gated agents write only what their gate-2 report named** — exactly those paths, after
`APPROVED` ([`APPROVAL_PROTOCOL.md`](APPROVAL_PROTOCOL.md) §4.2). A command that creates, moves,
deletes or truncates any other path is the same violation as an editor doing it.

**The unattended agents write inside their task's bounds.** The implementer follows the file gradient:
its `files`, then the roots of its own module as a recorded deviation, and nothing outside its module,
in a shared file or under `contracts/` ([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §3.2). The integrator
writes the shared files the task's notes name, and nothing else of the game's code.

**No agent writes the factory contract** — `docs/`, any harness, or `.factory/FACTORY_VERSION`. In a
game repository they are the copy of the factory version the game was built with; changing them is
an amendment made in the factory repository, or a newer version the operator adopts on purpose
([`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md) §4). None of them can appear in a gated agent's
gate-2 report, and for the implementer they lie outside every module root, where check 5 of
`verify-task` fails.

**No agent writes `.factory/project/reference/` either.** Every piece in it is made with the operator
and approved by the operator before any agent reads it, and its state is recorded in
`reference/README.md`. An agent that finds a reference wrong or ambiguous says so, in a blocked
report or a blocked file; it never corrects the reference.

### 3.2 Three writes nobody but one agent makes

| Only | Writes | Why |
|---|---|---|
| the architect | anything under `contracts/` | a contract change reaches every task written against it, and is approved by a person |
| the integrator | a [shared file](GLOSSARY.md#shared-file) | two tasks alive at once must never touch the same file, and shared files are the ones many tasks need |
| the scripts, and the agents [`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §5.1 names | a task's `status`, each only its own transition | a success status means *the verification passed*, and only a script knows that |

### 3.3 `.factory/` is written in the main checkout

**Every write under `.factory/` goes to the main checkout, never to a worktree.** A worktree has a copy
of `.factory/` too — the one its branch was cut with — and a status or a registry entry written there
would exist only on that branch, where the dispatcher, the planner and the integrator reading from
the main checkout never see it. The launcher passes every session the path of the main checkout.

---

## 4. Git

### 4.1 Reading

**`git log`, `git show`, `git diff` and `git status` are granted read-only to the architect, the
planner, the implementer and the integrator.** They are how the planner reads the state of a feature
still being built, how the implementer and `verify-task` see what a task changed, and how the
integrator and the architect see what a merge brings.

**What an agent may not do with the history is take a convention from it.** The conventions are in
[`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md). An integrator that copied the style of earlier merge
messages would reproduce their defects as if they were rules.

The translator runs before the game has a history worth reading. The tester has none of its own; what
changed in the task is already in the session it runs inside.

### 4.2 Writing

| Agent | Git writes it makes |
|---|---|
| `translator`, `architect`, `planner` | a commit on `main` of exactly its gate-2 write set; the architect also merges `main` into open feature branches after a contract change |
| `implementer` | one commit on `task/<id>`, after `verify-task` passes |
| `integrator` | the `--no-ff` merge into `feat/<feature>`, staging by path the files its `shared_file_notes` name and those `install_command` rewrote, `git merge --abort` when it fails, removing the task's worktree and deleting `task/<id>` |
| `tester` | none |

**No agent opens a pull request, merges into `main` or pushes** — the rule every harness carries.
Everything else in [`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) §6 belongs to a script or to the human.

---

## 5. The terminal

### 5.1 The grant

**Every agent may run commands in a terminal to read what §2 grants it and to write what §3 grants
it**, and the gated agents to make the git writes of §4.2. `ls`, `cat`, `grep`, the stack's own
test and lint commands and their equivalents are ordinary instruments, and none is listed as a closed
set: a list of spellings would deny by omission the one an operator's shell actually ships.

A command that returns its answer and nothing else is the cheapest read there is, which is why the
terminal is preferred over a tool that loads its own documentation into the session before answering.
At parallel width that difference is paid once per running task.

### 5.2 An instrument, not a resource

**The terminal widens nothing.** `cat` on a file the matrix denies is the denied read, not another
one, and a command that writes outside §3 is the forbidden write however it is spelled. The
unattended sessions run with a fixed list of allowed tools, set by the launcher before they start,
and **never with every permission bypassed**.

### 5.3 Search, and what it cannot see

**A search is bounded by `source_root`, never run from the repository root.** The root also holds
`.factory/`, where every task file and registry entry is committed as markdown, and a search from
there returns them as incidental matches — reads the agent was never granted, arriving through a
command that looks harmless.

**The answer to "what else reaches this code?" is found by search**: the symbol's spelling across the
source tree, and the module's path across the imports. **It is a lower bound, and is reported as
one.** A text search finds the spelling, not the reference: a symbol reached through dynamic
dispatch, a re-export, a string key or a generated file does not appear, and the search returns
success in exactly the shape it does when nothing reaches the change. An agent that finds no
dependants has found no *spelled* dependants, and says so in those terms.

### 5.4 The network

**The terminal reaches the repository, not the internet.** Three uses of the network exist, and none
of them is a standing grant for anything else:

| Who | Reaches | For |
|---|---|---|
| the architect | official documentation sites and package registries of the tools it is about to propose | confirming each one's current stable version, and nothing more |
| the launcher | the package registry, through `install_command` | installing the pinned dependencies of each new worktree |
| the integrator | the package registry, through `install_command` | reinstalling after an integration changed the manifest |

**No agent pushes, pulls or fetches.** Git's network belongs to the human
([`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) §6).

The architect's grant exists because a stack chosen from memory proposes what the model recalls, not
what exists. It is limited to the tools the architect is about to recommend; searching for an answer
to anything else is outside it.

---

## 6. When a boundary is in the way

**An agent that needs to read or write outside its boundary stops.** It does not read anyway and
mention it afterwards.

| Agent | How it stops |
|---|---|
| a gated agent | a blocked report in chat ([`APPROVAL_PROTOCOL.md`](APPROVAL_PROTOCOL.md) §5). The operator can grant one read, for this session only, or supply the fact |
| the implementer or the integrator | a blocked file with `needs: planner` — the task file should have supplied what was missing — or `needs: architect` when the need is to write outside the module |

A one-session grant does not amend this document, does not carry to the next session, and is not a
precedent. A read that turns out to be needed routinely is a defect in the matrix, and the fix is to
change §2 and bump the [factory version](GLOSSARY.md#factory-version).

---

## 7. Enforcement, honestly

**Most of these boundaries are conventions held by the harness prompt, not by tooling.** Nothing stops
an agent from opening a file, and the factory does not pretend otherwise. What holds them differs by
kind:

| Boundary | Held by |
|---|---|
| a gated agent's writes | the operator reading its gate-2 report before anything is written |
| an implementer's writes | check 5 of `verify-task`, which fails a diff outside `files` and the module's roots |
| the factory contract — `docs/`, the harnesses, `FACTORY_VERSION` — never written | a gated agent's gate-2 report, and check 5 for the implementer; for the integrator and the tester, their `CONTEXT.md` |
| the tools an unattended session can use | the launcher's allowed-tool list |
| every read | the harness's `CONTEXT.md`, and nothing else |

The reads are the weak row, and it is worth saying so. An agent that read outside its boundary
produces an artefact that looks exactly like a compliant one. In `3.x` that mattered most for the
tester's independence, which no longer exists; in `4.0.0` an out-of-bounds read mostly costs context,
and the writes — where parallel work actually breaks — are the boundaries a script checks.

### 7.1 An honest caveat about reading code this way

**Search does not compress.** A search against the source answers at a cost set by the size of the
repository. A game of a few dozen files is one an agent can search exhaustively, and at that size an
index costs more to keep current than the reads it saves — all the more when N tasks change the tree
at once. **The size at which this stops being true has not been measured.** When a game outgrows
exhaustive search, the answer is an index of some kind, and adopting one is an amendment to this
document.
