# Zone 3 — Sunken Graveyard: biome

- **Status:** approved 2026-10-02 (step 3.13)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Sheet:** [`sheet.png`](sheet.png) ·
  **Captures:** [`sandbox/captures/`](sandbox/captures/)
- **Sources:** `VISION.md` §Scope (Sunken Graveyard, cemetery and catacombs; fog, open graves, breakable
  tombstones as cover), §Bosses (Skeleton: «dodge … behind tombstones, which break») ·
  `01-story/zones-narrative.md` (zone 3: the graves of everyone who came down; the gravedigger digs them
  before they are needed; every stone bears three hollows in a row) · `01-story/dialogue/zone-3.md` («Mind
  the open graves», «There is a new grave by the gate») · `00-game/glossary.md` (cemetery and catacombs, fog,
  open graves) · `02-art-direction/ART_DIRECTION.md`, `dungeon/dungeon.md` (the drawing method) · zone 2
  (`../zone-2-echo-caverns/`), whose sandbox, generator, size and rules it keeps · the operator's approval
  of the proposal (2026-10-02)
- **Read by:** the tasks that draw and play zone 3; with [`layout.md`](layout.md),
  [`hazards.md`](hazards.md) and [`boss-room.md`](boss-room.md)

---

## A.1 Identity

The graveyard of everyone who came down for the clock, swallowed by the dungeon: tombstones tilted and
half buried, crosses leaning, iron fences bent. Two kinds of place:

- **the yard** (*camposanto*): high caverns of earth whose rock roof is lost in fog;
- **the catacombs**: stone galleries with rows of niches full of skulls, candles, and an ossuary.

The player must understand at once three things: **there is fog** and the eye does not reach far; **the
open graves swallow**; **the tombstones are cover**, and they break. Every tombstone bears the same mark
and no name: **three hollows in a row**, like the guard of Akeris's sword.

## A.2 Layers, back to front

| Layer | Contents | Parallax | Palette and hatching |
|---|---|---|---|
| far wall | the graveyard sinking in terraces into the deep: on each terrace a row of silhouettes (tombstones, crosses, mausoleums, dead trees) with a band of fog at its foot; dark top and bottom | 0.22 (tile 3000 × 2900 su, repeats sideways) | `far` `#433e37`; silhouettes in near-black at 55–75 %; fog in `paperLight` at 4–13 % |
| middle | big crosses, dead trees and mausoleums on their own small mound | 0.5 (tile 3000 × 2250 su, repeats both ways) | near-black at 78 % |
| catacomb back wall | only in catacomb rooms: dark masonry with four rows of arched niches over each floor (a skull, bones, or a shroud in each), pilasters every 800 su; in the ossuary, bands of stacked skulls and long bones | 1 (it hides the far layers) | masonry darkened to 62 % |
| play layer | earth floors with dry grass, stone floors, rock roofs with hanging roots, stone vaults, open graves, tombstones, crosses, fences, dead trees, lanterns, candles; live: the fog, the flames, the bell, tombstones cracking and breaking, the hands of a grave | 1 | §A.3 |
| foreground | near-black roots hanging from the top of the view, passing faster | 1.3 | `ink` at 90 % |
| **fog** | over the play layer and Akeris: the low band, the fog in the graves, the drifting banks (§A.4) | 1 | `paperLight` |
| **darkness** | the whole view darkened, with holes of light (§A.4) | screen | `rgba(9,7,6,a)`: a = 0.55 in the yard, 0.78 in the catacombs |
| paper overlay | grain, stains and edge vignette (unchanged) | screen | `palette.md` §1 |

**Camera:** Akeris at **60 %** of the view height, as in zones 1 and 2. It follows, snaps to the pixel and
never shakes.

## A.3 Earth, stone and tiles

Units are `su`; **32 su = 1 tile**. Never drawn as outlined tiles. No new hue (proposal Z29): earth
`#6c6253` (lit `#80766a`, dark `#4a433a`), the dungeon's stone for tombstones and masonry (`#a8a091`,
lit `#bbb3a3`, dark `#867e70`), rock `#77705f`, wood `#5e5243`, iron `#3a3631`; bone `#ddd6c6`.

| Kind | Where | How it is drawn | Collision |
|---|---|---|---|
| earth floor | yard rooms | the top edge is the floor: a thick stroke, almost straight (bumps ≤ 2.5 su), tufts of dry grass and pebbles on it; below, soil in layers with fine roots going down and, here and there, something buried (a bone, a skull, a coffin plank) at 55 %; darkening to near black 320 su down | solid from the edge to the room's bottom |
| stone floor | catacomb rooms | masonry slabs, a thick top edge, rubble and bone bits on it, darkening to near black 420 su down | solid |
| raised plot | `yard` | an earth mound with a stone curb and two low pillars | solid |
| rock roof | yard rooms | rock from the room's top down to its lower edge, roots hanging from it (30–140 su), a pale haze of fog under it: **the roof lost in the fog** | solid |
| stone vault | catacomb rooms | masonry with its lower edge, cobwebs | solid |
| walls | room sides, the rock that closes a dead end | rock in the yard, masonry in the catacombs; over a passage, a lip (roots hanging in the yard) | solid |
| open grave | `hazards.md` | a gap in the floor: earth walls cut with a spade, roots, the inside black, fog spilling over the edge; beside it (narrow graves) the heap of dug earth with the spade stuck in it; in the wide mass grave, bones in the dark | not solid: falling in is the hazard |
| heap | `fosa` | a mound of broken coffins, earth and skulls in the middle of the mass grave; its top is walked on | solid |
| hanging coffin | the boss room | a stone coffin on two chains, the three hollows on its side; its lid is walked on | solid, 40 su thick |
| tombstone | `hazards.md` | 58 × 150 su, rounded top, on a plinth; the three hollows near the top and two lines below; slightly tilted (fixed per stone); cracks as it is hit; a jagged stump and rubble when broken | **not solid**: walked through; it stops projectiles |

## A.4 Props, light, fog and life

| Prop | Where | Light | Moves? |
|---|---|---|---|
| **lantern of the mourners**: an iron post with a caged lantern | yard rooms, 1–3 by template | a hole in the darkness of **360 su** | the small flame sways |
| fallen lantern | `bonesEnd` | — | no |
| **candles**: three melted candles on a stone | catacombs; one beside every altar | 360 su | the flames sway |
| **candelabrum**: an iron stand with three candles | the boss room | **420 su** | the flames sway |
| **the ossuary's lamp**: a ring of bones with four candles, on a chain | `ossuary` | 360 su | the flames sway |
| wooden cross, leaning; old tombstone sunk to its top; bent iron fence; dead tree | yard rooms | — | no |
| the cemetery gate (two stone pillars, an iron arch, the gate half open) and **the new grave by the gate** (fresh earth, a spade, a wooden cross with the three hollows) | start | — | no |
| sarcophagus, pile of skulls, the bones and pack of one who came down | catacombs, dead ends | — | no |
| **the bell** of the sunken chapel, hanging from its yoke | `belltower`, at the top | — | **yes**: the chain makes it toll and swing (`sfx.zone3.bell`), only for show |
| roots going down the stair | the way down (zone 4 is below) | — | no |
| the skeleton's bier | the boss room | — | no |

**Light** (proposal Z30): the view is dark at **55 % in the yard** and **78 % in the catacombs**; crossing a
passage, the darkness changes slowly (about 0.4 s). Light comes from lanterns and candles (360 su), the
candelabra (420 su), **Akeris's eye** (300 su at 85 %), fire (220 su) and, faintly, the fury. Nothing flickers:
the light is fixed, only the flames sway.

**The fog** (proposal Z31), the zone's identity; it moves, it never trembles:

- **the low band**: over every yard floor, about 120 su high, two layers drifting in opposite directions
  (16 and 9 su/s), soft at its ends and at its top; it covers Akeris's feet without hiding where the floor is;
- **into the graves**: soft puffs that pour over the edge and sink inside (which also tells where a grave is);
- **the banks**: one per cell of each yard room (not in the boss room), a cloud about 1000 × 460 su at 55 %
  that drifts slowly back and forth across its room (about 70 s a round); inside it Akeris and his enemies
  are seen faintly. It is drawn over Akeris and under the darkness, so it glows near the lights.

## A.5 Ambient effects and sound

| Effect or sound | Where | Id |
|---|---|---|
| zone music, light version in the pause and the map | in play | `07-audio/music/music.md`, `music.zone3` (approved) |
| the graveyard's air (loop) | in play, under the music | `sfx.amb.zone3` (`07-audio/sfx/sfx.md`) |
| falling into an open grave | the fall | `sfx.zone3.graveGrab` |
| a tombstone cracks / breaks | the hazard | `sfx.zone3.stoneCrack`, `sfx.zone3.stoneBreak` |
| the bell tolls | the chain hits it | `sfx.zone3.bell` |
| boss doors | boss room | `sfx.bossDoor.seal`, `sfx.bossDoor.open` |
| the Skeleton's calm and fight | boss room | `music.skeleton.calm`, `music.skeleton.fight` (approved) |

**The catacombs' stone** (proposal Z32): in catacomb rooms every world sound also goes through a short
stone reverberation (two delays of 55 and 83 ms, feedback 0.42, low-pass 2.4 kHz, wet 0.3; a tail of about
0.2 s); the interface, the ambience and the voices do not (`sfx.md` §3). In the yard, nothing: the fog eats
the sound. There is **no echo ring and no noise mechanic** in this zone; noise is still what the enemies that
listen will hear (their contracts).

## A.6 Enemies and boss

| Enemy | Contract |
|---|---|
| Skeleton Archer | [`03-characters/enemies/zone-3/skeleton-archer/contract.md`](../../03-characters/enemies/zone-3/skeleton-archer/contract.md) (step 3.13); in the combat rooms (in «Enemigo») |
| Gravedigger | [`03-characters/enemies/zone-3/gravedigger/contract.md`](../../03-characters/enemies/zone-3/gravedigger/contract.md) (step 3.13); only in the yard's combat rooms (he digs; the catacombs are stone) (in «Enemigo») |
| Wraith | [`03-characters/enemies/zone-3/wraith/contract.md`](../../03-characters/enemies/zone-3/wraith/contract.md) (step 3.13); both combat rooms; it hides in walls, tombstones or the floor (in «Enemigo») |
| Ossuary Many-Armed | [`03-characters/enemies/zone-3/ossuary-many-armed/contract.md`](../../03-characters/enemies/zone-3/ossuary-many-armed/contract.md) (step 3.13); only in the ossuary rooms, where it rebuilds its arms from the heaps of skulls; the sandbox's default enemy (*Ir a… osario*) |
| **boss:** the Skeleton | `03-characters/bosses/skeleton/contract.md` (step 3.13, last piece); its room is [`boss-room.md`](boss-room.md) |

The sandbox puts the skeleton archer in the combat room; until the others are made, the zone 1 and 2 enemies stay
selectable as stand-ins (*Enemigo*), and the boss room has a stand-in Skeleton lying on its bier.

## A.7 Proposals for the operator (Z29–Z32; layout, hazards and the boss room have the rest)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z29 | Colours | earth and stone of the palette; bone, wood and iron; no new hue |
| Z30 | Darkness | 55 % in the yard, 78 % in the catacombs; lanterns and candles 360 su, candelabra 420 su, Akeris's eye 300 su; never flickering |
| Z31 | Fog | a low band over the yard floors, fog pouring into the graves, drifting banks over Akeris; it moves, never trembles |
| Z32 | Sound of the place | a short stone reverberation in the catacombs only; no echo and no noise mechanic |

## A.8 Never

- Outlined tiles, or a floor edge drawn so rough it hides where the feet go.
- Fog that hides where the floor or a grave is.
- Anything that trembles: the fog, the flames and the bell move; strokes and light never change.
- Daylight or sky: the roof is rock, lost in fog.
- A flickering light.
- A colour not in `palette.md`.
- A name on a tombstone: only the three hollows.

## Acceptance

1. The layers of A.2 appear in order at their parallax; the far tiles repeat with no seam; catacomb rooms hide the far layers behind their niche wall.
2. The darkness is 55 % in yard rooms and 78 % in catacomb rooms; each light opens its hole.
3. The low fog drifts over every yard floor, pours into the graves and the banks cross their rooms; none of it hides a floor edge.
4. In the catacombs world sounds have the short stone reverberation; in the yard they do not.
5. The chain makes the bell toll and swing.
6. The camera keeps Akeris at 60 % of the view height.
