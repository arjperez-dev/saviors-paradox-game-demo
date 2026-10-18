---
factory_version: 4.3.0
---

# The combatant roster moves by expand–contract

- **Date:** 2026-10-17
- **Outcome:** T143 copies `CombatantRoster` to `combat/infrastructure/`; T144 (module integration) switches `combat_exchange_test.dart`; T145 deletes the `application/` copy.
- **Decisions:** checklist A14 and architect change-04; the test is in module integration, so the move is three serial tasks inside the feature (operator, 2026-10-17). The `CLAUDE.md` stub row moves in the next architect session.
- **Deviations:** two copies live together on `feat/combat` until T145.
- **Evidence:** rejected: deferring the move; one task across two modules.
