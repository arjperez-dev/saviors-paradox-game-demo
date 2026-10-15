---
factory_version: 4.3.0
---

# Contract events/cinematic_started

- **Date:** 2026-10-15
- **Outcome:** `CinematicStarted{cinematic}` (HaltCause.cinematic), emitted by cinematics (stub `cinematic_director.dart`); consumed by loop, input and hud.
- **Decisions:** A cinematic halts the world and takes the generic menu context (hold Enter or Esc 5 s, intro.md S4, outro.md S7); the HUD hides (hud §2).
- **Deviations:** For the planner: the outro plays in-engine (outro.md shot 1) while this halts the world step, so FollowCamera holds; cinematics must drive that shot itself on the interface step (operator, 2026-10-15).
- **Evidence:** rejected: reading `CinematicState` each frame to infer a halt.
