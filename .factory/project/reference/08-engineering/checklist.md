# Engineering checklist

- **Status:** approved 2026-09-30
- **Sources:** `architecture.md` · `design-patterns.md` · `coding-standards.md` · `testing.md`
- **Read by:** the tester, on every task, against the files the task wrote or changed. Each item it
  fails goes to the implementer as a finding: the item's id, the file and line, what is missing.

Every item is answerable yes or no from the task's diff. An item that does not apply to the task —
no decorator, no seed — is answered `n/a`, never skipped silently. The reference in brackets is where
the rule and its examples are.

## Architecture

- [ ] **A1** The file sits in `lib/features/<feature>/<layer>/` or `lib/core/<area>/`, in the layer its content belongs to. [architecture §1, §3]
- [ ] **A2** No feature imports another feature; features meet only through `lib/core/contracts/`. `lib/core/` imports no feature. [architecture §2.2]
- [ ] **A3** `domain/` and `application/` import no Flutter, Flame, `dart:io`, `dart:ui` or `dart:async`, and no outer layer. [architecture §3]
- [ ] **A4** `infrastructure/` and `presentation/` do not import each other. [architecture §3]
- [ ] **A5** A port used only inside the feature is in its `application/ports/`; one crossing features is a contract. [architecture §3]
- [ ] **A6** Contract types are translated into the feature's own model in `application/`, not used as its domain model. [architecture §2.2]
- [ ] **A7** Each aggregate changes only through its root; aggregates refer to each other by id; a use case changes one aggregate. [architecture §4]
- [ ] **A8** Aggregates record domain events; only `application/` publishes integration events. [architecture §4]
- [ ] **A9** No game rule in `lib/core/`; no shared module in `core/` imports a feature. [architecture §1, §2.4]
- [ ] **A10** Nothing in the per-frame path of a hot loop allocates. [architecture §6]

## Design patterns

- [ ] **P1** An item, scroll, effect or status added to a character or enemy is one decorator over its loadout, overriding only what it changes. [patterns §1]
- [ ] **P2** Decorator chains are rebuilt when the modifiers change, in the fixed layer order, never every frame; durations live in the aggregate. [patterns §1]
- [ ] **P3** Items cross features as `LoadoutModifier` data, and each feature builds its own decorator from it. [patterns §1]
- [ ] **P4** Each ability is an `ActiveAbility` or `TriggeredAbility` strategy returning an `AbilityOutcome`; enemy brains and weapon move sets are strategies. [patterns §2]
- [ ] **P5** No `switch` or `if` chain over a kind, ability or weapon id picks behaviour. [patterns §2, standards §6]
- [ ] **P6** Postures and boss phases are state objects; transitions live in them. [patterns §3]
- [ ] **P7** Data shared by a kind is one flyweight, referenced, never copied into instances. [patterns §4]
- [ ] **P8** Features receive `PlayerCommand`s, never keys or mouse events. [patterns §5]
- [ ] **P9** Short-lived per-frame objects come from a pool. [patterns §8]
- [ ] **P10** No singleton, static mutable state, service locator or class that knows every feature. [patterns §14]

## The rules of this game

- [ ] **G1** No code outside `lib/core/loop/` reads a clock; logic receives `dt` as `Seconds`. [standards §8]
- [ ] **G2** No unseeded `Random()`; every random choice comes from a `Seed` passed in. [standards §8]
- [ ] **G3** Every player-visible string goes through the translator by key. [standards §8]
- [ ] **G4** Tile ↔ world conversion only through `TileCoord`; no stray `* 32`. [standards §8]
- [ ] **G5** No stroke is regenerated per frame; its geometry comes from its fixed seed. [standards §8]
- [ ] **G6** Every value taken from a reference matches it and names it in a comment. [standards §9]

## Code

- [ ] **C1** Each class has one reason to change; a new kind, ability, item or action is a new class, not an edit of an existing one. [standards §1]
- [ ] **C2** Dependencies are interfaces, passed through the constructor; no implementation throws for a member its interface promises. [standards §1]
- [ ] **C3** Names come from the game's language and follow the table; none of the banned words. [standards §2]
- [ ] **C4** No function over 20 lines, 4 parameters or 2 levels of nesting; no class over 200 lines; no file over 300. [standards §3]
- [ ] **C5** Fields and locals are `final` unless they must change; values, decorators and strategies are immutable; no internal collection leaks. [standards §5]
- [ ] **C6** No `dynamic`, no `as` outside tests, no unproven `!`, no `late` outside framework hooks and test `setUp`. [standards §6]
- [ ] **C7** Closed sets are `enum` or `sealed`, switched exhaustively without `default`; no boolean parameter switches behaviour. [standards §6]
- [ ] **C8** No empty or untyped `catch`; expected failures are a sealed result; platform exceptions stay in `infrastructure/`. [standards §7]
- [ ] **C9** Comments say why; ports, decorator bases and strategy interfaces have `///` docs; no commented-out code; no `TODO` without a task id. [standards §9]
- [ ] **C10** `dart format` leaves the files unchanged and `flutter analyze --fatal-infos` is clean; every `// ignore:` says why. [standards §10]

## Tests

- [ ] **T1** Each test file mirrors its production file's path under `test/`, and each criterion's test has its `Test name` verbatim. [testing §2]
- [ ] **T2** Each test checks one behaviour, given–when–then, through returned values, events or port calls that are the effect — never private state or internal call order. [testing §3, §4.2]
- [ ] **T3** Collaborators and ports are mocked with `mocktail`; the unit under test, value objects and kernel types are real; nothing from Flame, Flutter or `dart:io` is mocked directly. [testing §4.1]
- [ ] **T4** Tests are deterministic: fixed seed, fixed `dt`, no clock, no sleep, no network. [testing §3]
- [ ] **T5** Doubles are compared with a stated tolerance; values a reference fixes are asserted exactly and name it. [testing §3]
- [ ] **T6** Each decorator, strategy, handler, state and factory the task adds is tested as §5 says for its pattern. [testing §5]
- [ ] **T7** Every seeded factory, generator or system has a same-seed / different-seed test; every stroke primitive an identical-geometry test. [testing §6]
- [ ] **T8** No golden image and no wall-clock assertion. [testing §5, §8]
