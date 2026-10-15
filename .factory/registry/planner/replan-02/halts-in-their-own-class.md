---
factory_version: 4.3.0
---

# The halt causes live in their own class

- **Date:** 2026-10-15
- **Outcome:** `WorldHalts` in `loop/domain/` (T034); `StepClock` only asks it (T035).
- **Decisions:** the clock turns frame time into a step; the halt bookkeeping is a second reason to change (coding-standards §1 S, operator 2026-10-15). `StepClock({maxStep, WorldHalts? halts})` keeps its own when given none and exposes it as `halts`; `GameLoop` subscribes through `clock.halts`, so one instance is shared.
- **Deviations:** none
- **Evidence:** rejected: the set inside `StepClock` (planner's first proposal); a separate `halts:` on `GameLoop`, which with two defaults could hold two instances that disagree.
