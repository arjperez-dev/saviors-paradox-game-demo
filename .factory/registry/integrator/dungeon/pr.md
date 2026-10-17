---
factory_version: 4.3.0
---

# PR — dungeon

- **Date:** 2026-10-17
- **Outcome:** `dungeon: The run generates a playable zone from its seed, and steps, collides with and acts on the one it holds`
- **Decisions:** named the Scrutinise points at the unconsumed `Zone.takeFrom`/`_AltarBook` pairing
  against `ZoneAltars`' `returnTo`-only `Altars` contract, and at `zone_builder.dart`'s size and
  untested seed-exhaustion path, since those are where a reviewer not present for each task would
  otherwise have to rediscover the reasoning; and listed every implementer `Open finding:` verbatim
  (T092 C4, T092 A13, T093, T102) so the planner sees what no task could close inside its own bounds.
- **Deviations:** none — the feature's history is its eighteen planned tasks in order, no bug task,
  no replan.
- **Evidence:**

```text
## Summary

Builds the dungeon feature end to end: a domain that lays a zone's rooms out on a grid from a seed
(`ZoneBuilder`), checks the layout is playable (`ZoneValidator`), and assembles it behind its
aggregate root (`Zone`), with its altars, drifting platforms, boss-room door and the swept-AABB
collision rule (`Sweep`, `ZoneGeometry`) guarded underneath; and the application layer wiring that
root to the kernel's contracts — generating a zone from the run's seed, answering collision and
hook-point queries, stepping the drifting platforms each frame, opening the boss room's doors when
its boss dies, and returning an item to its altar. It deliberately leaves `BossRoomStage` a stub and
wires no enemy spawn into a room — both are for a later wave.

## Tasks

| id | title | type |
|---|---|---|
| T089 | Model a room template as values | feat |
| T090 | List the Suspended Sanctuary's room catalog | feat |
| T091 | Model a zone's layout as values | feat |
| T092 | Lay out one attempt at a zone on its grid | feat |
| T093 | Check a zone layout can be played | feat |
| T094 | Find where a moving box first meets a solid | feat |
| T095 | Build a zone's static solids from its layout | feat |
| T096 | Model what an altar can hold | feat |
| T097 | Guard a generated zone behind its root | feat |
| T098 | Build a valid zone from a kit and a seed | feat |
| T099 | Keep the current zone | feat |
| T100 | Read the zone into the contracts | feat |
| T101 | Answer collisions against the current zone | feat |
| T102 | Generate a zone when the run asks | feat |
| T103 | Open the boss room's doors | feat |
| T104 | Return an item to its altar | feat |
| T105 | Step the drifting platforms | feat |
| T106 | Test a zone from its seed to its collisions through the loop | test |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- `flutter test`: All tests passed! (586 tests)
- Manual tests: none

## Scrutinise

- `Zone.takeFrom` (T097) and its `_AltarBook` backing are built and tested, but no application use
  case or contract calls it — `ZoneAltars` (T104) implements the `Altars` contract's `returnTo` only.
  Worth confirming taking an item off an altar is tracked as a later task (inventory/items side)
  rather than forgotten.
- `zone_builder.dart` (T092) and the seed-search path it feeds (`ZoneFactory`, T098) are the one place
  this feature tries up to 600 seeded attempts before failing; a reviewer should look here first,
  since the failure branch itself (`ZoneFailure.noAttemptFits`) has no test reaching it (see the T102
  open finding below) and the file is already past its line budget (T092).
- Open finding C4 (T092 — file ≤300 lines): `zone_builder.dart` is 435 lines; a further split needs a
  second file, which the Constraints forbid.
- Open finding A13 (T092 — no nullable result): `build` returns `ZoneLayout?`, exactly the task's
  `exports` row.
- Open finding (T093 — not a checklist fail, a note for the architect/planner): `architecture.md` §4's
  "Policy / specification" row says that building block is "composable (`and`, `or`, `not`)", which
  `ZoneValidator` does not have — but `design-patterns.md` §14 says a pattern with a single
  implementation and no second case in sight stays a plain class until the second case arrives, and
  this is the first specification in the codebase. Left as the task's `Implementation`/`Interfaces`
  give it, for whoever adds the second specification to weigh.
- Open finding (T102): checklist T7 is a factory, generator or system; the generated "no attempt fits"
  `Failure` branch of `generate` (the `ZoneFailure.noAttemptFits` `StateError`) has no test reaching
  it, because `ZoneFactory` is instantiated inline (`const ZoneFactory()`) rather than injected, so a
  test cannot force all 600 seeded attempts to fail without widening the class's constructor — a
  change outside T102's `Interfaces`.
```
