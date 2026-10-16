---
factory_version: 4.3.0
---

# A moving body allocates its Vec2

- **Date:** 2026-10-16
- **Outcome:** each flight's move, and each platform's box, allocates its new kernel value per step; nothing else in the per-frame paths allocates.
- **Decisions:** the kernel's `Vec2` and `WorldBox` are immutable classes, and the contracts' own calls (`cast(Vec2, Vec2)`) take new ones; architecture §4 says snapshot values are replaced, never modified.
- **Deviations:** architecture §6.1 is held everywhere but these kernel values.
- **Evidence:** rejected: mirroring positions as raw doubles inside entities, which repeats the kernel's arithmetic (C11) for an unmeasured gain (§6.7).
