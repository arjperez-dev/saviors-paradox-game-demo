# Zone 4 — Rotting Canopy: the boss room

- **Status:** approved 2026-10-06 (the Giant Spider in place of the stand-in); approved 2026-10-03 before that (step 3.14)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → jefe*; *Entrar (espera)*,
  *Despierta (pelea)* and *Vencido* in the sound board) · **Captures:** [`jefe`](sandbox/captures/jefe.png),
  [`jefeDespierto`](sandbox/captures/jefeDespierto.png), [`jefeVencido`](sandbox/captures/jefeVencido.png),
  [`aviso`](sandbox/captures/aviso.png)
- **Sources:** `VISION.md` §Bosses (Giant Spider: «web shots that slow; eggs that hatch weak mini-spiders; poison
  spit leaving puddles; hangs from a thread (cut it with the chain to drop and stun it); floor webs slow and are
  burned by the fire shield»), §Scope (torches that burn webs), §Mechanics (sealed doors, every boss room has
  hanging platforms) · `01-story/dialogue/zone-4.md` (the warning spirit: «Something spins in the dark above the
  path», «When she tires, she hangs by a single thread. Cut it with your chain», «Fire does not care for webs») ·
  `../zone-3-sunken-graveyard/boss-room.md` (approved: the doors, the seal, no rings) · `07-audio/music/music.md`
  (`music.giantSpider.calm`, `.fight`, approved) · [`hazards.md`](hazards.md) (webs, torches)
- **Read by:** the task that builds the boss room; the Giant Spider's contract (its step) builds on it

- **Size (tiles):** 2 × 1 cells = 3200 × 1024 su = 100 × 32 tiles. A canopy room: **the hollow where the roots
  meet**.
- **Entry:** from the antechamber (white threads, egg sacs, the warning spirit), through an arched door. As in
  zones 1–3: when Akeris is **280 su past the door**, bars, chains and a padlock close both doors
  (`sfx.bossDoor.seal`), the game **autosaves**, and the zone music gives way to `music.giantSpider.calm`.
- **Arena:** one root floor the whole width (floor at 700 su); the roof is high — 670 su above the floor in the
  middle, 320 su over the doors so the arches fit — with **a web lattice** strung between its roots. In it:
  - **two roots hanging from vines** (400 su long, 40 su thick, 250 su above the floor, at 600–1000 and
    2200–2600): the hanging platforms every boss room has; Akeris reaches them with a jump and walks under them;
  - **four torches** planted in the floor (at 250, 1300, 1900 and 2950): the light, and the fire for the webs
    the Spider will weave (a blow or the chain knocks them over, `hazards.md`);
  - **no fixed pools**: the puddles come from her poison spit (her contract);
  - **no floor webs** at the start: the ones she weaves are her contract's, and they burn as the zone's;
  - **No rings** (as zones 1–3).
- **Light:** the four torches, 400 su each; the roof above is dark.
- **The Giant Spider:** hanging from her single thread in the middle, high up, curled; her fight is her contract
  ([`03-characters/bosses/giant-spider/contract.md`](../../03-characters/bosses/giant-spider/contract.md), step 3.14),
  which keeps the room as it is: she crawls in the lattice, hangs tired by one thread, comes down to the floor in her rage
  and weaves her own floor webs, which the four torches (knocked over or carried) burn. Defeated, she melts into ink.
  The stand-in of 2026-10-03 is gone.
- **Fight:** when she wakes, `music.giantSpider.fight` starts on the calm's next beat.
- **Exit:** when she dies, the padlock breaks, the chains fall and the bars rise (`sfx.bossDoor.open`); the map's
  padlock opens; the fight music fades and the zone's light music returns. The far door leads to the way down (a
  masonry wall with a broken merlon and its stair: zone 5 is below).

## Proposals for the operator (Z48)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z48 | The arena | the hollow where the roots meet: a high roof with a web lattice; two hanging roots 250 su up; four torches that can be knocked over to burn her webs; a firm floor, no fixed pools; no rings. The Giant Spider's contract may move them |

## Never

- The doors open before the boss dies, or close with Akeris in the doorway.
- A way down reachable before the boss dies.
- A torch of this room that stands up again during the fight once knocked over.

## Acceptance

1. Entering 280 su seals both doors with bars, chains and padlock, plays `sfx.bossDoor.seal` and starts
   `music.giantSpider.calm`.
2. The two hanging roots are reached with a jump and walked on.
3. A knocked torch keeps burning on the floor and lights the room.
4. When the boss dies the doors open and the way down can be reached.
