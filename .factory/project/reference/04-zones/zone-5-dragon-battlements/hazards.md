# Zone 5 — Dragon Battlements: hazards

- **Status:** approved 2026-10-07 (step 3.15)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → adarve, brecha, combate, ceniza*; *Volver a poner
  las almenas y el que vigila*; *Bola de fuego (O)* and *Lanzar piedra (Y)* against the merlons) ·
  **Captures:** [`viento`](sandbox/captures/viento.png),
  [`almena`](sandbox/captures/almena.png),
  [`almenaRota`](sandbox/captures/almenaRota.png), [`caida`](sandbox/captures/caida.png)
- **Sources:** `VISION.md` §Scope (side wind, gaps between merlons, merlons as cover against fire) · `01-story/dialogue/zone-5.md` («Keep behind the stones when it breathes», «The merlons will
  take the fire for you, until they break») · `../zone-1-suspended-sanctuary/hazards.md` (the fall, Z10) ·
  `../zone-3-sunken-graveyard/hazards.md` (the tombstone as cover, Z34–Z35) · `05-items/scrolls/` (the curse) · the
  operator's answers (2026-10-07: «me gustan las propuestas»; braziers «solo luz»; «el viento no debería de arrastrar a akeris»)
- **Read by:** the tasks that build the hazards; the tester; the contracts of the zone 5 enemies and of the Dragon

The list is closed: the zone 5 hazard is **the gap into the chasm**; **the merlons** are the zone's aid, listed here
because they belong to the same mechanics. **The side wind is not a hazard** (operator, 2026-10-07: it does not drag
Akeris): it is the biome's ambience, with the embers, the ash and the darkness (`biome.md` §A.4–A.5). The braziers are
only light.

| Hazard | Where | Telegraph (s) | Effect on the player | Look | Sound |
|---|---|---|---|---|---|
| **gap into the chasm** (proposal Z54) | `wallWalk` (220 and 240 su), `breach` (two collapses, crossed by rings), `ashEnd` (220 su); `layout.md` §B.3 | none: always visible (broken edges, darkness below) | falling **260 su** under its edge is **zone 1's fall**: 0.45 s falling, 0.25 s to dark, back at the last firm ground, 0.3 s to light, **2** of damage (stand-in; **the game decides**); with a curse active, it kills. On the main path every gap is jumped at a run. **The chain does not climb a gap's edge** | `sheet.png`: gap; `caida.png` | `sfx.zone5.fall` |

## The aid

| Aid | Where | How it works |
|---|---|---|
| **merlon of cover** (proposal Z56) | `wallWalk` (3), `bastion` (3), `ward` (1), the boss room (4) | a block of masonry **150 su** high and 96 wide, standing on the floor. **Not solid**: Akeris walks in front of it. **It stops every projectile** that reaches it (fire, rocks, arrows, a bone). **Fire breaks it in 3 hits** (cracks and soot after each; broken, a stump of 46 su that covers nothing); a projectile Akeris returned with a just block does not count; Akeris's weapons never break it; **once broken it does not come back** in the run. As zone 3's tombstone: a high shot passes over it; crouched, Akeris is wholly behind it |

**Last firm ground:** as zones 1–4: standing still on a floor with both feet on it; a hanging walk counts, a merlon does not.

## Proposals for the operator (Z54, Z56)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z54 | The gap | zone 1's fall 260 su under the edge, 2 of damage (stand-in); main-path gaps ≤ 240 su; a gap's edge is not climbed with the chain |
| Z56 | The merlon | 150 su, not solid; stops projectiles; fire breaks it in 3 hits, for the run |

The wind (Z55) moved to `biome.md`: smooth, it never moves Akeris and has no sound of its own (operator, 2026-10-07); the
anchor in the floor and the merlon's lee, which only made sense with a push, are gone.

## Never

- A wind that moves Akeris.
- A gap on the main path that cannot be jumped at a run.
- A merlon that comes back once broken, that Akeris's weapons break, or that blocks his way.
- A brazier that falls or burns anything.

## Acceptance

1. Running and jumping each `wallWalk` gap, Akeris lands past it (sandbox: 122 and 102 su past).
2. Falling into a gap plays the fall, returns him to the last firm ground and costs 2.
3. A rock stops at a merlon without damaging it; three fireballs break it; the fourth reaches Akeris (2 of damage).
4. The wind never moves him: standing, crouched or in the air (sandbox: 0 su; the same jump with the wind at its strongest and at its weakest).
5. Tested with a random player (60 runs of 25 s per seed, seeds 1–3, through every room of the zone, with sword, chain blades, hammer and spear and fireballs and rocks thrown): no errors, never out of a room, never inside the stone (2026-10-07).
