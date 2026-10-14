---
factory_version: 4.3.0
---

# Contract events/status_effect_applied

- **Date:** 2026-10-14
- **Outcome:** `StatusEffectApplied`, emitted by combat; consumed by akeris, enemies.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
