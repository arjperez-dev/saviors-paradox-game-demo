---
factory_version: 4.3.0
---

# Contract ports/ChainThrow

- **Date:** 2026-10-17
- **Outcome:** `ChainThrow` gains a required `bool isAirborne`; no stub changes, nothing builds it yet.
- **Decisions:** chain's rules need it: controls G19 (a ring level with Akeris or a little below, in the air) and G20 (wall to wall, only in the air). Note for the planner: the akeris task that builds `ChainThrow` fills `isAirborne` from his posture.
- **Deviations:** none
- **Evidence:** rejected: chain reading `AkerisState` (the cycle `ports-chain_blades` rejected); rejected: chain casting down from `from`, copying akeris's shoulder height.
