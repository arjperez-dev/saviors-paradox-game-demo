# Zone 1 — Suspended Sanctuary: the boss room

- **Status:** approved 2026-10-01
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → jefe*; *Despierta (pelea)* and
  *Vencido* in the sound board) · **Captures:** [`jefe`](sandbox/captures/jefe.png),
  [`jefeVencido`](sandbox/captures/jefeVencido.png), [`aviso`](sandbox/captures/aviso.png)
- **Sources:** `VISION.md` §Bosses (Golem), §Mechanics («doors sealed with bars, chains and a padlock
  until the boss dies; per-boss stage elements (hanging platforms, cover, rings)»), §Session shape
  (autosave on entering a boss room) · `07-audio/music/music.md` §3 · `06-ui/map/map.md`
- **Read by:** the task that builds the boss room; the Golem's contract (step 3.11) builds on it

- **Size (tiles):** 2 × 1 cells = 3200 × 1024 su = 100 × 32 tiles.
- **Entry:** from the antechamber, where the warning spirit stands, through an arched door (its bars
  raised). When Akeris is **280 su past the door**, the bars drop on both doors, chains cross them and
  a padlock closes them (`sfx.bossDoor.seal`); the game **autosaves** (`VISION.md`); the zone music
  gives way to `music.golem.calm`. The Golem floats in the middle of the room, its eye closed.
- **Arena:** one island the whole width (floor at 700 su, 380 su of rock below). Above it, **three
  slabs hanging from chains** (400 su wide at heights 270, 400 and 270 su above the floor, at a third,
  the middle and two thirds). **No rings** (operator, 2026-10-01, step 3.11: with the chain blades an attack
  near a ring hooked it and Akeris hung instead of striking). The slabs let Akeris
  leave the floor when the Golem attacks it and reach the Golem, as `VISION.md` asks. What changes
  between phases (the floor that shrinks in the rage phase, the rock rain) is the Golem's: step 3.11.
- **Fight:** when the Golem wakes, `music.golem.fight` starts on the calm's next beat.
- **Exit:** when the Golem dies, the padlock breaks, the chains fall and the bars rise on both doors
  (`sfx.bossDoor.open`); the map's padlock opens (`map.md` U26); the fight music fades and the zone's
  light music returns. The far door leads to the way down.

## Proposals for the operator (Z12–Z13)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z12 | When the doors seal | when Akeris is 280 su inside, so they never close on him in the doorway; both doors at once |
| Z13 | The arena aids | three hanging slabs at the heights above; no rings (operator, 2026-10-01); the Golem's contract may move them |

## Never

- The doors open before the boss dies, or close with Akeris in the doorway.
- A way down reachable before the boss dies.

## Acceptance

1. Entering 280 su seals both doors with bars, chains and padlock, plays `sfx.bossDoor.seal` and
   starts `music.golem.calm`.
2. The doors stay sealed until the boss dies; then they open with `sfx.bossDoor.open` and the map's
   padlock opens.
3. The slabs are where this file places them and can be reached from the floor; there are no rings.
