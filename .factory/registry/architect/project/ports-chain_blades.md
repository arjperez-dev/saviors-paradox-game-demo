---
factory_version: 4.3.0
---

# Contract ports/chain_blades

- **Date:** 2026-10-14
- **Outcome:** `ChainBlades`, implemented by chain; consumed by akeris.
- **Decisions:** Declared by `akeris`, implemented by `chain`; hands and aim travel as arguments, the result as `ChainPull`. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** `architecture.md` §2.3 had `akeris` upstream of `chain`; inverted so neither reads the other (operator, 2026-10-14).
- **Evidence:** rejected: `chain` reading `state/akeris_state` while `akeris` reacts to chain events — a cycle.
