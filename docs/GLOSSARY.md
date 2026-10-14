# Glossary

This document fixes the vocabulary of the Conectium Game Factory. Every other document, every
harness file and every artefact draws its terms from here. Where another document appears to use
a term differently, this document wins and the other document has a defect worth reporting.

Terms are grouped by kind and alphabetised within each group, so a term can be found without
knowing which group it belongs to. Every term used inside a definition has its own entry and is
linked to it — entries may therefore be read in any order. Terms that `4.0.0` retired keep an entry
in [§7](#7-retired-in-400), so an artefact written under an earlier
[factory version](#factory-version) can still be read.

---

## Distinctions that must never blur

Three pairs of terms sit close enough to be confused and matter enough that confusing them
corrupts everything downstream. They are stated here first and repeated inside the entries.

**1 · [Task file](#task-file) vs [registry](#registry).** A task file is what the
[planner](#planner) tells an [implementer](#implementer): the one [handoff](#handoff) the factory
keeps, and a contract addressed to someone else. A registry is what an [agent](#agent) records about
its own work: decisions, deviations and evidence. Other agents may read a registry, but reading it
never makes it an instruction. They must never duplicate each other: if content belongs in the task
file it does not belong in the record, and vice versa.

**2 · [Report](#report) vs [blocked file](#blocked-file).** A report is chat output — a gated agent
presenting work and asking for [explicit approval](#explicit-approval) — and is never written to a
file. A blocked file is written to disk by an agent that has stopped. The boundary is absolute: if
it is on disk, it is not a report.

**3 · [Contract](#contract) vs [factory contract](#factory-contract).** A contract is game code — a
source file under `contracts/` that the game compiles. The factory contract is what `docs/` and
`.factory/` fix, and what the [factory version](#factory-version) numbers. The bare word always
means the first; the second is always written in full.

---

## Index

[Acceptance criterion](#acceptance-criterion) ·
[Agent](#agent) ·
[Approval gate](#approval-gate) ·
[architect](#architect) ·
[Artefact](#artefact) ·
[Blocked](#blocked) ·
[Blocked file](#blocked-file) ·
[Bootstrap](#bootstrap) ·
[Client / idea author](#client--idea-author) ·
[Contract](#contract) ·
[Escalation](#escalation) ·
[Explicit approval](#explicit-approval) ·
[Factory](#factory) ·
[Factory contract](#factory-contract) ·
[Factory scripts](#factory-scripts) ·
[Factory version](#factory-version) ·
[Feature](#feature) ·
[Game repository](#game-repository) ·
[Handoff](#handoff) ·
[Harness](#harness) ·
[Human operator](#human-operator) ·
[implementer](#implementer) ·
[Integration](#integration) ·
[integrator](#integrator) ·
[Level](#level) ·
[Manual batch](#manual-batch) ·
[Manual check](#manual-check) ·
[Manual test](#manual-test) ·
[Module](#module) ·
[Plan](#plan) ·
[planner](#planner) ·
[PR body artefact](#pr-body-artefact) ·
[Project](#project) ·
[Reference](#reference) ·
[Registry](#registry) ·
[Replanning](#replanning) ·
[Report](#report) ·
[Scaffolding task](#scaffolding-task) ·
[Session](#session) ·
[Shared file](#shared-file) ·
[Status](#status) ·
[Stub](#stub) ·
[Task](#task) ·
[Task file](#task-file) ·
[Template](#template) ·
[tester](#tester) ·
[translator](#translator) ·
[Vision (VISION.md)](#vision-visionmd) ·
[Wave](#wave)

**Retired in `4.0.0`:**
[Commit message artefact](#commit-message-artefact) ·
[committer](#committer) ·
[Cycle](#cycle) ·
[Feature planning](#feature-planning) ·
[Fix cycle](#fix-cycle) ·
[Fix handoff](#fix-handoff) ·
[Project planning](#project-planning) ·
[Task plan (tasks.yaml)](#task-plan-tasksyaml) ·
[Test report](#test-report) ·
[`in_qa`, `qa_passed` and `done`](#in_qa-qa_passed-and-done)

---

## 1. Structural

### Bootstrap

The one-time procedure that installs the factory into a new [game repository](#game-repository):
copying the [template](#template), recording the [factory version](#factory-version), and
confirming that no artefacts from a previous [project](#project) came with the copy. It happens
once per project, before the first [translator](#translator) [session](#session), and is manual.
The procedure is specified in `docs/BOOTSTRAP.md`.

*Distinguish from:* [Scaffolding task](#scaffolding-task) — bootstrap installs the factory into
the repository; the scaffolding tasks of [wave](#wave) 0 build the game's own tooling afterwards,
and are executed by [implementers](#implementer) like any other [task](#task).

### Factory

The Conectium Game Factory: six [agents](#agent), their [harnesses](#harness), the
[factory scripts](#factory-scripts), and the documents defining how work flows between them and
where the [human operator](#human-operator) approves it. The factory repository contains only this
infrastructure; no game code lives in it. A game receives the factory as a copy of the
[template](#template).

*Distinguish from:* [Game repository](#game-repository) — the factory is what builds, the game
repository is what gets built.

### Factory contract

What `docs/` and `.factory/` fix: the agents, their gates, their read boundaries, the shape of every
[artefact](#artefact) and the rules each agent works under. It is what a
[factory version](#factory-version) numbers, and what an artefact's `factory_version` stamp says it
was produced under. This repository does not receive features; it receives amendments to the
factory contract.

*Distinguish from:* [Contract](#contract), which is game code. The bare word never means this one.

### Factory scripts

The four scripts under `.factory/scripts/` that do the pipeline's mechanical work, spend no tokens
and make no judgement. They are Python, 3.13 or newer, on the standard library alone, and share one
module, `factory_lib.py`:

| Script | Role | Does |
|---|---|---|
| `dispatch.py` | the **dispatcher** | Answers which [tasks](#task) can start now: `pending`, with every `depends_on_task` `integrated`, `priority: high` first. It ignores [wave](#wave) and does not validate the [plan](#plan) |
| `launch.py` | the **launcher** | Keeps up to N tasks running: opens the worktrees and branches, sets each task `in_progress`, starts an [implementer](#implementer) [session](#session) non-interactively, relaunches it on [escalation](#escalation), and starts the integration when the task is `implemented`. Writes the [blocked file](#blocked-file) itself when escalation runs out |
| `verify-task.py` | `verify-task` | Runs the mechanical checks a task must pass, and alone sets it `implemented` |
| `integrate.py` | the integration trigger | Starts the [integrator](#integrator) for one task under that [feature](#feature)'s lock, sets the task `integrated` once it finds the merge commit, and starts the session that writes the feature's [PR body](#pr-body-artefact) when the last task integrates |

They travel with the [template](#template), like everything else under `.factory/`.

*Distinguish from:* [Agent](#agent). A script decides nothing a person or a model should decide; an
agent decides nothing a script could.

### Factory version

One semver number covering the whole [factory contract](#factory-contract), stored at
`.factory/FACTORY_VERSION` and recorded in the `factory_version` frontmatter field of every
[artefact](#artefact) the factory generates: the [vision](#vision-visionmd), every
[task file](#task-file), [blocked file](#blocked-file), [registry](#registry) entry and
[manual test](#manual-test). There is no per-harness version: the six [harnesses](#harness) share
one factory contract, so a single number answers the only question that matters — under which
factory contract was this artefact produced? Bump rules are in `docs/REPOSITORY_LAYOUT.md`.

*Distinguish from:* the version of the game being built, which the factory does not manage. The
game's own artefacts — [contracts](#contract), [stubs](#stub), `CLAUDE.md` files — carry no stamp.

### Game repository

The repository of one game: the game's own code — its [contracts](#contract), its
[modules](#module) and their `CLAUDE.md` files — plus a copy of `.factory/` and `docs/` taken at
[bootstrap](#bootstrap). Once bootstrapped it evolves with the [project](#project) and does not
track the factory repository — adopting a newer [factory version](#factory-version) is a
deliberate act by the [human operator](#human-operator).

*Distinguish from:* [Factory](#factory) (the infrastructure) and [Project](#project) (the work);
the game repository is the container both end up inside.

### Harness

Everything that surrounds one [agent](#agent): its identity, hard rules, step-by-step process,
read boundary, output contract and templates. It lives at `.factory/harnesses/<agent>/`. Harnesses
come in **two shapes**: the three agents with [approval gates](#approval-gate) carry a checklist to
verify themselves against before each gate, and the three without gates do not. The shapes are
fixed by `docs/HARNESS_SPEC.md`.

*Distinguish from:* [Agent](#agent) — the agent is the model doing the work, the harness is the
written apparatus that constrains it. The word is never used for anything in the game's code.

### Module

A bounded part of the game's code, declared by the [architect](#architect) in the **module map** of
the root `CLAUDE.md` together with its kind — `feature`, `shared` or `integration` — and every root it
owns, code and tests alike. A module never imports another's code, except a **shared** module's,
which holds no game rule and is importable by all once its code is on `main`. Each module has its
own `CLAUDE.md` saying what it is, which [contracts](#contract) it consumes and emits, and what does
not belong to it. Every [task](#task) belongs to exactly one module, and the module's roots are the
boundary an [implementer](#implementer) may not write across.

*Distinguish from:* [Feature](#feature) — a feature is a capability of the game and may need work
in several modules; a module is a part of the code and serves several features.

### Template

The copyable part of the factory — `.factory/` and `docs/` as they exist before any project has
used them. A clean template has empty `project/`, `tasks/`, `registry/`, `blocked/` and
`manual-tests/` directories under `.factory/`; copying one that still holds another project's
history is the most likely [bootstrap](#bootstrap) error. The word also carries a smaller, local
sense: the files under a harness's `templates/` directory that an [agent](#agent) fills in to
produce an [artefact](#artefact).

*Distinguish from:* nothing — but the two senses are far apart. Where a sentence could be read
either way, write "the factory template" or "an artefact template".

---

## 2. Artefacts

### Artefact

Any file the factory produces or consumes as part of its [factory contract](#factory-contract).
Two kinds, told apart by where they live:

- **Factory artefacts**, under `.factory/`: the [vision](#vision-visionmd),
  [task files](#task-file), [registry](#registry) entries, [blocked files](#blocked-file) and
  [manual tests](#manual-test). Each carries the [factory version](#factory-version) it was produced
  under.
- **Game artefacts**, outside it: the [contracts](#contract), their [stubs](#stub) and the
  `CLAUDE.md` files. They are the game's code and facts, and carry no stamp.

Artefacts are permanent and version-controlled — they are the factory's memory, and how a future
operator reconstructs why the project looks the way it does. The [PR body artefact](#pr-body-artefact)
is the one exception: text handed to the operator, not a file.

*Distinguish from:* [Report](#report) — a report is chat output and leaves no artefact behind.

### Blocked file

What an [agent](#agent) writes when it is [blocked](#blocked): one markdown file at
`.factory/blocked/<feature>/<task-id>.md`, stating what it was asked to do, why it stopped, with
evidence, what would unblock it, and what it left in its worktree. Its `needs` field names who the
[human operator](#human-operator) summons — `architect` when a [contract](#contract) falls short or
the work would cross a [module](#module) boundary, `planner` when the [task file](#task-file) is
wrong, [escalation](#escalation) has failed, or [integration](#integration) has. Written by an
[implementer](#implementer) or the [integrator](#integrator) — or by the
[launcher](#factory-scripts) when escalation has run out — and carries the
[factory version](#factory-version).

*Distinguish from:* [Report](#report). A blocked file is on disk and is addressed to a person; a
report is chat output and is never written. The blocked report of earlier versions is what became
this file.

### Contract

A source file under `contracts/` that declares one thing modules share — a domain event, a shape of
shared read-only state, a port one module implements and another consumes, or a value type of the
shared kernel (`kernel/`), the only kind that carries behaviour, and only value semantics. It is **code**,
compilable from the first day, never prose describing code: that is what lets a [task](#task) that
consumes a contract import it and compile before the module implementing it exists, so that
depending on a contract never makes a task wait. A contract is identified by its path without
extension — `events/PlayerJumped` — because the extension belongs to the stack, not to the
[plan](#plan). Only the [architect](#architect) writes one, always under its two
[approval gates](#approval-gate), and always together with its [stub](#stub). The format is fixed by
[`CONTRACT_SPEC.md`](CONTRACT_SPEC.md).

*Distinguish from:* [Factory contract](#factory-contract). Why a contract has the shape it has goes
to the architect's [registry](#registry), never into the contract's file.

### Handoff

What one [agent](#agent) tells the next as a file. Since `4.0.0` exactly one remains: the
[task file](#task-file), which the [planner](#planner) writes for an [implementer](#implementer)
and which the [tester](#tester) and [integrator](#integrator) of that task read as well. Every other
artefact that passes between agents has a single writer, a fixed path and declared readers, and is
not addressed to any one of them.

Until `4.0.0` the word named every file a sending agent wrote into the receiving agent's
[harness](#harness) after its second [approval gate](#approval-gate). Four of the six agents no
longer have a second gate, and no artefact lives in a harness any more, so that sense is retired.
Handoffs written under it remain readable as history.

*Distinguish from:* [Registry](#registry) — a handoff is addressed to another agent and is a
contract; a registry is a record. They must never duplicate each other. A
[blocked file](#blocked-file) and a [manual test](#manual-test) are addressed to a person, not to an
agent, and are not handoffs.

### Manual check

The optional section of a [task file](#task-file) naming, in one line, what only a person can judge
about the work — how it feels, how it looks. Its absence means nothing about the task is observable
that way, which is the normal case. When it is present, the [tester](#tester) turns it into a
[manual test](#manual-test).

*Distinguish from:* [Acceptance criterion](#acceptance-criterion) — a criterion is asserted by an
automated test; a manual check exists precisely because none can assert it.

### Manual test

The file the [tester](#tester) writes at `.factory/manual-tests/<feature>/<task-id>.md` when, and
only when, the [task file](#task-file) carries a [manual check](#manual-check): the command to run
the game, the steps a person follows — each naming the manual check or
[acceptance criterion](#acceptance-criterion) it answers — and a `Verdict` the
[human operator](#human-operator) fills in with `PASS` or `FAIL` and what was seen. No step covers
ground an automated test already covers. It carries the [factory version](#factory-version).

*Distinguish from:* [Manual batch](#manual-batch), which is the operator running them.

### Plan

Every [task file](#task-file) of a [project](#project): the directory `.factory/tasks/`. There is no
index — the directory is the plan, and each task's [status](#status) lives in its own file. It is
written [wave](#wave) by wave by the [planner](#planner) and changed only by
[replanning](#replanning). Its dependency edges are what orders the work: the
[dispatcher](#factory-scripts) starts every task whose `depends_on_task` entries are all
`integrated`, and nothing else sequences it.

*Distinguish from:* the [task plan](#task-plan-tasksyaml) of earlier versions, an index plus task
files that executed one task at a time. Never name the plan by its data structure: see
[§6](#6-terms-we-deliberately-do-not-use).

### PR body artefact

The pull request body text the [integrator](#integrator) produces once per [feature](#feature),
when every [task](#task) of that feature is `integrated`. It is text, not an action: the
[human operator](#human-operator) opens the actual pull request, and only after the feature's
[manual batch](#manual-batch) has passed. Its format is fixed by `docs/GIT_CONVENTIONS.md`.

*Distinguish from:* the commit messages, which the integrator writes into the merge commits it
makes itself.

### Reference

A piece of `.factory/project/reference/` — an engineering standard, the art direction, or the
contract of one character, zone, item, piece of UI or sound, with its pose sheet and its playable
sandbox. It says, with numbers and pictures, what the [vision](#vision-visionmd) says in prose. It is
made with the [human operator](#human-operator) and approved by the operator before any
[agent](#agent) reads it, and `reference/README.md` records which pieces are approved. No agent
writes one. The [translator](#translator), the [architect](#architect) and the [planner](#planner)
read the approved pieces as a standing grant; the [implementer](#implementer) and the [tester](#tester) read the ones their
[task file](#task-file) cites in `references`. Where a cited reference and the code disagree, the
reference wins; where a reference is ambiguous, the agent stops. The reads are fixed by
[`CONTEXT_POLICY.md`](CONTEXT_POLICY.md) §2.

*Distinguish from:* the reference games of the vision, which are other people's games the project
takes from; a reference is the project's own approved material.

### Registry

What an [agent](#agent) records about its own work: decisions taken, deviations from the
[task file](#task-file), and the evidence behind them — the *why* that no other
[artefact](#artefact) captures. **One file is one entry**, at
`.factory/registry/<agent>/…`, so no two agents and no two tasks ever write the same file; the
directory is the accumulation. An entry is never edited retroactively — a correction is a new entry
referencing the old one — and is hard-capped at 15 lines, not counting the frontmatter that carries
its [factory version](#factory-version). It never records [status](#status). Paths and fields are
fixed by [`REGISTRY_SPEC.md`](REGISTRY_SPEC.md).

A registry is read by its writer, by the [integrator](#integrator) — which reads the
[implementer](#implementer)'s entry for the task it is integrating, to write the commit's *why* —
and by the [planner](#planner), which reads them all.

*Distinguish from:* [Task file](#task-file). The size limit is what keeps the boundary honest: a
15-line budget forces the agent to record the decision instead of re-narrating the work.

### Shared file

A game file that tasks in several [modules](#module) need an entry in — a system index, a
configuration table. Only the [integrator](#integrator) edits one, applying the directed
instructions a [task file](#task-file) lists in its `shared_file_notes`; an
[implementer](#implementer) never opens it. This is what keeps [tasks](#task) that run at the same
time from ever touching the same file.

*Distinguish from:* [Registry](#registry). A game's own index of systems is never called a
registry in a factory document.

### Stub

The placeholder implementation of a [contract](#contract): the file a [module](#module) will
implement it in exists, imports the contract, has the right signature, and does nothing real. The
[architect](#architect) writes each stub in the same act and under the same
[approval gates](#approval-gate) as its contract, because a stub is a mechanical projection of it and
writing them apart would create two artefacts that can disagree about one signature. Stubs are what
let the game compile before anything is implemented; a [task](#task) replaces a stub with the real
implementation.

*Distinguish from:* [Scaffolding task](#scaffolding-task) — a stub belongs to a contract; the
scaffolding of [wave](#wave) 0 is tooling and belongs to nobody's contract.

### Task file

The markdown file describing one [task](#task), at `.factory/tasks/<feature>/<task-id>.md`, written
by the [planner](#planner) and the one [handoff](#handoff) the factory keeps. Its frontmatter
carries the task's identity, `type` (`task` or `bug`), `task_type`, [feature](#feature),
[module](#module), [status](#status), priority, [wave](#wave), the [contracts](#contract) and the
tasks it depends on, the files it may write, its `shared_file_notes`, the
[references](#reference) it is built against and its
[factory version](#factory-version). Its body carries everything else — interfaces,
[acceptance criteria](#acceptance-criterion), an optional [manual check](#manual-check) and **the
implementation itself**, complete enough that the implementer decides nothing. A **bug task file**
(`type: bug`) is written by the planner during [replanning](#replanning) after a failed
[manual batch](#manual-batch); it names the task it came from in `origin` and never reopens that
task. The format is fixed by [`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md).

*Distinguish from:* [Registry](#registry) — the task file says what to build; the registry records
what happened while building it.

### Vision (VISION.md)

The canonical structured definition of the [project](#project): vision statement, genre, core
loop, mechanics, quantified content scope, reference games, session shape, input scheme, target
platform, constraints, explicit non-goals, success criteria, assumptions, open questions and
risks. It is the only thing the [translator](#translator) writes, at `.factory/project/VISION.md`,
and it is readable by every [agent](#agent) and carries the [factory version](#factory-version).
Where the vision and a [task file](#task-file) contradict each other, the agent writes a
[blocked file](#blocked-file) rather than choosing.

*Distinguish from:* the translator's handoff to the planner of earlier versions, which duplicated
this content with frontmatter and no longer exists.

---

## 3. Process

### Approval gate

A point at which an [agent](#agent) stops and may not continue without
[explicit approval](#explicit-approval) from the [human operator](#human-operator). Only three
agents have them — the [translator](#translator), the [architect](#architect) and the
[planner](#planner) — because those are the three seats where one error is multiplied across every
[task](#task) written against it. Each passes exactly two: gate 1 approves the work itself, gate 2
approves the set of files the agent is about to write, so the human sees what will reach disk before
it does. Iteration before either gate is unlimited. Downstream of planning there are none. The full
protocol is in `docs/APPROVAL_PROTOCOL.md`.

*Distinguish from:* [Explicit approval](#explicit-approval) — the gate is the place, the approval
is the act that opens it. The [manual batch](#manual-batch) and the pull request are points where a
person judges the work too, but neither is an approval gate.

### Blocked

The condition of an [agent](#agent) that has stopped rather than improvised: its input is
missing, malformed or contradictory; a [contract](#contract) falls short; the work would cross the
boundary of its [module](#module); [escalation](#escalation) has run out; or
[integration](#integration) has failed. An [implementer](#implementer) or the
[integrator](#integrator) — running with nobody watching — writes a [blocked file](#blocked-file) and
ends its [session](#session); a gated agent, whose operator is in the session, files a blocked
[report](#report) in chat and writes nothing. A blocked agent writes no [registry](#registry) entry
and integrates nothing, but an unattended one leaves its worktree as it was: on its own `task/` branch the half-done work disturbs nobody, and
it is the only evidence of what was tried. `blocked` is also a [status](#status) value, and the
[dispatcher](#factory-scripts) stops offering the task and everything that depends on it; the rest of the
[plan](#plan) keeps running.

*Distinguish from:* a failing test, which is ordinary work inside the session. Blocked means the
agent cannot proceed, not that the work is unfinished.

### Escalation

Relaunching a [task](#task) on Opus 5.5 after it has failed twice on Sonnet 5. If Opus 5.5 does not
resolve it either, the task is [blocked](#blocked) with `needs: planner`, by the launcher if the Opus 5.5
session did not write the blocked file itself. An unattended
[session](#session) needs a stopping condition, and escalation is the [implementer](#implementer)'s.

*Distinguish from:* [Replanning](#replanning) — escalation retries the same task file on a stronger
model; replanning changes the task file.

### Explicit approval

The [human operator](#human-operator) writing the literal keyword `APPROVED`. Nothing else counts
— not "ok", not "looks good", not "sure", not silence, not an emoji. Anything other than the
keyword is feedback, and returns the [agent](#agent) to iteration at the same
[approval gate](#approval-gate). There is no limit on how many iterations that takes.

*Distinguish from:* [Approval gate](#approval-gate). Approval is never recorded in a file: what a
gated agent writes exists only if it was approved, so its existence is the record.

### Integration

Taking one verified [task](#task) into its [feature](#feature): the [integrator](#integrator)
merges `task/<task-id>` into `feat/<feature>` with a merge commit, applies the task's
`shared_file_notes`, runs the whole test suite, writes the commit message and its own
[registry](#registry) entry, and removes the worktree; the integration trigger then sets the task
`integrated`. It happens **per task**, as soon as the implementer's session ends with the task
`implemented`, so that finished work lands at once and the tasks waiting on it are released. Integrations into one feature are serialised by a lock; two features
integrate in parallel. If anything fails, the integrator writes a [blocked file](#blocked-file) and
leaves the branch unmerged.

*Distinguish from:* the merge of a feature into `main`, which only the
[human operator](#human-operator) performs.

### Manual batch

The [human operator](#human-operator) running a [feature](#feature)'s [manual tests](#manual-test),
once or twice a day, and writing a verdict into each. It is the only check on the implementation
that a person performs, and at full parallel width it is the factory's bottleneck — which is why a
manual test exists only for what no automated test can see. A `FAIL` leads to
[replanning](#replanning), where the [planner](#planner) writes a bug [task file](#task-file); a
feature's pull request is not opened until its manual batch passes.

*Distinguish from:* [Approval gate](#approval-gate). The manual batch judges finished work, not a
plan or a contract, and nothing waits at it but the feature's pull request.

### Replanning

Revising the [plan](#plan) because a [task](#task) turned out to be wrong rather than merely
unfinished — a [blocked file](#blocked-file) with `needs: planner`, a [contract](#contract) the
[architect](#architect) has just changed, or a [manual batch](#manual-batch) that failed. Only the
[human operator](#human-operator) decides that it happens, by summoning the [planner](#planner); an
agent that finds a reason for it writes what it found and stops. Replanning revises only the tasks
the finding affects, and writes the [bug task files](#task-file) a failed manual batch calls for. It
is the only way a task leaves `blocked`: the planner returns it to `pending`. Existing
[registries](#registry) and blocked files are historical and are never deleted by replanning — the
plan is revised, the record stands.

*Distinguish from:* [Escalation](#escalation), which retries a task without changing it, and
[Wave](#wave), which is planning that is due rather than decided.

### Report

Chat output in which a gated [agent](#agent) presents what it produced, or what it is about to
write, and asks for [explicit approval](#explicit-approval). A report is never written to a file and
is length-limited so that it stays reviewable. Only the three agents with
[approval gates](#approval-gate) produce reports.

*Distinguish from:* [Blocked file](#blocked-file), which is on disk. If something called a report
is on disk, it is not this term.

### Session

One Claude Code conversation running one [harness](#harness) with one assigned model. The
[human operator](#human-operator) opens the sessions of the three gated [agents](#agent) and works
through their [approval gates](#approval-gate) inside them; the [launcher](#factory-scripts) and the
integration trigger start [implementer](#implementer) and [integrator](#integrator) sessions
non-interactively, one [task](#task) each. The [tester](#tester) has no session of its own: it runs
as a subagent inside the implementer's.

*Distinguish from:* [Agent](#agent) — six agents, five kinds of session.

### Status

The state of a [task](#task) in its lifecycle: `pending → in_progress → implemented → integrated`,
plus `blocked`. Status lives in the task's own [task file](#task-file) and nowhere else, and every
transition has exactly one owner:

| Transition | Owner |
|---|---|
| `pending → in_progress` | the [launcher](#factory-scripts), on opening the worktree |
| `in_progress → implemented` | `verify-task`, when every check passes |
| `implemented → integrated` | the integration trigger, on finding the [integrator](#integrator)'s merge commit |
| `* → blocked` | the [implementer](#implementer) or the integrator, on stopping; the launcher, when escalation runs out |
| `blocked → pending` | the [planner](#planner), on [replanning](#replanning) |

A success status is written by a script, never by an agent, because it means *the verification
passed* and only the script knows that. [Registries](#registry) never record status.

*Distinguish from:* [Blocked](#blocked), which is one of its values as well as a condition of the
agent.

---

## 4. Units of work

### Acceptance criterion

One checkable statement of what must be true for a [task](#task) to count as complete, written by
the [planner](#planner) into the [task file](#task-file). A task carries at least one, and each is
phrased so it can be asserted automatically — unless the task is a
[scaffolding task](#scaffolding-task), where the criterion is a command rather than a test. **Each
criterion also names the file and the name of the test that will assert it**; the planner writes
those and the [implementer](#implementer) writes the test's body, because an assertion authored by
whoever authored the code is shaped to that code. `verify-task` checks that each named file exists,
that each named test is in it, and that the file references something the task file declares under
its interfaces.

*Distinguish from:* [Manual check](#manual-check), which names what no test can assert, and the
definition of done in a harness's `CHECKLIST.md`, which constrains the [agent](#agent)'s own process
rather than the work product.

### Feature

A coherent group of [tasks](#task) delivering one capability of the game. One feature is one
`feat/` branch and one pull request, and several features may be open at once. **What bounds a
feature is that coherence — one capability — and not a count of tasks.** Its pull request is opened
when every one of its tasks is `integrated` and its [manual batch](#manual-batch) has passed,
without waiting for the other features of the same [wave](#wave).

*Distinguish from:* [Project](#project), which contains many features; [Task](#task), of which a
feature contains several; [Wave](#wave), which is a unit of planning and may cross features; and
[Module](#module), which is a part of the code rather than a capability.

### Level

Which scope an [artefact](#artefact) or a piece of work belongs to: **project** — the
[vision](#vision-visionmd), the [contracts](#contract), the [translator](#translator) and the
[architect](#architect); **wave** — one [planner](#planner) session; **feature** — a branch, a pull
request, a [manual batch](#manual-batch); **task** — a [task file](#task-file), a worktree, a
[registry](#registry) entry, a [blocked file](#blocked-file), a [manual test](#manual-test). The
level determines the path a file is written to.

*Distinguish from:* a level of the game being built. Factory documents never use the word that
way; write "stage" or "game level" when the game's own content is meant.

### Project

One game, built by one run of the pipeline from idea to finished repository. A project has
exactly one [vision](#vision-visionmd), one set of [contracts](#contract) and one [plan](#plan),
and is composed of [features](#feature).

*Distinguish from:* [Game repository](#game-repository) — the project is the work, the repository
is where it lives.

### Scaffolding task

A [task](#task) marked `task_type: scaffolding` because it produces structure rather than behaviour —
the package manifest, the language configuration, linter, formatter, test runner, build. [Wave](#wave)
0 consists of them, and is what first makes the game compile. It is the one declared exception to
the rule that every task carries at least one automated test: `verify-task` skips the checks that
read test files, and the planner must mark the task as such rather than leave it untested by
omission.

*Distinguish from:* [Bootstrap](#bootstrap), which installs the factory and is not a task at all,
and [Stub](#stub), which the architect writes with its contract rather than as a task.

### Task

The unit of execution: one [task file](#task-file), one `task/` branch, one worktree, one commit
and one [implementer](#implementer) [session](#session). **A task is one thing** — if the commit
subject describing it needs an "and", it is two tasks. A second question bounds it alongside the
first: whether anything in it is left for the implementer to decide. And one rule binds tasks to
each other: two tasks alive at the same time never write the same file, which the
[planner](#planner) guarantees when it writes them. A task either depends on another's real
behaviour, and waits for it to be `integrated`, or runs in parallel with it.

*Distinguish from:* [Feature](#feature), and from the task files in `factory-build/`, which are the
plan for building the factory itself and never travel to a [game repository](#game-repository).

### Wave

The [task files](#task-file) one [planner](#planner) [session](#session) writes: the unit of
**planning**, not of git and not of scheduling. Wave 0 is always the game's tooling, as
[scaffolding tasks](#scaffolding-task); from wave 1 on, everything the dependencies allow runs in
parallel. A wave may cross [features](#feature), and usually does — that is where the parallel width
comes from. The `wave` field of a task file records which session wrote it and nothing more: the
dispatcher ignores it, and a task of wave 3 with its dependencies met starts before an unstarted
task of wave 2.

*Distinguish from:* [Feature](#feature) — a feature is one branch and one pull request; a wave is
one planning session.

---

## 5. Roles

The pipeline order is `translator → architect → planner → implementer → integrator`, with the
`tester` running inside each `implementer`; the entries below are alphabetised for lookup, not
sequenced. Agent names are lowercase because they are identifiers: they name directories,
frontmatter values and, eventually, commands.

### Agent

One of the six roles doing work under a [harness](#harness). Five run as their own Claude Code
[session](#session); the [tester](#tester) runs as a subagent inside the
[implementer](#implementer)'s. The three agents with [approval gates](#approval-gate) must be
sessions: a subagent runs to completion and reports back, so it cannot pause mid-flight for
[explicit approval](#explicit-approval). The tester can be a subagent because it has no gate to
pause at.

*Distinguish from:* [Harness](#harness), which is the apparatus rather than the actor, and
[Factory scripts](#factory-scripts), which do the work that needs no actor.

### architect

Opus 5.5, once per [project](#project) and again for every change to a [contract](#contract), with
two [approval gates](#approval-gate) each time. Divides the game into [modules](#module), writes
`contracts/` as code together with their [stubs](#stub), chooses the stack and its versions, and
writes the root `CLAUDE.md` — with the module map — and one per module. It is the only
[agent](#agent) that edits a contract, and it answers every [blocked file](#blocked-file) with
`needs: architect`. It sets no task's [status](#status): after it changes a contract, the
[planner](#planner) replans what the change affects.

*Distinguish from:* [planner](#planner) — the architect decides what the parts of the game are and
how they talk to each other; the planner decides what work builds them, and in what order.

### Client / idea author

Whoever the game idea belongs to. The client is a source of intent, not a participant in the
pipeline: no [agent](#agent) ever addresses the client, and every question reaches them through
the [human operator](#human-operator). In practice the two are frequently the same person, which
is exactly why the roles are named separately.

*Distinguish from:* [Human operator](#human-operator) — the client supplies the idea, the
operator runs the factory and gives approval.

### Human operator

The person running the factory: opens the [sessions](#session) of the three gated
[agents](#agent) and gives or withholds [explicit approval](#explicit-approval) at their
[approval gates](#approval-gate); runs the [launcher](#factory-scripts); reads the `needs` of every
[blocked file](#blocked-file) and summons the [planner](#planner) or the [architect](#architect);
runs the [manual batch](#manual-batch); and opens every pull request, merges it into `main` and
deletes its branch. No agent opens a pull request or merges into `main` — every other git command
belongs to the agents and scripts. The operator alone decides when [replanning](#replanning)
happens.

*Distinguish from:* [Client / idea author](#client--idea-author) and [Agent](#agent). The operator
decides; the operator does not orchestrate.

### implementer

Sonnet 5, once per [task](#task), in its own worktree on its own `task/` branch, with no
[approval gates](#approval-gate); a task that fails twice goes to Opus 5.5 by
[escalation](#escalation). Puts the task's implementation and the bodies of its tests on disk,
adapting the implementation where it does not compile and recording each adaptation as a deviation
in its [registry](#registry). It may write a file its [task file](#task-file) did not list if the
file is inside a root of its own [module](#module), and records that too; outside its module, in a
[shared file](#shared-file) or under `contracts/`, it stops. It invokes the [tester](#tester), runs
`verify-task`, and commits the task; the launcher starts the integration once its session ends. It
writes no [status](#status) but `blocked`.

*Distinguish from:* [integrator](#integrator) — the implementer commits its own task on its own
branch; the integrator merges it into the feature.

### integrator

Sonnet 5, once per [task](#task) at [integration](#integration) and once per [feature](#feature)
when it closes, with no [approval gates](#approval-gate). Merges each task into its feature, edits
the [shared files](#shared-file) the task asked for, runs the whole test suite, reads the
[implementer](#implementer)'s [registry](#registry) entry and writes from it the commit message —
and, when the feature closes, the [PR body artefact](#pr-body-artefact). It is never Haiku: the
model of a seat is set by its hardest work, and editing shared files is writing code.

*Distinguish from:* the [human operator](#human-operator), who alone opens the pull request and
merges it into `main`, and the [committer](#committer) of earlier versions, which this role
absorbed.

### planner

Opus 5.5, once per [wave](#wave) and once per [replanning](#replanning), with two
[approval gates](#approval-gate) each time. Writes the [plan](#plan): decomposes the
[features](#feature) into [tasks](#task), sets the dependencies between them, keeps every two tasks
that can run at once apart in the files they write, emits wave 0 as the game's tooling and at least
one task per feature that tests several [modules](#module) together, and **writes the
implementation of every task** into its [task file](#task-file). It writes the bug task files a
failed [manual batch](#manual-batch) calls for, and it is the only [agent](#agent) that returns a
`blocked` task to `pending`. It reads every [registry](#registry), because it is their primary
consumer when it plans the next wave and when it replans.

*Distinguish from:* [architect](#architect) — the architect fixes the parts and how they talk; the
planner fixes the work and its order, and no longer chooses the stack.

### tester

Sonnet 5, as a subagent inside each [implementer](#implementer) [session](#session), once per
[task](#task), after the task's tests pass and before `verify-task`. Records what the automated
tests cover and what they do not, and writes a [manual test](#manual-test) when, and only when, the
[task file](#task-file) carries a [manual check](#manual-check) — most tasks produce none. It emits
no verdict and writes no code. It inherits the implementer's context on purpose: the independent
tester of earlier versions cost an Opus session and did not prevent wrong verdicts, and
`verify-task` is what stands in its place.

*Distinguish from:* [implementer](#implementer), whose session it runs inside, and the
[human operator](#human-operator), who alone judges a manual test.

### translator

Opus 5.5, once per [project](#project), with two [approval gates](#approval-gate). Turns an
unstructured idea into a structured project definition — [VISION.md](#vision-visionmd), the only
thing it writes — by interrogating the [human operator](#human-operator) until nothing is
ambiguous. It never asks what its input already answers, and each question names what is ambiguous
and why it matters. It structures and clarifies; it decides no scope, no MVP, no stack and no
architecture. The idea may arrive in Spanish or English; its output is always technical English.

*Distinguish from:* [architect](#architect) and [planner](#planner). The translator establishes
*what* is to be built; the architect and the planner decide *how*.

### Historical note — the Spanish originals

The first five roles were named in Spanish. The mapping is recorded once, here, for anyone
reading early notes. The `architect` and the `integrator` were named in English from the start, in
`4.0.0`. All identifiers, paths, frontmatter values and commands are English.

| English | Spanish original |
|---|---|
| `translator` | traductor |
| `planner` | planificador |
| `implementer` | implementador |
| `tester` | testeador |
| `committer` | registrador — retired in `4.0.0` |

---

## 6. Terms we deliberately do not use

Each of these carries baggage from a methodology the factory does not implement, or is ambiguous
in a way this glossary exists to prevent.

| Avoid | Why | Use instead |
|---|---|---|
| epic | Scrum hierarchy the factory has no equivalent for | [feature](#feature) |
| story, user story | implies a negotiable scope unit sized by estimation | [task](#task), or [acceptance criterion](#acceptance-criterion) |
| sprint | there are no timeboxes; work advances by dependencies and approval, not by calendar | [feature](#feature), [wave](#wave) |
| ticket, issue | there is no tracker; the plan is the only queue | [task](#task) |
| backlog | implies an unordered pool; the plan is ordered by its dependencies | [plan](#plan) |
| milestone | implies calendar planning the factory does not do | feature completion |
| graph, "the graph", task graph | names the [plan](#plan) by its data structure rather than its role | [plan](#plan) |
| contract, for the factory's rules | since `4.0.0` the bare word is game code | [factory contract](#factory-contract) |
| registry, for a game's own index | the factory's registries are records, not code | [shared file](#shared-file) |

---

## 7. Retired in 4.0.0

These terms named parts of the sequential pipeline that `4.0.0` replaced. They are kept so that an
[artefact](#artefact) stamped with an earlier [factory version](#factory-version) can still be read.
None of them may be used to describe the current factory.

### Commit message artefact

**Was:** the commit message text the [committer](#committer) wrote to its registry and echoed in
chat, for the [human operator](#human-operator) to paste into a commit only the operator made.
**Now:** the [integrator](#integrator) writes the message into the merge commit it makes itself, at
[integration](#integration); there is no separate artefact.

### committer

**Was:** the Haiku 4.5 agent that produced commit message and pull request text once per task and
per feature, and owned `qa_passed → done`. **Now:** absorbed by the [integrator](#integrator).

### Cycle

**Was:** one pass of a task through implement → test → approve, three sessions long. **Now:** no
approval sits inside a [task](#task), so the term has nothing to name; a task is one
[implementer](#implementer) [session](#session).

### Feature planning

**Was:** the planner session that wrote the task files of one feature, once the previous feature's
pull request had merged. **Now:** the planner plans by [wave](#wave), and a wave may cross
features.

### Fix cycle

**Was:** a repeat pass through implementation and verification after the tester returned `FAIL`,
driven by a [fix handoff](#fix-handoff). **Now:** the tester returns no verdict. A task that cannot
pass goes through [escalation](#escalation), and then to a [blocked file](#blocked-file).

### Fix handoff

**Was:** the handoff the tester wrote to the implementer when a task failed verification. **Now:**
nothing replaces it: `verify-task` fails the task in the implementer's own session, and what cannot
be fixed there becomes a [blocked file](#blocked-file).

### Project planning

**Was:** the planner session that chose the stack and the architecture and produced the whole task
queue. **Now:** the stack, the architecture and the [contracts](#contract) belong to the
[architect](#architect); the planner's first session writes [wave](#wave) 0 and wave 1.

### Task plan (tasks.yaml)

**Was:** the index `tasks.yaml` plus one file per task, executed one task at a time, with status
held in the index. **Now:** the [plan](#plan) — a directory of [task files](#task-file) with no
index, each holding its own [status](#status).

### Test report

**Was:** the tester's registry entry recording a verification — command output, coverage and both
verdicts. **Now:** the tester emits no verdict. Its [registry](#registry) entry records what the
automated tests cover, and anything a person must judge goes to a [manual test](#manual-test).

### `in_qa`, `qa_passed` and `done`

**Were:** the [status](#status) values between implementation and commit, owned by the implementer,
the tester and the committer. **Now:** `implemented`, written by `verify-task`, and `integrated`,
written by the [integrator](#integrator).
