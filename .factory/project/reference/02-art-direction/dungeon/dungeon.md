# The dungeon

- **Status:** approved 2026-09-30
- **Sources:** `../ART_DIRECTION.md` §2 (version 1 §4) · the Akeris sandbox (`drawFar`, `drawWorld`,
  `masonry`, `stone`, `render`, `updateCamera`) · `VISION.md` §Art direction
- **Sheet:** [`dungeon.png`](dungeon.png): the sandbox's test room at the approved scale, Akeris for
  size. **It is not zone 1** (see below)
- **Read by:** the task that builds the zone renderer and the camera; every zone's `04-zones/` files
  start from it and add their biome.

The dungeon is drawn as masonry, arches, pillars, chains and darkness, **never as outlined tiles**.
The recipe below holds for every biome; each zone varies the far wall, the props and the hazards.

> **This is not the design of any zone.** The room in the sandboxes and in `dungeon.png` is a test
> room, made to judge Akeris and the effects: its layout, its props and its look are not zone 1's.
> What this file fixes is only the drawing method every zone shares (layers, camera, masonry,
> torches). Each zone's look, layout, hazards and boss room are designed in its own
> `04-zones/zone-N-<biome>/` folder (step 3.9 for zone 1, the Suspended Sanctuary), and there the
> zone's reference wins over this file on how that zone looks.

---

## 1. Layers, back to front

| Layer | Moves | Drawn | Content |
|---|---|---|---|
| Paper | never | once per resize | the `paper` colour |
| Far wall | parallax 0.5 on x, eased on y | once per zone, cached as an image | ashlar courses 46 high; vaults of 470-wide bays with voussoir arches; in each bay a deep dark arch, a niche with skulls, or a barred window with a torn banner; pillars with capitals; hanging chains; darkness at the vault top (0–280) and at the bottom (`drawFar`) |
| World | with the camera | once per zone, cached | pits (gradient to black plus hatching), foreground pillars, hanging-slab and ring chains, doors, torch brackets, every solid as masonry, rubble, bones, skulls, cobwebs (`drawWorld`) |
| Live | every frame | every frame | torch halos and flames, enemies, the player, projectiles, particles, callouts |
| Foreground | parallax 1.3 | every frame (cheap) | a few near-black hanging chains (`drawFore`) |
| Paper overlay | never (screen space) | once per resize | stains, grain and the edge vignette (`../palette/palette.md` §1) |

## 2. Camera

- **It snaps to the device pixel** before the cached layers are copied
  (`Math.round(cam * k) / k` in `render`), so scrolling never shimmers.
- It follows with an eased look-ahead of 110 in the facing direction (rate 2/s) and keeps the player
  at 70 % of the view height (rates 5/s on x, 3.5/s on y).
- **It never shakes** (`../ART_DIRECTION.md` §2).

## 3. Masonry (`masonry`, `stone`)

A zone is a tile grid. **Merge adjacent solid tiles into rectangles first, then draw each rectangle
as masonry.** Never draw one outline per tile.

- Fill the rectangle with `mortar`. Lay rows 34–44 high (the top row 30); stones are 58–130 wide,
  inset 1.8 for the mortar gap.
- Each stone is a polygon whose corners are chipped with probability 0.35 (3–8). Its fill darkens
  with depth; it has a `stoneEdge` line along its top, and hatching over its lower 35–55 %. It has a
  crack with probability 0.3, and 0–3 pits.
- The `depth` gradient runs from 24 below the top edge to 300 below it; a block hanging from the
  ceiling is darkened toward its top instead.
- Outline the top edge at 3 (the edge you stand on must read clearly) and the exposed sides at 2.4.
  Scatter rubble and the odd bone along walkable tops.

## 4. Torches

A bracket on the wall, a flame of two nested shapes (`flame` outer and inner, outlined in ink 1.3),
and a `torchlight` halo of radius 210. The flame's height breathes by ±5 % at 2.6 rad/s and its tip
sways ±2.2 at 1.9 rad/s, each phase offset by the torch's x: a slow sway, never a flicker.
