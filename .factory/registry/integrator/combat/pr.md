---
factory_version: 4.3.0
---

# PR — combat

- **Date:** 2026-10-17
- **Outcome:** `combat: Strikes, blocks, reflects and status effects resolve through the loop`
- **Decisions:** the Summary and Scrutinise name the feature's own domain boundary (strikes, blocks, reflects, status effects, projectile flight) against what stays with the attacking features (weapon damage values and visuals) — the clearest line a reviewer needs to place the diff. No other naming choice was needed.
- **Deviations:** none.
- **Evidence:**

```text
combat: Strikes, blocks, reflects and status effects resolve through the loop

## Summary

Combat gets its own domain — Strike, Defender, Immunities, Guard, Affliction,
Missile and StatusEffects — and the services that turn an attack into a
resolved exchange: reach and collision, block judging against a strike's
element, hitstop, status-effect application through the control port,
projectile flight against the world, and the sounds and integration events
each exchange publishes. It does not own a weapon's damage values or visuals,
or any enemy's decision to attack — those stay with the attacking features.

## Tasks

| id | title | type |
|---|---|---|
| T067 | Model the values an exchange is made of | feat |
| T068 | Judge a raised shield against a strike's element | feat |
| T069 | Hold the world still as long as each exchange asks | feat |
| T070 | Tell whether a point reaches a body's box | feat |
| T071 | Name the sounds an exchange makes | feat |
| T072 | Model a strike reaching its defender | feat |
| T073 | Resolve one strike against one defender | feat |
| T074 | Keep the pending engagements | feat |
| T075 | Count down the status effects on every body | feat |
| T076 | Keep the status effects | feat |
| T077 | Model a projectile as combat flies it | feat |
| T078 | Fly the projectiles from a fixed pool | feat |
| T079 | Keep the projectiles in flight | feat |
| T080 | Read the contracts into combat's model | feat |
| T081 | Register the bodies an attack can reach | feat |
| T082 | Apply a status effect through the control port | feat |
| T083 | Step the status effects | feat |
| T084 | Publish what an exchange resolved | feat |
| T085 | Queue the attacks a body strikes or throws | feat |
| T086 | Resolve the pending engagements each step | feat |
| T087 | Step the projectiles against the world | feat |
| T088 | Test strikes, blocks and reflects through the loop | test |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- `flutter test`: `All tests passed!` (612 tests).
- Manual tests of the feature: none.

## Scrutinise

- T088 is the one place the whole feature is driven together — strikes,
  perfect blocks and reflected projectiles through a real `GameLoop` and
  `EventQueue`, stepping `StepEngagements`, `StepFlights` and
  `StepStatusEffects` over real in-memory repositories — so a review should
  start there before any single task's tests.
- `ReportExchange` is where every system's output converges into the events
  other features hear (`HitLanded`, `AttackBlocked`, `CounterTriggered`,
  `ProjectileReflected`, `HitstopStarted`, `SoundEffectCued`); a reviewer
  should check that ordering against `hit-feedback.md` and `counter.md`
  directly rather than trusting the per-task tests alone.
- Open finding: T068 — the tester also raised `architecture.md` §4's
  Policy/specification row.
```
