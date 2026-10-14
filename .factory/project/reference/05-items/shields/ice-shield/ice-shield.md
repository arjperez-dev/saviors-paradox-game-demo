# Ice shield

- **Status:** approved 2026-09-30 (step 3.6)
- **Kind:** shield (special)
- **Images:** [`icon.png`](icon.png) · [`icon-broken.png`](icon-broken.png) · on its altar: [`../../altar/altar-ice.png`](../../altar/altar-ice.png) · [`sheet-break.png`](sheet-break.png) · [`sheet-repair.png`](sheet-repair.png)
- **In his hands:** [`../../../03-characters/akeris/weapons/ice-shield.md`](../../../03-characters/akeris/weapons/ice-shield.md) (how he carries it, what a block does, how it breaks)
- **Sandbox:** [`../../sandbox/sandbox.html`](../../sandbox/sandbox.html): its altar; X equips it (a stand-in: in the game, only the pause menu); its repair button; scenarios `#roto`, `#reparar`, `#reparar2`
- **Sources:** `VISION.md` §Mechanics (Shields) · `00-game/controls.md` G16 · [`../../items.md`](../../items.md) §6 D-I2–D-I5, §7 I7, I8, I15

## 1. What it is

A crystalline shield. A perfect block against a melee hit freezes the attacker 1.5 s and lowers its defence (a normal block only stops it); a perfect block against a projectile reflects it and freezes its thrower 0.5 s; it is the only shield that stops ice attacks without damage; it never opens the counter (G16).

## 2. How he gets it

On a stone altar, in any zone, **once per run** (D-I2). G stores it; he equips it from the pause
menu's full inventory (`VISION.md`; I3). Lost on death.

## 3. Uses

**10 uses** (one per block, melee or projectile). **Not refilled on entering a zone** (D-I3). The last use breaks it.

## 4. Broken

- **On his arm:** it stays strapped to the forearm, drawn broken: a wedge missing from its upper
  right, an ink crack from the gap to the lower edge, the face dulled with graphite (`ink` at .3 and
  hatching). It **cannot block** (I8).
- **In both inventories:** [`icon-broken.png`](icon-broken.png): the same, and two loose shards
  (D-I5).

## 5. Restoring and repairing (full inventory)

| Its state | What the player does | Cost |
|---|---|---|
| whole, uses spent | **restore uses**: back to full at once | XP per missing use; the game decides (sandbox: 100) (I15) |
| broken | **repair**: pays and takes a **curse** — kill 10 enemies without taking damage; any damage kills Akeris. The shield is whole again, all uses back, when the tenth dies (D-I4) | more XP; the game decides (sandbox: 1500) |

Curses add up (D-I7): repairing it while another curse runs adds its 10 kills to the same count, and the shield is whole again only when the total is reached. The curse
looks like the cursed scroll's (`../../scrolls/scrolls.md` §4). Frames: [`../ice-shield/sheet-break.png`](../ice-shield/sheet-break.png)
(the last use, broken on the arm, the repair and its end), [`../ice-shield/sheet-repair.png`](../ice-shield/sheet-repair.png).

## 6. Sounds and text

`sfx.shield.break` (Akeris's), `sfx.shield.restore`, `sfx.shield.repaired`. Keys:
`item.iceShield.name` (Ice shield / Escudo de hielo), `item.shield.broken`, `item.shield.restore`, `item.shield.repair`,
`item.curse.progress` (`../../items.md` §9).

## 7. Acceptance

1. Each block, melee or projectile, spends a use; the quick inventory shows the uses left.
2. The last one breaks it with `crack`; he is staggered; it stays on his arm broken and cannot block.
3. Both inventories show `icon-broken.png`.
4. Restoring uses costs XP and needs no curse; repairing a broken one costs more and starts the curse;
   the tenth kill makes it whole; a hit during the curse kills him.
5. Entering a new zone does not refill it.
