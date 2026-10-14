# Zone 3 — Sunken Graveyard: hazards

- **Status:** approved 2026-10-02 (step 3.13)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → tumbas, fosa, combate, lapida*;
  *Volver a poner las lápidas*; *Lanzar piedra (Y)* to test the cover) · **Captures:**
  [`tumbas`](sandbox/captures/tumbas.png), [`fosa`](sandbox/captures/fosa.png),
  [`caida`](sandbox/captures/caida.png), [`lapida`](sandbox/captures/lapida.png),
  [`lapidaRota`](sandbox/captures/lapidaRota.png)
- **Sources:** `VISION.md` §Scope (open graves, breakable tombstones as cover), §Bosses (Skeleton: «dodge
  … behind tombstones, which break») · `01-story/dialogue/zone-3.md` («Mind the open graves. Not all are
  empty») · `../zone-2-echo-caverns/hazards.md` (approved: a fall costs health and returns to the last firm
  ground) · `05-items/scrolls/` (the curse)
- **Read by:** the tasks that build the hazards; the tester; the contracts of the zone 3 enemies that shoot

The list is closed: the zone 3 hazards are the open graves; the tombstones are the zone's cover (an aid,
listed here because they break). The fog and the darkness are the biome, not hazards (`biome.md` §A.4).

| Hazard | Where | Telegraph (s) | Effect on the player | Look | Sound |
|---|---|---|---|---|---|
| **open grave** | `graves` (two), `graveEnd` (one), the mass grave of `fosa` (two wide stretches); `layout.md` §B.3 | none: always visible (the dug earth and the spade beside a narrow one, fog pouring in) | sinking **100 su** below the floor (in the wide mass grave, 260 su, as zone 2's sima): bony hands rise and grab him, he sinks slowly (≤ 220 su/s) for 0.45 s, the screen goes dark in 0.25 s, Akeris is back at the **last firm ground** and loses health (sandbox: 2; **the game decides**); the dark lifts in 0.3 s. With a curse active, the damage kills him | `sheet.png`: open grave; `caida.png` | `sfx.zone3.graveGrab` |
| **tombstone** (cover) | 1–6 per room by template (`graves`, `terraces`, `yard`, the boss room) | — | **not solid**: Akeris walks through it. It **stops any projectile** that crosses it (enemy shots, bones, a thrown stone, the Skeleton's air slash; also a projectile sent back). Crouched behind it (138 su) Akeris is fully covered; standing (192 su), only up to the chest. Each projectile that hits it cracks it (`sfx.zone3.stoneCrack`); the **third** breaks it (`sfx.zone3.stoneBreak`, rubble, `crack!`), and broken it **does not come back** in the run. Akeris's own weapons pass through it and never break it, so the cover is never lost by mistake. How many hits the Skeleton's air slash takes is its contract's | whole, cracked, cracked twice, broken (`sheet.png`) | `sfx.zone3.stoneCrack`, `sfx.zone3.stoneBreak` |

**Last firm ground:** as zones 1 and 2: the last place where Akeris stood still or landed with both feet
on the floor (26 su each side of his centre). Teleports count as firm ground.

## Proposals for the operator (Z33–Z35)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z33 | The open grave | zone 2's fall: the hands pull him under 0.45 s, dark 0.25 s, back at the last firm ground, light 0.3 s; a stand-in 2 of damage |
| Z34 | The tombstone | not solid; stops every projectile; three hits break it; Akeris's weapons never break it; it does not come back |
| Z35 | Height of the cover | 150 su: covers Akeris crouched, only up to the chest standing; a high shot passes over it |

## Never

- A fall that kills outright (except with the curse).
- A grave that cannot be seen: fog never hides its mouth.
- A tombstone that Akeris breaks with his own weapons, or that blocks his way.
- A tombstone that comes back in the same run once broken.
- A respawn inside a grave or at its edge.

## Acceptance

1. Falling into any open grave returns Akeris to his last firm ground with the damage, the hands and the
   dark of the table, and plays `sfx.zone3.graveGrab`.
2. With a curse active, falling into a grave kills him.
3. A projectile that reaches a tombstone stops there; crouched behind it Akeris takes nothing.
4. The third hit breaks the tombstone; a broken one stops nothing and never comes back in that run.
5. Akeris walks through tombstones and his weapons do not harm them.
