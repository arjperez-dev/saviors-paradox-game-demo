# rendering

## What it is

The static pencil kit: seeded strokes, hatching, masonry, the paper and its vignette, ink smoke, generated once and drawn every frame. The world camera, `FollowCamera`: 750 world units tall, the one home of that height, its width following the screen's aspect; `lib/core/app/` hands it a target and the zone's bounds and steps it with the world step.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/world_camera` | implements | `lib/core/rendering/presentation/follow_camera.dart` |
| `kernel/seed` | consumes | — |
| `kernel/screen_vec2` | consumes | — |
| `kernel/facing` | consumes | — |
| `kernel/seconds` | consumes | — |
| `kernel/vec2` | consumes | — |
| `kernel/world_box` | consumes | — |

## Roots

`lib/core/rendering/`, `test/core/rendering/`, `assets/images/`, `assets/fonts/`

## References

- `.factory/project/reference/02-art-direction/ART_DIRECTION.md`
- `.factory/project/reference/02-art-direction/palette/palette.md`
- `.factory/project/reference/02-art-direction/palette/palette.png`
- `.factory/project/reference/02-art-direction/strokes/strokes.md`
- `.factory/project/reference/02-art-direction/strokes/strokes.png`
- `.factory/project/reference/02-art-direction/dungeon/dungeon.md`
- `.factory/project/reference/02-art-direction/dungeon/dungeon.png`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/biome.md`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/biome.md`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/biome.md`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/biome.md`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/biome.md`
- `.factory/project/reference/02-art-direction/fx/ink-smoke/ink-smoke.md`
- `.factory/project/reference/02-art-direction/fx/ink-smoke/sprites/`
- `.factory/project/reference/02-art-direction/sandbox/sandbox.html`

## Not here

- How Akeris, an enemy or a room looks: each feature's `presentation/` draws its own with this kit.
- Hit sparks and callouts: `combat`.
- What the camera follows: `lib/core/app/` reads it from `AkerisState` and `ZoneState`.
