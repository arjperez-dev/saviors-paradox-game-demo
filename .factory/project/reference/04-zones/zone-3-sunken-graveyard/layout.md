# Zone 3 — Sunken Graveyard: layout

- **Status:** approved 2026-10-02 (step 3.13)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (the generator is `zoneGen` and `zoneBuild`;
  *Semilla* makes another zone, *Ir a…* jumps to each place) · **Rooms:** [`rooms.png`](rooms.png) ·
  **Four seeds:** [`layout.png`](layout.png) · **The map of one:** [`sandbox/captures/mapa.png`](sandbox/captures/mapa.png)
- **Sources:** `../zone-2-echo-caverns/layout.md` (approved: the generator, its size and its rules, kept
  whole) · `VISION.md` §Core loop, §Mechanics · `01-story/zones-narrative.md` (where the spirits stand) ·
  `05-items/items.md` (altars off the main path)
- **Read by:** the task that builds the zone generator; the tester

---

## B.1 Size and shape

The same as zones 1 and 2 (proposal Z37): about 40 rooms (36–44) on a grid of 22 × 8 cells of
1600 × 1024 su (50 × 32 tiles); rooms of 1 × 1, 2 × 1 or 1 × 2 cells (the boss room 2 × 1); a main path of
13 rooms; about 10 minutes to the boss and 30 to explore it all; zone bounds 35 200 × 8192 su.

## B.2 How it is generated

**Exactly as zones 1 and 2** (`../zone-1-suspended-sanctuary/layout.md` §B.2): the same steps, the same main
path order (corridor, combat, shaft, corridor, corridor, combat, shaft, corridor, combat, antechamber, boss
room, way down), the same branches ending in dead ends, the same checks (≥ 36 rooms, ≥ 9 dead ends), the
same roles (the deepest dead end the lore spirit, the next 8 altars, the rest lookouts). Only the room
catalog (§B.3) and how a room is drawn (§B.4) change. The zone's number enters the seed, so seed 1 of zone 3
is not seed 1 of zones 1 or 2. Ten seeds tried: 1–9 attempts, 39–44 rooms, 9–10 dead ends.
**Step 3.16** (operator 2026-10-13, EP5 and the operator's answer of the same day; *approved 2026-10-13*): the last combat room of the
main path is always an `ossuary` (the guardian's room), the other two combat rooms of the main path are always `yard`s, and the
branches hold **at most one** `ossuary` (once one is placed, a branch's combat room is drawn as a `yard`). The generator shuffles
the templates exactly as before and only keeps the allowed one, so the seed's other choices are untouched; a yard that does not
fit makes the attempt start again (or the branch end), as any room that does not fit. Twenty seeds tried: 37–44 rooms, 1–17
attempts, every check passed, one or two ossuaries per seed.

## B.3 Room kinds — the catalog (`rooms.png`)

Every template may be mirrored. Each is either **yard** (earth, fog, a high rock roof) or **catacomb**
(stone, niches, candles; dark in `rooms.png`). Red arrows in `rooms.png` are its passages; red rings, its
open graves and its tombstones.

| Kind | Templates | Size (cells) | Contents | How many per zone |
|---|---|---|---|---|
| start | `gate` (yard) | 1 × 1 | the stair Akeris came down, the cemetery gate, **the new grave by the gate** (fresh earth, a spade, a wooden cross with the three hollows: the spirit's «there is always a new one»), two lanterns, a fence | 1 |
| corridor | `graves` (yard) · `crypt` (catacomb) · `fosa` (yard) · `terraces` (yard) | 2 × 1, 2 × 1, 2 × 1, 1 × 1 | `graves`: a flat yard with **two open graves** (150 and 140 su) and **four tombstones**, a dead tree, crosses, a fence; `crypt`: a stone gallery under a low vault (400 su clear), candles, two sarcophagi, skulls; `fosa`: the mass grave, two wide stretches with a heap of coffins and skulls in the middle, crossed with **two rings** in the roof (zone 2's `sima`); `terraces`: a hump of terraces (100 and 80 su up and down again) with **one tombstone** on top | 4 on the path; more in branches |
| combat | `yard` (yard) · `ossuary` (catacomb) | 2 × 1, 1 × 1 | `yard`: a wide yard with a raised family plot and **five tombstones** (cover for a shooting enemy), lanterns, a dead tree; `ossuary`: a chapel of bones, the lamp of bones; the foe spot is marked | 3 on the path; more in branches |
| shaft | `belltower` (catacomb) · `mausoleum` (catacomb) | 1 × 2 | `belltower`: the tower of a sunken chapel, two blocks 440 su apart over a clear floor, climbed **from wall to wall** (zone 2's `chimney`), the bell at the top; `mausoleum`: a family's vault, two blocks 760 su apart, each climbed by driving the chain into its foot (zone 2's `falls`), a sarcophagus below | 2 on the path; more in branches |
| dead end | `tomb` (catacomb) · `graveEnd` (yard) · `bonesEnd` (yard) | 1 × 1 | a closed crypt; across an open grave; the bones, pack and fallen lantern of one who came down under a dead tree; a feature spot for the altar, the lore spirit or the lookout (a cross) | 9 or more |
| antechamber | `ante` (catacomb) | 1 × 1 | a funeral chapel: the warning spirit, two candles, a sarcophagus, skulls; the boss door on its far side | 1 |
| boss | `skeletonCrypt` (catacomb) | 2 × 1 | [`boss-room.md`](boss-room.md) | 1 |
| way down | `exit` (yard) | 1 × 1 | a cut stair down into darkness with roots going down it: reaching its foot after the boss leads to zone 4 | 1 |

**Traversal limits** are zone 1's (a running jump ≈ 280 su across and ≈ 250 su up, the high jump ≈ 390 su; a
ring within 470 su of the hand) and zone 2's rule Z28 holds (nothing hangs closer than 470 su over a ledge,
every climbable wall ends at a floor, a wall that rises into a roof is not climbable, rings only where a gap
needs one). The shafts and the mass grave keep the geometry of zone 2's approved `chimney`, `falls` and
`sima`; the open graves are 140–180 su (a jump), the mass grave's stretches need its rings.

## B.4 How a room becomes earth and stone

| Piece | Rule |
|---|---|
| floor | solid from its edge to the room's bottom (the hanging coffins only their thickness); earth in the yard, slabs in the catacombs |
| ceiling | solid from the room's top down to its edge; every room has one; rock in the yard, a vault in the catacombs |
| sides | on each side of each room, rock or masonry **from top to bottom**, 56 su thick, except the opening of each used passage: **from the floor up to the room's own ceiling beside the wall** (at least 300 su). No lintel hangs over a passage: in the yard, where the roof is lost in the fog, a lintel read as a solid hanging pillar that stopped a jump (operator, 2026-10-02). Only the lower floor of the shafts (under the upper slab) and the boss room's low edges stay near 300 |
| open grave | the gap between two floors; the room's bottom under it is a floor no one reaches; sinking into it is the hazard |
| catacomb back wall | fills the room behind everything, hiding the far layers |
| empty cells | earth and rock |

**The joins between rooms** (operator, 2026-10-07: «las conexiones entre escenarios no se ven bien»): a block that hangs over a
passage (a shaft's or a step's) shows its face and closes with a lit underside and an edge, instead of fading to black; in the catacombs, every passage has its jamb (a stone pilaster, the wall's shadow beside it), so the inner wall
ends at an edge, not at a cut.

## B.5 Where things stand

| Thing | Where |
|---|---|
| Akeris at the start | the foot of the start stair |
| enemies | the combat rooms: two in a yard, one or two in an ossuary, by the mix below (step 3.16) |
| altars | dead ends 2–9 by depth, each with its clearing and candles beside it (`05-items/altar/`) |
| lore spirit | the deepest dead end |
| warning spirit | the antechamber, before the boss door |
| the Skeleton | lying on its bier in the middle of the boss room |
| the way down | the foot of the exit stair |

**The mix** (step 3.16, operator 2026-10-13, EP1, EP2, EP5 and EP8; *approved 2026-10-13*): every combat room
holds **only zone 3's own enemies**, chosen by the seed. **In the yard, two per room**: gravedigger 40 %, skeleton archer 35 %,
wraith 25 % (by quota, so each seed stays close); a room with an archer pairs it with a melee enemy (gravedigger or wraith) or
with a second archer, half and half in the long run (seeds 1–5: 4 and 6 rooms); two melee enemies of one kind share a yard only
when nothing else fits. **In the ossuary, always the ossuary many-armed**, and a wraith with it 40 % of the times (by quota).
**The ossuary many-armed always guards the last combat room of the main path**; with the generator of §B.2 it meets Akeris in
that room and in at most one branch, so it stays rare. The second enemy of a room stands on the same floor, 300–1000 su from the
first, at least 300 su from the doors, never on a tombstone nor by an open grave.
Each enemy of the plan keeps to its room (while it thinks and moves, its room's edges are walls to it; a blow that pushes it to
the door leaves it inside). In the sandbox the room's planned enemies appear when Akeris enters the room or a room next to it, and
once beaten they do not come back; the nearest one is «the one in front», the one Akeris's blows reach, and all of them move,
attack and die at the same time (block «Paso 3.16 — la proporción de enemigos», `zMix()`, kept on `ZONE.mix`). The *Enemigo*
button keeps its old list (one enemy picked by hand, from any zone, in the first combat room) only as a test tool; *Mezcla de la
zona* goes back to the plan and *Plan de enemigos* lists it room by room.

| Tier | Enemy | Share | Seeds 1–5 (each seed) | Seeds 1–5 (all) |
|---|---|---|---|---|
| common | gravedigger (yard only) | 40 % of the yard | 3 · 2 · 4 · 5 · 3 | 17 (39 % of the yard) |
| common | skeleton archer (yard only) | 35 % of the yard | 3 · 2 · 4 · 4 · 3 | 16 (36 % of the yard) |
| frequent | wraith (yard; and 40 % of the ossuaries) | 25 % of the yard | 3 · 3 · 3 · 4 · 3 | 16 (11 in the yard: 25 %) |
| rare, the guardian | ossuary many-armed (every ossuary) | one per ossuary | 2 · 2 · 2 · 2 · 2 | 10 (17 % of all) |

Seeds 1–5: 5–8 combat rooms (3–6 yards, 2 ossuaries), 9–15 enemies, never more than 2 in a room; the ossuary many-armed guards
the last room of the main path in all five. The captures of seed 1 that show its map (`layout.png`, `mapa.png`, `osario.png`,
the antechamber, the boss room and the way down…) were exported again from the sandbox.

## B.6 The map

As zones 1 and 2 (`06-ui/map/`): each room is its box from its lowest ceiling to its lowest floor, with its
platforms as lines; rooms with open graves show their dark bottom; the boss door has the padlock. The map
title is the zone's name and number (`zone.sunkenGraveyard.name`).

## B.7 Proposals for the operator (Z37–Z39)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z37 | Size | zones 1 and 2's: 22 × 8 cells, 36–44 rooms, 13 on the main path |
| Z38 | Generator | zone 1's, unchanged; only the catalog changes; closed rooms whose passages reach the room's own ceiling (operator, 2026-10-02; before, 300 su) |
| Z39 | The catalog | the 15 templates of §B.3: 8 yard and 7 catacomb rooms (the shafts, the ossuary, the crypt, the tomb, the antechamber and the boss room are catacombs) |

## Acceptance

1. Same seed, same zone; two seeds, two zones; zone 3's seed 1 differs from zones 1 and 2's.
2. Every zone has 36–44 rooms, a main path of 13 in order, 8 altars and a lore spirit off the path.
3. Every room is reachable from the start, and the boss without any branch.
4. Every gap and height is within the traversal limits.
5. No room opens onto another except through a passage.
