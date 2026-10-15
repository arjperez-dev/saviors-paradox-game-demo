---
factory_version: 4.3.0
---

# PR — loop

- **Date:** 2026-10-14
- **Outcome:** `loop: The fixed-order game loop drives every system each frame`
- **Decisions:** named the event queue's re-entrancy swap and the hitstop/pause interaction in
  Scrutinise, since both are invariants stated in the commit messages but not visible from the
  diff's shape alone.
- **Deviations:** none
- **Evidence:**

```text
## Summary

The loop feature delivers the fixed-order game loop that drives every system each frame: an
EventQueue every feature publishes to and subscribes from, a StepClock that clamps, pauses and
holds each frame's dt, and a GameLoop that delivers events, asks the clock for the step, then steps
every system in the given order — wired into Flame's update through LoopComponent inside the
composition root. It deliberately registers no system yet; the system list stays empty for later
waves to fill.

## Tasks

| id | title | type |
|---|---|---|
| T005 | Deliver published events in the order they were raised | feat |
| T006 | Turn each frame's time into the step the systems receive | feat |
| T007 | Step the systems in their fixed order | feat |
| T008 | Drive the game loop from Flame's update | feat |
| T009 | Test the loop frame by frame inside a Flame game | test |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- `flutter test`: All tests passed! (60 tests)
- Manual tests: none

## Scrutinise

- `EventQueue.deliver` swaps a pending/delivering pair of lists so an event published mid-delivery
  waits for the next call instead of re-entering a handler — worth checking that no system assumes
  same-frame delivery.
- `StepClock` holds the step for a hitstop's duration, waits out an active pause first, and never
  lets a shorter hitstop cut a longer one already running; the three interact only inside
  `GameLoop`, which subscribes to `PauseOpened`, `PauseClosed` and `HitstopStarted` itself.
```
