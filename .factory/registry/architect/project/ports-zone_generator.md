---
factory_version: 4.3.0
---

# Contract ports/zone_generator

- **Date:** 2026-10-14
- **Outcome:** `ZoneGenerator`, implemented by dungeon; consumed by run.
- **Decisions:** An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: importing another feature's implementation.
