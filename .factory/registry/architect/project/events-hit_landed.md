---
factory_version: 4.3.0
---

# Contract events/hit_landed

- **Date:** 2026-10-14
- **Outcome:** `HitLanded`, emitted by combat; consumed by akeris, bosses, chain, enemies, hazards, inventory.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
