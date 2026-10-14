---
factory_version: 4.3.0
---

# Contract events/pause_closed

- **Date:** 2026-10-14
- **Outcome:** `PauseClosed`, emitted by pause; consumed by loop, audio.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
