# Strokes

- **Status:** approved 2026-09-30
- **Sources:** `../ART_DIRECTION.md` §2 (version 1 §3) · the Akeris sandbox (`sline`, `scircle`, `poly`,
  `hatch`, `drawChain`, `popText`)
- **Sheet:** [`strokes.png`](strokes.png): the primitives, the widths and the lettering
- **Read by:** the task that builds the drawing primitives (`core/rendering`), and every task that
  draws with them.

Every primitive draws from a seed passed in (`seed(id)` before the stroke). The sandbox's `mulberry`
generator is an example; any seeded generator works. The same seed gives the same stroke in every
frame: **nothing trembles**.

---

## 1. Primitives

| Primitive | Rule (sandbox function) |
|---|---|
| Line | One quadratic curve. The control point is bowed sideways by ≤ min(1.3, 2.5 % of the length), each end moved by ≤ 0.3, the midpoint slid by ≤ 6 % along the line. A **second pass** follows it at 30 % alpha and 40 % width, offset ≤ 1.1 and overshooting the start by 1.5–4 (`sline`). |
| Circle | 16 points, radius ± min(0.8, 6 %), closed with quadratic midpoints (`scircle`, `closedCurve`). |
| Polygon / fill | Points moved by ≤ 0.3–0.7, filled, then outlined in ink (`poly`, `spath`). |
| Hatching | Parallel strokes at slope 0.6, gap 3–9, clipped to the shape, alpha 0.14–0.35 (`hatchRect`, `hatch`). |
| Chain | Links alternate between an ellipse 4.6 × 2.4 seen face-on and an 8.8 line seen edge-on, along a quadratic sag curve (`drawChain`). |

Lines use round caps and round joins.

## 2. Stroke widths (su)

| Part | Width |
|---|---|
| limbs | 2.9 |
| back arm | 2.6 |
| torso | 3.1 |
| head outline | 3 |
| foot | 2.7 |
| masonry: top edge | 3 |
| masonry: exposed sides | 2.4 |
| stone polygons | 1.25 (the sandbox's `stone`; 1.8 before, operator 2026-10-15) |
| chain links | 1.4–1.5 |
| hatching | 1 |

Enemies and bosses take their widths from these by size: a figure the size of Akeris uses the same
widths; a larger one scales them by its size ratio, capped at 1.6×, so outlines never turn into bars
(operator, 2026-09-30, `../ART_DIRECTION.md` §6 A1).

## 3. Lettering

Callouts (`../fx/callouts/callouts.md`) and the sandbox's labels are hand lettering: the sandboxes use the web
font *Patrick Hand*, and so does the game: it bundles *Patrick Hand* (SIL Open Font License) for its
callouts (operator, 2026-09-30, `../ART_DIRECTION.md` §6 A2). A callout is drawn filled with `paperLight` and
outlined in `ink` 6 wide, round-joined.

## 4. Seeds

- A stroke's seed comes from a stable id: the entity's id plus a part index, a tile-run index, a
  particle's id. Never time, never an unseeded generator.
- Two strokes that must look different never share a seed; the same stroke drawn twice (an
  afterimage, a pose sheet, a mirrored figure) reuses its seed on purpose, so the copy is exact.
