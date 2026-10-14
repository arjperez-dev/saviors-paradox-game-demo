# Zone 5 — Dragon Battlements: layout

- **Status:** approved 2026-10-07 (step 3.15)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (the generator is `zoneGen` and `zoneBuild`;
  *Semilla* makes another zone, *Ir a…* jumps to each place) · **Rooms:** [`rooms.png`](rooms.png) ·
  **Four seeds:** [`layout.png`](layout.png) · **The map of one:** [`sandbox/captures/mapa.png`](sandbox/captures/mapa.png)
- **Sources:** `../zone-4-rotting-canopy/layout.md` (approved: the generator, its size and its rules, kept whole) ·
  `VISION.md` §Core loop, §Mechanics, §Win / lose conditions · `01-story/zones-narrative.md` (where the spirits stand) ·
  `05-items/items.md` (altars off the main path) · [`hazards.md`](hazards.md)
- **Read by:** the task that builds the zone generator; the tester

---

## B.1 Size and shape

The same as zones 1–4: about 40 rooms (36–44) on a grid of 22 × 8 cells of 1600 × 1024 su (50 × 32 tiles); rooms of
1 × 1, 2 × 1 or 1 × 2 cells; **the boss room 3 × 2** (operator, 2026-10-07: the strongest boss of the demo needs room to fly); a main path of 13 rooms; about 10 minutes to the boss and 30 to explore
it all; zone bounds 35 200 × 8192 su.

## B.2 How it is generated

**Exactly as zones 1–4** (`../zone-1-suspended-sanctuary/layout.md` §B.2): the same steps, the same main path order, the
same branches ending in dead ends, the same checks, the same roles (the deepest dead end the lore spirit, the next 8
altars, the rest lookouts). Only the room catalog (§B.3) and how a room is drawn (§B.4) change. The zone's number enters
the seed. Seed 1: 43 rooms.

## B.3 Room kinds — the catalog (`rooms.png`)

Every template may be mirrored. Each is **wall walk** (open, wind), **tower** (masonry inside, no wind; dark in
`rooms.png`) or **breach** (open, ash, wind). Red in `rooms.png`: passages, gaps, merlons and rings.

| Kind | Templates | Size (cells) | Contents | How many per zone |
|---|---|---|---|---|
| start | `stair` (wall walk) | 1 × 1 | the stair Akeris came down by from zone 4's broken merlon; a brazier, a banner, rubble | 1 |
| corridor | `wallWalk` (wall walk) · `breach` (breach) · `gatehouse` (tower) · `guardroom` (tower) | 2 × 1, 2 × 1, 2 × 1, 1 × 1 | `wallWalk`: **two gaps of 220 and 240 su** jumped at a run, **three merlons**, two braziers, two banners, the far wall (the watcher may stand on it); `breach`: a collapse crossed by **three rings** of the old hoists (zone 1's `rings` geometry), with a stub of wall standing in the middle, charred beams; `gatehouse`: the raised portcullis, murder holes, barrels, a rack; `guardroom`: a bench, a rack, a barrel | 4 on the path; more in branches |
| combat | `bastion` (wall walk) · `ward` (breach) | 2 × 1, 1 × 1 | `bastion`: wide, open to the chasm, **merlons at both ends and in the middle**, two braziers, a banner, the far wall; `ward`: a burned court with one merlon; the foe spot is marked | 3 on the path; more in branches |
| shaft | `tower` (tower) · `curtain` (wall walk) | 1 × 2 | `tower`: two blocks 440 su apart, climbed **from wall to wall** (zone 2's `chimney`); `curtain`: the outer face of the wall, two blocks 760 su apart, each climbed by driving the chain into its foot (zone 2's `falls`), with wind while climbing | 2 on the path; more in branches |
| dead end | `watchEnd` (wall walk) · `armoryEnd` (tower) · `ashEnd` (breach) | 1 × 1 | the sentry box with the sentry's bones and horn, the far wall; an armoury of rusted weapons; a burned room **across a 220 su gap**; a feature spot for the altar, the lore spirit or the lookout (a fallen merlon) | 9 or more |
| antechamber | `ante` (breach) | 1 × 1 | claw marks on a block of the wall, a huge scale, scorch; the warning spirit, a brazier; the boss door on its far side | 1 |
| boss | `highBastion` (wall walk) | 3 × 2 | [`boss-room.md`](boss-room.md); its doors on the lower row; **the row of cells above it is kept empty** (the open cavern) | 1 |
| way down | `exit` (tower) | 1 × 1 | a stair sinking into the depths under an arch («the dungeon goes down fifteen times more»). **In the demo it is never reached**: when the Dragon dies the outro plays (`VISION.md` §Win). Kept for the full game | 1 |

**Traversal limits** are zone 1's, measured again in the sandbox: a running jump covers **≈ 360 su** in 0.96 s (the high
jump ≈ 426 su). The wind never moves Akeris; **no gap on the main path is wider than 240 su** (the `wallWalk` gaps
land 100–120 su past the far edge). Zone 2's rule Z28 holds (every climbable wall ends at
a floor, a wall that rises into a roof is not climbable, rings only where a gap needs one), and two rules are added for
this zone: **a step lower than 260 su is not climbed with the chain** (it is jumped), and **the edge of a gap is not
climbed** (falling is the fall). A climbable face must have air in front of it all the way up (in a passage between two
rooms, a face beside the other room's wall is not climbed).

**The rooms' plan** (operator, 2026-10-08: «los dragoncitos y gárgolas no deberían de estar en las mismas salas … las gárgolas regadas una por sala … los dragoncitos que aparezcan menos por sala»): each open room (`wallWalk`, `bastion`, `ward`, `breach`) is, by the seed, **a drakeling room or a gargoyle room, never both** (half and half); `watchEnd` has a gargoyle 60 % of the times. A drakeling room holds **one** drakeling, on one of its merlons; a gargoyle room holds **one** gargoyle on its pedestal (`wallWalk` 1600, `bastion` 2050, `ward` 880, `breach` 2560, `watchEnd` 480): **real** half of the times (70 % in the combat rooms `bastion` and `ward`), seen **in profile**; otherwise **decorative**, seen **from the front**, duller, part of the background. Seeds 1–3: 6–8 drakelings, 5–8 real gargoyles and 2–4 decorative ones. Never in the towers nor in the boss room. How common each
enemy is per zone is decided after zone 5 (operator, 2026-10-06). The pedestals are background (not solid).

**The garrison** (operator, 2026-10-12, R1–R5): the passage towers (`gatehouse`, `guardroom`) belong to the garrison: each holds **one** enemy of it, never two — on the main path always, in the branches 60 % of the times — the **fire mace brute** in the `gatehouse` 65 % of the times (it is long: room for its wave and its embers), otherwise the **elite shield knight**; in the `guardroom` the knight 65 %. Never in the open rooms (they belong to the drakelings and gargoyles), the shafts, the dead ends or the boss room (`z5Garrison`). Seeds 1–3: 3, 4 and 1 knights, 3 brutes each. The towers' vaults stand 400–420 su over the floor: both fit, the brute's raised mace included.

**The mix** (step 3.16, operator 2026-10-13, EP7; *approved 2026-10-13*): zone 5 **stays as it is** — the rooms' plan (`z5Plan`) and the garrison (`z5Garrison`) above are its mix.

## B.4 How a room becomes masonry

| Piece | Rule |
|---|---|
| floor | solid from its edge to the room's bottom (the shaft blocks and the hanging walks only their thickness) |
| gap | the space between two floors; nothing under it but a hidden floor at the room's bottom so nothing drops into the room below; falling 260 su under its edge is the fall |
| ceiling | solid from the room's top down to its edge; the cavern's rock (wall walk, breach) or a vault (tower) |
| sides | on each side of each room, masonry **from top to bottom**, 56 su thick, except the opening of each used passage, **from the floor up to the room's own ceiling beside the wall** (at least 300 su), as zones 3–4 |
| merlon | stands on the floor; **not solid** (`hazards.md`) |
| a passage in a tower | the inner wall ends at a **jamb** (a pale stone pilaster, with the wall's shadow beside it), not at a cut (operator, 2026-10-07) |
| a block over a passage | the shaft blocks show their face and close with an edge underneath (operator, 2026-10-07) |
| the far wall | inside its own room, ending in two towers (never cut by the room's edge) |
| tower wall | fills the room behind everything, hiding the far layers |
| empty cells | solid masonry, dark |

## B.5 Where things stand

| Thing | Where |
|---|---|
| Akeris at the start | the foot of the stair he came down by |
| enemies | the foe spot of each combat room; the drakelings and gargoyles by the rooms' plan (§B.3); the garrison in the passage towers (§B.3) |
| altars | dead ends 2–9 by depth, each with its candles beside it (`05-items/altar/`) |
| lore spirit | the deepest dead end |
| warning spirit | the antechamber, before the boss door |
| the Dragon | asleep on its broken tower in the boss room, which is open to the cavern |
| the one who watches | behind the far wall's merlons of 70 % of the `wallWalk`, `bastion` and `watchEnd` rooms; in the depths (a needle of rock) of half of the open `wallWalk` and `bastion` rooms where the near one is not (`biome.md` Z60) |
| the way down | the foot of the exit stair (full game only) |

## B.6 The map

As zones 1–4 (`06-ui/map/`): each room is its box from its lowest ceiling to its lowest floor (a gap shown 260 su deep),
with its platforms as lines; rooms with gaps are drawn as chasm rooms; the boss door has the padlock. The map title is the
zone's name and number (`zone.dragonBattlements.name`).

## Proposals for the operator (Z57)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z57 | The catalog | zones 1–4's generator and size; 15 templates (wall walk, tower, breach) as §B.3; the shafts repeat zone 2's approved geometry, the breach zone 1's rings; gaps on the main path ≤ 240 su; steps under 260 su and gap edges are not climbed |

## Acceptance

1. Any seed gives 36–44 rooms with a main path of 13 and at least 9 dead ends; the same seed always gives the same zone.
2. Every gap on the main path is jumped at a run; the breach is crossed by its rings.
3. Every wall that must be climbed ends at a floor; no step under 260 su and no gap edge is climbed with the chain.
4. The spirits stand where §B.5 says.
