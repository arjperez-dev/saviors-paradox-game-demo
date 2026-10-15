# Akeris — the chain blades (hook blades)

- **Status:** §7 approved 2026-10-13 (step 3.17, the balance enemy by enemy; the blades stay strong for now); approved 2026-10-06 (§6, the chain does not hold enemies still, C1–C3); approved 2026-09-30 before that (step 3.5). §1–§4 come unchanged from `../animations.md` version 1 §4–§5,
  approved 2026-09-30; §5 is new.
- **Images:** [`hook-blade.png`](hook-blade.png) (one blade alone) ·
  [`hook-blades-sheet.png`](hook-blades-sheet.png) (at the belt, drawn, one in each hand, shield up,
  throwing, on a ring, the free hand, the spin)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`HOOK`, `hookBlade`, `drawBackGear`,
  `chainFly`, `chainBack`, `updateChain`)
- **The item:** [`../../../05-items/weapons/chain-blades/chain-blades.md`](../../../05-items/weapons/chain-blades/chain-blades.md)

## 1. Look

A pair of hook blades, one in each hand, each on its own chain.

- **Blade:** a short blade runs straight for 40, then curls through a 210° arc of radius 13 into a
  hook whose tip points back at the handle. Its width tapers from 7.5 to 1, and a bright line marks
  the inner edge. Fill `hookBlade` `#d2cdc2`, hatched.
- **Handle:** 16 long, with a leather wrap (`leather` `#b9ad95`), a 14-wide guard and a ring pommel
  (radius 4.2) where the chain attaches.
- **Chain:** alternate links, one face-on (an ellipse 9.2 × 4.8) and one edge-on (a stroke 8.8),
  every 7 along a quadratic sag; 1.5 wide. Taut when hooked, sagging while it flies (`ten` 0.45 → 0.95).

## 2. Where they are

| Equipped | Front hand | Back hand | Elsewhere |
|---|---|---|---|
| sword | the sword | — (the shield is on its forearm) | both hook blades hang from the belt, joined by a short chain |
| hook blades | one hook blade | the other hook blade, except while the shield is up | the sword, sheathed on the back |
| hook blades, shield up | one hook blade | free (the second blade has gone back to the belt) | the sword on the back |
| drinking | the flask | — | both hook blades at the belt, the sword on the back |
| hanging, free hand with its blade | whichever hand holds the ring: its chain | the free hand: its hook blade | the sword on the back |
| hanging, free hand with the shield | the ring hand's chain | the free hand: the shield | one hook blade at the belt, the sword on the back |

**Drawing them** is the weapon swap (0.3 s): the front hand reaches **to the hip** (upper arm 112,
forearm 95, blade 100), and they are in the hands at the midpoint. See
[`../sprites/sheet-swap.png`](../sprites/sheet-swap.png).

## 3. Throwing (visual rules)

The two blades **alternate hands on every throw.** Each blade has its own chain drawn from its own
hand. A blade flies tip-first on a cubic ease-out (0.15–0.16 s), stays hooked, and comes back on a
quadratic ease-in (0.2 s), turning to the hand's angle.

- **Ranged strike:** aimed at the mouse (or straight ahead if it has not moved **in the last 4 s**, as
  the sandboxes' `mouseWorld` measures it; operator 2026-10-15), range 340. One
  blade flies while the other stays in hand. Since 2026-10-06 its hits never interrupt an enemy (§6, C1).
- **Ring:** caught from the ground (the ring above him) or **in mid-jump** (also level with him or a little below: up to 90 su under the shoulder), always within reach; if the mouse aims, the ring nearest the aim (G19; frames [`../sprites/sheet-jump-ring.png`](../sprites/sheet-jump-ring.png)). The hook passes over the ring and hangs down the far side; its grip sits 15 past the ring
  toward the throw and 37 below it. The body swings as a pendulum about the ring, reeling in to a
  length of 210, and A/D pump it. **Hand over hand:** the next ring is caught with the other hand,
  and once it hooks, the first blade lets go.
- **Wall to wall** (G20): in the air, a throw toward another wall within reach (toward the mouse, or ahead) bites into it at the aimed height; the chain pulls him across in 0.3 s, stretched toward it, and he hangs from the wall (`wallHang`). Frames [`../sprites/sheet-wall-to-wall.png`](../sprites/sheet-wall-to-wall.png).
- **Wall:** the hook bites into the stone, angled 25° up. Akeris climbs hanging from the chain with
  his feet walking up the wall, 250 per stretch. **The next stab uses the other hand, and the lower
  blade then pulls out.** Near the top, the hook catches over the edge, curled toward the wall, and
  he mantles up.
- **Letting go** (jump or drop) reels both chains in.
- **Callouts:** `chain` when a hook catches a ring and `clack` when it bites the wall, with sparks
  or chips (`../../../02-art-direction/fx/callouts/callouts.md`).

## 4. Counter

With the hook blades, the counter is a ranged burst, alternating hands
(`../../../02-art-direction/fx/counter/counter.md`).

## 5. New in step 3.5

| Use | How it looks | Frames |
|---|---|---|
| **bite** | a strike that hits an enemy stays in it 0.3 s, chain taut | [`../sprites/sheet-pull.png`](../sprites/sheet-pull.png) |
| **pull** | a click during the bite: the chain drags him to the enemy (0.22 s), then he strikes with the blade in hand | same |
| **overhead arc** | W + click: the front blade flies along a curve over his head to the floor 280 ahead (0.26 s), turned along the curve | [`../sprites/sheet-arc.png`](../sprites/sheet-arc.png) |
| **area spin** | click held: the front blade circles him on its chain (radius 150, flattened to 0.55, 13 rad/s) | [`../sprites/sheet-spin.png`](../sprites/sheet-spin.png) |
| **anchor** | S + click while levitating: straight down into the floor, where it bites (`clack`); the chain pulls him down | [`../sprites/sheet-levitate.png`](../sprites/sheet-levitate.png) |
| **free hand** | hanging: the free hand's blade thrown at the mouse (340, 0.15 s out, 0.2 s back); it strikes, snatches or hooks a boss part, never pulls, climbs or anchors | [`../sprites/sheet-hang.png`](../sprites/sheet-hang.png) |
| **hanging counter** | the free hand's blade out and back every 0.16 s | [`../sprites/sheet-hang-counter.png`](../sprites/sheet-hang-counter.png) |

The timing of each is `../animations.md` §5. **Snatching** an object (the knight's shield, the
skeleton's skull) is drawn as a strike whose blade comes back carrying the object; how the object
looks is in that enemy's contract.

## 6. The chain does not hold enemies still (operator, 2026-10-06)

The operator: the blades «mantienen al enemigo quieto en un sitio y puedes atacarlo de manera seguida… pasaba lo mismo
con todos los bosses». A first fix that slowed the ranged strike was rejected («no me gustó la forma en la que nerfeaste
las espadas gancho»): **they attack at range exactly as before** (reach 340, the alternating hands, the bite and pull,
the overhead arc, the area spin and their damage). What changes is that **they never immobilize**, and that **bosses get
annoyed** («deberían hacer que los bosses se molesten y te lancen una ráfaga sonora que te aleja»):

| # | Rule |
|---|---|
| C1 | The strike, the arc and the spin take their usual damage but **never interrupt an enemy nor push it back**: it goes on with its attack. (The pull's blow, the sword's, interrupts as before.) |
| C2 | **The chain's own reactions** (snatching the knight's shield or the gravedigger's spade, pulling the archer, yanking the wraith or the gravedigger out, cutting the mantis's telegraph, the ossuary's arms) happen **at most once every 5 s per enemy**; between them the strike only takes its damage. Freeing Akeris from a strangler vine always works. |
| C3 | **Bosses get annoyed:** after **four chain hits in a row** (with no 5 s pause between them) the boss lets out **a sound blast** (0.4 s telegraph: rings closing on it, a hiss) that **pushes Akeris ≈ 300 su away, without damage**, retracting his chains (if he hangs from a vine, it drops him). No shield stops it; **rolling passes it**. It never comes inside an untouchable moment (the spider's cocoon). |

Measured in the zone 4 sandbox (`balanceReport()`): no enemy held still longer than 1.4 s by the chain (before, the strike
locked them in a loop); the chain still does its old damage at range. The Giant Spider's blast is her contract's GA19. Each
boss of zones 1–3 and 5 will have its own blast (the golem, the bat, the skeleton, the dragon) when the game implements
the weapons; the sandboxes of zones 1–3 keep the weapon as it was approved (`_plan/PLAN.md`, 2026-10-06).

## 7. The balance, enemy by enemy (operator, 2026-10-13; step 3.17, *approved*)

**Operator's decision (2026-10-13):** keep the blades as they are and accept that they are strong; the heavies' lunges stay
(«Lo de las embestidas me gusta»). Later the game may rebalance them or make them **the weakest weapon** (least damage), mostly
for climbing and moving, their defined utility moves (snatching shields, knocking down the defined enemies) and anchoring to the
floor.

Against the zone 5 heavies the blades won far sooner than the other weapons (Akeris hits from range with no risk). Slowing the ranged
strike stays rejected. Approved HB1–HB4; measured and built as [`hook-blades-balance.md`](hook-blades-balance.md) says:

| # | Rule |
|---|---|
| HB1 | **Measure first:** every enemy of the five zones × each weapon, with one duelist bot for all weapons (20 runs each). Only an enemy the blades kill in **< 60 %** of the other weapons' mean time changes. Flagged: the elite shield knight, the fire mace brute and the gargoyle (heavies), and the eye, the archer, the gravedigger, the wraith, the mantis, the strangler vine and the drakeling (light, ranged or special: proposals only). |
| HB2 | **Heavies close the distance:** after **two chain hits in a row from range** (> 200 su; no 5 s pause), the heavy answers with **its own lunge** toward Akeris — the elite knight's long bash (shieldless, a running thrust), the fire brute's charge, the gargoyle's pounce (in the air, its dive at once): a clear warning seen and heard, **the roll always dodges it**, at most once every 5 s, never in an untouchable moment. |
| HB3 | **Shields stop the chain from the front:** while a shield knight (zone 1 or elite) holds its shield up, a frontal chain strike goes `¡CLANG!` and takes nothing (its 5 s reaction — snatch, or yank then snatch — as before); from above (the overhead arc), from behind or once the shield is gone, it lands. |
| HB4 | **Unchanged:** the reach (340), the rhythm, the damage, the arc, the spin, the pull, and C1–C3. |

Measured after HB2: the lunges are rolled and the three heavies stay under 60 % (elite knight 43 %, fire brute 34 %, gargoyle 36 %).
The operator decides between the proposals P1–P4 of `hook-blades-balance.md` §5.
