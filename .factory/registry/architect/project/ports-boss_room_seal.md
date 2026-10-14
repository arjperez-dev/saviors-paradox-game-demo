---
factory_version: 4.3.0
---

# Contract ports/boss_room_seal

- **Date:** 2026-10-14
- **Outcome:** `BossRoomSeal`, implemented by dungeon; consumed by run.
- **Decisions:** `run`, the process manager, opens the room when the boss dies. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: `dungeon` consuming `boss_defeated`, a cycle with `bosses` reading the geometry.
