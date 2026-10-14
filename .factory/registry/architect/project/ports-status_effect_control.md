---
factory_version: 4.3.0
---

# Contract ports/status_effect_control

- **Date:** 2026-10-14
- **Outcome:** `StatusEffectControl`, implemented by combat; consumed by abilities, akeris, bosses, hazards.
- **Decisions:** An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: importing another feature's implementation.
