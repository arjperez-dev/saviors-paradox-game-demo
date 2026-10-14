# Akeris — the spear

- **Status:** approved 2026-09-30 (step 3.6)
- **Images:** [`spear.png`](spear.png) (the spear alone) · [`spear-sheet.png`](spear-sheet.png) (carried,
  drawn, diagonal, rising, thrust, overhead, aerial, shield raised) ·
  [`../sprites/sheet-spear.png`](../sprites/sheet-spear.png) (the combo, the overhead strike and the
  aerial attack, in motion)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`spearDraw`, `ATKS.spear`,
  `AIR_ATKS.spear`, `POSE_W.spear`, `CARRY.spear`); key `3`, scenarios `#lanza`, `#lanzaEncima`, `#lanzaAire`
- **The item** (where it is found, level, icon): [`../../../05-items/weapons/spear/spear.md`](../../../05-items/weapons/spear/spear.md)

## 1. Look

A long wooden shaft held a third of the way along: it runs from 60 behind the hand to 124 in front,
4.4 wide, in `wood` with a graphite grain line. An iron butt cap (`iron`, 8 long) behind; a leather
wrap (`leather`) over the grip, −8 to 8; an iron socket from 118 to 128; and a leaf-shaped head in
`blade`, from 127 to the tip at 162, 16 at its widest, with a graphite midrib. Outline 1.3–1.6.
**Reach:** the tip is 162 from the hand, the sword's is 114.

## 2. Where it is

| Equipped | Where the spear is | Elsewhere |
|---|---|---|
| the spear | in the front hand | the sword sheathed on the back; both hook blades at the belt |
| any other weapon, or drinking | not drawn: it is in the quick inventory (`05-items/items.md`, I1) | — |

**Carried** (standing, walking, landing): in guard, almost upright, the head above his own
(`CARRY.spear`: upper arm 64, forearm −36, spear −80); running tilts it forward by up to 30.
**Drawing it** is the weapon swap (0.3 s) with the hand **over the shoulder**, like the sword.

## 3. Using it

The same inputs as the sword (`../../../00-game/controls.md` §2), with its own timing. Times are the
sandbox's shape and default; the game decides each duration and the animation is stretched to it.

| Attack | Keys (s) | Lands | Notes |
|---|---|---|---|
| diagonal | `windup` 0.09 → `slash` 0.17 → hold 0.28 → carry 0.48 | 0.14 | flatter than the sword's (`slash` forearm 30, spear 20) so the long head never goes through the floor |
| rising | `lowCock` 0.07 → `upslash` 0.15 → 0.26 → 0.48 | 0.12 | |
| thrust | `thrustCock` 0.11 → `thrust` 0.18 → 0.34 → 0.58 | 0.15 | lunge 560 (the sword's is 420): its signature |
| overhead (W + click) | `overCock` 0.14 → `overStrike` 0.22 → 0.36 → 0.6 | 0.2 | the head comes down level, forearm 30, spear 24 |
| aerial | `airWindup` 0.07 → `airStab` 0.14 → 0.27 → `fall` 0.42 | 0.11 | a stab down and forward (spear 70°) |
| shield raised | `block` with the spear up behind (−118) | — | the shield on the back forearm, as always |

The trail follows the head (tip 160, middle 110). Callouts: `slash` for the cuts, `thud` for the
thrust and the aerial stab.

## 4. Never

- The spear never passes through the floor while he stands or kneels.
- It never hooks, climbs or swings; the chain is the hook blades'.
- A weapon never blocks: the shield stays on the back forearm.
