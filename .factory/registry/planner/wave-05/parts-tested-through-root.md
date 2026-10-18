---
factory_version: 4.3.0
---

# A root's part file gets a test file, tested through the root

- **Date:** 2026-10-17
- **Outcome:** each posture of `Akeris`, and dungeon's `_PlatformMotion`, has a test file at its own path that exercises it only through the root's public methods.
- **Decisions:** one test file for the whole akeris library would pass 300 lines and make every posture task share it; tests stay behavioural (testing §3).
- **Deviations:** revises wave-04 `entities-behind-their-root`, where part files had no test file of their own.
- **Evidence:** rejected: a single `akeris_test.dart`; testing the private parts directly.
