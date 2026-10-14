---
factory_version: 4.3.0
---

# Contract ports/event_sink

- **Date:** 2026-10-14
- **Outcome:** `EventSink`, implemented by loop; consumed by abilities, akeris, arsenal, bosses, chain, combat, dungeon, enemies, hazards, inventory, narrative, pause, run.
- **Decisions:** An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: importing another feature's implementation.
