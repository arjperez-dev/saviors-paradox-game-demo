---
factory_version: 4.3.0
---

# Contract ports/loadout_modifier

- **Date:** 2026-10-14
- **Outcome:** `LoadoutModifier`, a companion type of the contracts that name it.
- **Decisions:** Descriptors of the decorators of `design-patterns.md` §1, as a sealed family; `akeris` builds its own decorators from them. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: sharing decorator classes across features (§1 rule 5).
