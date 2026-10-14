# Zone 2 — Echo Caverns: hazards

- **Status:** approved 2026-10-01 (step 3.12)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → rio, sima, tunel, estalactita*;
  *Volver a poner las estalactitas*) · **Captures:** [`rio`](sandbox/captures/rio.png),
  [`sima`](sandbox/captures/sima.png), [`caida`](sandbox/captures/caida.png),
  [`estalactita`](sandbox/captures/estalactita.png), [`eco`](sandbox/captures/eco.png)
- **Sources:** `VISION.md` §Scope (biomes and hazards), §Bosses (Giant Bat: stalactites dropped with the
  chain) · `../zone-1-suspended-sanctuary/hazards.md` (approved: a fall costs health and returns to the
  last firm ground) · `biome.md` §A.5 (noise) · `05-items/scrolls/` (the curse)
- **Read by:** the tasks that build the hazards; the tester

The list is closed: the zone 2 hazards are the black water and the cracked stalactites. The darkness is
the biome, not a hazard (`biome.md` §A.4).

| Hazard | Where | Telegraph (s) | Effect on the player | Look | Sound |
|---|---|---|---|---|---|
| **black water** | rivers, simas, lakes and pools of the templates (`layout.md` §B.3) | none: it is always visible, still and dark, with fixed glints | sinking 30 su below its surface: a splash (and an echo ring), he sinks slowly (≤ 260 su/s) for 0.45 s, the screen goes dark in 0.25 s, Akeris is back at the **last firm ground** and loses health (sandbox: 2; **the game decides**); the dark lifts in 0.3 s. With a curse active, the damage kills him | `sheet.png`: water | `sfx.zone2.splash` |
| **cracked stalactite** | marked in the templates (`tunnel` 3, `grotto` 2, `steps` 1); thicker and paler than the others, with a crack at its root | **0.6**: grit trickles from its root and the crack runs across it, with `sfx.zone2.stalCrack` | a **noise** under it (`biome.md` §A.5: running, landing, striking, a clang) within 300 su (measured sideways) cracks it; walking under it never does. After the telegraph it falls (2600 su/s²); if it meets Akeris: damage (sandbox: 2; the game decides), a short push away and `crack!`. The roll's invulnerability goes through it; **no shield stops it** (it falls from above). It breaks on the floor (or into the water) in pieces, leaves a heap of rubble and its own noise, and **does not come back** in the run | a stalactite, then falling, then rubble | `sfx.zone2.stalCrack`, `sfx.zone2.stalFall` |

**The chain and the stalactites:** a chain blade thrown into a cracked stalactite drops it at once
(0.15 s of crack; the blade comes back). A stalactite that falls on an enemy hits it (sandbox: 3). So the
player can bring them down on what stands below — the same tool the Giant Bat's fight asks for
(`boss-room.md`).

**Last firm ground:** as zone 1: the last place where Akeris stood still or landed with both feet on
rock (26 su each side of his centre). Teleports count as firm ground.

## Proposals for the operator (Z24–Z26)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z24 | Black water | zone 1's fall: sink 0.45 s, dark 0.25 s, back at the last firm ground, light 0.3 s; a stand-in 2 of damage |
| Z25 | What cracks a stalactite | a noise within 300 su sideways (running, landing, striking, a clang); walking never; 0.6 s of telegraph; running at full speed passes before it falls, stopping under it does not |
| Z26 | The chain and the falls | the chain drops a cracked stalactite at once; a falling stalactite hurts enemies too; once fallen it stays fallen |

## Never

- A fall that kills outright (except with the curse).
- A stalactite that falls with no telegraph, falls on its own, or falls because Akeris walked.
- A cracked stalactite that cannot be told from the others by its look.
- A respawn in the water or at its edge.

## Acceptance

1. Falling into any black water returns Akeris to his last firm ground with the damage and the dark of
   the table, and plays `sfx.zone2.splash`.
2. With a curse active, falling into the water kills him.
3. Running or landing under a cracked stalactite cracks it with 0.6 s of telegraph and the crack
   sound; walking under it does not.
4. Standing under a falling stalactite hurts him; rolling through it does not; a shield does not help.
5. A chain blade drops a cracked stalactite at once; one falling on an enemy hurts it.
6. A fallen stalactite leaves rubble and never comes back in that run.
