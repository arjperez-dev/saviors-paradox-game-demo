---
factory_version: 4.3.0
---

# Contract events/pause_closed

- **Date:** 2026-10-15
- **Outcome:** `PauseClosed` now extends `WorldResumed(HaltCause.pauseMenu)`; hud joins its consumers.
- **Decisions:** Pairs with `PauseOpened`.
- **Deviations:** none
- **Evidence:** rejected: no cause on the resume (see events-world_resumed).
