---
factory_version: 4.3.0
---

# Contract state/zone_state

- **Date:** 2026-10-15
- **Outcome:** `ZoneState` gains `bounds` (`WorldBox`), filled by dungeon; both dungeon stubs return a zero box.
- **Decisions:** The camera clamps to the zone's bounds (the sandbox's `updateCamera`); dungeon knows them when it generates the zone.
- **Deviations:** none
- **Evidence:** rejected: core/app taking the union of the room bounds, logic in the composition root.
