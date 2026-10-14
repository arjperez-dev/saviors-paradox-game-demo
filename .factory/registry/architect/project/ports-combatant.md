---
factory_version: 4.3.0
---

# Contract ports/combatant

- **Date:** 2026-10-14
- **Outcome:** `Combatant`, implemented by abilities, akeris, bosses, enemies, hazards; consumed by combat.
- **Decisions:** Declared by `combat`, the inner ring, and implemented by every body that can be hit; `combat` no longer reads `state/akeris_state`. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** `architecture.md` §2.3 had `akeris ⇄ combat` and `enemies ⇄ combat`; the client-owned port makes the context map acyclic (operator, 2026-10-14).
- **Evidence:** rejected: `combat` consuming each body's published state, a cycle with `hit_landed`.
