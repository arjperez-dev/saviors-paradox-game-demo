# Testing

- **Status:** approved 2026-09-30
- **Sources:** `docs/TASK_FILE_SPEC.md` §2.6, §5.2, §6.3 · `architecture.md` · `design-patterns.md` ·
  `coding-standards.md`
- **Read by:** the planner, when it names tests and writes assertions; the implementer and the tester
  when a task cites it.

How the game is tested. The factory fixes who does what — the planner names each test and states its
assertion, the implementer writes its body, `verify-task` checks it exists and exercises the task's
interfaces. This document fixes how a test is written.

**Tests observe behaviour: what a unit does, never how it does it.** A test states what goes in and
what must come out — a returned value, a published event, a call to a port that *is* the effect —
and stays green through any refactor that keeps that behaviour. To observe a unit on its own, its
collaborators are **mocked**.

---

## 1. Test first

Every `implementation` task is built test-first:

1. **Red.** Write the test for one criterion, from its `Assertion`, against the stub or the current
   code. Run it and see it fail for the reason the assertion names — not a compile error.
2. **Green.** Write the least code that makes it pass.
3. **Refactor.** Clean the code and the test with every test green; `coding-standards.md` applies to
   both.

Repeat per criterion. A test that passed the first time it ran has not been seen to fail: break the
code on purpose, watch it fail, restore it.

## 2. Where tests live

The test tree mirrors `lib/` exactly, per feature and per layer:

```text
lib/features/abilities/domain/golem/inverse_gravity.dart
test/features/abilities/domain/golem/inverse_gravity_test.dart

lib/features/inventory/application/drink_potion.dart
test/features/inventory/application/drink_potion_test.dart

test/features/<feature>/mocks.dart        the feature's mock classes
test/features/<feature>/builders.dart     builders for its aggregates and values
test/core/<area>/…                        the same for lib/core/
test/integration/<flow>_test.dart         several features together, through the contracts
```

One test file per production file. The `Test name` of a criterion is the string passed to `test()`,
character for character; `group()` names the type under test.

## 3. What a good test is

| Rule | Why |
|---|---|
| **One behaviour per test**, named as a sentence about the game: `a grounded Akeris jumps with the tuned impulse` | a failure names what broke |
| **Given, when, then** — arrange, act, assert — separated by a blank line | a reader finds the action at once |
| **Observes results, not internals**: returned values, published events, calls to ports that are the effect; never private fields, never internal call order | a refactor that keeps the behaviour keeps the test green |
| **Deterministic**: a fixed `Seed`, a fixed `dt`, no clock, no `sleep`, no network | the same result every run, on every machine |
| **Fast**: domain and application tests run in milliseconds, with no widget tree and no game loop | the whole suite runs on every task |
| **Independent**: `setUp` builds fresh objects and fresh mocks | tests pass in any order |
| **Exact where the reference is exact**: a value a reference fixes is asserted with that value and the reference named in a comment | the reference wins over the code |
| **Doubles with a stated tolerance**: `closeTo(0.42, 1e-9)` | floating point is not `==` |

## 4. Mocks

The mocking library is **`mocktail`** — no code generation, null-safe; the architect confirms its
version with the stack. Mock classes for a feature live in `test/features/<feature>/mocks.dart`.

### 4.1 What is mocked

| Mock | Never mock |
|---|---|
| the ports the unit depends on: `EventSink`, `SaveSlotStore`, `SfxPlayer`, `CollisionWorld` | the class under test |
| the collaborators behind an interface: the inner `Loadout` of a decorator, an `EnemyBrain`, a `ChainActionHandler`, an `AbilityContext` | value objects and `core/kernel` types — build real ones |
| another aggregate's service reached through an interface | Flame, Flutter or `dart:io` directly — mock the port the adapter implements |

### 4.2 How a mock is used

1. **Stub what the unit asks** (`when(() => inner.strike(any())).thenReturn(…)`), so the test
   controls the inputs.
2. **Verify only calls that are the behaviour** — an event published, a save requested, a sound
   played. A call that is a detail of how the unit works is not verified.
3. **Verify with the values that matter**, and `verifyNever` what must not happen.
4. **One mock per collaborator**, fresh per test; `registerFallbackValue` in `setUpAll` for custom
   argument types.

### 4.3 Examples

```dart
// test/features/akeris/domain/loadout/hammer_wielded_test.dart — a decorator
class MockLoadout extends Mock implements Loadout {}

void main() {
  setUpAll(() => registerFallbackValue(AttackMove.overheadStrike));

  group('HammerWielded', () {
    late MockLoadout inner;
    setUp(() => inner = MockLoadout());

    test('scales the damage of the loadout it wraps by the hammer factor', () {
      when(() => inner.strike(any())).thenReturn(const Damage(10));
      final hammer = HammerWielded(inner, aHammer(damageFactor: 1.5), level1);

      final dealt = hammer.strike(AttackMove.overheadStrike);

      expect(dealt, const Damage(15));
    });

    test('leaves immunities to the loadout it wraps', () {
      when(() => inner.isImmuneTo(DamageKind.fire)).thenReturn(true);
      final hammer = HammerWielded(inner, aHammer(), level1);

      expect(hammer.isImmuneTo(DamageKind.fire), isTrue);
    });
  });
}
```

```dart
// test/features/inventory/application/drink_potion_test.dart — a use case
class MockEventSink extends Mock implements EventSink {}

void main() {
  setUpAll(() => registerFallbackValue(const HealingGranted(amount: 0)));

  group('DrinkPotion', () {
    late MockEventSink events;
    setUp(() => events = MockEventSink());

    test('publishes the healing of the potion drunk', () {
      final drink = DrinkPotion(aSatchel(potions: 3), events);

      drink();

      verify(() => events.publish(const HealingGranted(amount: 40))).called(1);
    });

    test('publishes nothing when no potion is left', () {
      final drink = DrinkPotion(aSatchel(potions: 0), events);

      drink();

      verifyNever(() => events.publish(any()));
    });
  });
}
```

```dart
// Don't — it tests how, not what
test('drink potion', () {
  final satchel = MockSatchel();          // mocks the aggregate the use case is about
  DrinkPotion(satchel, events)();
  verifyInOrder([                         // pins the internal order of calls
    () => satchel.potionsLeft,
    () => satchel.drinkPotion(),
  ]);
});
```

## 5. By layer, and by pattern

| What is tested | How | Assert |
|---|---|---|
| a value object | real values only | invariants (the `assert` fires on invalid input), transitions |
| an aggregate | real values, mocked strategies or decorators it holds | what its methods return, the domain events it records |
| a **decorator** | a mocked inner component | what it changes, and that it delegates everything else unchanged |
| a **strategy** (ability, brain, move set) | a mocked or built context | the outcome or intent it returns for each situation |
| a **chain of responsibility** | each handler alone; the resolver with mocked handlers | who accepts which situation; the order; the fallback |
| a **state** (posture, boss phase) | a built view of the owner | the next state for each command or condition; the events on entry |
| a **factory** or builder | a fixed `Seed` and real kinds | a valid result; the same result for the same seed |
| a use case or system | the real aggregate, mocked ports | published events, calls to ports, the snapshot after N steps |
| an adapter in `infrastructure/` | the real library in a temporary directory, or Flame's test helpers | a round trip: what is saved loads back equal; a corrupt file gives `Corrupt` |
| `presentation/` | pure functions first — state → pose, seed → stroke points; `flame_test` for component wiring; widget tests for Flutter screens | geometry and choices, not pixels |

**No golden images in version 1.** Pixel output depends on the machine's fonts and GPU. How a drawing
looks is the manual check against the reference's `sprites/sheet.png`; what can be computed about it
is a unit test.

## 6. Tests the game always needs

1. **Determinism.** Every factory, generator and system that uses a seed has a test that runs it
   twice with the same seed and gets equal results, and once with another seed and gets a different
   one.
2. **Nothing trembles.** Every stroke primitive has a test that generates it twice from the same seed
   and gets identical points.
3. **`dt` independence where the reference asks for it.** A behaviour stepped with `dt = 1/60` and
   with `dt = 1/144` over the same total time ends within the stated tolerance.
4. **Every integration event a contract declares** has at least one test that makes its publisher
   publish it.
5. **Every decorator** has a test that it delegates the members it does not change.

## 7. Integration tests

Each feature has one task whose tests build several real features through the composition root's
builders, feed a scripted sequence of `PlayerCommand`s over a fixed number of steps with a fixed
seed, and assert the events and snapshots that cross the contracts. Nothing is mocked but the edges
of the machine — files, audio, the clock. They never reach into a feature's private code, and they
live in `test/integration/`.

## 8. What is not tested here

- **Feel and look.** Whether a jump feels responsive or a pose reads well is a `Manual check`.
- **Timing on the real machine.** No test asserts wall-clock time; performance is profiled.
- **Third-party code.** Flame, Flutter and the platform are trusted; the adapter around them is
  tested.
