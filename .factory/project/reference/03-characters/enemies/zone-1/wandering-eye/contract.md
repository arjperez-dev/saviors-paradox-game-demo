# Wandering Eye — character contract

- **Status:** approved 2026-10-01 (E1–E8 approved as the sandbox does them)
- **Kind:** enemy (zone 1, the Suspended Sanctuary)
- **Sandbox:** the zone 1 sandbox, [`../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`](../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html):
  *Ir a… combate*, then *Enemigo* until it reads *ojo errante*; `N` makes it fire ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 1 enemies: *floating eye firing a slow beam*),
  §Mechanics (block, chain blades, hit feedback) · `00-game/pillars.md` (blocking a projectile at the
  last moment sends it back at its thrower) · `00-game/controls.md` (G16) · `02-art-direction/ART_DIRECTION.md` §5 ·
  the operator's decisions of 2026-10-01 (it throws a fast stone of ink, not a beam; it can be blocked or
  sent back; reached with the chain, jumps and its own stone)
- **Built on:** its own shape (an eye between stone lids; no skeleton)
- **Code name:** `wanderingEye` · **Español:** ojo errante

Every gameplay number is the sandbox's and is marked **the game decides**. The proposals E1–E8 (§12)
were approved by the operator on 2026-10-01.

## 1. Identity

One of the sanctuary's watchers: a pale painted eye between two stone lids, set in a stone ring,
trailing threads of ink, floating high above the floor. It keeps its distance, opens wide, marks
where it will fire with a thin line and throws a stone of ink at Akeris. At a
glance a player reads: out of reach, watching me, about to fire. Jump at it, hook it, or send its
own stone back.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| eye | radius 30, the stone ring ≈ 36 | Akeris = 192 |
| ink threads | five, 24–46 long, hanging | they sway slowly |
| hover height | ≈ 380 above its floor (±10, slow bob) | the height of Akeris's chest at the top of a jump |
| fallen height | 80 (knee high) | where everything reaches it |

**Silhouette test:** a circle with a darker ring and hanging threads, high in the air; it can never
be read as a rock or a lamp: the lids and the pupil are always there.

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| outline | `ink` | 2.2–2.4 | — |
| eye white | `paperLight` `#efe6d6` | — | — |
| iris and pupil | `ink` at .25, `ink` | 1.6 | — |
| lids | `#b8ae9b` (the floating stones') | 1.6 | `ink` at .28, gap 3.4 |
| ring | `rock` `#a39a8a` | 1.4 | — |
| threads | `ink` at .75 | 1.4–2.4 | — |
| the ink stone | `ink` at .95, radius 17, a `paperLight` vein; three fading copies behind it | 1.6 | — |
| the aim line | `ink`, dashed, from .25 to .8 alpha as it locks | 1.2 → 2.6 | — |

No new colour and no glow: the stone is ink.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| drift | spawn, rise, the stone's end | — | yes | aim | lids half closed (`drift`), the pupil follows Akeris, slow bob |
| aim (the telegraph) | drift, after its pause | 0.75 | no | fire | the lids open wide (`aim`); a dashed line toward Akeris's chest that darkens; it follows him and locks 0.15 s before firing |
| fire | aim | until the stone lands | no | drift | lids wide; the stone flies |
| fall | a hit that lands, its stone sent back, freeze | 0.25, dropping | no | down | lids close (`closed`) |
| down | fall | 1.3, at knee height; graphite stars | no | rise | `closed` |
| stun | the fast descent beside it while down | 1.2; graphite stars | no | rise | `closed` |
| rise | down, stun | 0.5 | no | drift | — |
| death | its last health | the ink smoke's | no | — | `fx/ink-smoke` |

### the ink stone

`sprites/sheet-attack.png`. The stone leaves the eye's rim along the locked line at 820 su/s (the game
decides), turning as it flies, with three fading copies behind it, for up to 1100 su. When it meets
stone or a shield it bursts into ink; when it meets Akeris, §8. Sent back (`sheet-reflect.png`), it
flies back along the same line at 1200 su/s with speed lines, and when it reaches the eye the eye is
hit and falls.

## 5. Weapons and gear

None: the ink stone is its weapon.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| aim line | aim | §3 | 0.75 |
| ink stone | fire | §3, §4 | — |
| splash | the stone meets stone, a shield or Akeris | six ink puffs | 0.5–0.7 |
| reflect | a just block | the shield's ring and sparks, `WHOOSH!` (`fx/reflect`) | 0.26 |
| stars | down, stun | three graphite stars on a ring above it (as the other enemies') | the state's |
| hit feedback, freeze, burn, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.wanderingEye.aim` | aim starts: the telegraph | `07-audio/sfx/sfx.md` |
| `sfx.wanderingEye.fire` | the stone leaves the eye | `07-audio/sfx/sfx.md` |
| `sfx.wanderingEye.splash` | the stone bursts on stone | `07-audio/sfx/sfx.md` |
| `sfx.wanderingEye.fall` | it lands at knee height after a fall; ×0.7 when stunned | `07-audio/sfx/sfx.md` |
| `sfx.fx.reflect` | a just block sends the stone back | `07-audio/sfx/sfx.md` (existing) |
| shield sounds, `sfx.akeris.hurt` | the stone on a shield; on Akeris | `07-audio/sfx/sfx.md` (existing) |
| `sfx.fx.inkSmoke` | death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 10 marks) | — |
| damage of the stone | the game decides (sandbox: the HUD's test hit) | — |
| damage of the stone sent back | the game decides (sandbox: 3 marks, as a reflected stone) | `00-game/pillars.md` |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| sight | the game decides (sandbox: 1000 su across, 420 up or down) | — |
| hit radius | 52 su around the eye | the sandbox |

**Behaviour:**

1. **Drift (E2).** It floats about 380 su above its floor, keeps about 380 su from Akeris on its side
   and drifts slowly (80 su/s). It never leaves its room. No contact damage.
2. **Fire (E3).** After its pause (1.6 s) it aims for 0.75 s (the telegraph: the lids open, the line
   darkens and locks 0.15 s before) and throws the ink stone (§4).
3. **Answering the stone (E4):** step or jump out of its line; the roll's invulnerability passes through
   it; **the shield stops it** (the ice shield spends a use); **the just block with any shield sends it
   back**: it returns to the eye, hits it (3 marks) and makes it fall; sent back by
   the ice or fire shield it also freezes or burns the eye for 0.5 s (G16).
4. **Reaching it (E5).** From the floor no strike reaches it while it floats. A jumping strike reaches
   it through most of a normal jump; the chain blades reach it (strike, and pull with a second click);
   its stone sent back reaches it.
5. **Hit, it falls (E6).** Every hit that lands makes it fall to knee height for 1.3 s (then 0.5 s to
   rise): there every strike reaches it. The fast descent beside it while it is down stuns it 1.2 s.
6. **Defeated, it stays defeated** for the rest of the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles: the bob, the threads and the stone move smoothly; nothing boils.
- The stone is ink, never light or colour.
- It never fires without the aim line, and the line never moves in the last 0.15 s.
- It never touches the floor while it is alive and unhurt; it never leaves its room.
- It never comes back once defeated.

## 10. Acceptance

1. Floating, it matches `drift` of `sprites/sheet.png`, the pupil following Akeris.
2. Its attack plays as `sprites/sheet-attack.png`, with the aim sound first and the fire sound as the stone leaves.
3. Jumping over the stone leaves Akeris unhurt (`sheet-jump.png`).
4. The shield stops the stone (`sheet-block.png`); the just block sends it back and the eye falls (`sheet-reflect.png`).
5. A jumping strike makes it fall and, down, every strike reaches it (`sheet-reach.png`); from the floor no strike reaches it while it floats.
6. The chain blades reach it (`captures/cadena.png`).
7. At its last health it dissolves (`sheet-death.png`), drops XP and coins, and never comes back.

## 11. Exports

From the zone 1 sandbox (`eyExportAll()`, the sounds with `eyExportSfx()`): `sprites/sheet.png`, four
single poses, six frame sheets and eleven screenshots in `captures/`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| E1 | Look | a pale painted eye between two stone lids in a stone ring, five hanging ink threads; no glow, no new colour |
| E2 | Drift | floats ≈ 380 su high (the height of Akeris's chest at the top of a jump), keeps ≈ 380 su away, drifts at 80 su/s |
| E3 | The ink stone | aims 0.75 s (dashed line that darkens and locks 0.15 s before), then throws a stone of ink at 820 su/s, up to 1100 su (operator, 2026-10-01: a stone, not a beam, and fast); pause 1.6 s |
| E4 | Answers | dodge it; the roll passes through; any shield stops it (ice spends a use); the just block with any shield sends it back to the eye (3 marks, it falls; ice or fire also freeze or burn 0.5 s) |
| E5 | Reaching it | nothing from the floor while it floats; jumping strikes through most of a jump; the chain blades; its stone sent back |
| E6 | Falling | every hit that lands drops it to knee height (80 su) for 1.3 s, where every strike reaches it; the fast descent then stuns it 1.2 s |
| E7 | Hit radius | 52 su around the eye |
| E8 | Sound | aim (the telegraph), the throw, the splash, the fall |
