# Freeze

- **Status:** approved 2026-09-30
- **Sources:** `../../../00-game/controls.md` §2, §5 (G16, revised 2026-09-30: the ice shield, with a perfect block against a melee hit,
  freezes the attacker for 1.5 s and lowers its defence while frozen; it opens no counter; a
  projectile reflected with the ice shield freezes its thrower for 0.5 s) ·
  `VISION.md` §Mechanics (Shields, Status effects) · the art direction sandbox (`freezeDummy`,
  `dummyStep`, `drawFrozen`; screenshots [`congelar.png`](../../sandbox/congelar.png): a perfect
  block with the ice shield freezes and does not counter; [`congelar2.png`](../../sandbox/congelar2.png): a normal block only stops the hit)
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png)
- **Read by:** the task that draws a frozen enemy.

The game decides how much the defence drops (the sandbox's dummy takes double damage) and whether a
boss can be frozen. This file says how a frozen body looks. The 1.5 s is the operator's.

---

## 1. When it starts

A melee hit is blocked with the ice shield, perfect or not. The block itself is drawn as any ice
block (`../hit-feedback/hit-feedback.md` §2: 12 `ice` sparks, `crish`). The attacker's attack is
cancelled and it stops **in the pose it had**: nothing about it moves while it is frozen.

Also: a projectile reflected with the ice shield freezes its thrower for **0.5 s** when it hits
(`../reflect/reflect.md`). Everything below is the same, only shorter; the shell fades out over its
last third instead of 0.2 s.

## 2. While it lasts (1.5 s, or 0.5 s)

| Piece | Rule |
|---|---|
| shell | a faceted shell of ice around the body: 13 points on an ellipse about 1.2 × its width and 1.15 × its height, each radius varied 86–114 %, seeded once. Filled `ice` at 0.5, outlined in the ice facet colour (`rgba(60,110,140,.95)`) 1.8 wide |
| facets | thin lines (1, at 0.4) from a point above the centre to every corner of the shell |
| highlights | two white strokes (`rgba(255,255,255,.85)`), upper left and lower right |
| icicles | four small triangles hanging from the bottom of the shell |
| fade | the shell fades in over 0.12 s and out over its last 0.2 s |
| hits taken | drawn as usual (sparks, callout), but the body does not recoil: it is frozen |

## 3. When it ends

The shell breaks: 14 long sparks in the `ice` effect colour burst from its centre, and the body
moves again from where it stopped.

## 4. Never

- The shell never shimmers or sparkles frame to frame; it is seeded once and only fades.
- No blue tint on anything but the shell and its sparks.
