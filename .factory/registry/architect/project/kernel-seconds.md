---
factory_version: 4.3.0
---

# Contract kernel/seconds

- **Date:** 2026-10-14
- **Outcome:** `Seconds`, a shared-kernel value, complete, with no stub, used by every module that needs it.
- **Decisions:** A value type with the same meaning in every module: construction, validation, equality and arithmetic only.
- **Deviations:** none
- **Evidence:** rejected: a game rule in the kernel (`architecture.md` §2.4).
