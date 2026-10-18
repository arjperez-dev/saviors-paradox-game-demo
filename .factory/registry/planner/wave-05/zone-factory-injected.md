---
factory_version: 4.3.0
---

# The zone generator takes its factory

- **Date:** 2026-10-17
- **Outcome:** T108: `ZoneFactory` becomes an `interface class`, passed to `SeededZoneGenerator` with the real one as default; it closes T102's open finding (checklist T7, C2).
- **Decisions:** a test can then force `noAttemptFits`; the default keeps `dungeon_zone_test.dart` (module integration) compiling.
- **Deviations:** none
- **Evidence:** rejected: a required parameter, which breaks a file no dungeon task may edit.
