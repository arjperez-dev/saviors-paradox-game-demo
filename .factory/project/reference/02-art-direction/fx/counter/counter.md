# Counter

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Mechanics (Counter) · `../../../00-game/controls.md` §2, §5 (G7: only a
  perfect block against a **melee** hit opens a counter; G16: only with the **sacred shield**) · the art direction sandbox (`startCounter`,
  `counterStep`, `counterPose`, `drawAura`, `drawGhosts`; screenshots
  [`contra.png`](../../sandbox/contra.png), [`contra2.png`](../../sandbox/contra2.png),
  and a plain block for comparison, [`bloqueo3.png`](../../sandbox/bloqueo3.png))
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png) (sacred sword) · [`sprites/sheet-blades.png`](sprites/sheet-blades.png) (chain blades)
- **Read by:** the task that draws the counter.

**Only the sacred shield opens the counter.** A perfect block with the ice shield freezes the attacker
(`../freeze/freeze.md`) and one with the fire shield burns it (`../burn/burn.md`); a normal block
with either only stops the hit, and neither opens a counter (G16, revised 2026-09-30).

The game decides when a counter happens (the perfect-block window) and what it does (damage, how long
it lasts). This file says how it looks. The sandbox's window (0.2 s) and duration (1 s, from
`VISION.md`) are stand-ins where the game gives its own.

---

## 1. The moment it starts

| Piece | Rule |
|---|---|
| hitstop | 0.09 s |
| sparks | 16 ink strokes, long (44), from the shield |
| callout | `counter`, size 60, life 1.1 s, above Akeris's head |
| the attacker | its attack is cancelled and it recoils |

## 2. While it lasts

| Piece | Rule |
|---|---|
| **Strikes, sacred sword** | the three combo strikes in a loop (diagonal → rising → thrust), one every **0.16 s**: each blends from the previous strike's end to its wind-up in the first 30 % of the beat, then snaps to the strike (ease-out cubic) in the next 30 %. The hit lands at 45 % of the beat. The blade trail is on for the whole counter |
| **Burst, chain blades** | one throw every 0.16 s, **alternating hands**, at the target, each blade out in 0.06 s and back in 0.06 s, on the throw's own pose at burst speed; the throws' heights step over the target (−26, 0, +26) |
| **Afterimages** | every 0.04 s a copy of Akeris's body (no cape, no streak) is left behind and fades from 0.42 alpha to 0 in 0.24 s. It is the same drawing with the same seeds: graphite, not colour |
| **Aura** | a soft radial glow of `streakRed` (alpha 0.2 at the centre, radius 170) behind his torso, and 14 ink speed lines around him (radius 118–130 out to +34–74, 1.8 wide, alpha 0.55), seeded once, moving only with his body. Both fade in over 0.08 s and out over the last 0.15 s |
| **Each hit on the target** | it damages the target (how much is the game's); ink sparks at the blade; the target recoils. No callout per hit: the one `counter` is enough |
| Akeris | stays where he is; the cape is in its `atacar` mode |

## 3. Never

- No screen shake, no flash of the whole screen, no colour other than `streakRed` for the aura.
- No counter after a perfect block against a projectile: that is a reflect (`../reflect/reflect.md`).
- The aura's speed lines never flicker or change length frame to frame.

The counter while hanging from a ring, struck with the free hand's hook blade (`../../../00-game/
controls.md` §3.1), is drawn with Akeris's poses in step 3.5, with the same afterimages, aura and
callout.
