# Zone 2 — Echo Caverns: the boss room

- **Status:** approved 2026-10-01 (step 3.12)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → jefe*; *Entrar (espera)*,
  *Despierta (pelea)* and *Vencido* in the sound board) · **Captures:** [`jefe`](sandbox/captures/jefe.png),
  [`jefeDespierto`](sandbox/captures/jefeDespierto.png), [`jefeVencido`](sandbox/captures/jefeVencido.png),
  [`aviso`](sandbox/captures/aviso.png)
- **Sources:** `VISION.md` §Bosses (Giant Bat: «wakes hanging from the ceiling», «shockwave dodged from a
  hanging platform», «only its eyes show in the dark», «stalactites can be dropped on it with the chain»),
  §Mechanics (sealed doors, per-boss stage elements), §Session shape (autosave on entering a boss room) ·
  `../zone-1-suspended-sanctuary/boss-room.md` (approved: the doors, the seal, no rings) ·
  `07-audio/music/music.md` (`music.giantBat.calm`, `.fight`, approved)
- **Read by:** the task that builds the boss room; the Giant Bat's contract (its step) builds on it

- **Size (tiles):** 2 × 1 cells = 3200 × 1024 su = 100 × 32 tiles.
- **Entry:** from the antechamber, where the warning spirit stands under roosting small bats, through an
  arched door. As in zone 1: when Akeris is **280 su past the door**, bars, chains and a padlock close
  both doors (`sfx.bossDoor.seal`), the game **autosaves**, and the zone music gives way to
  `music.giantBat.calm`.
- **Arena:** one rock floor the whole width (floor at 700 su). The roof is **high** — 660 su above the
  floor in the middle, lower (320 su) over the doors so the arches fit. From it hang:
  - **two rock slabs on chains** (400 su wide, 40 su thick, 250 su above the floor, at 600–1000 and 2200–2600; Akeris
    reaches them with a jump and walks under them):
    the hanging platforms where Akeris rises above the bat's shockwave, as `VISION.md` asks;
  - **three big cracked stalactites** (at 1150, 1600 and 2050; 150 su long): they **only fall to the
    chain** (never to noise, so the fight is not decided by chance) and are the stones to drop on the
    bat. What they do to it is the bat's contract.
  - **No rings** (as zone 1, operator 2026-10-01: an attack near a ring hooked it).
- **Light:** four torches (two by the doors, two in the middle); the rest is dark, and the roof above
  the torches' reach is black — where the bat sleeps. **Its eyes show in the dark** (`VISION.md`):
  closed while it sleeps, open when it wakes; the sandbox draws them over the darkness.
- **The bat:** asleep in the middle of the roof, hanging upside down with its wings closed; its fight is its
  contract ([`03-characters/bosses/giant-bat/contract.md`](../../03-characters/bosses/giant-bat/contract.md), step 3.12), which
  keeps the room as it is: the slabs are cover and the escape from its slam, the stalactites bring it down, and in its
  rage it blows out the two middle torches (they burn again when it dies).
- **Fight:** when it wakes, `music.giantBat.fight` starts on the calm's next beat.
- **Exit:** when it dies, the padlock breaks, the chains fall and the bars rise (`sfx.bossDoor.open`);
  the map's padlock opens; the fight music fades and the zone's light music returns. The far door leads
  to the way down.

## Proposals for the operator (Z27)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z27 | The arena aids | a high roof over the middle; two hanging slabs 250 su up; three big cracked stalactites that only the chain drops; four torches; no rings. The bat's contract may move them |

## Never

- The doors open before the boss dies, or close with Akeris in the doorway.
- A way down reachable before the boss dies.
- A stalactite of this room falling by noise.

## Acceptance

1. Entering 280 su seals both doors with bars, chains and padlock, plays `sfx.bossDoor.seal` and starts
   `music.giantBat.calm`.
2. The doors stay sealed until the boss dies; then they open with `sfx.bossDoor.open` and the map's
   padlock opens.
3. The two slabs can be reached from the floor; there are no rings.
4. The three big stalactites fall only to the chain.
5. In the dark, only the bat's eyes show beyond the torches' reach.
