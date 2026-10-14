# Burn

- **Status:** approved 2026-09-30
- **Sources:** `../../../00-game/controls.md` §2, §5 (G16, revised 2026-09-30: the fire shield, with a perfect block against a melee hit,
  sets the attacker burning for 1.5 s, losing health; it opens no counter; a projectile reflected
  with the fire shield burns its thrower for 0.5 s) · `VISION.md` §Mechanics
  (Shields) · `../../dungeon/dungeon.md` §4 (the torch flame this reuses) · the art direction sandbox
  (`burnDummy`, `dummyStep`, `drawBurn`, `drawBurnGlow`)
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png)
- **Read by:** the task that draws a burning enemy.

The game decides how much health a burn takes and how often (the sandbox takes one of the dummy's
ten marks every 0.5 s, three in all). This file says how a burning body looks. The 1.5 s is the
operator's.

---

## 1. When it starts

A melee hit is blocked with the fire shield, perfect or not. The block is drawn as any fire block
(`../hit-feedback/hit-feedback.md` §2: 12 `fire` sparks, `fwoom`). The attacker keeps moving and can
attack again while it burns.

Also: a projectile reflected with the fire shield burns its thrower for **0.5 s** when it hits
(`../reflect/reflect.md`), drawn the same, only shorter (one tick of damage in the sandbox).

## 2. While it lasts (1.5 s, or 0.5 s)

| Piece | Rule |
|---|---|
| flames | five flames on the body, at seeded places from its feet to its head, each the torch's flame (`flame` outer, `flame` inner, outlined in `ink` 1.3), 20–32 tall. They breathe ±6 % and sway ±2.4, slowly, each with its own phase: a sway, never a flicker |
| glow | a `torchlight` halo behind the body (0.32 alpha at the centre, radius 150) |
| embers | small fire-coloured dust puffs rising from the body, about 12 a second |
| each tick of damage | 8 short `fire` sparks from the body; no callout |
| fade | flames and glow fade in over 0.12 s and out over the last 0.2 s |

## 3. Never

- No flicker, no flash, no smoke of any colour but the embers.
- A burning enemy that is defeated dissolves into ink smoke as usual (`../ink-smoke/ink-smoke.md`);
  its flames go out at once.
