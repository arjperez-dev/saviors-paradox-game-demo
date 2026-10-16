---
factory_version: 4.3.0
---

# The screen owns the focus

- **Date:** 2026-10-16
- **Outcome:** FocusGroup is pure navigation over rows of ids, after the sandbox's ttMove (T056); the screen holds the focused id and passes focused to each button.
- **Decisions:** EventSource has subscribe and no unsubscribe, so a widget listening to MoveFocus could not release it on dispose (coding-standards §11.5, checklist F5). For the architect, deferred, not solved: the first screen listening to MoveFocus, PressConfirm or PressEscape (pause, title, map, hud) needs a releasable subscription; settle it in a change-NN before the wave that plans the first screen (operator, 2026-10-16).
- **Deviations:** none
- **Evidence:** rejected: a FocusGroup widget subscribing to the queue.
