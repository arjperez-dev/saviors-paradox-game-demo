---
factory_version: 4.3.0
---

# Contract ports/world_camera

- **Date:** 2026-10-15
- **Outcome:** `WorldCamera` (`toWorld`, `toScreen`), implemented by core/rendering's `FollowCamera`; consumed by core/input and hud.
- **Decisions:** Scale: k = 1 (1 su = 1 world unit; 32 su = one tile, biome.md); the view is 750 world units tall, so Akeris (192) is 25.6 % (ART_DIRECTION §3); its width follows the screen's aspect, no letterbox (operator, 2026-10-15); 750's one home is FollowCamera. It takes plain kernel values (target, facing, bounds) from core/app and steps with the world step; rules from dungeon.md §2 and biome.md (60 %).
- **Deviations:** `scale` is not a registry entry name (REGISTRY_SPEC §2.3), so the scale is recorded here.
- **Evidence:** rejected: a camera in a feature; reading AkerisState/ZoneState inside core/rendering; letterboxing at 16:9.
