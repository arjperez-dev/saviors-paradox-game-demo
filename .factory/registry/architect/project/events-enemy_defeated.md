---
factory_version: 4.3.0
---

# Contract events/enemy_defeated

- **Date:** 2026-10-14
- **Outcome:** `EnemyDefeated`, emitted by enemies; consumed by inventory, run.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
