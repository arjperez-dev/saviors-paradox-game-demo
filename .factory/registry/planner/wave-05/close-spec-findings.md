---
factory_version: 4.3.0
---

# Close the Spec<T> findings of T068 and T093

- **Date:** 2026-10-17
- **Outcome:** no task adds a composable `Spec<T>`; the findings in `implementer/combat/T068.md` and `implementer/dungeon/T093.md` are closed.
- **Decisions:** architect change-04 `kernel-spec`: each is the only specification over its type and nothing composes them; `Spec<T>` arrives with its second case (design-patterns §12, §14).
- **Deviations:** none
- **Evidence:** rejected: a one-off composable wrapper per specification.
