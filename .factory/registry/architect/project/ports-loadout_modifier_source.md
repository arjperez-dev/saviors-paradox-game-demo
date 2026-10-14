---
factory_version: 4.3.0
---

# Contract ports/loadout_modifier_source

- **Date:** 2026-10-14
- **Outcome:** `LoadoutModifierSource`, implemented by abilities, arsenal, hazards, inventory; consumed by akeris.
- **Decisions:** `revision` lets `akeris` rebuild its decorator chain only when the modifiers change (§1 rule 3). An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: rebuilding the chain every frame.
