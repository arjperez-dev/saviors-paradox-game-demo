---
factory_version: 4.3.0
---

# Contract ports/boss_room_stage

- **Date:** 2026-10-14
- **Outcome:** `BossRoomStage`, implemented by dungeon; consumed by bosses.
- **Decisions:** Bosses change their room's stage through `dungeon`, which owns the geometry. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: `dungeon` reacting to boss phases — a cycle.
