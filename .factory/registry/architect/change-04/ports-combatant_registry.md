---
factory_version: 4.3.0
---

# Contract ports/combatant_registry

- **Date:** 2026-10-17
- **Outcome:** `CombatantRegistry` gains `Combatant? byId(EntityId combatant)`; `combatant_roster.dart` marks its existing `byId` `@override`.
- **Decisions:** It returns the body's own read-only `Combatant` view, as `near` does, never a combat entity (checklist A12), so `EngagementQueue` can take the contract (C2, T085's finding). Note for the planner: first, `EngagementQueue` and `StepFlights` depend on `CombatantRegistry` instead of `CombatantRoster`; only then the roster moves to `combat/infrastructure/` (A14), since `application/` may not import `infrastructure/`. The `CLAUDE.md` stub row moves in the next architect session, once the move has landed (operator).
- **Deviations:** none
- **Evidence:** rejected: a new read-only view type — a second interface for the same body.
