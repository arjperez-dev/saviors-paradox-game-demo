# Akeris — the sacred sword

- **Status:** approved 2026-09-30 (step 3.5). The rules come unchanged from `../animations.md` version 1 §4,
  approved 2026-09-30.
- **Images:** [`sacred-sword.png`](sacred-sword.png) (the sword alone) ·
  [`sacred-sword-sheet.png`](sacred-sword-sheet.png) (in the hand, on the back, drawn, and each strike)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`heroSword`, `drawBackGear`, `ATK`)
- **The item** (level, where it is found, inventory icon): [`../../../05-items/weapons/sacred-sword/sacred-sword.md`](../../../05-items/weapons/sacred-sword/sacred-sword.md)

## 1. Look

A pale blade 114 long (`blade` `#e4e1d9`, outline 1.8), with a thin graphite line down its middle,
a guard 26 wide (4.5 thick), a grip 18 long (5 thick) and a round pommel (radius 3.2). Its gem holes
are not drawn in the demo (`VISION.md` §Non-goals).

**Melee only.** It never hooks, climbs or swings; that is the hook blades'.

## 2. Where it is

| Equipped | Where the sword is |
|---|---|
| the sword | in the front hand, along the forearm's line at rest (`sw` of the pose) |
| the hook blades, or drinking | sheathed diagonally on the back: the scabbard (`#5a5047`, hatched) from above the shoulder down past the hip, foreshortened to 0.82, hilt up |

## 3. Drawing it and putting it away

The weapon swap (0.3 s) is an arm overlay on any pose: the front hand reaches **over the shoulder**
(upper arm −135, forearm −165, blade −175) and the sword appears in it at the midpoint (0.15 s);
putting it away is the same gesture, and at the midpoint the sword is back in its sheath. See
[`../sprites/sheet-swap.png`](../sprites/sheet-swap.png).

## 4. Using it

The strikes and their timing are `../animations.md` §4: the combo (diagonal, rising, thrust), the
overhead strike, the aerial attack and the counter. The blade leaves a trail while it strikes
(`02-art-direction/fx/hit-feedback/`). A hit gives the `slash` callout (the thrust `thud`).
