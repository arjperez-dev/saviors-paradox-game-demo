---
factory_version: 4.3.0
---

# Loop steps at most 1/30 s through tear-offs

- **Date:** 2026-10-14
- **Outcome:** `StepClock` caps a step at 1/30 s; `GameLoop` steps a list of `SystemStep` tear-offs; `core/app` gets the loop now, with no systems.
- **Decisions:** architecture §5 asks for a maximum without fixing it. Overlapping hitstops: the longest wins. A hitstop ending inside a frame steps the rest of it. Events are delivered while held, so `PauseClosed` arrives; an event raised while delivering waits (patterns §7.2). T003 owns `saviors_paradox_game.dart`; T008 changes it by note only.
- **Deviations:** none
- **Evidence:** rejected: a `GameSystem` interface in `loop` every feature would import.
