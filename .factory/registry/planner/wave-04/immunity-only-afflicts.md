---
factory_version: 4.3.0
---

# Immunity changes only what a shield inflicts

- **Date:** 2026-10-16
- **Outcome:** an ice-immune body is slowed where another would freeze; a fire-immune body does not burn; immunity never stops a hit from landing (`Affliction.byShield`, T067).
- **Decisions:** VISION: "stone enemies and the Dragon are slowed instead", "fire creatures and stone do not burn". The burn's health loss and the frozen body's lowered defence belong to the body's own loadout (design-patterns §1), not to combat (operator, 2026-10-16).
- **Deviations:** none
- **Evidence:** rejected: combat ticking the burn as `HitLanded` events; immunity voiding hits of that element.
