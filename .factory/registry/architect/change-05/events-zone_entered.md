---
factory_version: 4.3.0
---

# Contract events/ZoneEntered

- **Date:** 2026-10-17
- **Outcome:** `ZoneEntered` keeps its fields and gains a doc comment: it is delivered only after the zone it names is saved, so `ZoneState.start` is readable when it arrives.
- **Decisions:** akeris places Akeris on hearing it, reading the start from `state/zone_state`; the event queue delivers after `SeededZoneGenerator.generate` has saved the zone (operator).
- **Deviations:** none
- **Evidence:** rejected: a `start` field on the event — the value twice, and a break of the `const ZoneEntered` in dungeon's generator test.
