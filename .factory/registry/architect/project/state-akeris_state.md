---
factory_version: 4.3.0
---

# Contract state/akeris_state

- **Date:** 2026-10-14
- **Outcome:** `AkerisState`, owned by akeris; consumed by abilities, bosses, enemies, hazards, hud, map, narrative, pause, run.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
