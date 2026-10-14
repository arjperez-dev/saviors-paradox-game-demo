---
factory_version: 4.3.0
---

# Contract state/arsenal_state

- **Date:** 2026-10-14
- **Outcome:** `ArsenalState`, owned by arsenal; consumed by hud, pause, run, save.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
