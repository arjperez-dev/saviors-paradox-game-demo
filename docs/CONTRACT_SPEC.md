# Contract Specification

This document specifies everything the [architect](GLOSSARY.md#architect) writes into a game: the
[contracts](GLOSSARY.md#contract) under `contracts/`, the [stubs](GLOSSARY.md#stub) that implement
them in name only, and the `CLAUDE.md` files that state the facts of the project and of each
[module](GLOSSARY.md#module). The three are one writer's output, written in one session under the
same two [approval gates](GLOSSARY.md#approval-gate), and they are specified together because each
refers to the other two.

None of it is a factory [artefact](GLOSSARY.md#artefact). It is the game's own code and the game's
own facts: it lives outside `.factory/`, it carries no `factory_version`, and it survives the day a
game stops using the factory.

Vocabulary is fixed by [`GLOSSARY.md`](GLOSSARY.md); paths by
[`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md); what a [task file](GLOSSARY.md#task-file) says about
the contracts it consumes by [`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md); where the architect's reasoning goes by
[`REGISTRY_SPEC.md`](REGISTRY_SPEC.md); the gates by [`APPROVAL_PROTOCOL.md`](APPROVAL_PROTOCOL.md).

Two properties hold, and everything below follows from one of them:

- **A contract is code.** It is the source file that declares an interface, compilable from the
  first day, never prose describing one.
- **Only the architect writes any of it**, always under its two gates. No other agent edits
  `contracts/`, a stub it has not replaced, or a `CLAUDE.md`.

---

## 1. A contract is code

The parallel pipeline depends on this decision more than on any other. A task that consumes a
contract declares it in `depends_on_contract`, and that dependency **never makes the task wait**,
because the contract already exists. "Already exists" means something only if the task's code can
**import the contract and compile** against it before the module implementing it is finished. Were
the contract prose, something would have to turn it into code, nothing does, and every contract
dependency would block again.

So a contract contains **declarations and nothing else**: types, fields, signatures, the values of
an enumeration. It contains no behaviour, because behaviour is what tasks build — the value semantics
of a `kernel/` type are the one exception (§2) — and no reasoning,
because a comment explaining why the contract has its shape is prose that will drift from the code
beneath it. **Why a contract looks the way it does goes to the architect's
[registry](GLOSSARY.md#registry)**, one entry per contract, and never into the contract's file.

A contract is written in the game's own language, in the notation the stack uses, because what
reads it is a compiler.

---

## 2. The three forms

```text
contracts/
  events/<event_file>.<ext>     # a domain event
  state/<state_file>.<ext>      # shared state, read-only for everyone but its owner
  ports/<port_file>.<ext>       # an interface one module implements and another consumes
  kernel/<value_file>.<ext>     # a value type every module uses with the same meaning
```

| Folder | Declares | Example |
|---|---|---|
| `events/` | Something that happened: immutable, with its data | `PlayerJumped { at: number, from: Vec2 }` |
| `state/` | A shape of shared state, **read-only** to every module but the one that owns it | `PlayerState { position, velocity, onGround }` |
| `ports/` | An interface between two modules | `InputSource { poll(): Action[] }` |
| `kernel/` | A value type of the **shared kernel**: the same meaning in every module — a duration, a vector, a seed, an id, a result | `Seconds`, `Vec2 { x, y; plus(other) }` |

**`kernel/` is the one folder whose files carry behaviour**, and only value semantics: construction
and its validation, equality, arithmetic and conversions of the value itself — `Vec2.plus`,
`TileCoord.toWorld`. A game rule is never kernel: `Health` belongs to the modules that have health,
`Damage` to the one that deals it. A kernel file has no stub, because it is complete when the
architect writes it; it is kept small, because a change to it reaches every module, and it is tested
by the first scaffolding task after the one that makes the contracts compile.

**One declaration per file**, and the file is named for it. A file declaring two events is two
contracts sharing a path, and a task can no longer depend on one without depending on the other.

**The contracts root is `contracts/`, or `<source_root>/contracts/` where the stack requires it.**
It sits at the repository root unless the stack's module system cannot import code from outside
`source_root` — Dart and Flutter, whose `package:` imports reach only `lib/`, are the case that
settled this. There it sits at `<source_root>/contracts/`, e.g. `lib/contracts/`. The root
`CLAUDE.md` names it as `contracts_root` in its `Paths` table (§5.1), and **everywhere the factory
contract and the harnesses say `contracts/`, they mean the contracts root**: nobody's module root,
written only by the architect, a stop for every other agent. Placed under `source_root`, it is still
never inside a module's root, and no module root is inside it.

**No other folder exists.** A project that finds something shared which is none of the four says so
to the [human operator](GLOSSARY.md#human-operator) rather than inventing a fourth; whether
`contracts/` needs more than these is decided with the first project that needs it, as an amendment
to this document.

### 2.1 The identifier is the path

A contract is named by its path under `contracts/`, **without the extension**:

```yaml
depends_on_contract: [events/PlayerJumped, state/PlayerState]
```

resolves to `contracts/events/PlayerJumped.<ext>` and `contracts/state/PlayerState.<ext>`. The
extension belongs to the stack and not to the [plan](GLOSSARY.md#plan): a plan written with `.ts` in
it is a plan that says something the planner did not decide.

**The file name follows the stack's convention for file names, and the declaration inside it the
stack's convention for a type.** Where the two are the same word — `PlayerJumped.ts` declaring
`PlayerJumped` — the file is named for the type. Where the stack requires otherwise — Dart's
`lower_snake_case`, enforced by the `file_names` lint — the file is `player_jumped.dart` and declares
`PlayerJumped`, and the identifier is still the path: `events/player_jumped`. The identifier never
departs from the file on disk, because a task depends on a file, and the planner and every check
resolve it by path.

---

## 3. Stubs

For every contract a module **implements** — a port it provides, a state it owns, an event it emits
— the architect writes the stub: the file the implementation will live in exists, imports the
contract, has the correct signature, and does nothing real.

```ts
// src/mechanics/player/jump.ts — a stub written by the architect
import { PlayerState } from "../../../contracts/state/PlayerState";
import { PlayerJumped } from "../../../contracts/events/PlayerJumped";

export function jump(
  state: PlayerState,
  pressed: boolean,
  now: number,
): [PlayerState, PlayerJumped | null] {
  return [state, null]; // not implemented
}
```

**The stub is what lets everything compile before anything is implemented**, and therefore what
makes tasks independent. A task that imports `PlayerState` from inside `visuals/` compiles and runs
its tests while `mechanics/` is still a set of stubs.

Four rules:

- **A stub is written in the same act as its contract, under the same gates.** A stub is a
  mechanical projection of a contract, and writing the two apart would create two artefacts that can
  disagree about one signature.
- **A stub returns the most neutral value its signature allows** — its input unchanged, an empty
  list, zero — and never throws. A stub that throws fails every test that happens to reach it, and
  the tests of a module that merely consumes the contract would fail for the wrong reason.
- **A stub has no tests.** The task that replaces it writes them.
- **A stub is replaced by exactly one task**, whose `files` names the stub's path. From then on the
  file is ordinary module code, and the architect does not touch it again.

Where each stub lives is declared in its module's `CLAUDE.md` (§5.2), so that the planner writing
the task that replaces it can name the path without searching for it.

The stubs are not the whole skeleton. The package manifest, the language configuration, the linter,
the test runner and the build are [wave](GLOSSARY.md#wave) 0, written by the planner as
[scaffolding tasks](GLOSSARY.md#scaffolding-task). The line falls where it does because a stub is a
projection of a contract and a package manifest is not: what shares an origin with a contract is
written with it, and what is tooling goes through the ordinary machinery of task files. **The
architect writes contracts and stubs as text on disk, with no compiler**; wave 0 is what makes them
compile.

---

## 4. Modules meet only through contracts

**A module never imports another module's code, except a shared module's.** What one module needs
from another it reaches through `contracts/`: it consumes a port, reads a state, reacts to an event,
or uses a kernel value. The concrete
implementation behind a port is connected to its consumers in a [shared file](GLOSSARY.md#shared-file)
— a system index, a composition root — and only the [integrator](GLOSSARY.md#integrator) edits one,
following the task file's `shared_file_notes`.

This is what keeps the modules parallel. A task that imports another module's implementation depends
on that module's **behaviour**, which is `depends_on_task` and makes it wait; a task that imports a
contract depends only on a declaration that already exists.

### 4.1 Shared modules

Some code is needed by many modules and owned by none: how a stroke is drawn, how a key becomes a
command, how a text is translated, how the game loop hands out `dt`. Reaching it through a port would
put an adapter in front of every call for no gain. Such a module is declared **`shared`** in the
module map (§5.1), and:

| Rule | Why |
|---|---|
| any module may import a shared module's code | that is what makes it shared |
| a shared module imports only `contracts/` and other shared modules — never a `feature` module | the dependency points one way; a shared module that knew a feature would tie every feature to it |
| a shared module holds no game rule | a rule belongs to the module whose part of the game it is |
| **a task imports a shared module only once the code it uses is on `main`** | a shared module is built by tasks like any other, and another feature sees that code only after its feature reaches `main` ([`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) §1.4). The planner states it as a `Precondition`, never as a `depends_on_task` across features |

The shared modules are therefore built early, in features of their own that reach `main` right after
`tooling`, and extended the same way: a feature that needs more of a shared module waits for the
feature that adds it. A feature branch already open does not receive it — `main` returns to a feature
branch only after a contract change ([`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) §1.5) — so the work
that needs it is planned in a feature cut after it reaches `main`.

### 4.2 How it is held

No script checks it. It is reviewed where it can still be cheap to fix: at the architect's gates,
where the module map and the contracts are drawn so that no module *needs* another's code, and at
the planner's gates, where every `Implementation` shows its imports.

It replaces the `architecture` block the plan could declare from `2.0.0` to `3.0.1`, with its layers
and its `may_import` lists. A module map whose boundaries are crossed only through contracts is that
layering drawn at the level the parallel pipeline needs, and it binds the planner's code before it
binds anybody else's, exactly as the old block did.

---

## 5. `CLAUDE.md`

Claude Code loads a `CLAUDE.md` file on its own from the directory it works in and from every parent
of it. That makes it the right place for the facts every agent needs at every task, and the wrong
place for anything else: **every parallel [implementer](GLOSSARY.md#implementer) loads the root file
whole, at every task**.

Two scripts read it mechanically — `verify-task` reads the commands and the module map, and the file
gradient of [`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) resolves a path to a module through the map — so its shape is fixed
here down to the headings.

### 5.1 The root `CLAUDE.md`

Five sections, with these exact headings, in this order:

````markdown
# <Game title>

## Stack

- TypeScript 5.4
- Vite 5
- Vitest 1

## Commands

| Command | Value |
|---|---|
| `install_command` | `npm ci` |
| `test_command` | `npm test` |
| `lint_command` | `npm run lint` |
| `run_command` | `npm run dev` |
| `build_command` | `npm run build` |

## Paths

| Path | Value |
|---|---|
| `source_root` | `src` |
| `test_root` | `tests` |
| `contracts_root` | `contracts` |

## Modules

| Module | Kind | Roots |
|---|---|---|
| rendering | shared | `src/core/rendering/`, `tests/core/rendering/` |
| mechanics | feature | `src/mechanics/`, `tests/mechanics/` |
| visuals | feature | `src/visuals/`, `tests/visuals/` |
| integration | integration | `tests/integration/` |

## Rules

- Game logic never reads the clock directly; it receives a delta.
````

| Section | Required | Holds |
|---|---|---|
| `Stack` | always | One line per language, framework or tool, **with its version**. Each version is a current stable release, checked against a source the architect names in its registry |
| `Commands` | always | The commands exactly as typed. `install_command`, `test_command` and `lint_command` are required: the launcher runs the first in every new worktree, and `verify-task` runs the other two; `run_command` is required when the game can be run; `build_command` only on a stack where building is a step separate from testing |
| `Paths` | always | `source_root`, `test_root` and `contracts_root` (§2), repository-relative, no trailing slash |
| `Modules` | always | The module map (below) |
| `Rules` | optional | The few global rules every task must respect. A rule that concerns one module goes in that module's file. Where the game has engineering references (`.factory/project/reference/08-engineering/`), every rule derives from one and ends with its path in parentheses; a rule they do not support is not written |

**The commands are decided by the architect and made to work by wave 0.** The architect chooses the
stack and names the commands that will drive it; the scaffolding tasks of wave 0 write the manifest
and the configuration that make those commands exist. A command that does not work yet on the day it
is written is expected; a command wave 0 cannot make work is a finding for the architect.

**`install_command` is what makes a worktree usable.** Every task runs in its own worktree, and a
worktree shares the repository's history but not its installed dependencies. The launcher runs
`install_command` in each worktree it opens, before the implementer session starts, so no
implementer installs anything. The one agent that runs it is the integrator, in the feature's
integration worktree, after an integration changed the package manifest
([`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md) §3.3). Those two are the only network use of unattended
execution. It installs exactly what the
manifest and the lockfile already pin — `npm ci`, not `npm install` — because a worktree that
resolved different versions from its neighbours would test different code. Until wave 0 has written
the manifest, the command has nothing to install, and the `tooling` tasks run without it.

**An expected outcome never travels beside a command.** `test_command` is how the suite is run;
what passing means is each task's acceptance criteria. A count of tests that must pass is invented
before the tests exist, and wrong the moment the next task adds one.

**`source_root` bounds every search.** An agent looking for what else reaches the code it changed
searches from `source_root`, never from the repository root, because the root also holds `.factory/`,
and a text search from there returns registry entries and task files as incidental matches.

#### The module map

**Mandatory**, and the one table in the file a script depends on most. Each row is one module, its
**kind**, and **every root it owns, code and tests alike**, as backticked repository-relative paths
ending in `/`, separated by commas.

| Kind | Is |
|---|---|
| `feature` | a part of the game; imports `contracts/` and shared modules only |
| `shared` | code many modules import and none owns, with no game rule (§4.1) |
| `integration` | the tests that exercise several modules together |

- **Every file an implementer may write belongs to exactly one module.** Roots never overlap, and
  one root is never nested inside another module's root.
- **A module that only holds tests is a module.** Tests that exercise several modules belong to one
  the architect declares for them — `integration`, with its root under `test_root` — so that an
  integration-test task, like every task, belongs to one module.
- **`contracts/` is nobody's root.** No module owns it, which is what makes writing to it a stop
  for everyone but the architect.
- **`tooling` is reserved and never appears in the map.** It is the module of wave 0's scaffolding
  tasks, which write the root files that belong to no module
  ([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §3.3).
- **A path that is under no root is outside every module.** Shared files usually are, and
  deliberately: the implementer that reaches one stops.

The map is what makes the file gradient and check 5 of `verify-task` computable — which files a task
may touch without being listed, and which it may never touch. A module missing from the map, or a
root left out of a row, silently widens or narrows what every task in that module may do.

### 5.2 A module's `CLAUDE.md`

One file at the top of each module's code root, `<source_root>/<module>/CLAUDE.md`. Four sections,
and a fifth, `References`, before `Not here`, when the module answers for an approved
[reference](GLOSSARY.md#reference):

````markdown
# mechanics

## What it is

Movement, jumping and collision for every body in the game. It owns the player's physical state.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/PlayerState` | owns | `src/mechanics/player/state.ts` |
| `events/PlayerJumped` | emits | `src/mechanics/player/jump.ts` |
| `ports/InputSource` | consumes | — |

## Roots

`src/mechanics/`, `tests/mechanics/`

## Not here

- Drawing anything. Rendering belongs to `visuals`, which reads `state/PlayerState`.
````

| Section | Holds |
|---|---|
| `What it is` | One or two sentences |
| `Contracts` | Every contract the module touches, and its **role**: `implements` for a port, `owns` for a state, `emits` for an event, `consumes` for anything it only uses. A row with any role but `consumes` names its stub's path |
| `Roots` | The same roots as the module's row in the map, repeated so that an agent working inside the module sees them without opening the root file. The map wins where the two differ, and the difference is a defect for the architect |
| `References` | optional — the paths of the approved references the module answers for: the contract of its character, zone, item, piece of UI or sound. Paths only, one per line, never their content |
| `Not here` | What a reader would expect to find in this module and should not, and where it lives instead |

A module holding only tests has a `CLAUDE.md` at its test root, with no `Contracts` section.

**A link in `References` is not a read grant.** It tells a reader where the module's truth lives; an
implementer reads the references its task file cites, and no others
([`CONTEXT_POLICY.md`](CONTEXT_POLICY.md) §2.2).

### 5.3 What never goes in a `CLAUDE.md`

- **Reasoning.** Why this stack, why these modules, what was rejected — the architect's registry.
- **Instructions to an agent about how to work.** Those are the [harness](GLOSSARY.md#harness)'s,
  and a `CLAUDE.md` that restates one is a second copy of a rule.
- **Read boundaries.** They are the harness's `CONTEXT.md`. **Where a `CLAUDE.md` and a `CONTEXT.md`
  disagree, `CONTEXT.md` wins**, and the `CLAUDE.md` has a defect.
- **A `factory_version` stamp.** These are facts of the game, not factory artefacts.

**The root file stays short.** Facts and commands, never argument. Every line of it is loaded by
every implementer session of every task, and it is paid for at parallel width.

---

## 6. Changing a contract

Changing a contract is the one change to a project that always passes through a human gate, and the
most expensive operation the factory has: N tasks may already have code written against it.

1. **An implementer that finds a contract insufficient stops.** It writes a
   [blocked file](GLOSSARY.md#blocked-file) with `needs: architect` and ends its session. It never
   edits the contract, and never works around it in its own module.
2. **The human operator summons the architect**, who revises the contract **and its stub** in the
   same session, under its two gates. Where the stub has already been replaced by a real
   implementation, the architect names that file in its gate-2 write set, because changing a
   signature changes it too.
3. **The architect records the change** in its registry, in a `change-NN` session
   ([`REGISTRY_SPEC.md`](REGISTRY_SPEC.md)), and updates the affected modules' `CLAUDE.md` when a
   role or a stub path moved.
4. **The planner replans afterwards** the tasks the change invalidated, and it alone returns the
   blocked task to `pending`. The architect sets the status of no task.

The same path serves a boundary problem: an implementer whose task needs to write outside its own
module writes `needs: architect` too, because where a module ends is the architect's decision. The
answer may be a changed map rather than a changed contract.

A **new** contract follows the same path. Nothing is added to `contracts/` outside an architect
session.

---

## 7. Worked example

The architect's whole output for a small platformer, before wave 0 has run. Nothing here compiles
yet, and nothing needs to.

```text
my-game/
  CLAUDE.md                                  # §5.1
  contracts/
    events/PlayerJumped.ts
    state/PlayerState.ts
    ports/InputSource.ts
    ports/System.ts
  src/
    mechanics/
      CLAUDE.md                              # §5.2
      player/state.ts                        # stub — owns state/PlayerState
      player/jump.ts                         # stub — emits events/PlayerJumped
    input/
      CLAUDE.md
      keyboard.ts                            # stub — implements ports/InputSource
    visuals/
      CLAUDE.md                              # consumes state/PlayerState; no stubs
  tests/
    integration/
      CLAUDE.md                              # a test-only module
```

`contracts/state/PlayerState.ts` is a declaration and nothing else:

```ts
export interface PlayerState {
  readonly position: { readonly x: number; readonly y: number };
  readonly velocity: { readonly x: number; readonly y: number };
  readonly onGround: boolean;
}
```

Reading it: every field is `readonly`, because only `mechanics` owns this state and every other
module reads it. `visuals`
owns no contract and so has no stub; its first task writes real code that imports `PlayerState`
and compiles against `mechanics/player/state.ts` while that file still returns a neutral value. The
wiring of `input/keyboard.ts` into the game loop lives in a shared file under no module's root, and
the integrator will add it when the task implementing `InputSource` is integrated. The architect's
registry holds one entry per decision — `stack`, `modules`, and one per contract — under
`registry/architect/project/`.
