# Zone 4 — Rotting Canopy: layout

- **Status:** approved 2026-10-03 (step 3.14)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (the generator is `zoneGen` and `zoneBuild`;
  *Semilla* makes another zone, *Ir a…* jumps to each place) · **Rooms:** [`rooms.png`](rooms.png) ·
  **Four seeds:** [`layout.png`](layout.png) · **The map of one:** [`sandbox/captures/mapa.png`](sandbox/captures/mapa.png)
- **Sources:** `../zone-3-sunken-graveyard/layout.md` (approved: the generator, its size and its rules, kept
  whole) · `VISION.md` §Core loop, §Mechanics · `01-story/zones-narrative.md` (where the spirits stand) ·
  `05-items/items.md` (altars off the main path) · [`hazards.md`](hazards.md)
- **Read by:** the task that builds the zone generator; the tester

---

## B.1 Size and shape

The same as zones 1–3 (proposal Z47): about 40 rooms (36–44) on a grid of 22 × 8 cells of 1600 × 1024 su
(50 × 32 tiles); rooms of 1 × 1, 2 × 1 or 1 × 2 cells (the boss room 2 × 1); a main path of 13 rooms; about 10
minutes to the boss and 30 to explore it all; zone bounds 35 200 × 8192 su.

## B.2 How it is generated

**Exactly as zones 1–3** (`../zone-1-suspended-sanctuary/layout.md` §B.2): the same steps, the same main path
order (corridor, combat, shaft, corridor, corridor, combat, shaft, corridor, combat, antechamber, boss room, way
down), the same branches ending in dead ends, the same checks (≥ 36 rooms, ≥ 9 dead ends), the same roles (the
deepest dead end the lore spirit, the next 8 altars, the rest lookouts). Only the room catalog (§B.3) and how a
room is drawn (§B.4) change. The zone's number enters the seed, so seed 1 of zone 4 is not seed 1 of zones 1–3.
Ten seeds tried: 1–11 attempts, 38–44 rooms, 9–11 dead ends.

## B.3 Room kinds — the catalog (`rooms.png`)

Every template may be mirrored. Each is **canopy** (root floors), **rot** (mud floors with pools) or **hollow
root** (wood; dark in `rooms.png`). Red arrows in `rooms.png` are its passages; red rings, its pools, vines,
webs, curtains and rotten roots.

| Kind | Templates | Size (cells) | Contents | How many per zone |
|---|---|---|---|---|
| start | `roots` (canopy) | 1 × 1 | the roots Akeris came down by, from a hole in the roof with the last step of zone 3's stair; a torch, a stump, ferns, mushrooms | 1 |
| corridor | `pools` (rot) · `boughs` (rot) · `hollow` (hollow root) · `webs` (canopy) | 2 × 1, 2 × 1, 2 × 1, 1 × 1 | `pools`: **two pools of 600 su** with **two vines** over each (280 su apart), a fallen log between them, two torches, egg sacs over the log; `boughs`: across **four roots** high over three pools (two of them **rotten**), with mud islands between the pools for whoever falls; `hollow`: inside a giant root, ceiling 380 su up, a **floor web** with a torch beside it, egg sacs; `webs`: a **floor web** of 620 su with a torch beside it, white threads, egg sacs over the web | 4 on the path; more in branches |
| combat | `clearing` (rot) · `nest` (canopy) | 2 × 1, 1 × 1 | `clearing`: a wide mud clearing with a 240 su pool at one end, two torches, a fallen log, egg sacs away from the foe spot; `nest`: egg sacs and threads (the spiderlings' brood), a floor web at one end and **two torches, one beside the web** (step 3.14, the spiderlings: knocked over, it burns the web; before, one torch); the foe spot is marked | 3 on the path; more in branches |
| shaft | `trunk` (hollow root) · `cascade` (canopy) | 1 × 2 | `trunk`: a hollow trunk, two blocks 440 su apart over a clear floor, climbed **from wall to wall** (zone 2's `chimney`); `cascade`: a cascade of thin roots at the back, two blocks 760 su apart, each climbed by driving the chain into its foot (zone 2's `falls`) | 2 on the path; more in branches |
| dead end | `rootEnd` (canopy) · `webEnd` (hollow root) · `poolEnd` (rot) | 1 × 1 | the bones, pack and fallen torch of one who came down, egg sacs over them; behind a **web curtain** with egg sacs with a torch beside it; across a 200 su pool; a feature spot for the altar, the lore spirit or the lookout (a stump) | 9 or more |
| antechamber | `ante` (canopy) | 1 × 1 | white threads and egg sacs, already torn (the brood went to its mother); the warning spirit, a torch, a stump; the boss door on its far side | 1 |
| boss | `spiderHollow` (canopy) | 2 × 1 | [`boss-room.md`](boss-room.md) | 1 |
| way down | `exit` (canopy) | 1 × 1 | a masonry wall with a broken merlon, its stair cut down into darkness, roots hanging over it: reaching its foot after the boss leads to zone 5 | 1 |

**Spiderling nests** (step 3.14, operator 2026-10-05, after playing it): every room with whole egg sacs is a nest — `pools`,
`hollow`, `webs`, `clearing`, `nest` (two clusters), `rootEnd`, `webEnd`; about 26 in a zone of seed 1. The sacs hang over
floor (never over a pool), so every spiderling comes down onto ground it can walk.

**Spore pods** (step 3.14, operator 2026-10-05): rooted on the floor of the rot rooms, never in a pool nor by a door — `pools`
(one, on the far floor), `boughs` (two: the left floor, a sound root), `clearing` (two, away from the log), `poolEnd` (one); about
18 in a zone of seed 1. Most stand within a torch's fall of a torch, so knocking it over burns them.

**Strangler vines** (step 3.14, operator 2026-10-05: «por todos lados, como las arañitas»): rooted on the floor of every room
but the start, the antechamber, the boss room and the way down, away from doors, pools and pods — `hollow` (two, one by its
torch), `webs` (at the web's edge), `rootEnd`, `webEnd`, `pools` (on the island), `boughs` (on a sound root), `clearing`, `poolEnd` (by the altar), and the bottom of the `trunk` and the `cascade`; about 39 in a zone of seed 1.

**Mantises** (step 3.14, operator 2026-10-06: «en varias salas del mapa»; step 3.16, operator 2026-10-13: none in the
`clearing`): one lurking on clear floor of `nest` (at 830, under the sacs, beside the torch), `hollow` (at 2050, past the
floor web) and `rootEnd` (at 350, by the fern, away from the altar); 12 in a zone of seed 1, each on a floor of 1200–3100 su.
How many per zone, and which enemies are common in each zone, is decided after zone 5 (operator, 2026-10-06).

**The mix** (step 3.16, operator 2026-10-13, EP6; *approved 2026-10-13*): zone 4 keeps its four enemies placed by their templates, as above, with one kind less in its two fullest rooms (operator, 2026-10-13): **no mantis in the `clearing`, no strangler vine in the `nest`**. Counted per room (seeds 1–5): 34–40 rooms with enemies; a room holds at most 4 of them and 3 kinds (the `clearing`: a nest, two pods and a vine) and at most 8 bodies (a `nest`'s brood of 7 and its mantis); 6–14 mantises and 35–39 vines per seed (before: 12–18 and 38–43). Every room but the start, the antechamber, the boss room, the way down and the `nest` has its vine. The mantis's test scenarios now run in the `nest`.

**Traversal limits** are zone 1's (a running jump ≈ 280 su across and ≈ 250 su up, the high jump ≈ 390 su; a
ring within 470 su of the hand) and zone 2's rule Z28 holds (nothing hangs closer than 470 su over a ledge,
every climbable wall ends at a floor, a wall that rises into a roof is not climbable, rings only where a gap
needs one). The shafts keep the geometry of zone 2's approved `chimney` and `falls`. Short pools (200–240 su)
are a running jump; long ones (600 su) are crossed by the vines or waded; in `boughs` the roots are 180–200 su
apart and a high jump climbs from each mud island to the next root.

## B.4 How a room becomes roots, mud and wood

| Piece | Rule |
|---|---|
| floor | solid from its edge to the room's bottom (the boughs and the hanging roots only their thickness; a rotten root is solid until it breaks); roots in the canopy and the hollow root, mud in the rot |
| ceiling | solid from the room's top down to its edge; every room has one; tangled roots, or wood in the hollow root |
| sides | on each side of each room, earth with roots (wood in the hollow root) **from top to bottom**, 56 su thick, except the opening of each used passage: **from the floor up to the room's own ceiling beside the wall** (at least 300 su), as zone 3 (no hanging lintels) |
| pool | the gap between two floors; its bottom, 64 su below their edge, is solid mud: Akeris wades |
| web curtain | solid from the floor to the ceiling, 28 su thick, until it burns |
| hollow-root wall | fills the room behind everything, hiding the far layers |
| empty cells | earth and roots |

**The joins between rooms** (operator, 2026-10-07: «las conexiones entre escenarios no se ven bien»): a block that hangs over a
passage (a shaft's or a step's) shows its face and closes with a lit underside and an edge, instead of fading to black; in the hollow root, every passage has its jamb (a post of the root's wood, the wall's shadow beside it).

## B.5 Where things stand

| Thing | Where |
|---|---|
| Akeris at the start | the foot of the roots he came down by |
| enemies | the foe spot of each combat room |
| altars | dead ends 2–9 by depth, each with its clearing and candles beside it (`05-items/altar/`) |
| lore spirit | the deepest dead end |
| warning spirit | the antechamber, before the boss door |
| the Giant Spider | hanging from its thread in the middle of the boss room |
| the way down | the foot of the exit stair |

## B.6 The map

As zones 1–3 (`06-ui/map/`): each room is its box from its lowest ceiling to its lowest floor (a pool's bottom
included), with its platforms as lines; rooms with pools show their dark bottom; the boss door has the padlock.
The map title is the zone's name and number (`zone.rottingCanopy.name`).

## Proposals for the operator (Z47)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z47 | The catalog | zones 1–3's generator and size; 15 templates (canopy, rot, hollow root) as §B.3; the shafts repeat the approved geometry of zone 2 |

## Acceptance

1. Any seed gives 36–44 rooms with a main path of 13 and at least 9 dead ends; the same seed always gives the same zone.
2. Every pool can be jumped or crossed by its vines, and waded; every wall that must be climbed ends at a floor.
3. No web curtain stands on the main path.
4. The spirits stand where §B.5 says.
