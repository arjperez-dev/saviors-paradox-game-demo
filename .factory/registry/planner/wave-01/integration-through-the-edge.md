---
factory_version: 4.3.0
---

# Wave-1 integration runs through the contracts

- **Date:** 2026-10-14
- **Outcome:** each wave-1 feature's integration task drives its module through the contracts and the real Flame/Flutter edge (T009, T014, T033).
- **Decisions:** the wave's features run in parallel, so none may import another before it is on `main` (operator: option A, 2026-10-14). The first cross-module test, input → loop, lands in wave 2. `tooling` has none: T004 builds and analyzes every contract and stub together.
- **Deviations:** none
- **Evidence:** rejected: option B, planning `input` after `loop` reaches `main`, at the cost of parallelism.
