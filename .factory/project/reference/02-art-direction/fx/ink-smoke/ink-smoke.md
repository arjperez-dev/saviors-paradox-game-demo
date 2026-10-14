# Ink smoke

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Mechanics (Hit feedback: defeated enemies dissolve into ink smoke) ·
  `../../../00-game/tone.md` §2, §4 · the art direction sandbox (`startDissolve`, `smokeStep`,
  `drawDummyDissolving`; screenshots [`humo.png`](../../sandbox/humo.png) at 0.45 s and
  [`humo2.png`](../../sandbox/humo2.png) at 0.9 s)
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png)
- **Read by:** every task that removes a defeated enemy or boss.

How the defeated leave: they fill with ink and come apart into smoke that rises. No blood, no body
left behind, nothing that reads as injury (`../../../00-game/tone.md` §4).

---

## 1. The dissolve

The body stops in the pose it had when it was defeated, and from then on only the ink moves.

| Time (s) | What happens |
|---|---|
| 0 → 0.2 | the body **fills with ink**: its drawing is overlaid with `ink`, from 0 to 0.88 alpha (eased), inside its own shape only |
| 0.12 → 0.82 | **holes start to open** in it: 30 seeded circles, placed over the body, each starting at its own time (upper holes first, so the body comes apart from the head down, with a seeded spread) and growing to a radius of 20–42 over 0.45 s. The body is erased where they grow; nothing flickers, the holes only grow |
| as each hole opens | **a puff of smoke** leaves from its centre |
| ≈ 1.4 | the body is gone; the last puffs fade by ≈ 2.4 |

Durations scale with the body's size: the sandbox's are for a body of Akeris's size (≈ 200 su tall).
A boss uses the same recipe with more holes, not faster ones.

## 2. A puff

| Property | Rule |
|---|---|
| shape | an irregular blob of 9 points, radius 7–14 varying 70–115 %, seeded by the puff's id; its shape never changes |
| fill | `ink` at 0.72, with a light hatching (`paper` at 0.28) toward its upper left |
| wisp | one ink stroke curling up from its top, 1.3 wide |
| motion | rises at 55–125 su/s, drifts sideways up to 25 su/s, both slowing (rates 4/s and 3/s) |
| life | 0.9–1.5 s: it grows to 2.3× and fades to 0 |

## 3. Never

- No red, no fragments of the body, nothing left on the floor.
- No flicker: the holes and puffs are seeded once; only their size and position change.
- No callout: the dissolve is quiet.
