---
factory_version: 4.3.0
---

# Contract events/cinematic_ended

- **Date:** 2026-10-15
- **Outcome:** `CinematicEnded{cinematic}` (HaltCause.cinematic), emitted by cinematics; consumed by loop, input and hud.
- **Decisions:** Pairs with `CinematicStarted`, naming the same `CinematicId`.
- **Deviations:** none
- **Evidence:** rejected: `CinematicState.hasFinished` as the resume signal.
