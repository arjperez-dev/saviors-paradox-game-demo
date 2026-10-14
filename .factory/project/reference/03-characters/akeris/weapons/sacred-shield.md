# Akeris — the sacred shield

- **Status:** approved 2026-09-30 (step 3.5). The rules come unchanged from `../animations.md` version 1 §6,
  approved 2026-09-30, with G16 of `../../../00-game/controls.md`; §4 is new.
- **Images:** [`sacred-shield.png`](sacred-shield.png) (the shield alone, facing out) ·
  [`sacred-shield-sheet.png`](sacred-shield-sheet.png) (lowered, raised, taking a hit, with the hook
  blades, and on the free hand while hanging, lowered and raised)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`SHIELD_PTS`, `drawShield`, `hitPlayer`,
  `dummyStep`, `reflectShot`); `X` changes the shield
- **The item** (uses, where it is found, inventory icon, upgrades, repair): [`../../../05-items/shields/sacred-shield/sacred-shield.md`](../../../05-items/shields/sacred-shield/sacred-shield.md)

## 1. Look

A pale heater shield (`sacred` `#dcd5c3`, outline 2.2) with a gold double rim (the inner rim at 0.8 of the outline, 1.3 wide, `sacred (gold)`) and, when it faces out, a gold circle-cross sigil (a circle of radius 7 and a cross 38 × 24).

## 2. How he carries it

**Blocking is always a shield, never a weapon.** The shield is strapped to the back forearm, 60 % of
the way from the elbow to the hand, so the hand stays free. Lowered, it is drawn edge-on (22 % of its
width) beside the hip, 6 lower; raised, it faces out in front of the face and chest, 9 forward. The
pose's `sh` blends between the two. With the hook blades equipped, raising it sends the second blade
back to the belt. The equipped shield is changed only in the pause menu's inventory; there is no
drawing or sheathing animation.

## 3. What happens on a hit

| Case | What is drawn |
|---|---|
| blocked | hitstop 0.05 s, the `blockHit` push (260), sparks in the shield's colour and the `clang` callout |
| blocked, melee | **a perfect block opens the counter**, the only shield that does (`../../../02-art-direction/fx/counter/counter.md`); any other block pushes him back |
| blocked just before a projectile hits | the projectile flies back and damages its thrower (`../../../02-art-direction/fx/reflect/reflect.md`) |
| the last use is spent | `crack`, shards, and he is staggered (`hurt`) |
| an attack it cannot stop | the `hurt` pose and knockback, with `thud`, `burn` or `frost` |

**It stops:** physical attacks (melee and normal projectiles). Not fire, not ice: against those he takes the hit. **Uses:** unbreakable.

## 4. Hanging from a ring (step 3.5)

The wheel can give the shield to the **free hand**, whichever hand that is: it is drawn on that
forearm, lowered (arm 100/84, edge-on) or raised (arm 25/−55, facing out) with right click held, and
it rises and falls at a rate of 24/s. A hit while hanging pushes the swing instead of the ground
push; he never lets go. Everything in §3 holds; with the sacred shield a perfect block against a
melee hit opens the **hanging counter** (`../animations.md` §5.7).
