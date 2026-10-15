---
factory_version: 4.3.0
---

# The interface step is the clamped frame

- **Date:** 2026-10-15
- **Outcome:** `StepClock.clamp` gives the drain and the interface systems the frame capped at 1/30 s, untouched by halts and hitstops (T036).
- **Decisions:** architecture §5: both steps take the same clamp. A hitstop waits while the world is halted, as T006 had it. Per frame: drain, deliver, world, interface; so a halt drained this frame holds the world this frame, and a halt raised by a world system holds it from the next.
- **Deviations:** none
- **Evidence:** probed on a scratch copy of `main` with T034–T036 as written: `flutter analyze --fatal-infos` clean, 26 loop tests green, T009's unchanged. `prefer_initializing_formals` forced `this._drain`.
