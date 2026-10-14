# Drops: XP and coins

- **Status:** approved 2026-09-30 (step 3.6)
- **Kind:** currency
- **Images:** [`icon-xp.png`](icon-xp.png) · [`icon-coin.png`](icon-coin.png) · [`sheet-drops.png`](sheet-drops.png)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html): the dummy drops them when it dissolves (V, or out of health); scenarios `#botin`, `#botin2`
- **Sources:** `VISION.md` §Mechanics (XP and upgrades, Coins) · `02-art-direction/fx/ink-smoke/ink-smoke.md` · [`../items.md`](../items.md) I9

## 1. XP

Enemies drop XP by type (how much is an open question of `VISION.md`). It is spent in the full
inventory on weapon and shield upgrades and on restoring and repairing shields.

- **Look:** a **pale ink mote**, radius 4.6 su: `paperLight` fill, `ink` outline 1.3 and an ink core
  (radius 1.4), so it reads against the dark ink smoke and the stone. The cursed scroll's runes are
  the same mote inverted: ink with a paper core.
- **Motion:** the motes rise from the enemy's body as its ink smoke starts (0.35 s after, one every
  0.05 s), hesitate, then fly into Akeris's chest faster and faster (up to 900 su/s) and vanish. He
  never has to fetch them.

## 2. Coins

Enemies drop coins; they are lost on death; the shop is locked in the demo (`VISION.md`).

- **Look:** a coin of radius 8 su in the sacred shield's gold (`#c4a048`, I16), `ink` outline 1.3,
  stamped with the hourglass of the Time Chamber in dark gold.
- **Motion:** they pop out of the body, spin while they fly (drawn narrower as they turn), bounce
  twice and **lie flat** on the floor (a thin ellipse). Walking within 90 su pulls them to him and
  takes them.

## 3. Sounds and text

`sfx.xp.absorb`, `sfx.coin.drop`, `sfx.coin.take`. `item.xp.name`, `item.coin.name`.

## 4. Acceptance

1. A defeated enemy's motes fly into him by themselves; the XP counter rises.
2. Its coins bounce and lie flat; passing over them takes them.
3. Death empties the coins.
