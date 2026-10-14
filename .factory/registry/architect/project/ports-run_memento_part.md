---
factory_version: 4.3.0
---

# Contract ports/run_memento_part

- **Date:** 2026-10-14
- **Outcome:** `RunMementoPart`, a companion type of the contracts that name it.
- **Decisions:** Opaque: a key and a payload each feature encodes in its own `infrastructure/`. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: a typed memento per feature in the contracts, which `save` would have to know.
