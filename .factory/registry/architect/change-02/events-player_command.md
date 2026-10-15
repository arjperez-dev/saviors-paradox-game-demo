---
factory_version: 4.3.0
---

# Contract events/player_command

- **Date:** 2026-10-15
- **Outcome:** `Aim` removed; StartAttack, ReleaseAttack, RaiseShield carry `aim` (the click's world point) and `pointerStillFor`; PanMap/StartPanning/ZoomMap use `ScreenVec2`; StopPanning added.
- **Decisions:** The mouse counts only on a click. `pointerStillFor` is the time since the pointer moved, accumulated by core/input from the interface dt, `Seconds(double.infinity)` before it first moves; the 4 s threshold is the weapon's (sandbox `mouseWorld`, hook-blades.md, P7), never core's. PanMap per drag move, 1:1; StartPanning re-sent when the held set changes; ZoomMap anchor null for Q/E (view centre).
- **Deviations:** core/input is drained once per frame by the loop, before both steps (`drainInto(EventSink, Seconds)`). Glossary *pointer stillness*, *pan the map* approved.
- **Evidence:** rejected: a nullable aim since the last aimed click, which breaks a repeated throw at a still mouse (operator); counting stillness from launch.
