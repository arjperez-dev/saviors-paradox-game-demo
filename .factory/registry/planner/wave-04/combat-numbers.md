---
factory_version: 4.3.0
---

# Combat's numbers that VISION leaves to the game

- **Date:** 2026-10-16
- **Outcome:** perfect-block window 0.2 s; a reflect returns level at 1.6× with the projectile's own damage; a hit `hit-feedback.md` §2 does not list holds 0.05 s; a projectile is spent after 4 s; 64 fly at once, the oldest reused.
- **Decisions:** the planner proposed each, the operator confirmed each (2026-10-16); they live in `BlockJudge`, `Flights` and `HitstopRule`, each naming its source.
- **Deviations:** none
- **Evidence:** rejected: leaving them open, which would hand the choice to the implementer (TASK_FILE_SPEC §6.2).
