---
factory_version: 4.3.0
---

# Contract events/world_halted

- **Date:** 2026-10-15
- **Outcome:** `WorldHalted`, an abstract base carrying a `HaltCause`; extended by PauseOpened, MapOpened, DialogueOpened, AbilityChoiceOffered, CinematicStarted; consumed by loop and input.
- **Decisions:** The loop and the input stack listen to the base only and hold the set of causes, idempotently. Each frame: input drains first and is delivered whatever halts, then the world step (unless halted or in hitstop), then the interface step, which never halts; both take the same 1/30 s clamp (architecture §5, coding-standards §8).
- **Deviations:** `HitstopStarted` stays outside the base: a timed hold, not a screen, that never moves the input stack (operator, 2026-10-15). Glossary *world halt* approved.
- **Evidence:** rejected: the loop subscribing to each concrete event; an interface class with a getter body per event.
