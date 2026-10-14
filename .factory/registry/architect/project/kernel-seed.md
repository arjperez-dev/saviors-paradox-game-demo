---
factory_version: 4.3.0
---

# Contract kernel/seed

- **Date:** 2026-10-14
- **Outcome:** `Seed`, a shared-kernel value, complete, with no stub, used by every module that needs it.
- **Decisions:** Derivation per zone, room and entity is a splitmix mix of the value itself. A value type with the same meaning in every module: construction, validation, equality and arithmetic only.
- **Deviations:** none
- **Evidence:** rejected: `dart:math` `Random` inside the kernel.
