# Zone 2 — Echo Caverns: biome

- **Status:** approved 2026-10-01 (step 3.12)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Sheet:** [`sheet.png`](sheet.png) ·
  **Captures:** [`sandbox/captures/`](sandbox/captures/)
- **Sources:** `VISION.md` §Scope (Echo Caverns, caves), §Bosses (Giant Bat: «only its eyes show in the
  dark», stalactites) · `01-story/zones-narrative.md` (zone 2: caves that keep every sound) ·
  `01-story/dialogue/zone-2.md` («Walk, do not run. Some things down here hunt by the noise») ·
  `02-art-direction/ART_DIRECTION.md`, `dungeon/dungeon.md` (the drawing method) · the operator's request
  of 2026-10-01 (caves, dripping water, darkness lit by torches) · zone 1 (`../zone-1-suspended-sanctuary/`),
  whose generator, size and rules it keeps
- **Read by:** the tasks that draw and play zone 2; with [`layout.md`](layout.md),
  [`hazards.md`](hazards.md) and [`boss-room.md`](boss-room.md)

---

## A.1 Identity

Closed caves under the sanctuary, where Akeris's people went down one by one and none came up. The caves
keep every sound ever made in them. The player must understand at once three things: **it is dark**, and
what is seen is what a torch or Akeris's own eye lights; **noise matters** (running, landing and striking
are heard, walking is not); and **water is death's colour here**: black, still, deep.

Unlike zone 1, there is no open void: rock above, rock below, rock at the sides. The danger is in what
hangs from the roof and in the black water between the floors.

## A.2 Layers, back to front

| Layer | Contents | Parallax | Palette and hatching |
|---|---|---|---|
| far cave wall | rock in wavy strata, 12 rock columns (stalactite and stalagmite grown together, narrowing and widening), pale streaks where water ran, a fringe of stalactites at the top and stalagmites at the bottom, dark top and bottom | 0.22 (tile 3000 × 2900 su, repeats sideways) | `far` rock `#5d564b`; streaks in `paperLight` at 7 % |
| middle columns | 7 darker rock columns, top to bottom | 0.5 (tile 3000 × 2250 su, repeats both ways) | 0.6 of the full ink |
| play layer | floors, shelves, ceilings with stalactites, rock walls, black water, torches, stalagmites, pools, bones, remains; live: drops, ripples, the waterfall, cracked stalactites, flames | 1 | §A.3 |
| foreground | near-black stalactites hanging from the top of the view, passing faster | 1.3 | `ink` at 92 % |
| **darkness** | the whole view darkened, with holes of light (§A.4) | screen | `rgba(9,7,6,.84)` |
| paper overlay | grain, stains and edge vignette (unchanged) | screen | `palette.md` §1 |

**Camera:** Akeris at **60 %** of the view height, as in zone 1, so the roof above and the water below
are both seen (proposal Z14). It follows, snaps to the pixel and never shakes.

## A.3 Rock, water and tiles

Units are `su`; **32 su = 1 tile**. Never drawn as outlined tiles. The colours are the dungeon's stone
tones darkened (`rock #8b8273`, `rockLit #9d9483`, `rockDark #6c6458`, `ceil #7a7265`); water is ink, its
light is `paperLight` (proposal Z15: no new hue).

| Kind | How it is drawn | Collision |
|---|---|---|
| floor | the top edge is the floor: a thick stroke, almost straight (bumps ≤ 2.5 su, so the edge never lies), wet glints along it, pebbles; below, wavy strata closer together with depth, hatching, darkening to near black 320 su down | solid from the edge to the room's bottom |
| shelf | a lip of rock coming out of a wall (shafts), its underside tapering in lobes with small stalactites | solid, 60–140 su thick |
| ceiling | rock from the room's top down to its lower edge (thick stroke, bumps ≤ 4 su), darker upward; stalactites hang from it every 50–170 su, up to 22 % of the clear height below (≤ 150 su), a third of them larger; half carry a forming drop | solid; **stalactites are not** |
| rock wall | the room's sides, rock fins in shafts, the rock that closes a dead end; where a passage opens, the rock above it ends in a ragged lip with two small stalactites | solid |
| black water | still: a dark gradient (ink 78 → 97 %), cross-hatching, a surface stroke and a few fixed glints of torchlight | not solid: falling in is the hazard (`hazards.md`) |
| pool | a shallow dark lens on a floor with one glint | decoration |
| rock outside the rooms | dark rock with strata | — |

## A.4 Props, light and life

| Prop | Where | Light | Moves? |
|---|---|---|---|
| **torch of those who came down**: a stick with sooted rags in an iron ring nailed to the rock, soot above | 1–4 per room by template; one beside every altar | warm flame and halo (`dungeon.md`), and a hole in the darkness of **470 su** | the flame sways slowly |
| burnt-out torch on the floor | a dead end (`bonesEnd`) | — | no |
| stalagmite | rooms, by template; lookouts | — | no |
| bones of one who came down; their pack and rolled blanket | river crossings, dead ends | — | no |
| small bats hanging, wings closed (decoration only; the enemy comes in its step) | tunnel, grotto, antechamber | — | no |
| iron ring nailed into the roof, on its chain | `sima`, one over each stretch of water | — | no |
| entrance stair (cut, masonry) / stair down into darkness | start / exit | — | no |
| altar's clearing: the rock around an altar a little lighter | over every altar | — | no |
| **drops**: from some stalactites, one every 1.6–4.2 s (fixed per drop), falling to the floor or the water | 1 per 700 su of ceiling | — | **yes**: fall and leave a ripple |
| **waterfall** down a shaft (`falls`) | behind the shelves | — | **yes**: streaks run down, rings spread at its foot |

**Light** (proposal Z16): the view is dark at 84 %. Light comes from **torches** (470 su), from
**Akeris himself** — the red light in his eye that the story speaks of — 300 su around his head at 85 %,
from **fire** (fireballs, 220 su) and, faintly, from the **fury** (`05-items/scrolls/`). Torches never
flicker: the light is fixed, only the flame sways.

**The echo** (proposal Z17, revised by the operator 2026-10-01): a noise (§A.5) sends a ring that opens from
where it was made (about 1.3 s, up to twice its reach) and lightens the darkness as it passes, so the cave is
seen for an instant; a faint pencil ring goes with it. **The ring only appears near a cracked stalactite that
still hangs, or under a swarm of small bats still asleep** (the noise that wakes them; operator, 2026-10-01), where noise is dangerous; once the bats wake, no more rings for them; the blind ghoul's clicks open their own ring (its contract); elsewhere noise makes no ring (it still sounds, with
its echo). Walking makes no ring. It is real motion, never a tremble.

## A.5 Ambient effects, sound and noise

| Effect or sound | Where | Id |
|---|---|---|
| zone music, light version in the pause and the map | in play | `07-audio/music/music.md`, `music.zone2` (approved) |
| the caves' air (loop) | in play, under the music | `sfx.amb.zone2` (`07-audio/sfx/sfx.md`) |
| a drop landing near Akeris | within 700 su, one in two | `sfx.zone2.drip` |
| falling into black water | the fall | `sfx.zone2.splash` |
| a cracked stalactite cracks / falls | the hazard | `sfx.zone2.stalCrack`, `sfx.zone2.stalFall` |
| boss doors | boss room | `sfx.bossDoor.seal`, `sfx.bossDoor.open` |
| the Giant Bat's calm and fight | boss room | `music.giantBat.calm`, `music.giantBat.fight` (approved) |

**The echo of every sound** (proposal Z18): in this zone every world sound also goes through one echo
(0.32 s, three returns, darker each time); the interface, the ambience and the voices do not
(`sfx.md` §3).

**Noise** (proposal Z19): the zone listens. These events are a noise with a reach; they make the echo
ring, crack the stalactites under them (`hazards.md`) and are what the zone's enemies that hunt by sound
will hear (the Blind Ghoul, in its step):

| Noise | Reach (su) |
|---|---|
| a running step (faster than 330 su/s) | 300 |
| landing | 360 |
| a roll | 240 |
| a strike that lands (blade) | 380 |
| a clang, any shield block, the hammer's slam | 500 |
| a stalactite breaking, a splash | 500 |
| walking, standing, climbing, swinging | none |

## A.6 Enemies and boss

| Enemy | Contract |
|---|---|
| Small Bats, Blind Ghoul, Ceiling Crawler, Many-Armed | `03-characters/enemies/zone-2/<name>/contract.md` (step 3.12, next pieces); they stand in combat rooms (`layout.md` §B.3) |
| **boss:** the Giant Bat | `03-characters/bosses/giant-bat/contract.md` (step 3.12, last piece); its room is [`boss-room.md`](boss-room.md) |

Until they are made, the sandbox puts the training dummy in the combat room, and the zone 1 enemies stay
selectable as stand-ins (*Enemigo*); the boss room has a stand-in Giant Bat asleep on the roof (only its
eyes show in the dark).

## A.7 Proposals for the operator (Z14–Z19; layout, hazards and the boss room have the rest)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z14 | Camera height | Akeris at 60 % of the view, as in zone 1 |
| Z15 | Colours | the dungeon's stone darkened; water in ink with `paperLight` glints; no new hue |
| Z16 | Darkness | the view at 84 % dark; light from torches (470 su), Akeris's eye (300 su), fire (220 su) and the fury; never flickering |
| Z17 | The echo ring | each noise opens a ring that lightens the dark for ≈ 1.3 s, **only within 900 su of a hanging cracked stalactite** (operator, 2026-10-01) |
| Z18 | The echo on sounds | every world sound echoes (0.32 s, three returns) |
| Z19 | Noise | the table of §A.5: running, landing, striking and clashing are heard; walking is not |

## A.8 Never

- Outlined tiles, or a floor edge drawn so rough it hides where the feet go.
- Anything that trembles: drops, ripples and the waterfall move; strokes and light never change.
- Daylight, sky, or a void below like zone 1's: here it is rock and black water.
- A flickering torch or a light that pulses.
- A colour not in `palette.md` (water is ink, not blue).

## Acceptance

1. The layers of A.2 appear in order at their parallax; the far tiles repeat with no seam.
2. Away from torches and from Akeris the view is dark; each torch lights 470 su and Akeris 300 su.
3. Running, landing, striking or blocking near a hanging cracked stalactite makes an echo ring; walking does not; far from them no ring.
4. Drops fall from their stalactites at their fixed rhythm and leave a ripple; the waterfall runs down.
5. Every world sound echoes; interface sounds do not.
6. The camera keeps Akeris at 60 % of the view height.
