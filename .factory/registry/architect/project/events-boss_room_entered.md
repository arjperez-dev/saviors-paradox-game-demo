---
factory_version: 4.3.0
---

# Contract events/boss_room_entered

- **Date:** 2026-10-14
- **Outcome:** `BossRoomEntered`, emitted by dungeon; consumed by bosses, save.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
