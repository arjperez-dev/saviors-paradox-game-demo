---
factory_version: 4.3.0
---

# Contract events/run_started

- **Date:** 2026-10-14
- **Outcome:** `RunStarted`, emitted by run; consumed by narrative.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
