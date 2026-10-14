---
factory_version: 4.3.0
---

# Contract ports/xp_account

- **Date:** 2026-10-14
- **Outcome:** `XpAccount`, implemented by arsenal; consumed by run.
- **Decisions:** Implemented by `arsenal`, which holds XP because only it spends XP; `run` credits the drops. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** `architecture.md` §2.1 put XP in `run` (operator, 2026-10-14).
- **Evidence:** rejected: XP in `run`, which `arsenal` would have to query back — a cycle.
