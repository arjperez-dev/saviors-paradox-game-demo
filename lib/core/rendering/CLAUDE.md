# rendering

## What it is

The static pencil kit: seeded strokes, hatching, masonry, the paper and its vignette, ink smoke, generated once and drawn every frame.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `kernel/seed` | consumes | — |
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
- `.factory/project/reference/02-art-direction/fx/ink-smoke/ink-smoke.md`
- `.factory/project/reference/02-art-direction/fx/ink-smoke/sprites/`
- `.factory/project/reference/02-art-direction/sandbox/sandbox.html`

## Not here

- How Akeris, an enemy or a room looks: each feature's `presentation/` draws its own with this kit.
- Hit sparks and callouts: `combat`.
