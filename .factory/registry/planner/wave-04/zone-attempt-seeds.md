---
factory_version: 4.3.0
---

# A zone's attempts come from its seed

- **Date:** 2026-10-16
- **Outcome:** `SeededZoneGenerator` derives `seed.forZone(zone)`; `ZoneFactory` makes up to 600 attempts, each `ZoneBuilder.build(kit, Seed(seed.value + attempt))` drawing from `Random(seed.value)`, keeping the first that `ZoneValidator` passes (T092, T098, T102).
- **Decisions:** design-patterns §10: "a zone that fails is rebuilt from the next seed"; 600 is the sandbox's `zoneGen`. The same seed gives the same zone in this game, not the sandbox's zone.
- **Deviations:** none
- **Evidence:** rejected: porting the sandbox's mulberry hash so its seeds give its zones.
