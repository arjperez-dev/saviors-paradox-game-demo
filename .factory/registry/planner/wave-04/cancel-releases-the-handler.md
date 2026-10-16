---
factory_version: 4.3.0
---

# Cancel releases the handler, tested without an allocation test

- **Date:** 2026-10-16
- **Outcome:** T066 carries change-03's note: `cancel` marks the subscription, delivery skips it, and the list is compacted in place after each `deliver`.
- **Decisions:** idempotent cancel, no skipped handler, and identity handles each get a test. "No allocation in `deliver`" is a `Constraint` the tester holds against checklist A10.
- **Deviations:** the architect's note asked for a test of each property; a deterministic unit test cannot measure allocation.
- **Evidence:** rejected: `removeWhere` (it allocates) and removing a subscription during delivery (it would shift the handlers not yet offered).
