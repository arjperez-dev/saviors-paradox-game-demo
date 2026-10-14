# Architecture

- **Status:** approved 2026-10-14 (step 5.2: §2.1 lists the twenty features the architect fixed, §2.3 is
  the acyclic context map by rings, §2.4 adds `WorldBox` and the shared ids; before, approved 2026-09-30,
  version 1)
- **Sources:** `VISION.md` §Client constraints (OOP, DDD, Clean Code, Decorator, Flyweight, optimal
  performance), §Mechanics, §Content scope · `docs/CONTRACT_SPEC.md` §1–§4 · the architect's step 5.2
  session (the root `CLAUDE.md`, `lib/core/contracts/`, `.factory/registry/architect/project/`)
- **Read by:** the architect for the module map, the contracts and every `CLAUDE.md`; the planner
  for every `Implementation`; the implementer and the tester when a task cites it.

How the game's code is organised: **Clean Architecture split per feature**, with **Domain-Driven
Design** deciding where the feature boundaries fall and what lives inside each one. This document
says where code goes and what it may import. `design-patterns.md` says which pattern solves which
problem of this game; `coding-standards.md` says how each line is written. These three documents are
the most important references for the code.

---

## 1. The tree

```text
lib/
  core/                       what every feature shares — never game rules
    app/                      bootstrap and the composition root — shared files, edited by the integrator
    contracts/                the published language between features (the factory's contracts root)
      events/  state/  ports/
      kernel/                 the shared kernel: Seconds, Vec2, Seed, EntityId, TileCoord, Result
    loop/                     the game loop: reads Flame's dt, clamps it, steps the systems in order
    rendering/                the static pencil kit: seeded strokes, hatching, paper, ink smoke
    input/                    keyboard and mouse → player commands
    localization/             the translator, English and Spanish texts
  features/
    <feature>/
      domain/                 aggregates, entities, value objects, domain events, policies
      application/            use cases, systems, the feature's own ports, the anti-corruption layer
      infrastructure/         adapters: files, audio, Flame, platform
      presentation/           Flame components, Flutter widgets, controllers
test/
  core/<area>/…               mirrors lib/core/
  features/<feature>/<layer>/…  mirrors lib/features/, one test file per production file
  integration/                several features together, through the contracts
assets/
  audio/  images/  fonts/
```

**A feature has only the layers it needs.** `combat` may have no `infrastructure/`; `settings` may
be mostly `presentation/`. An empty layer folder is not created.

**`lib/core/` holds no game rules.** It holds what several features need and no feature owns: how
the game starts, the contracts, the shared kernel, how a stroke is drawn, how a key becomes a
command, how a text is translated. A rule about Akeris, an enemy or a zone in `core/` is in the wrong
place.

**How the factory sees this tree.** Each folder under `lib/features/` is a module of kind `feature`;
`core/loop`, `core/rendering`, `core/input` and `core/localization` are modules of kind `shared` —
importable by every feature, holding no game rule, and built early so their code is on `main` before
any feature imports it (`docs/CONTRACT_SPEC.md` §4.1). `core/contracts/` is the contracts root
(`contracts_root` in the root `CLAUDE.md`; `docs/CONTRACT_SPEC.md` §2 shows `lib/contracts/` only as its
Dart example), written only by the architect, `kernel/` included. `core/app/` is the composition root, the shared
files the integrator edits. A factory *feature* — a branch of work — may touch several of these
modules; a folder under `lib/features/` is a module, whatever the factory calls a feature.

**Each shared module follows the same layers as a feature (§3) where it has more than one.**
`core/rendering/domain/` generates a stroke's points from its seed in pure Dart, and
`core/rendering/presentation/` draws them on a Flame canvas; `core/contracts/` is pure Dart
throughout.

## 2. Features are bounded contexts

Each feature is one **bounded context** of the game: it owns a part of the game's language and the
rules that go with it, and nobody else writes them. The same word may mean different things in two
contexts — a "hit" in `combat` is a resolved collision with damage; in `rendering` it is a spark and
an onomatopoeia — and that is intended. Each context's words are in `00-game/glossary.md`: its
**ubiquitous language**, used the same way in conversation, in the references and in the code.

### 2.1 The features

Twenty features, fixed by the architect in step 5.2 (2026-10-14) and listed as modules in the root
`CLAUDE.md`. Each sits in one of the six rings of §2.3.

| Feature | Ring | Owns | Main aggregates |
|---|---|---|---|
| `dungeon` | 1 | zone generation, rooms, altars, boss rooms and their seal and stage, the collision world and its hook points | `Zone` |
| `combat` | 1 | hits, blocks, counters, reflects, damage, status effects, hitstop; the registry of combatants | `Engagement` (one exchange of attacks), `StatusEffects` |
| `akeris` | 2 | movement, postures, health, the resolved loadout, noise, death | `Akeris` |
| `chain` | 2 | the chain blades: throw, hook, swing, climb, anchor, snatch; what they do to Akeris's body (`ChainPull`) | `ChainPair` |
| `hazards` | 3 | what hurts, hinders or breaks in a zone: black water, open graves, poison pools, floor webs and web curtains, rotten roots, cracked stalactites, tombstones, merlons, the torch of zone 4 | `Hazard` |
| `enemies` | 3 | the twenty normal enemies, their brains, spawns and defeats | `Enemy` |
| `bosses` | 3 | the five bosses, their parts, phases and stage changes | `Boss` |
| `arsenal` | 3 | weapons, shields, their levels, breaks and repairs; XP, because only it spends XP | `Arsenal` |
| `inventory` | 3 | potions, scrolls, the cursed challenge, rage, taking from altars | `Satchel` |
| `abilities` | 4 | the ten abilities, the three equipped slots, the choice after a boss, revival | `AbilitySet` |
| `run` | 5 | the incursion as a **process manager**: zones in order, scaling, coins, the way down, death, victory; it credits XP drops to `arsenal` | `Run` |
| `narrative` | 5 | spirits, dialogue, the dialogue sheet, the memory of past runs | `SpiritMemory`, `Dialogue` |
| `settings` | 6 | volumes, language | `Settings` |
| `audio` | 6 | music per zone, sound effects, spirit voices | `Soundscape` |
| `cinematics` | 6 | the intro and the outro: their shots, cards and cues | `Cinematic` |
| `pause` | 6 | the pause menu: resume, the full inventory, manual save, quit to title | — (presentation) |
| `map` | 6 | the zone map on M and the minimap: what has been explored, kept with the run | `ZoneMap` |
| `save` | 6 | the three save slots, autosave, manual save; the **caretaker** of every feature's memento | `SaveSlot` |
| `hud` | 6 | health, shields, potions, abilities, boss health on screen | — (presentation) |
| `home` | 6 | the home screen, slot selection, new game, the locked shop | — (presentation) |

Against version 1 (2026-09-30): `hazards`, `map`, `pause` and `cinematics` are features of their own
(before, inside `dungeon`, `dungeon`, `hud` and `narrative`); XP moves from `run` to `arsenal`
(operator, 2026-10-14).

### 2.2 The rules between features

| Rule | Why |
|---|---|
| **A feature never imports another feature.** | the factory builds features in parallel; an import is a dependency on behaviour that may not exist yet (`docs/CONTRACT_SPEC.md` §4) |
| **Features meet through `lib/core/contracts/`**: an integration event, a published state, or a port | the contracts are the **published language** between contexts |
| **A feature may import `core/contracts/` and the shared modules** — `core/loop`, `core/rendering`, `core/input`, `core/localization` — once their code is on `main`; never `core/app/`. `lib/core/` never imports a feature | the shared parts point inward (`docs/CONTRACT_SPEC.md` §4.1) |
| **Each feature translates contract types into its own model at its edge**, in `application/` | this is its **anti-corruption layer**: a change in another context's language stops there |
| **Only `lib/core/app/` knows every feature** | the composition root builds each feature and connects its ports; its files are shared files, edited by the integrator |

### 2.3 The context map

Who may know whom. The twenty features sit in **six rings**, and **a feature knows only features in
its own ring or in an inner one**; inside a ring the order below holds. No two features know each
other: the map is **acyclic**. The architect fixed it in step 5.2 (2026-10-14) from the contracts;
the root `CLAUDE.md` lists the modules, this section the edges. "Knows" means: reads its `state/`,
hears its `events/`, calls a port it offers, or implements a port it declares — always through
`core/contracts/`, never by import (§2.2).

| Ring | Features, inner first | Why here |
|---|---|---|
| 1 | `dungeon`, `combat` | the world, and the resolution of hits: everything else happens in a zone and can be hit. `combat` knows `dungeon` (the collision world); `dungeon` knows nobody |
| 2 | `akeris`, `chain` | the player's body and its chains. `chain` knows `akeris` (it implements his `ChainBlades`); `akeris` knows nothing of `chain` |
| 3 | `hazards`, `enemies`, `bosses`, `arsenal`, `inventory` | what Akeris meets and carries. `inventory` knows `arsenal` and `enemies`; the rest know only rings 1 and 2 |
| 4 | `abilities` | the bosses' gifts: knows `bosses`, `akeris`, `combat` |
| 5 | `run`, `narrative` | the process manager and the story told over it. `narrative` knows `run` |
| 6 | `settings`, `audio`, `cinematics`, `pause`, `map`, `save`, `hud`, `home` | the shell: it reads, plays, draws and stores. `audio` knows `settings`; `cinematics` knows `audio`; `save` knows `pause` and `map`; `home` knows `save`, `pause`, `cinematics`, `run` and `settings` |

**Three ways to know.**

1. **Facts flow outward.** An outer feature reads an inner one's `state/` snapshot and hears its
   `events/`. An inner feature never reads or hears an outer one.
2. **Services are ports the inner feature offers.** `dungeon` offers `CollisionWorld`,
   `ZoneGenerator`, `BossRoomSeal`, `BossRoomStage` and `Altars`; `combat` offers `AttackResolver`,
   `CombatantRegistry` and `StatusEffectControl`; `arsenal` offers `XpAccount` and `ShieldRepairs`;
   `akeris` offers `AkerisHealth` and `AkerisStagger`. The caller, outer, knows the implementer.
3. **Client-owned ports when an inner feature needs an outer one.** The inner feature declares the
   port from its own need, the outer one implements it, and `core/app/` connects them. `combat`
   declares `Combatant`, and every body — `akeris`, `enemies`, `bosses`, `hazards`, the bodies
   `abilities` conjures — implements it; `akeris` declares `ChainBlades` (implemented by `chain`),
   `LoadoutModifierSource` (by `arsenal`, `inventory`, `abilities`, `hazards`), `PotionSupply` (by
   `inventory`) and `RevivalSource` (by `abilities`); `pause` declares `ManualSave` (by `save`). The
   implementer knows the client's need; the client knows nobody.

**Two roles that keep the map acyclic.**

- **`run` is a process manager.** It owns no world object. It drives the incursion by hearing what
  happened — `WayDownReached`, `BossDefeated`, `EnemyDefeated`, `AbilityChosen`, `AkerisDied` — and
  calling inner ports — `ZoneGenerator`, `BossRoomSeal`, `XpAccount`. XP lives in `arsenal`, which
  spends it; `run` only credits the drops. Nothing inner knows `run`.
- **`save` is the caretaker.** Every feature with run state implements `RunMementoSource`; `save`
  calls each one's `capture()` and `restore()`, and stores the parts without knowing their inside.
  No feature gathers the others' state (`design-patterns.md` §11).

**Two families that cross the rings without an edge.**

- `PlayerCommand` is emitted by `core/input`; `pause` emits the same family for its menu. The
  features that act on it — `akeris`, `abilities`, `arsenal`, `dungeon`, `hazards`, `map`,
  `narrative`, `settings`, `cinematics`, `home` — know `core/input`, never `pause`.
- `SoundEffectCued` is emitted by every feature that makes a sound, with an id of
  `07-audio/sfx/sfx.md` and a position; only `audio` hears it. `HitstopStarted`, `PauseOpened` and
  `PauseClosed` are heard by `core/loop`, which holds or resumes the step.

**The edges, feature by feature.** What each one knows, and through what. Each feature also
publishes `SoundEffectCued` where its reference gives a sound, and every feature that acts
subscribes through `EventSource` and publishes through `EventSink`, both implemented by `core/loop`.

| Feature | Knows | Through |
|---|---|---|
| `dungeon` | — | offers `CollisionWorld` (with its `HookPoint`s), `ZoneGenerator`, `BossRoomSeal`, `BossRoomStage`, `Altars`; owns `ZoneState`; emits `ZoneEntered`, `RoomEntered`, `BossRoomEntered`, `WayDownReached`, `ItemTaken` |
| `combat` | `dungeon` | calls `CollisionWorld`; declares `Combatant`; offers `AttackResolver`, `CombatantRegistry`, `StatusEffectControl`; emits `HitLanded`, `AttackBlocked`, `CounterTriggered`, `ProjectileReflected`, `StatusEffectApplied`, `StatusEffectEnded`, `HitstopStarted` |
| `akeris` | `combat`, `dungeon` | implements `Combatant`; calls `AttackResolver`, `CombatantRegistry`, `StatusEffectControl`, `CollisionWorld`; hears `HitLanded`, `AttackBlocked`, `CounterTriggered`, `StatusEffectApplied`, `StatusEffectEnded`, `ZoneEntered`; declares `ChainBlades`, `LoadoutModifierSource`, `PotionSupply`, `RevivalSource`; owns `AkerisState`; offers `AkerisHealth`, `AkerisStagger`; emits `AkerisDied`, `AkerisLanded`, `FastDescentLanded`, `NoiseMade`, `PotionDrunk` |
| `chain` | `akeris`, `combat`, `dungeon` | implements `ChainBlades` (answers with `ChainPull`); calls `AttackResolver`, `CombatantRegistry`, `CollisionWorld`; hears `HitLanded`; emits `ChainThrown`, `ChainHooked`, `ChainAnchored` |
| `hazards` | `akeris`, `combat`, `dungeon` | implements `Combatant`, `LoadoutModifierSource` (`CarriedTorch`); calls `AttackResolver`, `CombatantRegistry`, `StatusEffectControl`, `CollisionWorld`; reads `AkerisState`, `ZoneState`; hears `HitLanded`, `NoiseMade`; emits `HazardBroken`, `TorchTaken`, `TorchDropped`, `TorchLaidDown` |
| `enemies` | `akeris`, `combat`, `dungeon` | implements `Combatant`; calls `AttackResolver`, `CombatantRegistry`, `CollisionWorld`; reads `AkerisState`, `ZoneState`; hears `HitLanded`, `AttackBlocked`, `CounterTriggered`, `StatusEffectApplied`, `NoiseMade`; emits `EnemyDefeated` |
| `bosses` | `akeris`, `combat`, `dungeon` | implements `Combatant`; calls `AttackResolver`, `CombatantRegistry`, `StatusEffectControl`, `CollisionWorld`, `BossRoomStage` (with a `StageChange`); reads `AkerisState`; hears `HitLanded`, `AttackBlocked`, `BossRoomEntered`; owns `BossState`; emits `BossWoke`, `BossPhaseChanged`, `BossDefeated` |
| `arsenal` | `akeris`, `combat`, `dungeon` | implements `LoadoutModifierSource` (`HeldWeapon`, `StrappedShield`); calls `AkerisStagger`; hears `AttackBlocked`, `ItemTaken`; owns `ArsenalState`; offers `XpAccount`, `ShieldRepairs`; emits `WeaponUpgraded`, `ShieldBroken`, `ShieldRepairRequested`, `ShieldRepaired` |
| `inventory` | `akeris`, `arsenal`, `enemies`, `combat`, `dungeon` | implements `LoadoutModifierSource` (`AttackBoost`, `Rage`, `Curse`), `PotionSupply`; calls `AkerisHealth`, `ShieldRepairs`, `Altars`; hears `PotionDrunk`, `EnemyDefeated`, `ShieldRepairRequested`, `HitLanded`, `ItemTaken`, `ZoneEntered`; owns `SatchelState`; emits `ScrollRead`, `CurseStarted`, `CurseProgressed`, `CurseFulfilled`, `RageStarted`, `RageEnded` |
| `abilities` | `akeris`, `bosses`, `combat` | implements `Combatant` (its conjured bodies), `LoadoutModifierSource` (`VenomEdgeActive`, `StoneOrbitActive`), `RevivalSource`; calls `AttackResolver`, `CombatantRegistry`, `StatusEffectControl`; reads `AkerisState`; hears `BossDefeated`, `FastDescentLanded`; owns `AbilitySetState`; emits `AbilityChoiceOffered`, `AbilityChosen`, `AbilityTriggered` |
| `run` | `dungeon`, `akeris`, `arsenal`, `enemies`, `bosses`, `abilities` | calls `ZoneGenerator`, `BossRoomSeal`, `XpAccount`; reads `AkerisState`, `ArsenalState`; hears `WayDownReached`, `AkerisDied`, `EnemyDefeated`, `BossDefeated`, `AbilityChosen`; owns `RunState`; offers `RunStarter`; emits `RunStarted`, `RunEnded` |
| `narrative` | `run`, `akeris`, `dungeon` | hears `RunStarted`; reads `AkerisState`, `ZoneState`; emits `DialogueOpened`, `DialogueClosed`, `SpiritWhispered` |
| `settings` | — | owns `SettingsState`, read by `audio`, `home` and `core/localization` |
| `audio` | `settings`, and every feature that sounds | reads `SettingsState`; hears `SoundEffectCued`, `BossWoke`, `BossDefeated`, `ZoneEntered`, `RunEnded`, `SpiritWhispered`, `PauseOpened`, `PauseClosed`; offers `Soundscape` |
| `cinematics` | `audio` | calls `Soundscape`; offers `CinematicPlayer`; owns `CinematicState` |
| `pause` | `akeris`, `arsenal`, `inventory`, `abilities` | reads `AkerisState`, `ArsenalState`, `SatchelState`, `AbilitySetState`; declares `ManualSave`; emits `PauseOpened`, `PauseClosed`, `QuitToTitleRequested` and its menu's `PlayerCommand`s |
| `map` | `dungeon`, `akeris` | reads `ZoneState`, `AkerisState`; hears `RoomEntered`; implements `RunMementoSource` |
| `save` | `pause`, `map`, `run`, `arsenal`, `dungeon` and every other originator | calls every `RunMementoSource` (`abilities`, `akeris`, `arsenal`, `dungeon`, `enemies`, `hazards`, `inventory`, `map`, `run`); implements `ManualSave`; reads `RunState`, `ArsenalState`; hears `BossRoomEntered`, `RunEnded`, `QuitToTitleRequested`; offers `SaveSlots` |
| `hud` | `akeris`, `arsenal`, `inventory`, `abilities`, `bosses`, `run`, `narrative` | reads `AkerisState`, `ArsenalState`, `SatchelState`, `AbilitySetState`, `BossState`, `RunState`; hears `DialogueOpened`, `DialogueClosed` |
| `home` | `save`, `run`, `cinematics`, `pause`, `settings` | calls `SaveSlots`, `RunStarter`, `CinematicPlayer`; reads `SettingsState`; hears `RunEnded`, `QuitToTitleRequested` |

Against version 1 (2026-09-30): the two-way edges `akeris ⇄ combat`, `enemies ⇄ combat` and
`akeris → chain → akeris` are gone (client-owned ports); `run` no longer publishes to `dungeon`,
`enemies` and `save` but hears them and calls their ports; `save` collects the memento instead of
`run` capturing it (operator, 2026-10-14).

### 2.4 The shared kernel

`lib/core/contracts/kernel/` holds the few value objects every context uses with the **same**
meaning: time, space, identity, randomness and results. It is pure Dart, small, and changes rarely,
because a change to it reaches every feature: like every contract, only the architect writes it
(`docs/CONTRACT_SPEC.md` §2).

| Type | Is |
|---|---|
| `Seconds` | a duration, as a zero-cost extension type |
| `Vec2` | a point or displacement in world units, y downward |
| `TileCoord` | a tile position; the only conversion to and from world units (1 tile = 32) |
| `Seed` | a deterministic source of randomness, split per zone, room and entity |
| `EntityId` | the identity of anything that lives in a zone |
| `Result<T, F>` | a sealed success-or-failure for expected failures |
| `WorldBox` | an axis-aligned rectangle in world units, as a centre and two half sizes: hurtboxes, hitboxes, sweeps |
| `ZoneNumber`, `Biome`, `Element`, `Facing`, `Language`, `ScrollKind`; `AbilityId`, `BossId`, `EnemyKindId`, `ShieldId`, `WeaponId` | the enumerations and identifiers every context names the same way, with no rule attached |

Anything with a game rule is not kernel. `Health` belongs to the contexts that have health; `Damage`
to `combat`, which publishes it in its events.

## 3. Four layers inside a feature

```text
presentation ──► application ──► domain
infrastructure ─┘
```

The dependency points inward. `domain/` knows nothing outside itself; `application/` knows the
domain; `infrastructure/` and `presentation/` know the application and the domain, never each other.

| Layer | Holds | May import | Never imports |
|---|---|---|---|
| `domain/` | aggregates, entities, value objects, domain events, domain services, policies, specifications, and the decorator and strategy **interfaces** of its model | `dart:core`, `dart:math`, `dart:collection`, `dart:typed_data`; `package:meta`; `core/contracts/kernel/`; `core/contracts/`; its own `domain/` | Flutter, Flame, `dart:io`, `dart:ui`, `dart:async`; any other layer |
| `application/` | use cases (one per player intent), systems (one step of the game, driven by `dt`), the feature's own ports, the translation of contracts into the domain | what `domain/` may; its own `domain/` and `application/` | Flutter, Flame, `dart:io`, `dart:ui`; `infrastructure/`, `presentation/` |
| `infrastructure/` | adapters that implement ports: files, audio, platform, Flame services | anything the stack provides; `core/contracts/` and the shared modules; its own `domain/` and `application/` | `presentation/`; any other feature |
| `presentation/` | Flame components that draw, Flutter widgets, controllers that turn state into what is shown | Flutter, Flame; `core/contracts/` and the shared modules; its own `domain/` and `application/` | `infrastructure/`; any other feature |

**Where a port lives.** A port only this feature uses — `SaveSlotStore` inside `save` — is declared
in its `application/ports/` and implemented in its `infrastructure/`. A port another feature
implements or consumes is a contract, in `core/contracts/ports/`.

**`dart:async` stays out of the game's rules.** The game advances by `step(dt)`, not by futures or
streams. Loading, saving and audio are asynchronous and live in `infrastructure/`.

## 4. DDD tactical building blocks

Every feature's `domain/` and `application/` are built from these. The names below are the game's
own.

| Building block | Is | In this game | Rules |
|---|---|---|---|
| **Value object** | a value with rules and no identity | `Health`, `Damage`, `ShieldCharges`, `WeaponLevel`, `Cooldown`, `Xp` | immutable; equal by value; validates itself in its constructor; transitions return a new value |
| **Entity** | something with an identity that survives change | a room, a boss part, a spirit | equal by `EntityId`; changes only through its methods |
| **Aggregate** | a cluster with one root that guards its invariants | `Akeris`, `Enemy`, `Boss`, `Run`, `Zone`, `Arsenal`, `AbilitySet`, `Satchel`, `SaveSlot` | the root is the only way in; nothing outside holds a reference to its parts; one aggregate changes per use case; aggregates refer to each other by id |
| **Domain event** | something that happened inside the context | `PotionDrunk`, `WeaponUpgraded`, `PhaseChanged` | past tense, immutable, raised by the aggregate that changed; handled inside the feature |
| **Integration event** | a domain event another context needs | `HitLanded`, `EnemyDefeated`, `BossDefeated` | declared in `core/contracts/events/`; published by the feature's `application/` after the aggregate raised its domain event |
| **Domain service** | a rule that belongs to no single aggregate | `CounterWindow`, deciding whether a block was a perfect block | stateless; named for the rule |
| **Policy / specification** | one question, as an object | `CanClimb`, `IsInBossRoom`, `DetectsRunningAkeris` (the blind ghoul) | composable (`and`, `or`, `not`) instead of `if` chains |
| **Factory** | builds a valid aggregate | `EnemyFactory`, `ZoneFactory`, `LoadoutFactory` | from data and a `Seed`; never from `Random()`; never returns an invalid aggregate |
| **Repository** | a collection-like port for aggregates that persist | `SaveSlotStore`, `SpiritMemoryStore` | an interface in `application/ports/`; implemented in `infrastructure/`; loads and saves whole aggregates |
| **Use case** | one thing the player or the game does | `DrinkPotion`, `EquipShield`, `SwapAbility`, `UpgradeWeapon` | orchestrates: loads, calls the aggregate, publishes events; holds no rule itself |
| **System** | one step of a continuous process | `StepAkerisMovement`, `StepEnemyBrains`, `StepStatusEffects` | `step(Seconds dt)`; called by the game loop in a fixed order |

**Aggregates mutate; values do not.** An aggregate that changes every frame — Akeris's position, a
chain's segments — changes its own private fields through its methods, which keep its invariants.
What it shows the rest of the game is an immutable snapshot, the `state/` contract, built once per
step. The values inside it are replaced, never modified.

**Domain events inside, integration events outside.** An aggregate records its domain events; the
use case or system that called it collects them after the call and publishes the integration events
other contexts need through the `EventSink` port. The domain never publishes directly.

```dart
// lib/features/inventory/application/drink_potion.dart — a use case
final class DrinkPotion {
  DrinkPotion(this._satchel, this._events);

  final Satchel _satchel; // aggregate root
  final EventSink _events; // core/contracts/ports/event_sink.dart

  void call() {
    final drunk = _satchel.drinkPotion(); // domain rule: none left → no event
    if (drunk case PotionDrunk(:final healing)) {
      _events.publish(HealingGranted(amount: healing)); // integration event
    }
  }
}
```

## 5. The game step

```text
core/input → PlayerCommand → use cases and systems step(dt) → aggregates → events + snapshots
                                                                        ↘ presentation draws them
```

- **One clock.** Only `core/loop/` reads time, from Flame's `update(dt)`. It passes `dt` as `Seconds`
  to every system; no other code reads a clock.
- **Fixed order.** The composition root calls the systems in one documented order each step, so the
  same inputs and seed produce the same game.
- **`dt` is clamped** to a maximum, so a stall never tunnels a body through a wall.
- **Randomness** comes from the run's `Seed`, split per zone, room and entity.
- **Drawing never changes the game.** `presentation/` reads snapshots and events; it never writes
  domain state.

## 6. Performance

The game runs at the monitor's refresh rate on Windows, with dozens of enemies, chains, particles and
hand-drawn strokes.

1. **No allocation in the per-frame path of a hot loop.** Reuse lists; pool short-lived objects
   (`design-patterns.md` §8).
2. **Shared data is held once** — enemy kinds, weapon kinds, tile kinds, stroke geometry
   (`design-patterns.md` §4).
3. **Decorator chains are resolved when they change, not every frame.** Equipping, drinking or an
   effect ending rebuilds the chain and caches the resolved stats (`design-patterns.md` §1).
4. **Strokes are generated once** from their seed and cached; a frame only transforms and draws them.
5. **Snapshots are small.** A `state/` contract carries what its readers need, not the aggregate.
6. **Zero-cost types for units and ids** — extension types.
7. **Measure before optimising.** An optimisation that makes code less clear carries a profile note
   in the task that introduced it.
