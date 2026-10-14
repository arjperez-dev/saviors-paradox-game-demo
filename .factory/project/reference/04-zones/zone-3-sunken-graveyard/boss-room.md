# Zone 3 — Sunken Graveyard: the boss room

- **Status:** approved 2026-10-02 (step 3.13)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → jefe*; *Entrar (espera)*,
  *Despierta (pelea)* and *Vencido* in the sound board) · **Captures:** [`jefe`](sandbox/captures/jefe.png),
  [`jefeDespierto`](sandbox/captures/jefeDespierto.png), [`jefeVencido`](sandbox/captures/jefeVencido.png),
  [`aviso`](sandbox/captures/aviso.png)
- **Sources:** `VISION.md` §Bosses (Skeleton: «unblockable air slashes at range (dodge by jumping or behind
  tombstones, which break)», bone throws, «bony hands from the ground», «reassembles once … unless its skull
  is snatched with the chain»), §Mechanics (sealed doors, every boss room has hanging platforms) ·
  `01-story/dialogue/zone-3.md` (the warning spirit: «the bones in the lowest crypt still hold a sword»,
  «put a stone between you») · `../zone-2-echo-caverns/boss-room.md` (approved: the doors, the seal, no rings) ·
  `07-audio/music/music.md` (`music.skeleton.calm`, `.fight`, approved)
- **Read by:** the task that builds the boss room; the Skeleton's contract (its step) builds on it

- **Size (tiles):** 2 × 1 cells = 3200 × 1024 su = 100 × 32 tiles. A catacomb room: **the lowest crypt**.
- **Entry:** from the antechamber (a funeral chapel with the warning spirit, two candles, a sarcophagus),
  through an arched door. As in zones 1 and 2: when Akeris is **280 su past the door**, bars, chains and a
  padlock close both doors (`sfx.bossDoor.seal`), the game **autosaves**, and the zone music gives way to
  `music.skeleton.calm`.
- **Arena:** one stone floor the whole width (floor at 700 su); the vault is high — 660 su above the floor in
  the middle, 320 su over the doors so the arches fit. In it:
  - **two stone coffins hanging on chains** (400 su long, 40 su thick, 250 su above the floor, at 600–1000
    and 2200–2600): the hanging platforms every boss room has; Akeris reaches them with a jump and walks
    under them;
  - **six tombstones** (at 420, 1060, 1250, 1950, 2140 and 2780): the cover against what the Skeleton throws
    and slashes; they break as in `hazards.md` (how many hits its air slash takes is its contract's). The
    approved proposal said five; with the bier in the middle, six keep the room symmetric (three on each
    side);
  - **the bier** in the middle (320 su wide, 70 high, a step at each end), where the Skeleton lies with its
    sword in its hands;
  - **No rings** (as zones 1 and 2).
- **Light:** four iron candelabra (one by each door, one at each end of the bier), 420 su each; the vault
  above is dark.
- **The Skeleton:** lying on its bier; its fight is its contract
  ([`03-characters/bosses/skeleton/contract.md`](../../03-characters/bosses/skeleton/contract.md), step 3.13),
  which keeps the room as it is: the tombstones are cover from its slashes, the coffins lift Akeris over what
  runs along the floor. The sandbox now has the real one (2026-10-02, in `review`): asleep on its bier, it
  wakes when the doors seal; its contract keeps the room as it is.
- **Fight:** when it wakes, `music.skeleton.fight` starts on the calm's next beat.
- **Exit:** when it dies, the padlock breaks, the chains fall and the bars rise (`sfx.bossDoor.open`);
  the map's padlock opens; the fight music fades and the zone's light music returns. The far door leads
  to the way down (roots going down a stair: zone 4 is below).

## Proposals for the operator (Z36)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z36 | The arena | the lowest crypt: a high vault; two hanging stone coffins 250 su up; six breakable tombstones; the bier in the middle; four candelabra; no rings. The Skeleton's contract may move them |

## Never

- The doors open before the boss dies, or close with Akeris in the doorway.
- A way down reachable before the boss dies.
- A tombstone of this room that comes back during the fight once broken.

## Acceptance

1. Entering 280 su seals both doors with bars, chains and padlock, plays `sfx.bossDoor.seal` and starts
   `music.skeleton.calm`.
2. The doors stay sealed until the boss dies; then they open with `sfx.bossDoor.open` and the map's
   padlock opens.
3. The two coffins can be reached from the floor; there are no rings.
4. The six tombstones stop projectiles and break as in `hazards.md`.
