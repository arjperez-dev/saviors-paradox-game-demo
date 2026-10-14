# Zone 2 — Echo Caverns: layout

- **Status:** approved 2026-10-01 (step 3.12)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (the generator is `zoneGen` and `zoneBuild`;
  *Semilla* makes another zone, *Ir a…* jumps to each place) · **Rooms:** [`rooms.png`](rooms.png) ·
  **Four seeds:** [`layout.png`](layout.png) · **The map of one:** [`sandbox/captures/mapa.png`](sandbox/captures/mapa.png)
- **Sources:** `../zone-1-suspended-sanctuary/layout.md` (approved: the generator and its rules, kept
  whole) · `VISION.md` §Core loop, §Mechanics · `01-story/zones-narrative.md` (where the spirits stand) ·
  `05-items/items.md` (altars off the main path)
- **Read by:** the task that builds the zone generator; the tester

---

## B.1 Size and shape

The same as zone 1 (proposal Z20): about 40 rooms (36–44) on a grid of 22 × 8 cells of 1600 × 1024 su
(50 × 32 tiles); rooms of 1 × 1, 2 × 1 or 1 × 2 cells (the boss room 2 × 1); a main path of 13 rooms;
about 10 minutes to the boss and 30 to explore it all; zone bounds 35 200 × 8192 su.

## B.2 How it is generated

**Exactly as zone 1** (`../zone-1-suspended-sanctuary/layout.md` §B.2): the same steps, the same main
path order (corridor, combat, shaft, corridor, corridor, combat, shaft, corridor, combat, antechamber,
boss room, way down), the same branches ending in dead ends, the same checks (≥ 36 rooms, ≥ 9 dead
ends), the same roles (the deepest dead end the lore spirit, the next 8 altars, the rest lookouts). Only
the room catalog (§B.3) and how a room becomes rock (§B.4) change. The zone's number enters the seed, so
seed 1 of zone 2 is not seed 1 of zone 1. Ten seeds tried: 1–15 attempts, 37–44 rooms, 9–11 dead ends.

## B.3 Room kinds — the catalog (`rooms.png`)

Every template may be mirrored. Red arrows in `rooms.png` are its passages; red circles, its cracked
stalactites.

| Kind | Templates | Size (cells) | Contents | How many per zone |
|---|---|---|---|---|
| start | `start` | 1 × 1 | the stair Akeris came down, the roof open above it; two torches, a pool, the pack of one who came before | 1 |
| corridor | `tunnel` · `river` · `sima` · `steps` | 2 × 1, 1 × 1 | `tunnel`: a flat floor under a high dome with **three cracked stalactites**, roosting small bats; `river`: black water 130 su below the banks, crossed on three stones (gaps of 140 su); `sima`: deep black water with a rock in the middle, crossed with **two rings** in the roof, one over each stretch of water; `steps`: a hump of ledges (100 and 80 su up, and down again) under a dome with **one cracked stalactite** | 4 on the path; more in branches |
| combat | `grotto` · `lake` | 2 × 1, 1 × 1 | a wide cave with a raised mound and **two cracked stalactites** (a fight under them brings them down, on the enemies too); a cave split by a small lake (a 180 su gap); the foe spot is marked | 3 on the path; more in branches |
| shaft | `chimney` · `falls` | 1 × 2 | `chimney`: two blocks of rock 440 su apart over a clear floor; Akeris jumps from the floor and drives the chain into the foot of a wall, then climbs **from wall to wall** (G20) or up either wall, and on top each block is the floor of an upper passage; `falls`: a waterfall into a pool of black water with a stone in the middle (gaps of 120 su); he jumps beside a wall, drives the chain into its foot and climbs to the upper passage. No rings, no shelves, nothing in the way along the floor | 2 on the path; more in branches |
| dead end | `nook` · `poolEnd` · `bonesEnd` | 1 × 1 | a cave closed by rock; across a still pool; the bones, pack and burnt torch of one who came down; a feature spot for the altar, the lore spirit or the lookout | 9 or more |
| antechamber | `ante` | 1 × 1 | the warning spirit, two torches, small bats roosting on the roof; the boss door on its far side | 1 |
| boss | `batRoom` | 2 × 1 | [`boss-room.md`](boss-room.md) | 1 |
| way down | `exit` | 1 × 1 | a cut stair down into darkness: reaching its foot after the boss leads to zone 3 | 1 |

**Traversal limits** are zone 1's (a running jump ≈ 280 su across and ≈ 250 su up, the high jump
≈ 390 su; a ring within 470 su of the hand). No template asks more; every floor is a jump or a ledge,
never a 40 su lip Akeris would stop against. Checked in the sandbox with deterministic runs (operator, 2026-10-01): **nothing hangs over a ledge closer than 470 su** (Akeris's height plus a jump), so no ledge above stops the jump to the one below; water gaps are 140–180 su; a wall that climbs to a roof is not climbable (it leads nowhere): every climbable wall ends at a floor (proposal Z28).

## B.4 How a room becomes rock

| Piece | Rule |
|---|---|
| floor | solid from its edge to the room's bottom (shelves and the hanging slabs only their thickness) |
| ceiling | solid from the room's top down to its edge; every room has one |
| sides | on each side of each room, rock **from top to bottom**, 56 su thick, except the opening of each used passage: **300 su above the floor** (the rock above it ends in a lip) |
| black water | the room's bottom under it is a bed no one reaches; falling below its surface is the hazard |
| empty cells | rock |

So no room ever opens onto another except through a passage, and vertical movement happens inside
shafts, as in zone 1.

**The joins between rooms** (operator, 2026-10-07: «las conexiones entre escenarios no se ven bien»): a block that hangs over a
passage (a shaft's or a step's) shows its face and closes with a lit underside and an edge, instead of fading to black.

## B.5 Where things stand

| Thing | Where |
|---|---|
| Akeris at the start | the foot of the start stair |
| enemies | the combat rooms: one or two each, by the mix below (step 3.16) |
| altars | dead ends 2–9 by depth, each with its clearing and a torch beside it (`05-items/altar/`) |
| lore spirit | the deepest dead end |
| warning spirit | the antechamber, before the boss door |
| Giant Bat | asleep on the roof of the boss room, in the middle |
| the way down | the foot of the exit stair |

**The mix** (step 3.16, operator 2026-10-13, EP1, EP2, EP4 and EP8; *approved 2026-10-13*): every combat room
holds **only zone 2's own enemies**, chosen by the seed: **one or two** per room (half and half); **a bat swarm counts as one**.
The kinds are dealt by quota, so each seed stays close to the shares below; the hardest never stands in the first room of the main
path, and two of one kind share a room only when nothing else fits. **The many-armed always guards the last combat room of the main
path** (the one before the antechamber). Each enemy keeps its own placement: the bats roost in the roof over their spot, the
ceiling crawler starts in the roof over its spot. The second enemy of a room stands on the same floor, 300–1000 su from the first
(in the `lake`, on the same island, 300 su), at least 300 su from the doors and never by the water.
Each enemy of the plan keeps to its room (while it thinks and moves, its room's edges are walls to it), except the ceiling
crawler, which by its contract follows Akeris along the roof from room to room. In the sandbox the room's planned enemies appear when Akeris enters the room or a room next to it, and once beaten they do not come back; the nearest one is «the one in front», the one Akeris's blows reach, and all of them move, attack and die at the same time (block «Paso 3.16 — la proporción de enemigos», `zMix()`, kept on `ZONE.mix`). The *Enemigo* button keeps its old list (one enemy picked by hand, from any zone, in the first combat room) only as a test tool; *Mezcla de la zona* goes back to the plan and *Plan de enemigos* lists it room by room.

| Tier | Enemy | Share | Seeds 1–5 (each seed) | Seeds 1–5 (all) |
|---|---|---|---|---|
| common | small bats (a swarm) | 30 % | 5 · 3 · 4 · 3 · 3 | 18 (30 %) |
| common | blind ghoul | 30 % | 5 · 3 · 4 · 3 · 3 | 18 (30 %) |
| frequent | ceiling crawler | 25 % | 4 · 3 · 4 · 2 · 3 | 16 (27 %) |
| rare, the guardian | many-armed | 15 % | 2 · 1 · 2 · 1 · 2 | 8 (13 %) |

Seeds 1–5: 6–9 combat rooms, 9–16 enemies, never more than 2 in a room; the many-armed guards the last room of the main path in
all five, with one more.

## B.6 The map

As zone 1 (`06-ui/map/`): each room is its box from its lowest ceiling to its lowest floor, with its
shelves and stones as lines; rooms with water show their dark bottom; the boss door has the padlock.
The map title is the zone's name and number.

## B.7 Proposals for the operator (Z20–Z23)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z20 | Size | zone 1's: 22 × 8 cells, 36–44 rooms, 13 on the main path |
| Z21 | Generator | zone 1's, unchanged; only the catalog changes |
| Z22 | Closed caves | rock on every side; a passage opening is 300 su tall |
| Z23 | The catalog | the 15 templates of §B.3 |
| Z28 | Walls and ledges (operator, 2026-10-01) | climbing from wall to wall always leads to a new place (the floors on top of the blocks); a wall that rises into a roof cannot be climbed; a wall whose foot is above Akeris can be hooked from the start of a jump (the blade bites its foot); nothing closer than 470 su above a ledge; nothing to trip on along a shaft's floor; rings only where a gap needs one |

## Acceptance

1. Same seed, same zone; two seeds, two zones; zone 2's seed 1 differs from zone 1's.
2. Every zone has 36–44 rooms, a main path of 13 in order, 8 altars and a lore spirit off the path.
3. Every room is reachable from the start, and the boss without any branch.
4. Every gap and height is within the traversal limits.
5. No room opens onto another except through a passage.
