# Design patterns

- **Status:** approved 2026-10-14 (step 5.2: §11, the memento is captured per originator and `save` is
  the caretaker; before, approved 2026-09-30, version 1)
- **Sources:** `VISION.md` §Client constraints (Decorator, Flyweight, DDD tactical patterns, optimal
  performance), §Mechanics, §Bosses, §Abilities, §Content scope · `architecture.md` ·
  `lib/core/contracts/ports/run_memento_source.dart` (step 5.2)
- **Read by:** the architect and the planner; the implementer and the tester when a task cites it.

Which pattern solves which problem of this game. **Each problem below has one pattern, and the code
uses that one.** A task that meets one of these problems follows this document; a task that meets a
problem not listed here chooses the simplest code that works, and the planner adds the problem here
if it recurs.

A pattern is used where it removes a condition, a copy or a coupling — never to decorate a simple
function. The values in the examples are placeholders; real numbers come from the references
(`03-characters/`, `05-items/`) and `VISION.md`.

| § | Problem in this game | Pattern | Feature |
|---|---|---|---|
| §1 | Items, scrolls, effects and statuses change what a character can do | **Decorator** | `akeris`, `enemies`, `bosses` |
| §2 | Ten abilities, three equipped, each doing something different | **Strategy** | `abilities` |
| §2 | Each enemy kind behaves differently; each weapon has its own moves | **Strategy** | `enemies`, `bosses`, `arsenal` |
| §3 | Postures and boss phases with their own rules and transitions | **State** | `akeris`, `bosses` |
| §4 | Twenty enemy kinds, five weapons, many tiles, thousands of strokes | **Flyweight** | every feature with kinds; `core/rendering` |
| §5 | Keys and mouse turned into intents the game can replay | **Command** | `core/input`, every feature that acts |
| §6 | One click of the chain blades means different actions by context | **Chain of Responsibility** | `chain` |
| §7 | Contexts that react to what happened in another | **Observer** (domain and integration events) | every feature, through `core/contracts` |
| §8 | Particles, projectiles, rocks and afterimages created every frame | **Object Pool** | `core/rendering`, `combat`, `bosses` |
| §9 | Bosses made of parts that are hit, torn and broken separately | **Composite** | `bosses` |
| §10 | Enemies, biomes and zones built valid from data and a seed | **Factory, Abstract Factory, Builder** | `enemies`, `dungeon` |
| §11 | Saving a run and restoring it exactly | **Memento** | every feature with run state (the originators); `save` (the caretaker) |
| §12 | Rules like "can climb here" or "sees Akeris" | **Specification** | every feature |
| §13 | Flame, files and audio behind the game's own interfaces | **Adapter, Facade** | `infrastructure/` of every feature |

---

## 1. Decorator — what a character carries

**Every item, scroll, effect and status added to a character is a decorator** over that character's
**loadout**: the object that answers what it deals, what it absorbs, how fast it moves and what it is
immune to. Akeris without anything is the base; equipping the hammer wraps it; strapping on the ice
shield wraps that; drinking into a rage boost wraps it again. Enemies are decorated the same way:
the Fire Mace Brute is a Mace Brute wrapped in `FireInfused`; the Elite Shield Knight is a Shield
Knight wrapped in `Elite`; every enemy of zone N is wrapped in `ZoneScaled(n)`.

```dart
// lib/features/akeris/domain/loadout/loadout.dart
abstract interface class Loadout {
  Damage strike(AttackMove move);
  Damage absorb(Damage incoming);
  double get speedFactor;
  bool isImmuneTo(DamageKind kind);
}

// lib/features/akeris/domain/loadout/bare_akeris.dart — the component
final class BareAkeris implements Loadout {
  const BareAkeris(this._tuning); // a flyweight, §5
  final AkerisTuning _tuning;

  @override
  Damage strike(AttackMove move) => _tuning.baseDamage(move);
  @override
  Damage absorb(Damage incoming) => incoming;
  @override
  double get speedFactor => 1;
  @override
  bool isImmuneTo(DamageKind kind) => false;
}

// lib/features/akeris/domain/loadout/loadout_decorator.dart — the base decorator
abstract base class LoadoutDecorator implements Loadout {
  const LoadoutDecorator(this.inner);
  final Loadout inner;

  @override
  Damage strike(AttackMove move) => inner.strike(move);
  @override
  Damage absorb(Damage incoming) => inner.absorb(incoming);
  @override
  double get speedFactor => inner.speedFactor;
  @override
  bool isImmuneTo(DamageKind kind) => inner.isImmuneTo(kind);
}
```

```dart
// lib/features/akeris/domain/loadout/hammer_wielded.dart — an item
final class HammerWielded extends LoadoutDecorator {
  const HammerWielded(super.inner, this._hammer, this._level);
  final WeaponKind _hammer; // flyweight: 05-items/hammer.md
  final WeaponLevel _level;

  @override
  Damage strike(AttackMove move) =>
      inner.strike(move).scaledBy(_hammer.damageFactorAt(_level));
  @override
  double get speedFactor => inner.speedFactor * _hammer.speedFactor;
}

// lib/features/akeris/domain/loadout/fire_shield_strapped.dart — an item
final class FireShieldStrapped extends LoadoutDecorator {
  const FireShieldStrapped(super.inner);

  @override
  bool isImmuneTo(DamageKind kind) =>
      kind == DamageKind.fire || inner.isImmuneTo(kind);
}

// lib/features/akeris/domain/loadout/cursed_challenge.dart — a scroll's effect
final class CursedChallenge extends LoadoutDecorator {
  const CursedChallenge(super.inner);

  @override
  Damage absorb(Damage incoming) =>
      incoming.isNone ? incoming : Damage.lethal; // VISION §Mechanics, Scrolls
}
```

**What is a decorator here**, and what is not:

| Decorator (changes what the character can do while it lasts) | Not a decorator |
|---|---|
| each weapon and shield carried or equipped; weapon levels | drinking a potion — an instant heal, a use case on `Akeris` |
| the attack-and-ability scroll; the rage boost; the cursed challenge | the health scroll — an instant change |
| an ability's lasting effect: Venom Edge, Stone Orbit | an ability's instant effect — §2 |
| a status effect: slowed, frozen, poisoned, stunned, levitating | the posture Akeris is in — §4 |
| zone scaling, elite, fire-infused on an enemy | an enemy's kind — §5 |

**Rules.**

1. **One decorator per item or effect**, named for it: `IceShieldStrapped`, `RageBoost`, `Slowed`.
   A decorator overrides only what that item changes and delegates everything else.
2. **The order is fixed by layer**, not by when the item arrived: base → zone scaling → kind variants
   (elite, fire) → weapon → shield → upgrades → scrolls → ability effects → status effects. A
   `LoadoutFactory` sorts the active modifiers by layer and folds them onto the base.
3. **The chain is rebuilt when the set of modifiers changes**, never every frame. The aggregate keeps
   the list of active modifiers and the resolved `Loadout`; `equip`, `unequip`, an effect starting
   or expiring rebuilds it.
4. **A temporary decorator has its duration outside it**: the aggregate holds `(modifier,
   remaining)`; a system counts it down with `dt` and rebuilds the chain when it ends.
5. **Across features, items travel as data.** `arsenal`, `inventory` and `abilities` publish
   `LoadoutModifier` descriptors through `core/contracts/ports/loadout_modifier_source`; `akeris` and
   `enemies` translate each descriptor into their own decorator in `application/` — their
   anti-corruption layer. No feature imports another's decorator.
6. **Never a subclass per combination.** `FireMaceBrute extends MaceBrute` or `AkerisWithHammerAndIce`
   is the explosion this pattern exists to prevent.

## 2. Strategy — abilities

**Each ability is a strategy** behind one interface, so `AbilitySet` treats the three equipped slots
the same way whatever they hold, and a new ability is a new class, never a new `case`.

Abilities come in two families, fixed as a sealed hierarchy:

```dart
// lib/features/abilities/domain/ability.dart
sealed class Ability {
  const Ability(this.id);
  final AbilityId id;
}

/// Fired by the player with Q, E or R.
abstract base class ActiveAbility extends Ability {
  const ActiveAbility(super.id, this.cooldown);
  final Seconds cooldown;
  AbilityOutcome activate(AbilityContext context);
}

/// Fires by itself when its trigger happens.
abstract base class TriggeredAbility extends Ability {
  const TriggeredAbility(super.id);
  bool reactsTo(AbilityTrigger trigger);
  AbilityOutcome respond(AbilityTrigger trigger, AbilityContext context);
}
```

```dart
// lib/features/abilities/domain/golem/inverse_gravity.dart
final class InverseGravity extends ActiveAbility {
  const InverseGravity(AbilityTuning tuning)
      : _tuning = tuning,
        super(const AbilityId('golem.inverse_gravity'), tuning.cooldown);
  final AbilityTuning _tuning;

  @override
  AbilityOutcome activate(AbilityContext context) => AreaEffect(
        centre: context.akerisPosition,
        radius: _tuning.radius,
        effect: StatusKind.levitating,
        duration: _tuning.duration, // VISION §Abilities: 2 s
      );
}

// lib/features/abilities/domain/skeleton/reassemble.dart
final class Reassemble extends TriggeredAbility {
  const Reassemble() : super(const AbilityId('skeleton.reassemble'));

  @override
  bool reactsTo(AbilityTrigger trigger) =>
      trigger is AkerisWouldDie && !trigger.usedThisZone(id);
  @override
  AbilityOutcome respond(AbilityTrigger trigger, AbilityContext context) =>
      const Revive(healthFraction: 0.3); // VISION §Abilities
}
```

**What an ability returns is data**, a sealed `AbilityOutcome`: `AreaEffect`, `Summon`, `Projectile`,
`LoadoutBoost` (a decorator descriptor, §1 — Venom Edge, Stone Orbit), `FastDescentShockwave`,
`Revive`, `NoEffect`. `abilities` publishes it as the integration event `AbilityTriggered`; `combat`,
`enemies` and `akeris` carry it out. An ability never reaches into another feature.

**The same pattern gives behaviour per kind:** each enemy kind has an `EnemyBrain`
strategy (`decide(self, perception, dt) → EnemyIntent`) — the Blind Ghoul's brain listens for
running, the Wraith's passes through walls; each weapon has a `MoveSet` strategy
(`next(combo, command) → AttackMove`). **Never a `switch` over a kind id to pick behaviour.**

## 3. State — postures and boss phases

**Akeris's postures** — standing, running, jumping, crouching, rolling, blocking, attacking,
climbing, swinging, levitating — are a **sealed family** in `akeris/domain`, and each posture object
decides which command it accepts and which posture follows. An exhaustive `switch` over the sealed
type handles what is data; behaviour lives in the posture's own methods.

**Each boss phase is a state object** with its own attack table and its own transition rule:
`GolemOrbiting → GolemRage` when its health crosses the threshold in its `phases.md`; the arena
change (the floor shrinks) is an event the phase raises on entry.

```dart
// lib/features/bosses/domain/boss_phase.dart
abstract interface class BossPhase {
  BossIntent decide(BossView self, Perception perception, Seconds dt);
  BossPhase? next(BossView self); // null: stay
  Iterable<Object> onEnter(); // domain events, e.g. ArenaShrank
}
```

## 4. Flyweight — kinds and strokes

**Data shared by every instance of a kind is one object**, created once and shared:

| Flyweight (intrinsic, shared) | Instance (extrinsic, per object) |
|---|---|
| `EnemyKind`: health, damage, speeds, brain factory, pose table, sounds | `Enemy`: id, position, health left, posture, decorators |
| `WeaponKind`: move set, damage factors per level, reach | the level Akeris has it at |
| `TileKind`: solidity, drawing recipe | the tile's coordinate |
| `StrokeGeometry`: the seeded points of a limb, block or prop outline | the transform it is drawn at this frame |

Kinds are loaded once by a registry in `application/` and handed to factories. **An instance never
copies a kind's data**; it holds a reference.

## 5. Command — the player's intents

`core/input` turns keys and the mouse, per the bindings in `VISION.md`, into a sealed
`PlayerCommand` — `Move(direction)`, `Jump`, `Attack`, `Block(raised)`, `Roll`, `Crouch`,
`ThrowChain(aim)`, `UseAbility(slot)`, `DrinkPotion`, `SwapWeapon(slot)`, `Talk`, `Pause`. The
command type is a contract; each feature's use cases take commands, never keys.

A command is data, so a test can script a sequence of commands over N steps and a bug can be
replayed from its seed and its command log.

## 6. Chain of Responsibility — the chain blades

One click with the chain blades means different things by context (`VISION.md` §Mechanics). Each
possible action is a handler; the first that accepts the situation acts:

```dart
// lib/features/chain/domain/chain_action_handler.dart
abstract interface class ChainActionHandler {
  ChainAction? tryHandle(ChainSituation situation);
}

// lib/features/chain/domain/chain_resolver.dart
final class ChainResolver {
  const ChainResolver(this._handlers); // order: 03-characters/akeris/weapons/chain-blades.md
  final List<ChainActionHandler> _handlers;

  ChainAction resolve(ChainSituation situation) {
    for (final handler in _handlers) {
      final action = handler.tryHandle(situation);
      if (action != null) return action;
    }
    return StrikeTowardAim(situation.aim); // the last resort always accepts
  }
}
```

Handlers: `AnchorWhileLevitating`, `SwingFromRing`, `ClimbWall`, `HookBossPart`, `SnatchObject`,
`PullEnemy`, `StrikeTowardAim`. A new use of the chain is a new handler, placed in the order its
reference gives.

## 7. Observer — events

Contexts react to each other only through events (`architecture.md` §4). The `EventSink` and
`EventSource` ports in `core/contracts/ports/` are the subject; the composition root subscribes each
feature's handlers.

1. **Events are delivered at the end of the system that raised them, in the order raised**, from a
   queue — never re-entrantly in the middle of another handler. The game stays deterministic.
2. **A handler never throws back** into the publisher and never publishes synchronously into the
   same queue it is being called from; it records, and its own system publishes next step.
3. **Flutter's `ChangeNotifier` and streams are presentation tools**, used only in `presentation/`.

## 8. Object Pool — short-lived objects

Ink smoke, sparks, dust puffs, afterimages, projectiles, thrown rocks and bat swarms are created and
destroyed many times a second. They come from a `Pool<T extends Poolable>`: `acquire()` resets and
returns a free object, `release(obj)` returns it. The pool's size is fixed at zone load from the
zone's worst case; a pool that runs out reuses the oldest active object rather than allocating.

## 9. Composite — boss bodies

A boss is a tree of `BodyPart`s: the Golem's core, eye and slabs; the Giant Bat's body and two wings;
the Skeleton's skull and bones. A hit is routed to the part it struck; a part may break, be torn off
(the bat's wing) or be snatched (the skeleton's skull) and leaves the tree; the boss's health and
what it can still do are computed from the parts that remain. A leaf and a group answer the same
interface, so the combat code never asks which it hit.

## 10. Factory, Abstract Factory and Builder — building the world

- **`EnemyFactory`** builds an `Enemy` from its `EnemyKind` (§4), the zone index and a `Seed`, and
  applies its decorators (§1): zone scaling, elite, fire. It never returns an invalid enemy.
- **`BiomeKit`**, an abstract factory, has one implementation per biome — `SuspendedSanctuaryKit`,
  `EchoCavernsKit`… — and produces the family of things that must match: tile kinds, props,
  hazards, the enemy roster and the boss room.
- **`ZoneBuilder`** builds a zone step by step from a biome kit and a seed: rooms → connections →
  hazards → spawns → boss room. A `ZoneValidator` checks the result — the boss is reachable, no room
  is sealed — before it reaches the game, and a zone that fails is rebuilt from the next seed.

## 11. Memento — saving a run

A run's state is spread over its features, and no feature may gather the others' (`architecture.md`
§2.3): `run` is a process manager, not the owner of everything. So the memento is captured **per
originator**. Every feature with run state — `abilities`, `akeris`, `arsenal`, `dungeon`, `enemies`,
`hazards`, `inventory`, `map`, `run` — implements `RunMementoSource` (`core/contracts/ports/`): a
`key` that names its part, `capture()` that returns an opaque `RunMementoPart`, and `restore(part)`
that rebuilds its aggregate exactly. `save` is the **caretaker**: on autosave and on manual save it
calls every source's `capture()` and stores the parts, without knowing their inside, through its
`SaveSlotStore` repository; on load it gives each part back to the source with the same key. The
file format belongs to `save/infrastructure/`; what a part's payload means belongs to its originator
alone, so a feature changes what it saves without touching `save`.

```dart
// lib/features/arsenal/application/arsenal_memento_source.dart — one originator
final class ArsenalMementoSource implements RunMementoSource {
  ArsenalMementoSource(this._arsenal);

  final Arsenal _arsenal; // aggregate root

  @override
  String get key => 'arsenal';

  @override
  RunMementoPart capture() =>
      RunMementoPart(key: key, payload: _arsenal.capture().encode()); // ArsenalMemento, a domain value

  @override
  void restore(RunMementoPart part) =>
      _arsenal.restore(ArsenalMemento.decode(part.payload));
}
```

The aggregate's own memento (`ArsenalMemento`) is an immutable domain value; the source in
`application/` is the only place that encodes it for the contract. The composition root hands `save`
the list of sources; the order of the parts does not matter, their keys do.

## 12. Specification — questions as objects

A rule that answers yes or no about something is a `Spec<T>` with `isSatisfiedBy(T)` and `and`, `or`,
`not`: `CanClimb`, `IsGroundedOn(tile)`, `DetectsAkeris` (sight, or hearing for the Blind Ghoul),
`OpensCounter`. A chain of `if`s over the same object is a specification waiting to be named.

## 13. Adapter and Facade — the edges

- **Adapter:** every `infrastructure/` class implements a port with a library: `FlameAudioPlayer`
  implements `SfxPlayer`, `JsonSaveSlotStore` implements `SaveSlotStore`, `FlameKeyboardSource`
  feeds `core/input`.
- **Facade:** `audio` offers one `Soundscape` port — play a sound, set the zone's music, duck for
  dialogue — over the music, effects and voice subsystems.
- **Cross-cutting concerns are decorators on ports**, not code inside the game rules:
  `ValidatingZoneGenerator` wraps the generator; a `LoggingEventSink` wraps the sink in debug
  builds only.

## 14. Never

| Never | Instead |
|---|---|
| a Singleton, a static mutable field, a service locator | one instance built by the composition root and passed through constructors |
| a subclass per combination of items or variants | Decorator (§1) |
| a `switch` over a kind id, an ability id or a weapon id to pick behaviour | Strategy (§2) |
| `if` chains over the posture or phase spread through the code | State (§3) |
| copying a kind's data into each instance | Flyweight (§4) |
| reading keys inside a feature | Command (§5) |
| a `GameManager`, `World` or `Engine` class that knows every feature | the composition root wires; features own their rules |
| a pattern with a single implementation and no second in sight | a plain class; the pattern arrives with the second case |
