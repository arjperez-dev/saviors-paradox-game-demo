---
factory_version: 4.3.0
---

# Contract ports/akeris_health

- **Date:** 2026-10-14
- **Outcome:** `AkerisHealth`, implemented by akeris; consumed by inventory.
- **Decisions:** Healing and maximum health reach Akeris through a port he declares. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: `akeris` consuming `inventory` events, a cycle with the loadout source.
