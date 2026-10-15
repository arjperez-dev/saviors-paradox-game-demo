---
factory_version: 4.3.0
---

# Contract events/ability_choice_offered

- **Date:** 2026-10-15
- **Outcome:** `AbilityChoiceOffered` now extends `WorldHalted(HaltCause.abilityChoice)`.
- **Decisions:** The game pauses on the choice after a boss (glossary *ability drop*); it takes the generic menu context (A/D, Enter).
- **Deviations:** No reference says what the HUD or audio do during it; nothing added, for the planner to raise.
- **Evidence:** rejected: a separate halt event beside the offer.
