# Akeris — the fire shield

- **Status:** approved 2026-09-30 (step 3.5). The rules come unchanged from `../animations.md` version 1 §6,
  approved 2026-09-30, with G16 of `../../../00-game/controls.md`; §4 is new.
- **Images:** [`fire-shield.png`](fire-shield.png) (the shield alone, facing out) ·
  [`fire-shield-sheet.png`](fire-shield-sheet.png) (lowered, raised, taking a hit, with the hook
  blades, and on the free hand while hanging, lowered and raised)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (`SHIELD_PTS`, `drawShield`, `hitPlayer`,
  `dummyStep`, `reflectShot`); `X` changes the shield
- **The item** (uses, where it is found, inventory icon, upgrades, repair): [`../../../05-items/shields/fire-shield/fire-shield.md`](../../../05-items/shields/fire-shield/fire-shield.md)

## 1. Look

Round dark iron (`fire (iron)` `#5d4637`, 18 sides, radius 25, outline 2.2), an inner ring at 0.8, 6 rivets, and, when it faces out, an orange flame emblem (`fire` `#e0782c`) with a yellow heart (`fire (emblem)` `#ffd166`).

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
| blocked | hitstop 0.05 s, the `blockHit` push (260), sparks in the shield's colour and the `fwoom` callout |
| blocked, melee | a **perfect** block **burns** the attacker 1.5 s; a normal block only stops the hit (G16, revised 2026-09-30), losing health (`../../../02-art-direction/fx/burn/burn.md`); no counter |
| blocked just before a projectile hits | the projectile flies back, damages its thrower and burns it 0.5 s (`../../../02-art-direction/fx/reflect/reflect.md`) |
| the last use is spent | `crack`, shards, and he is staggered (`hurt`) |
| an attack it cannot stop | the `hurt` pose and knockback, with `thud`, `burn` or `frost` |

**It stops:** physical attacks and fire attacks (the only shield that stops fire without damage; each fire hit spends a use). Not ice. **Uses:** 4 uses against fire (`VISION.md`: 4 dragon blasts); the last one breaks it. They are not refilled on entering a zone: they are bought back with XP, and a broken shield is repaired with XP and a curse (operator, 2026-09-30; `05-items/shields/fire-shield/`). **Broken,** it stays on the forearm drawn broken and cannot block (step 3.6, `05-items/items.md` I8).

## 4. Hanging from a ring (step 3.5)

The wheel can give the shield to the **free hand**, whichever hand that is: it is drawn on that
forearm, lowered (arm 100/84, edge-on) or raised (arm 25/−55, facing out) with right click held, and
it rises and falls at a rate of 24/s. A hit while hanging pushes the swing instead of the ground
push; he never lets go. Everything in §3 holds; with the sacred shield a perfect block against a
melee hit opens the **hanging counter** (`../animations.md` §5.7).
