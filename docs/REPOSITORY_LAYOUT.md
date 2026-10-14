# Repository Layout & Versioning

This document defines the physical layout of the Conectium Game Factory, exactly which parts
of it are copied into a game repository, what is tracked in version control, and how the
factory is versioned.

Every other document and every harness writes files into the layout defined here. If a path is
not described in this document, it does not exist.

---

## 1. The factory repository

The factory repository contains **only infrastructure** — the six harnesses, the factory scripts
and their documentation. No game code lives here. Games live in their own repositories and receive
the factory as a copied template.

```text
conectium-game-factory/
  README.md                        # master readme: what the factory is, how to start
  LICENSE                          # proprietary notice
  CONTRIBUTING.md                  # how the factory repository itself is changed
  CHANGELOG.md                     # every factory contract change, by version
  ROADMAP.md                       # what is deferred, and why
  .gitattributes                   # normalise text to LF
  .markdownlint.json               # lint rules for the corpus
  release-please-config.json       # release automation; a visible type is releasable
  .release-please-manifest.json    # the version the release tooling considers current
  .github/                         # issue and PR templates, three CI workflows
  .githooks/                       # commit-msg and pre-push, activated per clone
  factory-build/                   # build records, one folder per factory generation — does NOT travel
    v1/                            # the plan that built 1.0.0
    v4/                            # the design 4.0.0 was written from
  factory-research/                # measured evidence about the factory — does NOT travel
  factory-tests/                   # tests of the factory scripts, run by CI — does NOT travel
  docs/                            # general factory documentation — travels whole
    README.md                      # index of the twelve, and the precedence rules
    REPOSITORY_LAYOUT.md           # this document
    GLOSSARY.md                    # canonical vocabulary; every other doc defers to it
    ARCHITECTURE.md                # the six-agent pipeline and how work flows through it
    APPROVAL_PROTOCOL.md           # the two gates of the three gated agents
    CONTRACT_SPEC.md               # contracts/ as code, their stubs, how one changes
    TASK_FILE_SPEC.md              # format of the task file, the plan's only artefact
    REGISTRY_SPEC.md               # format of the registry entries
    CONTEXT_POLICY.md              # what an agent may load into context, and with what
    GIT_CONVENTIONS.md             # branches, worktrees, commits, merges and PRs
    HARNESS_SPEC.md                # the two shapes every harness implements
    BOOTSTRAP.md                   # installing the factory into a new game repository
    WORKFLOW.md                    # end-to-end operator workflow
  .factory/                        # ← the template, copied verbatim into game repositories
    FACTORY_VERSION                # semver of the whole factory contract, e.g. 4.0.0
    .gitignore                     # one line: locks/
    project/                       # the vision; empty in the template
    tasks/                         # the plan; empty in the template
    registry/                      # registry entries; empty in the template
    blocked/                       # blocked files; empty in the template
    manual-tests/                  # manual tests; empty in the template
    scripts/                       # the four factory scripts, Python 3.13 or newer
      factory_lib.py               # what the four share
      dispatch.py
      launch.py
      verify-task.py
      integrate.py
    harnesses/                     # one directory per agent, in one of two shapes
      translator/
      architect/
      planner/
      implementer/
      tester/
      integrator/
```

The internal contents of each harness directory (rules, process, boundaries, templates) are
defined in `HARNESS_SPEC.md`. This document fixes only their location. **No artefact lives inside a
harness directory**: a harness holds what constrains its agent, never what its agent produces.

### Why artefacts are keyed by task, not by agent

Until `4.0.0` every artefact lived inside the harness of one agent — a handoff in its reader's, a
registry in its writer's — and a central directory was rejected because the path alone made each
agent's read boundary unambiguous. That argument assumed one agent working at a time. Under
parallel execution the property that matters is a different one:

> **One file, one writer.** Any artefact two agents could write at the same time is split until
> every file has exactly one writer.

| Artefact | Writers that could collide | Resolved by |
|---|---|---|
| The plan | N implementers changing a status | One [task file](GLOSSARY.md#task-file) per task |
| The registries | **Three agents on the same task** — implementer, tester, integrator — times N tasks | `registry/<agent>/<scope>/<entry>.md`: the agent segment separates the three, the scope and entry segments separate the N |
| The blocked files | N implementers and the integrator | `blocked/<feature>/<task-id>.md` |
| The manual tests | N testers | `manual-tests/<feature>/<task-id>.md` |
| The game's shared files | N implementers | **Only the integrator edits them** — see [shared file](GLOSSARY.md#shared-file) |
| The contracts | — | Only the architect, under its two gates |

That is why the four artefact directories share one shape, keyed by feature and task. The read
boundary did not disappear; it moved out of the path and into each harness's `CONTEXT.md`, as a
matrix fixed by `CONTEXT_POLICY.md`.

The registry of an agent that does not work per task — the translator, the architect, the planner
— has no task id to key it by. It is keyed by session and decision instead, under the same grammar;
[`REGISTRY_SPEC.md`](REGISTRY_SPEC.md) §2.3 fixes both.

---

## 2. A game repository after bootstrap

```text
my-game/
  CLAUDE.md                                   # architect — project facts and the module map
  contracts/                                  # architect — game code; under source_root where
    events/<event_file>.<ext>                 #   the stack requires it (CONTRACT_SPEC.md §2)
    state/<state_file>.<ext>
    ports/<port_file>.<ext>
  <module>/
    CLAUDE.md                                 # architect — module facts
    ...                                       # the module's code, stubs first
  tests/<module>/...
  .factory/
    FACTORY_VERSION
    .gitignore                                # locks/
    project/VISION.md                         # translator
    project/reference/                        # the operator — approved references, indexed in README.md
    tasks/<feature>/<task-id>.md              # planner
    registry/<agent>/<scope>/<entry>.md       # each agent, in its own subtree
    blocked/<feature>/<task-id>.md            # implementer or integrator
    manual-tests/<feature>/<task-id>.md       # tester
    locks/<feature>.lock                      # integration trigger's lock — never committed
    scripts/
    harnesses/<agent>/
  docs/                                       # the factory contract, copied
```

Immediately after bootstrap only `.factory/` and `docs/` exist. The
[architect](GLOSSARY.md#architect) writes `contracts/`, the [stubs](GLOSSARY.md#stub) and every
`CLAUDE.md`; [wave](GLOSSARY.md#wave) 0 writes the package manifest, the tooling and the root
`.gitignore`; the tree of modules is whatever the module map declares.

**Everything the factory owns lives under `.factory/`, with two exceptions that belong to the game
rather than the factory:** `contracts/`, which is code the game compiles, and the `CLAUDE.md`
files, which Claude Code loads from wherever they sit. Keeping the rest under `.factory/` preserves
the `source_root` rule: a recursive search starts from the root of the game's code, never from the
root of the repository, so a text search never returns registry entries as incidental matches.

Three kinds of path sit **outside** the repository, as its siblings, and belong to no commit: the
integration worktree of each open feature, `../wt-feat-<feature>`; the worktree of each running task,
`../wt-<task-id>`; and the launcher's session logs, `../logs/`.
[`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) §1 fixes how worktrees are created and removed.

### What travels at bootstrap

| Path | Copied into the game repository? |
|------|----------------------------------|
| `.factory/` | **always** — this is the template |
| `docs/` | **always**, and whole — the operator needs the workflow and protocol docs on site |
| `factory-build/` | **never** — its records are the plan and the design the factory was built from, not for using it, and not contract |
| `factory-research/` | **never** — it is evidence *about* the factory, and it is not contract |
| `factory-tests/` | **never** — it tests the scripts in the factory repository; a game runs them, it does not test them |
| `README.md` | **never** — the game repository has its own readme |
| everything else at the root | **never** — it governs the factory repository, not a game |

**The line is the repository root.** `.factory/` and `docs/` travel; nothing else does. That is
why the build plans and the research directory sit at the root rather than under `docs/`: a
directory that must be copied and then deleted is a step an operator can forget, and a checklist item
that exists only to catch that forgetting.

`docs/` travels because the human operator works inside the game repository and must be able
to read the approval protocol, the task file format and the workflow without leaving it. The
copy is a snapshot: it corresponds to the `FACTORY_VERSION` in effect at bootstrap.

The exact copy procedure is defined in `BOOTSTRAP.md`.

---

## 3. Version control policy

| Path | Tracked in the game repo? | Why |
|------|---------------------------|-----|
| `.factory/harnesses/**` | yes | project infrastructure — the agents' rules are part of the project |
| `.factory/scripts/**` | yes | project infrastructure — the mechanical half of the pipeline |
| `.factory/project/**` | yes | the canonical project definition |
| `.factory/tasks/**` | yes | the plan, and the status of every task in it |
| `.factory/registry/**` | yes | decisions and evidence must survive the session that produced them |
| `.factory/blocked/**` | yes | why a task stopped, and what was tried — the record replanning starts from |
| `.factory/manual-tests/**` | yes | what a person checked, and the verdict they wrote |
| `.factory/locks/**` | **no** | runtime state of a running integration; committing it records nothing |
| `.factory/FACTORY_VERSION` | yes | tells you which factory contract the artefacts around it were produced under |
| `.factory/.gitignore` | yes | the one exclusion the factory makes |
| `docs/**` | yes | the operator's on-site reference |

**The factory excludes exactly one thing: its locks.** Everything else under `.factory/` is
committed — a historical record that is not versioned is not a historical record. Task files,
registry entries, blocked files and manual tests are the factory's memory: they are how a future
operator, or a future agent, reconstructs why the project looks the way it does. Excluding them to
keep the repository tidy would trade the one property that makes the pipeline auditable for nothing
of value.

A lock is the opposite case. `locks/<feature>.lock` exists only while an integration into that
feature runs, and says nothing once it has finished. The exclusion lives in `.factory/.gitignore`,
not in the root `.gitignore`: it travels with the template, it never collides with the one the
game writes in wave 0, and it keeps the boundary visible — what the factory excludes lives inside
`.factory/`, what the game excludes lives at the root. Every other exclusion in a game repository —
`node_modules/`, `dist/`, `__pycache__` and their relatives — is the game's.

Empty template directories carry a `.gitkeep` file so the layout survives cloning. These are
placeholders, not content: an agent writing its first real artefact into such a directory may
leave the `.gitkeep` in place or remove it — either is correct.

---

## 4. Versioning

The factory carries **one global version** at `.factory/FACTORY_VERSION`, a single semver line
(e.g. `4.0.0`) covering the whole factory contract — not one version per harness.

The six harnesses share the artefacts they pass between them. A change to the shape of one touches
every agent that reads or writes it, so a per-harness version would only record which harness
happened to be edited, not what an artefact can be trusted to mean. One version answers the
question that actually matters: *under which factory contract was this produced?*

Every artefact the factory generates records the `factory_version` it was produced under: the
[vision](GLOSSARY.md#vision-visionmd), every [task file](GLOSSARY.md#task-file),
[blocked file](GLOSSARY.md#blocked-file), [registry](GLOSSARY.md#registry) entry and
[manual test](GLOSSARY.md#manual-test). The stamp is uniform on purpose: every factory artefact
carries it, so nobody has to remember which ones do, and every one of them can be traced to the
factory contract it was written under. The game's own artefacts — [contracts](GLOSSARY.md#contract),
[stubs](GLOSSARY.md#stub), `CLAUDE.md` files — carry none.

What an agent does when the stamp on a task file differs from its own `FACTORY_VERSION` is
[`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §7.1. The task file is the only artefact an agent acts on,
so it is the only stamp an agent checks.

### What triggers a bump

| Bump | Trigger |
|------|---------|
| **MAJOR** | A breaking change to the factory contract: a field of a factory artefact removed, renamed, or given different semantics; an agent added to or removed from the pipeline; a change to the approval gates; any change that makes artefacts produced under the previous version unreadable or misleading without migration. |
| **MINOR** | A backwards-compatible addition: a new optional field of a factory artefact, a new registry entry type, a new harness rule that does not invalidate existing artefacts, a newly documented procedure. Everything produced under the previous version remains valid and correctly interpreted. |
| **PATCH** | No change to behaviour or factory contract: wording, clarification, examples, typo and formatting fixes, corrections to a document that made a rule ambiguous without changing the rule. |

A change to a game's [contracts](GLOSSARY.md#contract) never moves the factory version. Contracts
are game code; the factory version numbers the factory contract, and nothing else.

The version was initialised at `0.1.0` while the factory was being written and promoted to `1.0.0`
by the consistency pass that released it. While the major version is `0`, the factory contract is
still settling and a MAJOR-class change is recorded as a minor bump, per ordinary semver practice;
from `1.0.0` onwards the table above governs unmodified.

A game repository bootstrapped under one version does **not** upgrade automatically. Its
`.factory/` is a copy that evolves with the project; adopting a newer factory version is a
deliberate act by the operator. A game bootstrapped under `3.x` does not migrate to `4.0.0` at all:
adopting it means rewriting the game's whole plan.

---

## 5. Plugin readiness

The factory is expected to be packaged as a Claude Code plugin eventually, with each agent's
harness launchable by agent name. This layout must remain compatible with that packaging:

- All six harnesses sit side by side under `.factory/harnesses/`, addressable by agent name.
- No harness *file* references another harness's files. Artefact paths **are** shared — every
  agent reads task files out of `.factory/tasks/`, and the integrator reads the implementer's
  registry entries — but nothing in one harness's identity, rules, process or boundaries depends on
  another harness's text. Where one agent starts another, as the implementer starts the tester, it
  does so by agent name, never by a path into the other harness.
- Nothing depends on the factory living at a particular absolute path. The scripts resolve every
  path from the repository they run in.

We are deliberately **not** building the plugin. The requirement here is only that doing so later
should not force a re-layout of the repository.
