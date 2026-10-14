# Zone 4 — Rotting Canopy: biome

- **Status:** approved 2026-10-03 (step 3.14)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Sheet:** [`sheet.png`](sheet.png) ·
  **Captures:** [`sandbox/captures/`](sandbox/captures/)
- **Sources:** `VISION.md` §Scope (Rotting Canopy, underground jungle; roots, poison pools, spores, vines to
  swing over poison, torches that burn webs), §Bosses (Giant Spider: floor webs slow and are burned by the fire
  shield), §Mechanics (status effects: slow, poison) · `01-story/zones-narrative.md` (zone 4: the roots of the
  world above, grown down into the dark and rotting as the days run out; someone waits at the bottom, holding
  the clock, counting) · `01-story/dialogue/zone-4.md` («Mind the pods. Mind the pools», «Keep away from the white
  threads», «Fire does not care for webs») · `07-audio/music/music.md` (`music.zone4`, approved) · zone 3
  (`../zone-3-sunken-graveyard/`), whose sandbox, generator, size and rules it keeps · the operator's answers to
  the proposal (2026-10-03)
- **Read by:** the tasks that draw and play zone 4; with [`layout.md`](layout.md),
  [`hazards.md`](hazards.md) and [`boss-room.md`](boss-room.md)

---

## A.1 Identity

The roots of the world above have grown down into the dark: an underground jungle with no sky, all root, moss,
fungus and rot. Three kinds of place:

- **the canopy** (*dosel*): galleries where Akeris walks on roots as thick as trunks, with moss and vines;
- **the rot** (*podredumbre*): the bottom, mud floors with poison pools, fallen trunks and mushrooms;
- **the hollow root**: inside a giant root, wood with its grain all round; darker.

The player must understand at once three things: **the pools poison**, **the vines carry you over them**, and
**the white threads hold you, and fire burns them**.

**The zone's hint** is the spirits' (operator, 2026-10-03): the lore spirit says it in words («He does not sleep.
He counts»). Nothing in the scenery repeats it: no tally marks (the operator removed them, «no aportan nada»), no
purple glint.

## A.2 Layers, back to front

| Layer | Contents | Parallax | Palette and hatching |
|---|---|---|---|
| far wall | curtains of roots coming down in six bands, each deeper and darker, with bands of mist between them (a touch of the poison accent); silhouettes of giant mushrooms and fallen trunks at the foot | 0.22 (tile 3000 × 2900 su, repeats sideways) | `far` `#3d3832`; roots in near-black at 38–78 %; mist in `paperLight` 7 % and `poison` glow 6 % |
| middle | twisted root trunks crossing top to bottom with branches, ferns and big mushrooms | 0.5 (tile 3000 × 2250 su, repeats both ways) | near-black at 80 % |
| hollow-root wall | only in hollow-root rooms: dark wood with grain going up, knots with their rings | 1 (it hides the far layers) | wood darkened to 58 % |
| play layer | root floors with bark and moss, mud floors with rotten leaves, ceilings of tangled roots with hanging moss, pools, vines, webs, torches, ferns, mushrooms, logs, stumps, egg sacs and white threads; live: the vines, the pools, the webs and curtains, the torches, the rotten roots | 1 | §A.3 |
| foreground | near-black roots and leaves hanging from the top of the view, passing faster | 1.3 | `ink` at 90 % |
| **poison and spores** | over the play layer and Akeris: the poison of the pools (up to his knees) and the spores (§A.4) | 1 | `poison`, `paperLight` |
| **darkness** | the whole view darkened, with holes of light (§A.4) | screen | `rgba(9,7,6,a)`: a = 0.62 in the canopy and the rot, 0.75 in the hollow root |
| paper overlay | grain, stains and edge vignette (unchanged) | screen | `palette.md` §1 |

**Camera:** Akeris at **60 %** of the view height, as in zones 1–3. It follows, snaps to the pixel and never
shakes.

## A.3 Roots, mud and wood

Units are `su`; **32 su = 1 tile**. Never drawn as outlined tiles. Bark `#5e5243` (lit `#6e5f4d`, dark
`#3f372e`), mud `#4f473c` (lit `#5f564a`), rotten wood `#857a66`, pale fungus `#c9bea7`, bone `#ddd6c6`; and the
**poison accent** (proposal Z40, the only new colour, `palette.md` §6): liquid `#7a8638`, deep `#4d5527`, drips
`#a6b04c`, glow `rgba(150,170,60,.55)`.

| Kind | Where | How it is drawn | Collision |
|---|---|---|---|
| root floor | canopy and hollow-root rooms | the top edge is the floor: a thick stroke, almost straight (bumps ≤ 2.5 su), moss curls on it; the top 74 su are a giant root lying down (bark grain and short cracks); below, a tangle of fine roots and earth, darkening to near black 320 su down | solid from the edge to the room's bottom |
| mud floor | rot rooms | the edge with rotten leaves and moss; mud in layers with roots and, here and there, a bone or a skull at 50 % | solid |
| bough | `boughs` | a root crossing the air, 60 su thick: bark, cut ends with rings, moss on top and hanging below, bracket fungus | solid, 60 su thick |
| **rotten root** | `boughs` | the same, paler, with holes, cracks and fungus | solid until it breaks (`hazards.md`) |
| hanging root | the boss room | a bough hanging from two vines | solid, 40 su thick |
| ceiling | every room | a tangle of roots with thick ones coming down a little and moss hanging in beards (canopy, rot); wood with grain (hollow root) | solid |
| walls | room sides, what closes a dead end | earth with roots going down; wood in the hollow root; over a passage, a lip of roots | solid |
| **poison pool** | `hazards.md` | a gap in the floor with a mud bottom 64 su below the edge and mud banks; the poison over it is drawn live, in front of Akeris | the bottom is solid: Akeris wades |

## A.4 Props, light, spores and life

| Prop | Where | Light | Moves? |
|---|---|---|---|
| **torch of those who came down**: a stake planted in the floor, its head wrapped in rag, 170 su high | 1–4 per room by template (`tc`) | a hole in the darkness of **400 su** | the flame sways; a blow or the chain knocks it over (`hazards.md`) |
| fallen torch, out | `rootEnd` | — | no |
| **mushrooms**: a cluster of three pale caps with gills | everywhere | — | no |
| **fern**: fronds of light leaflets with ink outlines | canopy and rot | — | no |
| **fallen log**: rotten, with holes, moss, bracket fungus and a small mushroom | rot rooms, `webs` | — | no |
| **stump**: a cut root with its rings, plain | a few rooms; every lookout dead end | — | no |
| **egg sacs**: pale sacs hanging from threads; each room's whole sacs are a spiderlings' nest (step 3.14) | `nest` (two clusters), `pools`, `hollow`, `webs`, `clearing`, `rootEnd`, `webEnd`; already torn in `ante` | — | they tear when the nest wakes |
| **white threads** hanging from the ceiling | `webs`, `nest`, `ante` | — | no |
| roots coming down from a hole in the roof, with the last step of the stair from zone 3 | start | — | no |
| a curtain of thin roots at the back of the shaft | `cascade` | — | no |
| the web lattice under the roof | the boss room | — | no |
| the masonry wall with a broken merlon and its stair down | the way down (zone 5 is below) | — | no |
| the bones and pack of one who came down | `rootEnd` | — | no |

**Light** (proposal Z41): the view is dark at **62 % in the canopy and the rot** and **75 % in the hollow
root**; crossing a passage, the darkness changes slowly (about 0.4 s). Light comes from the torches (400 su), the
altar candles (360 su), **Akeris's eye** (300 su at 85 %), fire (220 su; a web burning too) and, faintly, **the
pools** (a 180 su hole at 50 % every 200 su along them, and a faint glow of the poison accent over them: in the
dark one knows where they are). Nothing flickers: the light is fixed, only the flames sway.

**The spores** (proposal Z42), the zone's identity, as the fog was zone 3's: pale motes (2–4.4 su, 35–75 %)
drifting slowly through every room (26 per cell), sideways and upward; over a pool, more of them, in the poison
accent, rising and fading. **Only atmosphere: they do no harm.** The toxic cloud belongs to the **Spore Pod**,
which is an enemy (its step). They move, they never tremble; in the boss room they stop during the fight.

## A.5 Ambient effects and sound

| Effect or sound | Where | Id |
|---|---|---|
| zone music, light version in the pause and the map | in play | `07-audio/music/music.md`, `music.zone4` (approved) |
| the canopy's air (loop) | in play, under the music | `sfx.amb.zone4` (`07-audio/sfx/sfx.md`) |
| wading into a pool / the poison bites | the hazard | `sfx.zone4.wade`, `sfx.zone4.poison` |
| grabbing a vine | the vine | `sfx.zone4.vineGrab` |
| a rotten root creaks / snaps | the hazard | `sfx.zone4.rootCreak`, `sfx.zone4.rootSnap` |
| stepping into a web / a web burning | the hazard | `sfx.zone4.webStick`, `sfx.zone4.webBurn` |
| a torch falls | the hazard | `sfx.zone4.torchFall` |
| boss doors | boss room | `sfx.bossDoor.seal`, `sfx.bossDoor.open` |
| the Giant Spider's calm and fight | boss room | `music.giantSpider.calm`, `music.giantSpider.fight` (approved) |

**The sound of the place** (proposal Z49): nothing; the jungle muffles. No echo (zone 2), no reverberation
(zone 3), no noise mechanic; noise is still what the enemies that listen will hear (their contracts). The
spirits of zone 4 speak at 0.90 (warning) and 1.09 (lore) (`07-audio/voice/voice.md`).

## A.6 Enemies and boss

| Enemy | Contract |
|---|---|
| Spiderlings | `03-characters/enemies/zone-4/spiderlings/contract.md` (step 3.14; approved 2026-10-05): a nest in every room with egg sacs (operator, 2026-10-05, after playing it) |
| Spore Pod | `03-characters/enemies/zone-4/spore-pod/contract.md` (step 3.14; approved 2026-10-05): on the floor of the rot rooms (`pools`, `boughs`, `clearing`, `poolEnd`) |
| Strangler Vine | `03-characters/enemies/zone-4/strangler-vine/contract.md` (step 3.14; approved 2026-10-05): on the floor of every room but the start, the antechamber, the boss room and the way down |
| Mantis | `03-characters/enemies/zone-4/mantis/contract.md` (step 3.14; approved 2026-10-06): on clear floor of several rooms (`clearing`, `nest`, `hollow`, `rootEnd`; operator: «en varias salas del mapa») |
| **boss:** the Giant Spider | `03-characters/bosses/giant-spider/contract.md` (step 3.14; approved 2026-10-06); its room is [`boss-room.md`](boss-room.md) |

The spiderlings are not a room enemy: they live in their nests, whatever the room's enemy. The sandbox's default enemy is
none; until the others are made, the dummy and the enemies of zones 1–3 stay selectable as stand-ins (*Enemigo*); the boss room has the Giant Spider (approved 2026-10-06; until then a stand-in). Since 2026-10-06 the torches can be carried in the hand (`hazards.md` Z49).

## A.7 Proposals for the operator (Z40–Z42, Z49; layout, hazards and the boss room have the rest)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z40 | Colours | bark, mud and wood of the palette; **one new accent, the poison** (bile yellow-green, `palette.md` §6; operator, 2026-10-03: «me gusta el amarillo verdoso») |
| Z41 | Darkness | 62 % in the canopy and the rot, 75 % in the hollow root; torches 400 su, Akeris's eye 300 su, the pools glow faintly; never flickering |
| Z42 | Spores | pale motes drifting and rising over the pools; atmosphere only (the cloud is the Spore Pod's) |
| Z49 | Sound of the place | none: the jungle muffles; the ambience does the work |

## A.8 Never

- Outlined tiles, or a floor edge drawn so rough it hides where the feet go.
- A pool that cannot be seen: its poison always glows faintly, even in the dark.
- Spores that hurt, or that hide where the floor or a pool is.
- Anything that trembles: the spores, vines, flames, poison and falling roots move; strokes and light never change.
- Daylight or sky: the roof is roots.
- A flickering light.
- A colour not in `palette.md`.

## Acceptance

1. The layers of A.2 appear in order at their parallax; the far tiles repeat with no seam; hollow-root rooms hide the far layers behind their wood.
2. The darkness is 62 % in canopy and rot rooms and 75 % in hollow-root rooms; each light opens its hole; the pools glow faintly.
3. The spores drift through every room and rise over the pools; none of them hurts.
4. World sounds have no echo and no reverberation.
5. The camera keeps Akeris at 60 % of the view height.
