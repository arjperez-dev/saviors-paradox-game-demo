# The altar

- **Status:** approved 2026-09-30 (step 3.6)
- **Kind:** world object
- **Images:** [`altar.png`](altar.png) (lit, with nothing on it) · [`altar-empty.png`](altar-empty.png)
  (taken: candles out) · one per item on it: `altar-spear.png`, `altar-flail.png`, `altar-hammer.png`,
  `altar-ice.png`, `altar-fire.png`, `altar-health.png`, `altar-power.png`, `altar-cursed.png` ·
  [`sheet-pickup.png`](sheet-pickup.png)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`drawAltar`, `candle`, `startPickup`); scenario `#recoger`
- **Sources:** operator decision D-I6 · `02-art-direction/dungeon/dungeon.md` (masonry) · [`../items.md`](../items.md) §2

## 1. What it is

Where weapons, shields and scrolls wait, in rooms off the main path. Which altars a zone has, and
where, is `04-zones/`; a zone's biome may dress it, never change its shape.

## 2. Look (su, standing on the floor)

- A base slab 108 wide and 16 high (stone, hatched), a column 54 wide and 68 high (`pillar`) with two
  grooves and **the hourglass of the Time Chamber carved** in it (a hollow in `hollow` at .55, with
  ink lintels), and a top slab 96 wide, 98 above the floor, with the `stoneEdge` light line.
- **Two candles** on the top slab, 35 either side: pale wax (`paperLight`) with drips, a wick and the
  torches' flame in small (11 high, swaying slowly), each with a little `torchlight` halo (radius 70).
- The item floats 30 above the slab, bobbing ±3 su slowly (1.2 rad/s): it reads as something to take.

## 3. Taken

The candles go out over 0.25 s with a thread of ink smoke; the empty altar stays (I10). Sound
`sfx.altar.out`.

## 4. Never

- The candles are the only light; their flames sway, never flicker.
- An altar is never drawn with outlined tiles: it is masonry.
