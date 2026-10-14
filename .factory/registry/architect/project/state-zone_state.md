---
factory_version: 4.3.0
---

# Contract state/zone_state

- **Date:** 2026-10-14
- **Outcome:** `ZoneState`, owned by dungeon; consumed by enemies, hazards, map, narrative.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
