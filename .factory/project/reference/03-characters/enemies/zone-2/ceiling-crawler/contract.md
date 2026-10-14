# Ceiling Crawler — character contract

- **Status:** approved 2026-10-01 (CC1–CC9 approved as the sandbox does them)
- **Kind:** enemy (zone 2, the Echo Caverns)
- **Sandbox:** the zone 2 sandbox, [`../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html`](../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html):
  *Ir a… combate* (the default enemy); `N` makes it drop · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 2: *Ceiling Crawler — drops on Akeris*) · `04-zones/zone-2-echo-caverns/biome.md`
  (darkness, grit) · `00-game/controls.md` (G16) · the operator's decision of 2026-10-01 (the proposal as made: it follows
  Akeris along the roof, given away by falling grit and the rustle of its legs; it lets itself down for 0.5 s and falls; dodge
  or shield; 1.2 s on its back; on the roof only the chain reaches it; a pale eyeless cave centipede)
- **Built on:** its own shape (a segmented body, no skeleton)
- **Code name:** `ceilingCrawler` · **Español:** reptador del techo

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals CC1–CC9 (§12) were approved by the operator on 2026-10-01.

## 1. Identity

A long, flat, pale cave centipede with no eyes, pincer jaws and long feelers. It clings to the roof and follows Akeris from
above. In the dark it is not seen; it is heard and given away by the grit that trickles from the roof under it. A player
reads: grit falling, a rustle overhead — something is above me; it lets itself down on a thread — move.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| body | ≈ 118 long, 22 wide; ten segments | Akeris = 192 |
| legs | a pair per segment on each side, ≈ 25 long, jointed | they ripple in a wave |
| head | flat, no eyes; pincer jaws; feelers ≈ 36 | the jaws open in the drop |
| thread | thin `ink` line from the roof | while it hangs, falls and climbs back |

**Silhouette test:** a segmented line bristling with legs; hanging, a vertical bristle with pincers at the bottom. Never a
snake (legs) and never a spider (long and segmented).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| body | `#c4bba8` (pale, between `stone` and `bone`) | 1.6 per segment, a seam line | `ink` at .3, gap 2.8; a `paperLight` sheen |
| legs, jaws, feelers | `ink` | legs 1.5–1.0, jaws 2.4–2, feelers 1–.8 | — |
| thread | `ink` at .85 | 1.1 | — |

No new colour and no glow.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| ceiling | spawn, climb | — | yes | hang | `ceiling`: along the roof, legs up, rippling as it follows; grit falls under it every 0.45 s (`sheet-ceiling.png`) |
| hang (the telegraph) | ceiling, right above Akeris | 0.35 | no | fall | it lets itself down 46 su on its thread, turns head down, curls and opens its jaws (`hang`), with a hiss |
| fall | hang; the chain | until the floor | no | down | `fall`: head down, falling fast (`sheet-drop.png`) |
| down (the opening) | fall | 1.2; 1.8 after a shield (2.4 after a just block), 1.6 after the chain | no | flip | `down`: on its back, legs flailing; graphite stars when stunned (`sheet-block.png`, `sheet-chain.png`) |
| flip | down | 0.3 | no | climb | rights itself and turns head up |
| climb | flip | until the roof (320 su/s) | no | ceiling | `climb`: up its thread (`sheet-strike.png`) |
| death | its last health | the ink smoke's | no | — | `fx/ink-smoke` (`sheet-death.png`) |

## 5. Weapons and gear

None: its jaws.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| grit | ceiling, while it sees Akeris | four specks of grit falling from the roof under it (the zone's stalactite grit) | 0.7 each |
| thread | hang, fall, down, climb | the `ink` line to the roof | the states' |
| dust | landing | `spawnDust` | — |
| stars, hit feedback, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.ceilingCrawler.skitter` | every 0.7 s on the roof while it sees Akeris | `07-audio/sfx/sfx.md` |
| `sfx.ceilingCrawler.hiss` | it lets itself down (the telegraph) | `07-audio/sfx/sfx.md` |
| `sfx.ceilingCrawler.drop` | it falls | `07-audio/sfx/sfx.md` |
| `sfx.ceilingCrawler.land` | it hits the floor or a shield | `07-audio/sfx/sfx.md` |
| shield sounds, hits, `sfx.fx.inkSmoke` | blocks, hits, death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 5) | — |
| bite (landing on Akeris) | the game decides (sandbox: the HUD's test hit) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 52 su; on its back, strikes along its legs count down to the floor | the sandbox |

**Behaviour:**

1. **On the roof (CC2).** It clings to the roof and, while it sees Akeris (1100 su across, his level), follows him from
   above at up to 280 su/s **along any roof there is**, from room to room: it steps down and up with the roof (the rock over
   a passage, a dome), and stops only where there is no roof over a floor or water (operator, 2026-10-01). **It never jumps**
   (operator, 2026-10-01): at a step in the roof it stops, turns smoothly to vertical and climbs down or up the rock face at
   420 su/s; small bumps it follows walking; to turn round it curls and turns over 0.35 s, and it only turns when it
   really moves the other way. Grit falls under it and its legs rustle.
2. **The drop (CC3).** When it is right above him (40 su) and he is on the floor at least 260 su below, it lets itself down on
   its thread for **0.35 s** (the telegraph, with a hiss) and falls head first, fast (operator, 2026-10-01: a faster attack).
   Then it waits 0.6 s before it can drop again.
3. **Answers (CC4).** Step aside, or roll (its invulnerability passes through). **With the shield raised** it bounces off and
   lands on its back, stunned 1.8 s (2.4 with a just block; ice or fire also freeze or burn it, G16). If it lands on Akeris,
   it bites (the hurt) and lands beside him.
4. **The opening (CC5).** On its back for 1.2 s, legs in the air: every strike reaches it. Then it rights itself and climbs its
   thread back to the roof.
5. **On the roof only the chain (CC6).** Strikes cannot reach the roof; a chain blade thrown at it (jumping, the roof is high)
   hurts it and pulls it down: it falls and lies stunned 1.6 s.
6. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles: the legs ripple smoothly, the strokes never change.
- No snap: it never changes height, side or heading in one frame (at most ≈ 5 su and ≈ 9° a frame).
- It never drops without its 0.35 s telegraph and hiss, and never off to the side of Akeris.
- It never stays on the roof or the floor when defeated: it dissolves in ink smoke where its body is.
- It never walks on the floor to chase him: it climbs back to the roof.
- It never comes back once defeated.

## 10. Acceptance

1. On the roof it follows Akeris and grit falls under it (`sheet-ceiling.png`).
2. Right above him it hangs 0.35 s with its hiss and falls (`sheet-drop.png`); standing still, it bites.
3a. It follows him from room to room along the roof.
3. Rolling or stepping aside, it misses and lies on its back (`sheet-dodge.png`); with the shield raised it bounces and lies stunned (`sheet-block.png`).
4. On its back every strike reaches it; after 1.2 s it climbs its thread (`sheet-strike.png`).
5. On the roof only the chain reaches it, and it falls stunned (`sheet-chain.png`).
6. At its last health it dissolves (`sheet-death.png`) and never comes back.

## 11. Exports

From the zone 2 sandbox (`crExportAll()`, the sounds with `crExportSfx()`): `sprites/sheet.png`, five single poses, seven
frame sheets (`ceiling`, `drop`, `dodge`, `block`, `chain`, `strike`, `death`) and eleven screenshots in `captures/`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| CC1 | Look | a pale eyeless cave centipede, ten segments, jointed legs on both sides, pincer jaws, long feelers; no new colour |
| CC2 | On the roof | follows Akeris from above at up to 280 su/s along any roof, room to room (operator); grit every 0.45 s and a rustle every 0.7 s give it away |
| CC3 | The drop | right above him (40 su) and he at least 260 su below: hangs 0.35 s on its thread with a hiss, falls head first, fast (operator); 0.6 s before another |
| CC4 | Answers | step aside or roll; the raised shield bounces it (stunned 1.8 s, 2.4 with a just block); landing on him, it bites |
| CC5 | The opening | 1.2 s on its back, every strike reaches it; then it climbs its thread back |
| CC6 | The chain | the only reach on the roof: it hurts it and pulls it down, stunned 1.6 s |
| CC7 | Health | 5 (the game decides) |
| CC8 | Sound | skitter, hiss (the telegraph), drop, landing; through the zone's echo |
| CC9 | Where | in combat rooms and under high roofs (the tunnel's dome), over the foe spot |
