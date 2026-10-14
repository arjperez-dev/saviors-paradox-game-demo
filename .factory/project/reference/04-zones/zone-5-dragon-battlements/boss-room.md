# Zone 5 — Dragon Battlements: the boss room

- **Status:** approved 2026-10-07 (step 3.15)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → jefe*; *Entrar (espera)*, *Despierta (pelea)* in
  the sound board; «Dragón (sustituto): vencido» in the bar) · **Captures:** [`jefe`](sandbox/captures/jefe.png),
  [`jefeDespierto`](sandbox/captures/jefeDespierto.png), [`jefeVencido`](sandbox/captures/jefeVencido.png) (again 2026-10-12, with the dragon),
  [`aviso`](sandbox/captures/aviso.png)
- **Sources:** `VISION.md` §Bosses (Dragon: «fire bursts (low and high breath), earthquakes when slamming into the floor,
  wind slashes from its wings, floor eruptions telegraphed by glowing cracks; plus claw (blockable), bite, flight with wind
  gusts, dive; fire blocked by the fire shield; finisher: hook the horn and strike the neck»), §Scope (merlons as cover
  against fire), §Mechanics (sealed doors, every boss room has hanging platforms), §Win (the outro) ·
  `01-story/dialogue/zone-5.md` (the warning spirit) · `01-story/cinematics/outro.md` (changed by the operator 2026-10-14, second version: after the
  ability choice the gates open and Akeris walks toward the way down; the fog; Future Akeris behind him; played in this room) · `07-audio/music/music.md` (`music.dragon.calm`, `.fight`, approved) ·
  [`hazards.md`](hazards.md) (the merlons)
- **Read by:** the task that builds the boss room; the Dragon's contract (its step) builds on it

- **Size (tiles):** **3 × 2 cells = 4800 × 2048 su = 150 × 64 tiles** (operator, 2026-10-07: «hacer más grande la sala para que
  él se pueda mover libremente ya que es el boss más fuerte de la demo»; the other zones' boss rooms are 2 × 1). **Open air**
  (operator, 2026-10-07: «al aire libre no dentro de algo cerrado»): **the highest bastion**, open to the chasm and to the
  cavern above, with **no roof and no walls**; only **the two gates**, each in its narrow gate tower (130 su), that close the
  way back and the way on while the fight lasts. The doors are on the lower row; above the arena there are ≈ 1840 su of
  air. **The generator keeps the row of cells above the room empty** (no room is placed there; it is drawn as the open
  cavern darkening upward), so the sky over the Dragon is always open.
- **Entry:** from the antechamber (claw marks, the scale, the warning spirit), through an arched door. As in zones 1–4:
  when Akeris is **280 su past the door**, bars, chains and a padlock close both doors (`sfx.bossDoor.seal`), the game
  **autosaves**, and the zone music gives way to `music.dragon.calm`.
- **Arena** (proposal Z58; template coordinates, the floor at 1844, 120 su below the door landings at 1724, which are a
  step jumped, not climbed with the chain):
  - **five merlons of cover** (at 600, 1500, 2400, 3300 and 4200): «Keep behind the stones when it breathes»; each breaks
    under **3 breaths** (or 3 fire hits) and does not come back in the fight (`hazards.md`);
  - **three broken pieces of wall walk hanging from chains** (400 su long, 40 thick, **250 su** above the floor, at
    800–1200, 2200–2600 and 3600–4000): the hanging platforms every boss room has. Their chains rise to the old hoists
    high in the cavern;
  - **the broken bridge** that once joined the two gate towers, 650 su above the floor (its deck ending at 1194; two spans,
    130–1950 and 2850–4670, with arches under the deck, broken in the middle). Stone: a high jump from a hanging piece
    touches it and does not pass. **When the Dragon wakes, what is left of it comes down** (operator, 2026-10-07: «para
    que el dragón pueda volar»): it cracks (0.7 s: the cracks appear, nothing trembles; `sfx.zone5.bridgeCrack`, once),
    both spans fall, turning, and break on the bastion (`sfx.zone5.bridgeFall`, once) in dust and flying stones, and **a
    heap of rubble stays** where each fell. **Harmless** (the moment of the waking; the Dragon's contract may decide
    otherwise). Then **nothing solid stands over the arena** but the gate towers. Reset with the zone;
  - **the broken tower** at one end (4300, 340 su high), with claw marks and soot: the Dragon sleeps coiled on it, on **a
    nest of rubble, bones and old scales**;
  - **the remains of those who came up to face it** (at 1900 and 3700): soot, a helmet, a shield, a sword stuck in the
    stone, a skull and bones; two torn banners (420, 3950), hanging still (no wind here);
  - **cracks** in the floor (1200, 2400, 3500): where the eruptions will glow (the Dragon's contract);
  - **the far wall** across the chasm, pale, with its merlons, **always empty** (the 2026-09-30 outro put a
    watcher there; the operator's 2026-10-14 script dropped him); **the glow of the chasm** rises stronger behind this bastion (fixed, never flickering);
  - **no wind of the zone** (here the wind is the Dragon's wings); **no rings**; two braziers on the landings (220, 4580).
- **Light:** the two braziers, 450 su each, and the glow from below; darkness 45 %.
- **The Dragon:** asleep on its broken tower; its fight is its contract (`03-characters/bosses/dragon/contract.md`, step
  3.15, **approved 2026-10-13: no longer a stand-in**; the room is kept as it is: the merlons stop its low breath and its
  fire rain, the hanging walks are above the low breath and in the high one, the cracks are its eruptions; the hanging
  walks hang in front of it, they do not block it). Before it, a stand-in (redrawn twice on 2026-10-07 at the operator's
  request), drawn in curves: four legs with haunches and shoulders and curved talons, a neck in an S with its belly
  plates, a long head with a brow, nostrils, a hinged jaw with teeth and two curved ringed horns (one chipped: the
  finisher hooks the horn), scales in pencil, back spines (one chipped), belly plates, a spade-tipped tail, wings with
  arm, elbow, wrist, four finger bones, veins and a scalloped membrane with a tear, scars; in `iron`, `fire` iron on the
  spines, `bone` horns and talons. Old: it forgot why it guards, not how. **Asleep** on the tower: curled, legs tucked, the
  wing folded flat on its back, the head on its claws, the eye shut, smoke from the nostril, the tail hanging down the
  tower; it breathes every two bars. **Awake** (≈ 1000 su from tail to snout; Akeris 192), it rises in the bastion: the
  neck raised, the wings half open, the ember eye with a slit pupil, the jaw open with fire inside, the fire glowing in its
  chest and between its belly plates. The stand-in wakes on its own **2.5 s after the doors seal**. Like every boss, after
  four chain hits in a row it lets out a blast that pushes Akeris away without damage (`03-characters/akeris/weapons/hook-blades.md`
  §6); the Dragon's will be its own.
- **Fight:** when it wakes, `music.dragon.fight` starts on the calm's next beat.
- **Exit:** when it dies and its ability has been taken, **the gates of the two gate towers open**: on each gate the
  padlock breaks, the chains fall and the bars rise into the arch (`sfx.bossDoor.open`; ≈ 1.5 s, step 3.18); the fight
  music fades; **in the demo the outro plays here, in this room** (`01-story/cinematics/outro.md`: Akeris walks
  toward the far gate, the fog fills the room). The far gate leads to the way down (full game).
- **Tested (2026-10-07):** entering seals the doors (`sfx.bossDoor.seal`, `music.dragon.calm`); 2.5 s later it wakes
  (`music.dragon.fight`, one `bridgeCrack`), the bridge falls in ≈ 1.4 s (one `bridgeFall`), no solid is left over the
  arena; a random player locked in for 60 s of fight never leaves the room nor enters the stone; defeated, the doors open
  (`sfx.bossDoor.open`, the zone's music); reset, the bridge is whole again.

## Proposals for the operator (Z58)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z58 | The arena | 3 × 2 cells, the highest bastion in the open air: no roof, no walls, only the two gates in their narrow gate towers, and nothing above (the generator keeps the row over it empty); the broken bridge high above, which comes down when the Dragon wakes and leaves its rubble; five merlons; three hanging pieces; the remains of the fallen, two banners, the nest on the tower, a stronger glow from the chasm; the floor 120 su below the doors;  the Dragon on a broken tower; cracks in the floor; the far wall for the outro; no zone wind, no rings. The Dragon's contract may move them |

## Never

- The doors open before the boss dies, or close with Akeris in the doorway.
- Anyone on the far wall (the outro no longer uses it).
- A merlon of this room that stands again during the fight once broken.
- The zone's gusts in this room.
- A roof or a wall over the arena: only the gates.

## Acceptance

1. Entering 280 su seals both doors with bars, chains and padlock, plays `sfx.bossDoor.seal` and starts `music.dragon.calm`.
2. The three hanging pieces of wall walk are reached with a jump from the floor and walked on.
3. The landings are reached with a jump from the floor; the chain does not climb them.
4. When the boss dies (and its ability is taken) the gates of both gate towers open (in the demo, the outro).
5. When the Dragon wakes, the bridge cracks, falls and leaves its rubble; nothing solid stands over the arena but the gate towers.
6. No room is ever generated over the boss room: its sky is the open cavern.
