---
factory_version: 4.3.0
---

# CombatantRoster stays in application, against A14

- **Date:** 2026-10-16
- **Outcome:** `CombatantRoster` (T081) is at the path combat's `CLAUDE.md` fixes, `application/combatant_roster.dart`; its block is "—", an adapter of other features' bodies (design-patterns §13).
- **Decisions:** it is no DDD repository: what it holds are other features' aggregates, seen as `Combatant`s. Its reach rule is the domain's `Reach` (operator, 2026-10-16).
- **Deviations:** checklist A14 would put a collection-like port's implementation in `infrastructure/`; the stub's path belongs to the architect. Change-04 is asked to move it.
- **Evidence:** rejected: calling it a repository, or a use case that holds state.
