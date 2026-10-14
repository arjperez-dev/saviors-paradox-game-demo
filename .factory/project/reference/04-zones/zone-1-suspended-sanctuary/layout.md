# Zone 1 — Suspended Sanctuary: layout

- **Status:** approved 2026-10-01
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (the generator is `zoneGen` and
  `zoneBuild`; *Semilla* makes another zone, *Ir a…* jumps to each place) ·
  **Rooms:** [`rooms.png`](rooms.png) · **Four seeds:** [`layout.png`](layout.png) ·
  **The map of one:** [`sandbox/captures/mapa.png`](sandbox/captures/mapa.png)
- **Sources:** `VISION.md` §Core loop (procedural zones, permadeath), §Mechanics (boss rooms, map),
  §Client constraints (no zone is the same twice) · `01-story/zones-narrative.md` (where the spirits
  stand) · `05-items/items.md` (altars off the main path) · the operator's decisions of 2026-10-01
- **Read by:** the task that builds the zone generator; the tester

---

## B.1 Size and shape

| Measure | Value | Source |
|---|---|---|
| zone size | about 40 rooms (36–44), on a grid of 22 × 8 cells | operator, 2026-10-01 («gigante») |
| cell | 1600 × 1024 su = 50 × 32 tiles | this file |
| room size | 1 × 1, 2 × 1 or 1 × 2 cells (the boss room 2 × 1) | §B.3 |
| main path | 13 rooms, start to the way down | §B.2 |
| time | about 10 minutes straight to the boss; about 30 minutes to explore it all | operator; the game measures it |
| zone bounds | 35 200 × 8192 su | 22 × 8 cells |

## B.2 How it is generated

Deterministic: **the same seed gives the same zone**, and each run draws a new seed (`VISION.md`).

1. **Grid.** 22 × 8 empty cells. Rooms join only through **side passages**, at the floor height of
   their row (700 su below the row's top); a passage is 260 su tall. Rooms never open into the room
   above or below: **vertical movement happens inside shafts** (1 × 2 rooms with passages on both
   rows).
2. **Main path.** The start room goes in column 0, row 2–5 by seed. Then, always to the right, one room
   of each kind in this order: corridor, combat, shaft, corridor, corridor, combat, shaft, corridor,
   combat, antechamber, boss room, way down. For each, the generator tries the templates of that kind
   in seeded order, plain or mirrored, entering through the passage that meets the previous room;
   a shaft must leave by its other row, so the path climbs or drops. If a room does not fit, the whole
   attempt starts again with the next number from the seed.
3. **Branches.** While there are fewer rooms than the target (36–44, by seed), a free passage of any
   room on or off the path (not the start, antechamber, boss room or way down) grows a branch of 1–4
   rooms (corridor, combat or shaft) that ends in a **dead end**. A branch that cannot fit ends early
   in a dead end, or not at all.
4. **Checks.** The attempt is kept only with at least 36 rooms and at least 9 dead ends; otherwise it
   starts again (10 seeds tried: 1–27 attempts, 36–43 rooms).
5. **Roles of the dead ends.** The deepest (most rooms from the start) holds the **lore spirit**; the
   next 8 hold **altars** (the sandbox's 3 scrolls and 5 weapons or shields; which items, `05-items/`);
   the rest are **lookouts** (a broken column, a view of the void).
6. **Closing.** Where a floor meets a room edge with no passage, a broken column-wall closes it. Where
   no floor meets the edge, the edge is the abyss.
7. **What varies:** the shape of the path, every branch, which template each room uses, which way it
   faces, where the altars and the lore spirit stand, the floating stones. **What never varies:** the
   order of the main path's kinds, that the antechamber with the warning spirit comes right before the
   boss room and the way down right after it, the room catalog itself.

## B.3 Room kinds — the catalog (`rooms.png`)

Every template may be mirrored. Red arrows in `rooms.png` are its passages.

| Kind | Templates | Size (cells) | Contents | How many per zone |
|---|---|---|---|---|
| start | `start` | 1 × 1 | the stair Akeris came down, along the left wall; a column, an arch with the clock relief, a brazier | 1 |
| corridor | `gap` · `steps` · `rings` · `bridge` | 2 × 1, 1 × 1 | islands over the abyss: two drifting platforms and two rings (`gap`); five stepping islands (`steps`); three rings over two wide gaps, a small island between (`rings`); one rising and sinking platform (`bridge`) | 4 on the path; more in branches |
| combat | `hall` · `isle` | 2 × 1, 1 × 1 | a wide island (with a raised ledge) where enemies stand; the foe spot is marked | 3 on the path; more in branches |
| shaft | `lift` · `columns` | 1 × 2 | `lift`: two platforms rising and sinking in turn between the two floors; `columns`: two hanging columns, three ledges and two rings | 2 on the path; more in branches |
| dead end | `isleEnd` · `ledgeEnd` · `shrineEnd` | 1 × 1 | one island off the branch; a feature spot for the altar, the lore spirit or the lookout | 9 or more |
| antechamber | `ante` | 1 × 1 | the warning spirit, two braziers, the clock relief; the boss door on its far side | 1 |
| boss | `golemRoom` | 2 × 1 | [`boss-room.md`](boss-room.md) | 1 |
| way down | `exit` | 1 × 1 | a stair down into darkness: reaching its foot after the boss leads to zone 2 | 1 |

**Traversal limits the templates respect** (from Akeris's numbers in the sandbox; the game keeps them
in step): a running jump crosses about 280 su and climbs about 250 su (the high jump about 390 su);
a ring holds within 470 su of the hand. No gap in a template asks more.

## B.4 Where things stand

| Thing | Where |
|---|---|
| Akeris at the start | the start room's foot of the stair |
| enemies | the combat rooms: one or two each, by the mix below (step 3.16; the enemy kinds, step 3.10) |
| altars | dead ends 2–9 by depth, each under a light shaft (`05-items/altar/`) |
| lore spirit | the deepest dead end (off the main path, `zones-narrative.md`) |
| warning spirit | the antechamber, before the boss door (`zones-narrative.md`) |
| Golem | the middle of the boss room |
| the way down | the foot of the exit stair |

**The mix** (step 3.16, operator 2026-10-13, EP1–EP3 and EP8; *approved 2026-10-13*): every combat room holds
**only zone 1's own enemies**, chosen by the seed. The first combat room of the main path holds **one** enemy; every other one
**one or two** (half and half). The kinds are dealt by quota, so each seed stays close to the shares below; the hardest never
stands in the first room, and two of one kind share a room only when nothing else fits. **The mace brute always guards the last
combat room of the main path** (the one before the antechamber). The second enemy of a room stands on the same floor, 300–1000 su
from the first and at least 300 su from the doors. The `isle`'s foe spot lies under its raised ledge (160 su of air: a knight or a
brute standing there was caught in the stone and could not walk), so the mix moves it to the nearest floor with room to stand.
Each enemy of the plan keeps to its room (while it thinks and moves, its room's edges are walls to it). In the sandbox the room's planned enemies appear when Akeris enters the room or a room next to it, and once beaten they do not come back; the nearest one is «the one in front», the one Akeris's blows reach, and all of them move, attack and die at the same time (block «Paso 3.16 — la proporción de enemigos», `zMix()`, kept on `ZONE.mix`). The *Enemigo* button keeps its old list (one enemy picked by hand, from any zone, in the first combat room) only as a test tool; *Mezcla de la zona* goes back to the plan and *Plan de enemigos* lists it room by room.

| Tier | Enemy | Share | Seeds 1–5 (each seed) | Seeds 1–5 (all) |
|---|---|---|---|---|
| common | shield knight | 35 % | 4 · 4 · 3 · 3 · 5 | 19 (35 %) |
| common | rune sentinel | 30 % | 4 · 3 · 3 · 3 · 4 | 17 (31 %) |
| frequent | wandering eye | 20 % | 2 · 2 · 2 · 2 · 3 | 11 (20 %) |
| rare, the guardian | mace brute | 15 % | 2 · 1 · 1 · 1 · 2 | 7 (13 %) |

Seeds 1–5: 6–10 combat rooms, 9–14 enemies, never more than 2 in a room; the brute guards the last room of the main path in all
five, alone or with one more.

## B.5 The map

The map (`06-ui/map/`) draws each room as its box, from 140 su below the room's top to its lowest
floor, with the islands and platforms as its lines; rooms with an abyss show their dark bottom; the
boss door carries the padlock. Revealing, markers and levels are unchanged (`map.md`).

## B.6 Proposals for the operator (Z5–Z9)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z5 | Grid and cell | 22 × 8 cells of 1600 × 1024 su; rooms of 1–2 cells; 36–44 rooms |
| Z6 | Vertical movement | only inside shafts, never through floors or ceilings |
| Z7 | The main path | 13 rooms in the fixed order of §B.2 |
| Z8 | Dead ends | the deepest holds the lore spirit, the next 8 the altars, the rest are lookouts |
| Z9 | The way down | only after the boss; reaching the foot of the stair starts the next zone |

## Acceptance

1. Two runs with the same seed produce the same zone, room for room; two seeds produce different ones.
2. Every zone has 36–44 rooms, a main path of 13 in the order of §B.2, 8 altars and a lore spirit off
   the path.
3. Every room is reachable from the start, and the boss is reachable without any branch.
4. Every gap and height in every template is within the traversal limits of §B.3.
5. No floor ends at a room edge without a passage or a wall.
