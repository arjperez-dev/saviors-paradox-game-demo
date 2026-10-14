# Documentation

The twelve documents that define the Conectium Game Factory. Together with `.factory/`, this
directory **is** the factory — it is copied into every game repository, and the operator reads it
there without leaving the project.

These are specifications, not guides. Three rules settle any disagreement between them:

1. **[`GLOSSARY.md`](GLOSSARY.md) wins on vocabulary** against every other document.
2. **A protocol document beats a descriptive one.** Where [`ARCHITECTURE.md`](ARCHITECTURE.md) and a
   protocol disagree, the protocol wins and `ARCHITECTURE.md` has a defect worth reporting.
3. **The more specific document wins** in every other case.

---

## Start here

| Document | What it is | Read it when |
|---|---|---|
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | The six agents as a system: why the pipeline runs in parallel, the three gated seats, where a person stops the work, what flows between agents, how the work is checked and what happens when it fails, and the cost model behind every structural choice | First, and again whenever a detail in a protocol stops making sense on its own |
| [`GLOSSARY.md`](GLOSSARY.md) | The canonical vocabulary — including the three pairs that must never blur and the nine terms the factory refuses to use | A term is ambiguous, or you are about to invent one |
| [`BOOTSTRAP.md`](BOOTSTRAP.md) | Installing the factory into a new game repository, then the first run command by command: the three gated sessions, the launcher's first wave, and the pull request that leaves a game that compiles — plus the prompt for every gated session | Day one of a new project |
| [`WORKFLOW.md`](WORKFLOW.md) | The operator's loop and the commands between its steps, then one wave walked end to end across two features, with every real artefact — including an escalation, an integration that conflicts and is replanned, and a manual test that fails and becomes a bug | Every day after day one |

## The contracts

| Document | What it fixes |
|---|---|
| [`APPROVAL_PROTOCOL.md`](APPROVAL_PROTOCOL.md) | The two gates of the three gated agents, what `APPROVED` means and what it buys, the shape of every report, the blocked report, and the blocked file an unattended agent writes when it cannot proceed |
| [`CONTRACT_SPEC.md`](CONTRACT_SPEC.md) | What the architect writes into a game: `contracts/` as code in three forms, the stubs that let the game compile before anything is implemented, the rule that modules meet only through contracts, the exact shape of the root and module `CLAUDE.md`, and how a contract is changed |
| [`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) | The plan — a directory of task files, one per task, each carrying its own status: the format, what is binding, the two kinds of dependency, the file gradient, the status lifecycle and what `verify-task` requires, the rules the planner writes under, what a reading agent checks, and how replanning and bug task files work |
| [`REGISTRY_SPEC.md`](REGISTRY_SPEC.md) | The registries: one file per entry under one path grammar for all six agents, the five-field entry and its 15-line cap, where the PR body lands, and who reads whose |
| [`CONTEXT_POLICY.md`](CONTEXT_POLICY.md) | What each of the six agents may read, write and run in git, stated as grants rather than prohibitions — plus which checkout each works in, the three uses of the network, and an honest account of which boundaries anything enforces |
| [`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) | Feature and task branches and their worktrees, why `.factory/` is committed only on `main`, the task commit and the integrator's merge commit, the per-feature lock, pull requests, and the three git actions that stay with a person |

## The infrastructure

| Document | What it fixes |
|---|---|
| [`HARNESS_SPEC.md`](HARNESS_SPEC.md) | The two shapes every harness implements — gated and unattended — their files and sections, the six cross-cutting rules copied verbatim into all six, and how to add a seventh agent |
| [`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md) | The physical layout, exactly what travels into a game repository, what is tracked in git, and how the factory is versioned |

---

## What is not part of this contract

Three directories at the repository root are *about* the factory rather than part of it. None of
them **ever travels** to a game repository, and if one disagrees with a document above, the document
above is right.

| Directory | What it is | Read it for |
|---|---|---|
| [`factory-build/`](../factory-build/README.md) | The build records, one folder per major version of the factory they built: [`v1/`](../factory-build/v1/00-index.md), the plan that built the sequential factory of `1.0.0`, and [`v4/`](../factory-build/v4/00-architecture.md), the design the parallel factory of `4.0.0` was written from. Both are finished, and kept for their reasoning | why a rule is shaped as it is |
| [`factory-research/`](../factory-research/README.md) | What the factory has learned about itself, and research on where it could go next | evidence, and open questions |
| [`factory-tests/`](../factory-tests/README.md) | The tests of the four [factory scripts](GLOSSARY.md#factory-scripts), which CI runs on Linux and Windows against a simulated Claude Code | what the scripts are verified to do |

`factory-research/` is the most dangerous of the three to misread. It holds evidence and open
questions, not rules — a number in it describes what happened once, and a note in it describes
something the factory does **not** do. Nothing there becomes real until it lands here or in
[`ROADMAP.md`](../ROADMAP.md).

`factory-tests/` stays behind for a different reason: it tests the scripts in the factory
repository, and a game runs them without testing them. What the scripts must do is fixed here —
[`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §4–§5 and [`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) §3–§4 —
and the tests are how the factory repository checks that they do it.

**Only this directory and `.factory/` travel, and nothing else does.** That is why the three sit at
the root: a directory that has to be copied and then deleted is a step an operator can forget
([`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md) §2).

`GIT_CONVENTIONS.md` governs **game** repositories. The factory repository itself is governed by
[`CONTRIBUTING.md`](../CONTRIBUTING.md), which diverges where the factory has consumers, releases, a
tracker and CI — and a game has none of them.
