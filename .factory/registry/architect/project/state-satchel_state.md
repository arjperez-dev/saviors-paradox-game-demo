---
factory_version: 4.3.0
---

# Contract state/satchel_state

- **Date:** 2026-10-14
- **Outcome:** `SatchelState`, owned by inventory; consumed by hud, pause.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
