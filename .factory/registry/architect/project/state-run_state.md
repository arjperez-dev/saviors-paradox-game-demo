---
factory_version: 4.3.0
---

# Contract state/run_state

- **Date:** 2026-10-14
- **Outcome:** `RunState`, owned by run; consumed by hud, save.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
