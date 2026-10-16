---
factory_version: 4.3.0
---

# Note for the architect's change-04

- **Date:** 2026-10-16
- **Outcome:** three contract questions for change-04; none blocks this wave.
- **Decisions:**
  - dungeon's RoomEntered, BossRoomEntered, WayDownReached and ItemTaken need Akeris's position, which no contract gives dungeon. The likely shape is a port dungeon offers (map rule 2), e.g. `movedTo(position)` called by akeris; not one dungeon declares (operator, 2026-10-16);
  - move `CombatantRoster`'s implementation to `infrastructure/` (A14);
  - decide who hands out `EntityId`s (an allocator, or a block per feature).
- **Deviations:** none
- **Evidence:** rejected: dungeon hearing akeris's events, an edge the acyclic map forbids (architecture §2.3).
