# Coding standards

- **Status:** approved 2026-09-30 · 2026-10-15: §4.6 (don't repeat yourself), the widget-animation row of
  §8 and §11 (Flutter widgets), asked by the operator
- **Sources:** `VISION.md` §Client constraints (OOP, DDD, Clean Code) · `architecture.md` ·
  `design-patterns.md`
- **Read by:** the implementer and the tester, whole, on every task (`docs/CONTEXT_POLICY.md` §2.2);
  every task that writes code cites it. The tester checks it through `checklist.md`.

How each line of the game is written, in Dart 3: object-oriented, SOLID, Clean Code. Every rule has a
**Do** and a **Don't**. Where a rule and the linter disagree, the stricter one wins.
`architecture.md` says where code goes; `design-patterns.md` says which pattern solves which
problem; this says how it is written.

---

## 1. SOLID, in this game

### S — one reason to change

A class answers to one part of the game. `ChainResolver` decides which action a click of the chain
blades means; it does not move the chain, draw it or play its sound. `DrinkPotion` drinks; the rule
of how much it heals is `Satchel`'s; the gulp is `audio`'s, reacting to the event.

```dart
// Don't — four reasons to change in one class
final class AkerisController {
  void update(double dt) { /* input, physics, damage, drawing, sounds… */ }
}
```

### O — open for extension, closed for modification

A new ability, enemy kind, weapon, item or chain action is **a new class**, and no existing class
changes. That is what Strategy, Decorator and Chain of Responsibility give (`design-patterns.md`
§1, §2, §6).

```dart
// Do — the eleventh ability is one more class
final class StoneOrbit extends ActiveAbility { … }

// Don't — every new ability edits this switch
AbilityOutcome use(AbilityId id) => switch (id.value) {
      'golem.inverse_gravity' => …,
      'golem.stone_orbit' => …,
      _ => const NoEffect(),
    };
```

### L — any implementation can stand in

Every decorator is a `Loadout`; every brain an `EnemyBrain`; every adapter its port. A caller never
checks which implementation it holds (`is HammerWielded`), and no implementation throws
`UnimplementedError` for a method its interface promises.

### I — small interfaces

A port offers what one kind of client needs. `SfxPlayer` and `MusicPlayer` are two ports, not one
`AudioService`; `EventSink` (publish) and `EventSource` (subscribe) are two. A class implementing an
interface uses every member of it.

### D — depend on abstractions

Domain and application code depends on interfaces it owns or on contracts; the composition root
hands it the implementation.

```dart
// Do
final class SaveRun {
  SaveRun(this._store); // application/ports/save_slot_store.dart
  final SaveSlotStore _store;
}

// Don't
final class SaveRun {
  final _store = JsonSaveSlotStore(File('C:/saves')); // infrastructure inside a use case
}
```

## 2. Names

**Names come from the game's language** — `00-game/glossary.md` — and say what a thing is in the
domain, not how it is stored.

| Kind | Convention | Example |
|---|---|---|
| file | `lower_snake_case.dart`, named for its main type | `chain_resolver.dart` |
| type, enum, extension | `UpperCamelCase`, a noun | `ChainResolver`, `Posture` |
| decorator | the item or effect as a state of the character | `HammerWielded`, `IceShieldStrapped`, `Slowed` |
| strategy | what it is in the game | `InverseGravity`, `BlindGhoulBrain`, `SpearMoveSet` |
| use case | the intent, imperative | `DrinkPotion`, `SwapAbility` |
| system | `Step` + what it advances | `StepStatusEffects` |
| domain event | past tense | `PotionDrunk`, `BossDefeated` |
| method | a verb for actions, a noun for queries | `throwAt(target)`, `reach` |
| boolean | reads as a question: `is`, `has`, `can` | `isGrounded`, `canClimb` |
| number with a unit | the unit in the type or, failing that, in the name | `Seconds cooldown`, `speedUnitsPerSecond` |

**Banned in type names:** `Manager`, `Helper`, `Util`, `Handler` (except a chain-of-responsibility
link), `Data`, `Info`, `Base`, `Impl`. Name the thing itself. An adapter is named for how it
implements: `FlameAudioPlayer`, `JsonSaveSlotStore`.

```dart
// Do
final class ChainPair {
  bool get isHooked => _hooked != null;
  void throwAt(Vec2 target) { … }
}

// Don't
class CBMgr {
  bool flag = false;
  void doThrow(double x, double y, double t) { … } // t in what unit?
}
```

## 3. Size

| Unit | Limit | When it is exceeded |
|---|---|---|
| function or method body | **20 lines** | extract a well-named function |
| parameters | **4** | pass a value object |
| nesting depth | **2** levels of `if`/`for`/`switch` | return early, extract, or use a pattern `switch` |
| class | **200 lines** | it has more than one reason to change; split it |
| file | **300 lines** | one public type per file, plus its private helpers |
| line | **80 columns** | `dart format` decides |

Generated code, test data tables and `const` lookup tables are exempt from the line counts, not from
the rest.

## 4. Classes and objects

1. **Tell, don't ask.** Behaviour lives with the data it uses.
2. **Composition over inheritance.** Inherit only to specialise a sealed family, a pattern's base
   (`LoadoutDecorator`, `ActiveAbility`) or a framework class (`Component`, `StatelessWidget`). State
   the intent with `final class`, `base class`, `sealed class` or `interface class`.
3. **Dependencies arrive through the constructor.** No singletons, no static mutable state, no
   service locator.
4. **No primitive obsession.** A value with rules or a unit is a type.
5. **Law of Demeter.** Talk to what you hold, not to what it holds: `akeris.canClimb(wall)`, not
   `akeris.body.hands.first.grip > wall.height`.
6. **Don't repeat yourself.** Each piece of knowledge — a rule, a number from a reference, a
   conversion, a widget — has one home, and every other use calls it. Two blocks that differ only in
   their values are one function, one widget or one type with those values as parameters. Two values
   that merely happen to be equal, each fixed by its own reference, are not repetition: each keeps
   its source.

```dart
// Do — the rule lives with the data
final class ShieldCharges {
  const ShieldCharges(this.remaining) : assert(remaining >= 0);
  final int remaining;

  bool get isSpent => remaining == 0;
  ShieldCharges spendOne() =>
      isSpent ? this : ShieldCharges(remaining - 1);
}

// Don't — every caller re-implements the rule
if (shield.charges > 0) {
  shield.charges = shield.charges - 1;
}
```

```dart
// Do — a zero-cost unit type, from core/contracts/kernel
extension type const Seconds(double value) {
  Seconds operator +(Seconds other) => Seconds(value + other.value);
  bool operator >=(Seconds other) => value >= other.value;
}

// Don't
double cooldown = 0.35; // seconds? frames? milliseconds?
```

## 5. Immutability

1. **Fields are `final`.** A mutable field is allowed only inside an aggregate root or a pooled
   object, and is private.
2. **Value objects are immutable**, with `const` constructors where possible, value equality, and a
   named transition (`minus`, `spendOne`) or `copyWith` instead of setters.
3. **Decorators and strategies are immutable.** Their state — a duration left, a cooldown — lives in
   the aggregate that holds them.
4. **Collections that leave an object are unmodifiable**: `List.unmodifiable(_items)` or an
   `Iterable`, never the internal list.
5. **Locals are `final`** unless they are reassigned.
6. **Records** are for short-lived groupings inside a function; a grouping with a name in the domain
   is a class.

```dart
// Do
final class Wave {
  Wave(List<EnemySpawn> spawns) : _spawns = List.unmodifiable(spawns);
  final List<EnemySpawn> _spawns;
  Iterable<EnemySpawn> get spawns => _spawns;
}

// Don't
class Wave {
  List<EnemySpawn> spawns = []; // anyone can add, clear or replace it
}
```

## 6. Types and control flow

1. **No `dynamic`**, no `Object?` to dodge a type, no `as` casts outside tests. The analyzer runs
   with `strict-casts`, `strict-inference` and `strict-raw-types`.
2. **Null means absent, and only where absence is part of the domain.** No `!` on a value that could
   be null; prove it with a pattern or a guard.
3. **Closed sets are `enum` or `sealed`**, handled with an exhaustive `switch` and no `default`, so a
   new case is a compile error everywhere it matters.
4. **A `switch` picks data, never behaviour per kind.** Behaviour per kind is a strategy
   (`design-patterns.md` §2).
5. **No `late`** except for a field a framework initialises (`onLoad` in Flame) and a test's
   fields assigned in `setUp`.
6. **No boolean parameters** that switch behaviour; two methods, or an enum.

```dart
// Do
sealed class Posture {}
final class Standing extends Posture {}
final class Rolling extends Posture {
  Rolling(this.elapsed);
  final Seconds elapsed;
}

String poseFor(Posture p) => switch (p) {
      Standing() => 'idle',
      Rolling(:final elapsed) => elapsed.value < 0.1 ? 'roll-in' : 'roll',
    };

// Don't
String poseFor(String posture, [bool fast = false]) {
  if (posture == 'roll') { … } else if (posture == 'stand') { … } // a typo compiles
  return 'idle';
}
```

## 7. Errors

| Situation | How |
|---|---|
| a programmer error: a broken invariant, an impossible state | `assert` in constructors; `StateError` / `ArgumentError` at a public boundary. Never caught |
| an expected failure: a missing or corrupt save, an unreadable asset | a `sealed` result the caller must handle (`Result<T, F>` from `core/contracts/kernel`) |
| a platform exception | caught in `infrastructure/`, translated into the result, never leaked into `application/` |

1. **Never an empty `catch`**, never `catch (e)` without a type, never `on Exception` to silence
   everything.
2. **Never exceptions for control flow** in the game step.
3. **A failure the player can see** is shown through a translator key, never a raw exception text.

```dart
// Do
sealed class LoadOutcome {}
final class Loaded extends LoadOutcome {
  Loaded(this.memento);
  final RunMemento memento;
}
final class Missing extends LoadOutcome {}
final class Corrupt extends LoadOutcome {
  Corrupt(this.reason);
  final String reason;
}

// Don't
RunMemento? load() {
  try { return _read(); } catch (_) { return null; } // corrupt and missing look the same
}
```

## 8. The rules of this game

These are the root `CLAUDE.md` rules; each has one form in code.

| Rule | Do | Don't |
|---|---|---|
| Game logic never reads the clock | `void step(Seconds dt)` | `DateTime.now()`, `Stopwatch`, `Timer` outside `core/loop/` |
| A widget's own animation is presentation only | a Flutter implicit animation or `AnimationController` for a fade or a flash a reference gives | a ticker or `Timer` that changes game state, or times anything the game's `dt` measures |
| Randomness comes from a seed | `Random(seed.forRoom(index).value)` | `Random()`, `Random.secure()`, `shuffle()` without a `Random` |
| Flutter and Flame only in the outer layers | `presentation/`, `infrastructure/`, `core/app/`, `core/loop/` | `import 'package:flame/…'` in `domain/` or `application/` |
| Features never import features | contracts, events, ports | `import 'package:saviors_paradox/features/combat/…'` from `akeris` |
| Every player-visible string goes through the translator | `translator.text(TextKey.pausedTitle)` | `Text('Paused')` |
| One tile is 32 world units; y grows downward | `TileCoord.toWorld()` from `core/contracts/kernel` | `* 32` scattered through the code |
| Nothing trembles | stroke geometry generated once from its seed | a new random offset each frame |

## 9. Comments and documentation

1. **Code says what; a comment says why** — a constraint, a source, a non-obvious trade-off.
2. **A value copied from a reference names it**: `// 03-characters/akeris/contract.md §4: 0.42 s`.
3. **Public members of a port, a decorator base and a strategy interface have a `///` doc comment**:
   what each promises, in one sentence.
4. **No commented-out code, no `TODO` without a task id.**

## 10. Formatting, lint and imports

- `dart format` with the project's `analysis_options.yaml`, and `flutter analyze --fatal-infos`
  clean. Code that needs `// ignore:` has a comment saying why on the same line.
- Imports: `dart:` first, then `package:`, then relative, each group sorted. Across folders, import
  with `package:saviors_paradox/…`; relative imports only inside one layer of one feature.

## 11. Flutter widgets

Every screen, menu and overlay is built from small widgets. Each rule has its Do and its Don't, as
everywhere in this file.

1. **One widget, one job.** A `build()` obeys §3 like any function: when it grows, extract a widget
   class — never a helper method returning `Widget`, which Flutter cannot skip on rebuild.
2. **`const` wherever it compiles.** A `const` constructor on every widget that can have one, and
   `const` at every call site that can take it, so Flutter skips the subtree.
3. **Stateless by default.** A `StatefulWidget` holds only the ephemeral state it owns — focus,
   hover, its own animation. Game state arrives as a snapshot or a published state; a widget never
   changes domain state (`architecture.md` §5: drawing never changes the game).
4. **Rebuild only what changes.** A `ValueListenableBuilder` (or another listenable) wraps the
   smallest subtree that shows the value; nothing costly sits under a parent that rebuilds every
   frame; a static painted part sits behind a `RepaintBoundary`; a `CustomPainter`'s `shouldRepaint`
   compares exactly what it draws.
5. **Lifecycle.** Controllers and subscriptions are created in `initState` and released in
   `dispose`; nothing asynchronous starts in `build`.
6. **One theme.** Colours, lettering and stroke widths come from one theme built from
   `02-art-direction/palette/palette.md` and `strokes/strokes.md`; no `Color(…)` or font size is
   written inside a widget.
7. **Independent of the screen.** Sizes and positions are in the UI frame of `06-ui/ui.md` §3 (hu,
   scaled by screen height ÷ 1080); a widget reads its space from `LayoutBuilder` or `MediaQuery`,
   never from a fixed pixel size.
8. **Shared, not copied.** A widget two screens need is written once, in shared code, and reused
   with parameters (§4.6); a screen never copies another's widget.
9. **Pointer and keys meet in one place.** What is clickable shows the hand cursor; a button that
   carries a key cap does exactly what its key does (`06-ui/ui.md` §3).
10. **Tested as a widget.** Each widget has a widget test of what it shows and what it sends —
    geometry and choices, not pixels (`testing.md` §5).

```dart
// Do — small, const, the value scoped to the subtree that shows it
final class CoinCount extends StatelessWidget {
  const CoinCount({required this.coins, super.key});
  final ValueListenable<int> coins;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int>(
    valueListenable: coins,
    builder: (context, value, _) => InkLabel('$value'),
  );
}

// Don't — a helper method, a hard-coded colour, the whole screen rebuilt for one number
Widget _coins() => Text('$coins', style: const TextStyle(color: Color(0xFF1A1715)));
```
