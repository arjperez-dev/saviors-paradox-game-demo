---
factory_version: 4.3.0
---

# Contract events/boss_defeated

- **Date:** 2026-10-14
- **Outcome:** `BossDefeated`, emitted by bosses; consumed by abilities, audio, run.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
