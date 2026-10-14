# Reflect

- **Status:** approved 2026-09-30
- **Sources:** `../../../00-game/controls.md` §2, §5 (G7: a projectile blocked perfectly goes back,
  faster, to its thrower and damages it; it opens no counter; projectiles are never split) · the
  operator, 2026-09-30: the reflected projectile damages whoever threw it · the art direction sandbox
  (`reflectShot`, `updateShots`, `drawShots`; screenshots [`devolver.png`](../../sandbox/devolver.png),
  [`devolver2.png`](../../sandbox/devolver2.png), [`devolver3.png`](../../sandbox/devolver3.png))
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png) (a rock, sacred shield) ·
  [`sprites/sheet-ice-shield.png`](sprites/sheet-ice-shield.png) (a rock, ice shield: freezes) ·
  [`sprites/sheet-fire-shield.png`](sprites/sheet-fire-shield.png) (a rock, fire shield: burns) ·
  [`sprites/sheet-fire.png`](sprites/sheet-fire.png) (a fireball, fire shield) · an ice shard is in
  [`../elements/sprites/sheet-ice.png`](../elements/sprites/sheet-ice.png)
- **Read by:** the task that draws a reflected projectile.

**Any shield that stops a projectile reflects it on a perfect block** (operator, 2026-09-30):
reflecting is not a counter, so G16 does not limit it. Which shield stops which projectile is
`../elements/elements.md` §1: any shield stops a plain one, only the fire shield a fireball, only the
ice shield an ice shard. The ring and sparks take the colour of the shield that reflected it.

**A reflected projectile damages whoever threw it**, and the shield that reflected it adds its
element (operator, 2026-09-30):

| Reflected with | On hitting the thrower |
|---|---|
| the sacred shield | damage only |
| the ice shield | damage, and the thrower is **frozen for 0.5 s** (`../freeze/freeze.md`) |
| the fire shield | damage, and the thrower **burns for 0.5 s** (`../burn/burn.md`) |

The game decides how fast it returns and how much damage it does; the sandbox returns it at 1.6×
its speed and takes 3 of its dummy's 10 marks, and both are stand-ins. The 0.5 s is the operator's.

---

## 1. The moment of the block

| Piece | Rule |
|---|---|
| hitstop | 0.07 s |
| Akeris | the `blockHit` push, shorter than a plain block's (160 instead of 260 in the sandbox) |
| ring | an ellipse in the shield's accent (`sacred`, `ice` or `fire`) grows from 20 × 30 to 66 × 90 around the shield over 0.26 s, thinning from 4 to 1 wide and fading |
| sparks | 12, long (34), in the shield's accent |
| callout | `reflect`, size 42 |

No shield use is spent by the drawing; whether the game spends one is the game's.

## 2. The way back

| Piece | Rule |
|---|---|
| path | straight back toward its thrower, level (no arc) |
| echoes | its last 7 positions are kept; every other one is drawn as a copy of the projectile at 0.32 alpha fading to 0 along the tail |
| speed lines | 3 ink lines behind it, 1.4 wide, at .55 alpha, 48–76 long, spaced 9 apart |
| a rock | keeps spinning as it flies |
| a fireball | keeps its glow and embers |

## 3. When it hits its thrower

It **damages** its thrower (and freezes or burns it for 0.5 s, by the table above), and the hit is
drawn like any hit that lands on an enemy: hitstop 0.05 s,
sparks (12, ink or `fire`), the `thud` callout and the thrower's recoil
(`../hit-feedback/hit-feedback.md` §2). Then the projectile falls away (a rock) or goes out (a
fireball). If the damage defeats the thrower, it dissolves into ink smoke
(`../ink-smoke/ink-smoke.md`).
