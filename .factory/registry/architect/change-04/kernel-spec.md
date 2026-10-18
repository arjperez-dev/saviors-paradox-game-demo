---
factory_version: 4.3.0
---

# Contract kernel/spec

- **Date:** 2026-10-17
- **Outcome:** Not added: no shared `Spec<T>` yet; `ShieldStops` (T068) and `ZoneValidator` (T093) stay plain classes with `isSatisfiedBy`.
- **Decisions:** Each is the only specification over its type and nothing composes them (design-patterns §14: a pattern arrives with its second case). The planner closes both findings citing this entry. When a second specification needs `and`, `or`, `not` (likely `DetectsAkeris` in enemies), the architect decides where `Spec<T>` lives: not `kernel/`, which holds values with value semantics only.
- **Deviations:** architecture §4 and design-patterns §12 say composable without that condition; the operator fixes the reference.
- **Evidence:** rejected: a `Spec<T>` in `core/contracts/kernel/` now — not a value type, and a pattern with no second implementation.
