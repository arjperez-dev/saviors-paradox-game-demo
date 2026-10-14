---
factory_version: 4.3.0
---

# Contract kernel/result

- **Date:** 2026-10-14
- **Outcome:** `Result`, a shared-kernel value, complete, with no stub, used by every module that needs it.
- **Decisions:** A sealed family: `Success` and `Failure`. A value type with the same meaning in every module: construction, validation, equality and arithmetic only.
- **Deviations:** none
- **Evidence:** rejected: nullable returns for expected failures.
