---
factory_version: 4.3.0
---

# Contract kernel/weapon_id

- **Date:** 2026-10-14
- **Outcome:** `WeaponId`, a shared-kernel value, complete, with no stub, used by every module that needs it.
- **Decisions:** A value type with the same meaning in every module: construction, validation, equality and arithmetic only.
- **Deviations:** none
- **Evidence:** rejected: a game rule in the kernel (`architecture.md` §2.4).
