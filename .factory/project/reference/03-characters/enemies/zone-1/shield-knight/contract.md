# Shield Knight — character contract

- **Status:** approved 2026-10-01 (K1–K9 approved as the sandbox does them)
- **Kind:** enemy (zone 1, the Suspended Sanctuary)
- **Sandbox:** the zone 1 sandbox, [`../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`](../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html):
  the knight stands in the combat room (*Ir a… combate*); *Enemigo* switches it with the training
  dummy; `N` makes it attack · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 1 enemies: *sword and eye-shield that blocks frontal
  attacks; shield snatched with the chain*), §Mechanics (counter, chain blades, fast descent, status
  effects, hit feedback) · `02-art-direction/ART_DIRECTION.md` §5 · `00-game/controls.md` (G16) ·
  `00-game/pillars.md` (combat is a duel; the chain takes enemies apart) · `00-game/glossary.md` §7
- **Built on:** Akeris's skeleton, poses and crossfade at 1.12× (`ART_DIRECTION.md` §5), with its own
  head (a closed helm) and no cape
- **Code name:** `shieldKnight` · **Español:** caballero con escudo

Every gameplay number below is the sandbox's and is marked **the game decides**: the sandbox only
shows the shape and the order. The proposals K1–K9 (§12) were approved by the operator on 2026-10-01.

## 1. Identity

One of the sanctuary's keepers, still on guard. It walks forward behind a tall stone shield with a
painted eye that **follows Akeris**, its sword pointing at him over the rim. At a glance a player
reads a dark armoured figure, taller than Akeris, a pale shield in front of it and a clock on its
tabard: the front is closed; the way in is around it, over it, through its shield (the chain) or
through the moment after it swings. Patient and heavy, never fast, never comic.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| standing height | ≈ 215 (helm top ≈ 228) | Akeris = 192; his rig at 1.12× |
| width at the widest point | ≈ 80 in guard | shield in front, sword arm behind it |
| head | a closed helm ≈ 29 × 38 | iron, eye slit, three breathing holes, a gorget line |
| shield | ≈ 56 × 92 | heater shape, stone face, iron rim; worn on the back forearm like Akeris's |
| sword | ≈ 124 (blade 102) | iron blade, black grip, iron pommel |
| body | Akeris's limbs | iron plate on the torso, two faulds, a paper tabard to mid-thigh; cuisses, knee cops, greaves and sabatons on the legs; vambraces and gauntlets on the arms; a pauldron |

**Silhouette test:** filled black at 26 % of the screen height, it reads as a squared helm, a broad
plate, a tall shield shape in front and a long blade over it; shieldless, a two-handed swordsman.
It is never mistaken for Akeris: no round head, no cape, no streak.

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| outline | `ink` `#1a1715` | Akeris's widths × 1.12 (`strokes/strokes.md` §2, A1) | — |
| helm, plate, faulds, leg and arm pieces, pauldron | `iron` `#5a554e` | 1.3–2.6 | `rgba(8,6,5,.28–.3)`, gap 3.2–3.4 |
| light edges on the iron | `rgba(210,205,194,.65)` (the hammer's bands, step 3.6) | 1–1.2 | — |
| sword blade | `iron` | 1.8 | `rgba(8,6,5,.3)`, gap 3.4 |
| grip and wrap | `ink`, `leather` `#b9ad95` | 5 / 1.2 | — |
| tabard | `paper` | 1.7 | `ink` at .3, gap 3.6 |
| clock emblem (one hand) | `paper`, `ink` | 1.3 | — |
| shield face | `stone` `rgb(200,192,179)` | — | `ink` at .16 on its lower half |
| shield rim | `iron` 4.2 under `ink` 1.9 | — | — |
| painted eye | `paperLight` `#efe6d6` white, `ink` iris (.22 fill) and pupil, five lashes and a painted tear | 1.2–1.8 | — |

Only colours of `02-art-direction/palette/palette.md`; no new colour. No accent: the knight is iron
and stone (K1).

## 4. Animations

A closed list. The game logic chooses the state; this table says how each state is drawn.

| Animation | Entered from | Duration (s) | Loops | Exits to | Key poses (`sprites/`) |
|---|---|---|---|---|---|
| guard | spawn, every state's end | — | yes (breathing) | walk, attack, turn | `guard` |
| walk | guard, Akeris farther than ≈ 180 su | the gait follows the distance moved | yes | guard | `walk-1`, `walk-2` (Akeris's gait, arms kept in guard) |
| turn | guard, Akeris behind it for 0.5 s | crossfade 0.16 | no | guard | `guard`, mirrored |
| attack: raise | guard, Akeris within reach | the logic's; default 0.55 (0.42 shieldless) | no | attack: cut | `wind` / `bare-wind` |
| attack: cut | raise | default 0.07 to the hit, held to 0.92 (0.76) | no | attack: recover | `cut` / `bare-cut` |
| attack: recover | cut | default to 1.30 (0.98) | no | guard | `recover` (cut → guard; the shield comes back last) |
| blocked | a hit on its shield | 0.24 | no | guard | `blocked` |
| hurt | a hit that lands | 0.32 | no | guard | `hurt` |
| stagger | a counter starts on it | 1.30 | no | guard | `stagger`, swaying |
| stun | Akeris's fast descent lands beside it | 1.20 | no | guard | `stagger`, the head rolling; graphite stars (§6) |
| snatched | the chain tears its shield away | 0.60 | no | guard (shieldless) | `snatched` → `bare-guard` |
| frozen | `fx/freeze` | the effect's | — | guard | the pose it had, held |
| death | its last health | the ink smoke's | no | — | the pose it had, filling with ink (`fx/ink-smoke`) |

**Blending:** crossfade 0.08–0.16 s between states; the hit reactions (blocked, hurt, stagger, stun,
snatched) cut in at 0.04–0.06 s so the blow reads at once.

**Timing rule:** a timed animation is stretched to the duration the game logic gives it; the times
above are the shape and the default, never a gameplay number.

### attack

`sprites/sheet-attack.png`. From guard the sword rises behind the helm while the shield still covers
(0 → raise end, eased in): **this is the telegraph**, seen and heard (`sfx.shieldKnight.raise`). The
blade snaps down to the cut (ease out, the hit on its first frames), the shield swings low and aside
(`sh` 0.25), the body lunges (feet 56 / −44, hips 62). It holds the cut, then recovers to guard; the
shield returns last. Shieldless, the same three keys with both hands on the grip, shorter.

### snatched

`sprites/sheet-snatch.png`. The shield leaves the forearm toward Akeris; the arm follows it out
(`bU` −6) and the body is pulled forward, then settles into the two-handed guard.

## 5. Weapons and gear

| Item | Where it sits | How it moves | When it changes | Detail |
|---|---|---|---|---|
| sword | front hand | with the arm; never sheathed | two-handed once the shield is gone | `weapons/knight-sword.png`, `weapons/knight-sword-sheet.png` |
| eye-shield | back forearm, like Akeris's | with the arm: front-on in guard, aside in the cut, hanging in stagger | torn away by the chain; then it flies, lands, lies flat and dissolves | `weapons/eye-shield.png`, `weapons/eye-shield-sheet.png` |
| the painted eye | on the shield | its pupil follows Akeris across the eye (±5 su) | never blinks | §3 |
| helm, plate, tabard | on the body | rigid, with the rig; the tabard hangs | never | §2 |

Neither the sword nor the shield is an item: Akeris cannot pick them up. There is no `05-items/` entry.

## 6. Effects

| Effect | Trigger (game event) | Look | Duration (s) |
|---|---|---|---|
| shield block | a hit on its shield | ink sparks at the rim, `CLANG!` (`fx/callouts`) | 0.28 |
| snatch | the chain tears the shield | ink sparks, `CHAIN!`; the shield flies in an arc | — |
| loose shield | it rests on the floor | lies flat for 1.2 s, then nine ink puffs and it fades | 0.9 |
| stun stars | stun | three graphite four-point stars circling a thin ring above the helm (graphite: no colour) | the stun's |
| hit feedback, freeze, burn, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.shieldKnight.step` | each foot contact while it walks | `07-audio/sfx/sfx.md` |
| `sfx.shieldKnight.raise` | the attack starts: the telegraph | `07-audio/sfx/sfx.md` |
| `sfx.shieldKnight.swing` | the cut, 0.03 s before the raise ends | `07-audio/sfx/sfx.md` |
| `sfx.hit.clang` | a hit on its shield | `07-audio/sfx/sfx.md` (existing) |
| `sfx.hit.blade`, `sfx.hit.blunt` | a hit that lands | `07-audio/sfx/sfx.md` (existing) |
| `sfx.shieldKnight.snatch` | the chain tears the shield | `07-audio/sfx/sfx.md` |
| `sfx.shieldKnight.shieldDrop` | the loose shield hits the floor | `07-audio/sfx/sfx.md` |
| `sfx.shieldKnight.stun` | stun starts | `07-audio/sfx/sfx.md` |
| `sfx.fx.inkSmoke` | death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (the sandbox shows 10 marks) | — |
| damage of the cut | the game decides (the sandbox uses the HUD's test hit) | — |
| XP and coins it drops | the game decides | `VISION.md` §Assumptions (open question) |
| scaling | its elite version is zone 5's Elite Shield Knight, a separate contract | `VISION.md` §Content scope |
| walk speed | the game decides (sandbox 110 su/s) | — |
| sight | the game decides (sandbox: 1000 su across, 260 su up or down) | — |
| reach of the cut | the game decides (sandbox 215 su) | — |
| hitbox | its body: from the floor to the helm top (≈ 228 su), ≈ 60 su wide | the sandbox |

**Behaviour:**

1. **Guard.** It stands on its island with its shield up. When it sees Akeris it faces him and walks
   forward in guard to about 180 su (K9). It never jumps, never leaves its island or room, and does no
   damage by touch (K8).
2. **Attack.** Within reach and after its pause it raises the sword (the telegraph, 0.55 s) and cuts
   (K6). The cut reaches only in front of it: behind it, Akeris is safe. The cut is blockable: a normal block stops it; a **just block with the sacred shield** opens
   the counter and the knight staggers for its length; with the ice or fire shield the just block
   freezes or burns it (G16). After the cut it holds and recovers with the shield aside: **open**.
   Then it pauses (1.0 s) before it can attack again.
3. **The shield (K2).** Every hit from the front while the shield is up bounces off: `CLANG!`, no
   damage, Akeris is pushed back a step, and the knight shortens its pause to 0.25 s: it answers.
4. **Ways in (K3):** from **behind** (it takes 0.5 s to turn, and it loses sight of Akeris while he rolls: the 0.5 s start when the roll ends; rolling under it opens the back); from
   **the air at helm height** (a jumping strike that meets the helm on the way down); during its cut
   and recovery; while staggered, stunned or frozen; the chain blades' **overhead arc** (it comes from
   above); burning; a projectile reflected at it (it throws none).
5. **Snatch (K4).** A chain blades' ranged strike (or the hanging free throw) that meets the shield
   from the front tears it away: no damage, no bite; the shield flies toward Akeris, lands, lies flat
   and dissolves. The chain comes back.
6. **Shieldless (K5).** It fights with both hands and faster (raise 0.42 s, pause 0.5 s) and every
   hit lands, from any side, for the rest of its life.
8. **Defeated, it stays defeated.** Once it dissolves it never comes back during the run, in the demo
   or the full game (operator, 2026-10-01; every enemy). The sandbox's *Volver a poner el enemigo* is
   a test tool.
7. **Stun (K7).** Akeris's fast descent landing within 170 su of it stuns it for 1.2 s: shield
   down, no attack. The descent does no damage.

## 9. Never

- Nothing trembles: no line boil, no jitter, no shake; its sway and breathing are slow and smooth.
- No round head, no cape, no eye streak, no colour beyond §3: it must never read as an Akeris.
- No blood: a hit is sparks and a callout; death is ink smoke.
- The painted eye never blinks and never glows.
- It never blocks from behind, never blocks a strike that meets its helm from the air, and never
  blocks while its shield is aside (cut, recovery, stagger, stun, snatched, frozen).
- It never attacks without the raise: the telegraph is always seen and heard.
- It never falls into the abyss and never walks into the stone.

## 10. Acceptance

What the operator checks in the game, side by side with the sandbox.

1. Standing still, it matches `guard` of `sprites/sheet.png`; the eye's pupil follows Akeris.
2. It walks toward Akeris in guard and stops at about the distance of `captures/guardia.png`.
3. Its attack plays as `sprites/sheet-attack.png`, with `sfx.shieldKnight.raise` at the start.
4. Hitting its shield from the front gives `CLANG!`, no damage, and pushes Akeris back (`sheet-guard.png`).
5. Rolling under it takes Akeris out of its reach; walking back and striking its back lands before it turns (`sheet-behind.png`, `captures/espalda.png`).
6. A jumping strike at its helm lands (`captures/arriba.png`).
7. A chain blades' strike on the shield tears it away as `sheet-snatch.png`; then it fights two-handed and faster.
8. A just block with the sacred shield staggers it and the counter lands (`sheet-counter.png`).
9. The fast descent beside it stuns it with the graphite stars (`sheet-stun.png`).
10. At its last health it dissolves as `sheet-death.png`, drops XP and coins, and never comes back.
11. Each sound of §7 plays at its trigger.

## 11. Exports

Every PNG is exported from the zone 1 sandbox (`kExportAll()`, the sounds with `kExportSfx()`):
`sprites/sheet.png`, the 13 single poses, the 7 frame sheets, `weapons/`, and `captures/` (11
scenarios: `guardia`, `alzar`, `corte`, `escudo`, `espalda`, `arriba`, `arrebatar`, `sinEscudo`,
`contra`, `aturdido`, `humo`).

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| K1 | Look | Akeris's rig at 1.12×, closed iron helm, iron plate and leg and arm pieces, a paper tabard with the one-handed clock of the sanctuary, a dark iron sword, a stone heater shield with a painted eye whose pupil follows Akeris; no new colour |
| K2 | The shield | hits from the front bounce (`CLANG!`, no damage, Akeris pushed back a step) and the knight answers sooner (pause 0.25 s) |
| K3 | Ways in | behind (0.5 s to turn, counted from the end of Akeris's roll), the air at helm height, its cut and recovery, stagger, stun, freeze, the chain arc, burning, reflected projectiles |
| K4 | Snatch | a ranged chain strike on its shield from the front tears it away: no damage, the shield flies, lands and dissolves in ink after 1.2 s |
| K5 | Shieldless | two-handed and faster (raise 0.42 s, pause 0.5 s); every hit lands |
| K6 | One attack | an overhead cut with a 0.55 s raise as its telegraph (seen and heard); blockable; the just block opens the counter |
| K7 | Stun | the fast descent within 170 su stuns it 1.2 s, no damage; graphite stars |
| K8 | Body | no contact damage; Akeris passes through it; it never jumps and never leaves its island |
| K9 | Distances | sight 1000 su × 260 su, advance at 110 su/s to ≈ 180 su, reach 215 su (all: the game decides) |

## 13. Chain balance (step 3.17, *approved* 2026-10-13)

HB1 does not flag it (72 %): no lunge. **HB3:** a frontal chain strike on its raised shield clangs and takes nothing (its snatch, once
every 5 s, as K4); from above (the overhead arc), from behind or shieldless it lands. In the zone 4 and 5 sandboxes the arc was being
stopped by the shield (the C1–C2 rule passed it as a weak chain): fixed (K3 holds again).
