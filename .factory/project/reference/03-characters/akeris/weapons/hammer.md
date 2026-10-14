# Akeris — the hammer

- **Status:** approved 2026-09-30 (step 3.6)
- **Images:** [`hammer.png`](hammer.png) · [`hammer-sheet.png`](hammer-sheet.png) (carried on the
  shoulder, drawn, each attack, shield raised) · [`../sprites/sheet-hammer.png`](../sprites/sheet-hammer.png)
  (in motion) · poses [`../sprites/hammer-cock.png`](../sprites/hammer-cock.png),
  [`../sprites/hammer-slam.png`](../sprites/hammer-slam.png)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`hammerDraw`, `ATKS.hammer`,
  `POSE_W.hammer`, `CARRY.hammer`); key `5`, scenarios `#martillo`, `#martilloEncima`, `#martilloAire`
- **The item:** [`../../../05-items/weapons/hammer/hammer.md`](../../../05-items/weapons/hammer/hammer.md)

## 1. Look

A wooden handle (`wood`, −14 to 86, 5.6 wide) with a leather wrap and a round iron pommel; a heavy
iron head across the handle (`iron`, 24 thick from 79 to 104, 50 across), hatched, with two pale
iron bands and a lit top edge. Outline 2 on the head.

## 2. Where it is

In the front hand when equipped; not drawn otherwise (`05-items/items.md`, I1). **Carried on the
shoulder** (`CARRY.hammer`: upper arm 36, forearm −96, hammer −150): the head rests behind his
shoulder while he stands, walks or runs. **Drawing it** is the weapon swap with the hand **over the
shoulder**.

## 3. Using it: slow and heavy

| Attack | Keys (s) | Lands | Notes |
|---|---|---|---|
| diagonal | `windup` 0.13 → `slash` 0.22 → 0.36 → carry 0.64 | 0.19 | the head stops just above the floor (hammer 38) |
| rising | `lowCock` 0.11 → `upslash` 0.2 → 0.34 → 0.64 | 0.17 | |
| thrust | `thrustCock` 0.13 → `thrust` 0.21 → 0.38 → 0.68 | 0.18 | a short ram with the head, lunge 380 |
| overhead (W + click) | `hamCock` 0.22 → `hamSlam` 0.31 → 0.52 → 0.84 | 0.29 | he leans far back with the head behind him, then slams it down with the handle almost level: **dust puffs and `thud` on the floor even when it hits nothing**, hitstop 0.07 |
| aerial | `airWindup` 0.1 → `airChop` 0.19 → 0.32 → `fall` 0.48 | 0.16 | |
| shield raised | `block` with the hammer up behind (−140) | — | |

A hit pushes the enemy harder than the sword (knockback 8 against 5.5 in the sandbox) and holds the
hitstop longer (0.08). How much damage it does is the game's. Callout: `thud` for every blow.

## 4. Never

- The head never goes through the floor: the slam lands on it.
- No screen shake, not even for the slam: the weight is timing, dust and hitstop.
