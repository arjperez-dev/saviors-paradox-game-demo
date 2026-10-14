# Akeris — the ice shield

- **Status:** approved 2026-09-30 (step 3.5). The rules come unchanged from `../animations.md` version 1 §6,
  approved 2026-09-30, with G16 of `../../../00-game/controls.md`; §4 is new.
- **Images:** [`ice-shield.png`](ice-shield.png) (the shield alone, facing out) ·
  [`ice-shield-sheet.png`](ice-shield-sheet.png) (lowered, raised, taking a hit, with the hook
  blades, and on the free hand while hanging, lowered and raised)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`SHIELD_PTS`, `drawShield`, `hitPlayer`,
  `dummyStep`, `reflectShot`); `X` changes the shield
- **The item** (uses, where it is found, inventory icon, upgrades, repair): [`../../../05-items/shields/ice-shield/ice-shield.md`](../../../05-items/shields/ice-shield/ice-shield.md)

## 1. Look

A crystalline polygon (`ice` `#c3dbe4`, outline 2.1) with blue facet lines from a point near its centre to every corner, and a white highlight on its upper left.

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
| blocked | hitstop 0.05 s, the `blockHit` push (260), sparks in the shield's colour and the `crish` callout |
| blocked, melee | a **perfect** block **freezes** the attacker 1.5 s; a normal block only stops the hit (G16, revised 2026-09-30) and lowers its defence while frozen (`../../../02-art-direction/fx/freeze/freeze.md`); no counter |
| blocked just before a projectile hits | the projectile flies back, damages its thrower and freezes it 0.5 s (`../../../02-art-direction/fx/reflect/reflect.md`) |
| the last use is spent | `crack`, shards, and he is staggered (`hurt`) |
| an attack it cannot stop | the `hurt` pose and knockback, with `thud`, `burn` or `frost` |

**It stops:** physical attacks and ice attacks (the only shield that stops ice without damage). Not fire. **Uses:** 10 blocks, melee or projectile; the last one breaks it. They are not refilled on entering a zone: they are bought back with XP, and a broken shield is repaired with XP and a curse (operator, 2026-09-30; `05-items/shields/ice-shield/`). **Broken,** it stays strapped to the forearm, drawn broken (a wedge missing, an ink crack, the face dulled in graphite), and cannot block (step 3.6, `05-items/items.md` I8).

## 4. Hanging from a ring (step 3.5)

The wheel can give the shield to the **free hand**, whichever hand that is: it is drawn on that
forearm, lowered (arm 100/84, edge-on) or raised (arm 25/−55, facing out) with right click held, and
it rises and falls at a rate of 24/s. A hit while hanging pushes the swing instead of the ground
push; he never lets go. Everything in §3 holds; with the sacred shield a perfect block against a
melee hit opens the **hanging counter** (`../animations.md` §5.7).
