---
factory_version: 4.3.0
---

# Contract events/game_event

- **Date:** 2026-10-14
- **Outcome:** `GameEvent`, consumed by loop.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
