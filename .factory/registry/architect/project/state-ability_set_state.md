---
factory_version: 4.3.0
---

# Contract state/ability_set_state

- **Date:** 2026-10-14
- **Outcome:** `AbilitySetState`, owned by abilities; consumed by hud, pause.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
