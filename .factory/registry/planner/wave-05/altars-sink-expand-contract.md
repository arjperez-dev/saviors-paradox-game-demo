---
factory_version: 4.3.0
---

# The altars' sink lands by expand–contract

- **Date:** 2026-10-17
- **Outcome:** T111 adds an optional sink to `ZoneAltars`; T140 (module integration) passes it in `dungeon_zone_test.dart`; T141 makes it required and implements `takeWithin`.
- **Decisions:** a constructor change used by an integration test cannot land in one task (TASK_FILE_SPEC §3.1); three serial tasks inside the feature, as T106 put a dungeon task in module integration (operator, 2026-10-17).
- **Deviations:** the optional sink exists only on `feat/dungeon`, never on `main`.
- **Evidence:** rejected: a default sink that drops `ItemTaken`; sending it to the architect.
