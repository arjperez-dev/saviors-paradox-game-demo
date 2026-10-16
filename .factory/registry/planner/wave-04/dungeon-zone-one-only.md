---
factory_version: 4.3.0
---

# Dungeon's first wave defers five parts

- **Date:** 2026-10-16
- **Outcome:** deferred: the step driven by Akeris's position (RoomEntered, BossRoomEntered, WayDownReached, ItemTaken, sealing); the enemy mix (`ZoneState.spawns` empty); the stage changes (with the Golem's contract); the memento source; zones 2–5.
- **Decisions:** the position step needs a contract (change-04); the `Zone` root already offers `roomContaining`, `altarWithinReach`, `takeFrom` and `sealBossRoom`, so that step will be only a port adapter (operator, 2026-10-16).
- **Deviations:** the stubs `boss_room_stage_elements.dart` and `zone_memento_source.dart` stay stubs this wave.
- **Evidence:** rejected: blocking the whole of dungeon on the architect.
