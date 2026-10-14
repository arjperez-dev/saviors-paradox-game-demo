---
factory_version: 4.3.0
---

# Contract events/shield_repair_requested

- **Date:** 2026-10-14
- **Outcome:** `ShieldRepairRequested`, emitted by arsenal; consumed by inventory.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
