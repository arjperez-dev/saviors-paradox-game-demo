---
factory_version: 4.3.0
---

# What cannot fly is not a flying action

- **Date:** 2026-10-17
- **Outcome:** `FlyingAction` (T149) narrows `ChainAction` to what sends a blade out; `ChainPair` holds and arrives with it only, so `StayPut` is never a case there.
- **Decisions:** the types say what cannot happen (operator, 2026-10-17).
- **Deviations:** none
- **Evidence:** rejected: a `StateError` in the domain for the unreachable arm.
