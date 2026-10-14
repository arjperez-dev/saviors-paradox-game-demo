---
factory_version: 4.3.0
---

# Contract events/room_entered

- **Date:** 2026-10-14
- **Outcome:** `RoomEntered`, emitted by dungeon; consumed by map.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
