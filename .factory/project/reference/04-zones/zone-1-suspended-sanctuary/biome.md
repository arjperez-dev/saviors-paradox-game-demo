# Zone 1 — Suspended Sanctuary: biome

- **Status:** approved 2026-10-01
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Sheet:** [`sheet.png`](sheet.png) ·
  **Captures:** [`sandbox/captures/`](sandbox/captures/)
- **Sources:** `VISION.md` §Bosses (Golem), §Scope (biomes, hazards) · `01-story/zones-narrative.md`
  (zone 1) · `02-art-direction/ART_DIRECTION.md`, `dungeon/dungeon.md` (the drawing method) ·
  the operator's decisions of 2026-10-01 (below)
- **Read by:** the tasks that draw and play zone 1; with [`layout.md`](layout.md),
  [`hazards.md`](hazards.md) and [`boss-room.md`](boss-room.md)

**The operator decided (2026-10-01):** the sanctuary is **inside an immense cavern**, still the
dungeon; the zone is **about 40 rooms, about 30 minutes** to explore whole; it is **built from
hand-drawn rooms joined by the seed**; a fall into the abyss **costs health and returns Akeris to the
last firm ground**.

---

## A.1 Identity

The sanctuary where Akeris's people climbed to hear the clock. When the clock was used below, the
stones forgot how to fall: the ruins float in a cavern so large its walls are never seen, under a pale
light that falls from above, over a dark abyss. The player must understand at once that **the ground
is islands**, that the void between them is the danger, and that this place was holy: arches, broken
columns and the clock carved in stone with its single hand.

## A.2 Layers, back to front

| Layer | Contents | Parallax | Palette and hatching |
|---|---|---|---|
| far cavern | the ceiling (darkness and hanging stone), five pale light shafts, 40 distant chains, 30 small floating ruins (a slab with a column, an arch, steps or a tower, and broken rock below), fog banks, the dark deep | 0.22 on x and y (tile 3000 × 2900 su, repeats sideways) | `far` stone; ruins lighter with distance; light shafts in `paper` at 13–32 % |
| middle ruins | 8 larger floating ruins, a third hung from pairs of chains | 0.5 (tile 3000 × 2250 su, repeats both ways) | darker stone, 0.6 of the full ink |
| depth wash | a vertical wash over the whole zone: clear at the top, 12 % at mid height, 60 % at the bottom; the deeper, the darker, because the light falls from above | 1 | `ink` at 0–60 % |
| play layer | the islands, columns, arches, reliefs, braziers, stairs, chains, altars, rings; the drifting platforms and floating stones (live) | 1 | as `dungeon.md`: masonry tops, rock undersides hatched |
| foreground | near-black hanging chains passing faster | 1.3 | `ink` at 90 % |
| paper overlay | grain, stains and edge vignette (unchanged) | screen | `palette.md` §1 |

**Camera:** in this zone Akeris sits at **60 %** of the view height, not 70 % (`dungeon.md` §2), so the
void under the islands is seen (proposal Z1). Everything else of the camera is unchanged: it follows,
snaps to the pixel and never shakes.

## A.3 Tiles and masonry

Units are `su`; **32 su = 1 tile** (`CLAUDE.md`). Never drawn as outlined tiles.

| Kind | Size | How it is drawn | Variants |
|---|---|---|---|
| island | 260–3200 su wide; top 60–90 su thick; rock below 100–380 su | a masonry slab whose top edge is the floor (thick stroke), rubble and the odd bone on it; under it, broken rock tapering down in lobes, hatched, darkening downward, with roots and loose stones | by seed |
| drifting platform | 240–320 × 44 su, rock 110 su below | a small island (same recipe), cached once and moved: it is never redrawn | — |
| hanging slab | 400 × 50 su | a slab on two chains up to the ceiling (boss room only) | — |
| solid column / wall | 50–60 su wide | a sanctuary column with a broken top; walls where a floor meets a room edge with no passage | — |

## A.4 Props and light

| Prop | Where | Light | Moves? |
|---|---|---|---|
| broken column | rooms, by template | — | no |
| sanctuary arch (one side broken) | start, steps, ledge end, shrine end | — | no |
| the clock relief: a stone clock face with **one hand** (`01-story/`) | start, hall, ante, shaft, boss room, rings corridor | — | no |
| brazier | most rooms | warm flame and halo (the torch of `dungeon.md`) | the flame sways slowly |
| entrance stair, down along the wall | start room | — | no |
| stair down into darkness | exit room | — | no |
| light shaft | over every altar | pale, from above | no |
| decorative chain | rings corridor, lift shaft | — | no |
| floating stones (2–4 per room) | in the air of every room | — | **yes**: bob 9 su over 3–6 s and turn a little; real motion, never jitter |

## A.5 Ambient effects and sound

| Effect or sound | Where | Id |
|---|---|---|
| zone music, light version in the pause and the map | in play | `07-audio/music/music.md`, `music.zone1` |
| the cavern's air (loop) | in play, under the music | `sfx.amb.zone1` (`07-audio/sfx/sfx.md`) |
| falling into the abyss | the fall | `sfx.zone1.fall` |
| boss doors sealing and opening | boss room | `sfx.bossDoor.seal`, `sfx.bossDoor.open` |
| the Golem's calm and fight | boss room | `music.golem.calm`, `music.golem.fight` |

## A.6 Enemies and boss

| Enemy | Contract |
|---|---|
| Shield Knight, Rune Sentinel, Wandering Eye, Mace Brute | `03-characters/enemies/zone-1/<name>/contract.md` (step 3.10); they stand in combat rooms (`layout.md` §B.3) |
| **boss:** the Golem | `03-characters/bosses/golem/contract.md` (step 3.11); its room is [`boss-room.md`](boss-room.md) |

The sandbox puts one of the four enemies in its main combat room (*Enemigo* chooses which; the training
dummy stays as a fifth choice) and a floating rock with an eye for the Golem until step 3.11. The game
places several enemies per room (`layout.md` §B.3).

## A.7 Proposals for the operator (Z1–Z4; layout, hazards and the boss room have the rest)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z1 | Camera height in this zone | Akeris at 60 % of the view, to see the abyss under the islands |
| Z2 | Floating stones | 2–4 per room, small, bobbing slowly: the stones that forgot how to fall |
| Z3 | Light | pale shafts from above in the far cavern and over each altar; warm braziers in the rooms; darker the deeper |
| Z4 | The clock relief | the sanctuary's emblem in many rooms: a clock face with one hand, as the story's clock |

## A.8 Never

- Outlined tiles, a ground that reads as a continuous floor, or walls closing the cavern in view.
- Anything that trembles: the stones and platforms move smoothly, the strokes never change.
- A daylight sky or clouds: it is a cavern.
- A floor that ends at a room edge with no wall and no passage, except the planned abyss.

## Acceptance

1. The layers of A.2 appear in order and scroll at their parallax factors; the far tiles repeat with no
   seam.
2. Lower parts of the zone are darker than upper ones.
3. Each prop of A.4 appears where its template places it, drawn as `sheet.png`.
4. Platforms and floating stones move smoothly and nothing else moves except flames.
5. The camera keeps Akeris at 60 % of the view height in this zone.
