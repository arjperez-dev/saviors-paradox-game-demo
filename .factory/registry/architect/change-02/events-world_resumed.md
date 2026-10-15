---
factory_version: 4.3.0
---

# Contract events/world_resumed

- **Date:** 2026-10-15
- **Outcome:** `WorldResumed`, an abstract base carrying the `HaltCause` it ends; extended by PauseClosed, MapClosed, DialogueClosed, AbilityChosen, CinematicEnded.
- **Decisions:** Each resume names the halt it ends, so a resume with no matching halt changes nothing (an `AbilityChosen` with no offer).
- **Deviations:** Glossary *world resume* / *mundo reanudado* approved, 2026-10-15.
- **Evidence:** rejected: a counter decremented by any resume.
