---
factory_version: 4.3.0
---

# Contract events/halt_cause

- **Date:** 2026-10-15
- **Outcome:** `HaltCause`: pauseMenu, map, dialogue, abilityChoice, cinematic; consumed by loop and input through the halt bases.
- **Decisions:** One value per screen that stops the world (06-ui/pause-menu §2, map §2, dialogue §2, glossary *ability drop*, VISION §World on cinematics); one per kind suffices because no two of a kind overlap. An enum beside `events/death_cause`, with no rule.
- **Deviations:** Glossary term *halt cause* / *causa de la detención* approved by the operator, 2026-10-15.
- **Evidence:** rejected: a plain halt count, which an unmatched or repeated event leaves halted for good (operator, 2026-10-15); the event's runtime type as identity.
