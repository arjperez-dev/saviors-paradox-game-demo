# Akeris — the flail

- **Status:** approved 2026-09-30 (step 3.6)
- **Images:** [`flail.png`](flail.png) (the flail alone, the chain stretched) ·
  [`flail-sheet.png`](flail-sheet.png) (carried, drawn, each attack, shield raised) ·
  [`../sprites/sheet-flail.png`](../sprites/sheet-flail.png) (in motion)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`flailDraw`, `FLAIL`, `stepFlail`,
  `restBall`, `ATKS.flail`); key `4`, scenarios `#mayal`, `#mayalEncima`, `#mayalAire`
- **The item:** [`../../../05-items/weapons/flail/flail.md`](../../../05-items/weapons/flail/flail.md)

## 1. Look

A short wooden handle (`wood`, −12 to 36, 5 wide) with a leather wrap over the grip and an iron ring
at its end; a chain of alternating links (the hook blades' chain, 1.4 wide) **52** long; a spiked iron
ball (`iron`), radius 10.5, hatched, with 8 spikes 7 long and a light glint. The spikes turn with the
chain, so the ball's shape never changes.

## 2. The ball moves for real

The ball hangs from the chain and **the arm moves it**: a position-based (Verlet) pendulum with
gravity 2600, a damping of 0.996 per half step, a chain that never stretches, and a stop on the floor.
It inherits the handle's whip, so each swing flings it through a wide arc behind the hand, and the
thrust throws it straight out to the end of the chain. This is real motion, allowed by
`02-art-direction/ART_DIRECTION.md` §2.1: nothing trembles, and at rest it hangs still.

In a pose sheet or a still (no motion), the ball hangs straight down, or lies along the line of the
blow for an attack pose; it never goes below the floor.

## 3. Where it is, carrying and drawing

As the spear (§2 of `spear.md`): in the front hand when equipped, not drawn otherwise. It is carried
like the sword, the ball hanging at his side. **Drawing it** is the weapon swap with the hand **to the
hip**, like the hook blades.

## 4. Using it

| Attack | Keys (s) | Hits | Notes |
|---|---|---|---|
| diagonal | `windup` 0.1 → `slash` 0.19 → 0.32 → 0.56 | 0.15–0.36 | the ball hits whatever it passes through inside that window, once |
| rising | `lowCock` 0.08 → `upslash` 0.17 → 0.3 → 0.56 | 0.13–0.34 | |
| thrust | `thrustCock` 0.12 → `thrust` 0.19 → 0.36 → 0.62 | 0.17–0.4 | the ball flies out straight to the end of the chain; lunge 300 |
| overhead (W + click) | `overCock` 0.16 → `overStrike` 0.25 → 0.42 → 0.68 | 0.22–0.46 | the ball goes over his head and smashes into the floor: a dust puff where it lands |
| aerial | `airWindup` 0.08 → `airChop` 0.16 → 0.28 → `fall` 0.44 | 0.12–0.34 | |

The trail is the ball's path. Callout: `thud`.

## 5. Never

- The ball never jitters, never stretches its chain, never goes through the floor.
- The flail never hooks, climbs or swings from anything.
