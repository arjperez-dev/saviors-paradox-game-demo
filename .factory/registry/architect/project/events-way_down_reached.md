---
factory_version: 4.3.0
---

# Contract events/way_down_reached

- **Date:** 2026-10-14
- **Outcome:** `WayDownReached`, emitted by dungeon; consumed by run.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
