# The Many-Armed — character contract

- **Status:** approved 2026-10-01 (MA1–MA12 approved as the sandbox does them)
- **Kind:** enemy (zone 2, the Echo Caverns); the zone's hardest in a straight fight
- **Sandbox:** the zone 2 sandbox, [`../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html`](../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html):
  *Ir a… combate* (the default enemy); `N` makes it attack · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 2: *Many-Armed — six extra arms with short swords, thrust waves*) ·
  `00-game/controls.md` (G7, G16) · the operator's decisions of 2026-10-01 (the proposal, with: the sacred shield never
  breaks; after the sixth thrust in a row blocked, Akeris is stunned 1.5 s; if it catches him with its arms it crushes him to
  death, with a sound of bones breaking) · the operator's review of 2026-10-01 (the waves can be blocked but never open the
  counter; taller waves with a red core; with fewer arms, attacks of its own for 4–5, 2–3 and 0–1 arms)
- **Built on:** Akeris's skeleton at 1.2×, plus six procedural arms
- **Code name:** `manyArmed` · **Español:** el de muchos brazos

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals MA1–MA12 (§12) were approved by the operator on 2026-10-01.

## 1. Identity

One of those who came down, twisted by the cave: tall and stooped under a hooded shroud, eyes and mouth sewn shut, and six
extra arms growing from its back and sides, each with a short rusted sword. A player reads: a wall of blades; when they all
go back, a burst is coming; it never runs out of arms unless I tear them off; do not just stand behind the shield.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 230 (Akeris's skeleton at 1.2×, stooped) | Akeris = 192 |
| extra arms | six, two bones of ≈ 34 + 32, at three heights on both sides | three behind the body, three in front |
| swords | short, ≈ 46, on every hand (eight in all) | — |
| the wave | ≈ 120 tall, along the floor (operator: taller) | it can be jumped (feet above ≈ 110) |

**Silhouette test:** a hooded hunched figure bristling with blades; in the mill, a star of swords. Never a spider (it stands
on two legs) and never the knight (no shield, no armour).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| skin | `#bab29f` (the ghoul's sickly `stone`) | limbs 3.6–5.4 inside an `ink` line +2 | `ink` at .2–.24 |
| shroud and hood | `#3f3a33` | 2 | `ink` at .42 |
| swords | rust `#6b5d4c`, a `paperLight` edge at .4, an `ink` crossguard | 1.4; crossguard 2.2 | — |
| sewn eyes and mouth | `ink` thread with cross stitches | 1.6 / 1 | — |
| the wave | an `ink` arc, a **red core** (`streakRed` `#6e0a10` wide pass, `#d8141d` core), `paperLight` arcs trailing, ink drops | 3 / 5 + 2.2 / 1.4 | — |

No new colour. **The red core is the operator's decision (2026-10-01)** so the waves read at a glance; it is an exception to
`palette.md`, which keeps red for the timelines only.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| guard | spawn | — | yes | burst, mill, grab | `guard`: arms open, swaying slowly; it keeps ≈ 360 su from Akeris |
| burst — wind (the telegraph) | guard | 0.6 | no | thrusts | `wind`: the arms go back one after another, blades scraping (`sheet-burst.png`) |
| burst — thrusts | wind | 0.08 between thrusts (0.48 for six); with 4–5 arms, in pairs 0.24 apart | no | tangle | `thrust`: each arm (each pair) stabs forward and pushes a wave (`sheet-pairs.png`) |
| tangle (the opening) | burst | 1.0 | no | guard | `tangle`: arms crossed in front, the blades clashing (`sheet-tangle.png`) |
| mill | guard, Akeris close | 0.5 + 0.5 | no | guard | `mill`: arms raised wide (the telegraph), then a turning star of blades (`sheet-mill.png`) |
| grab | guard, Akeris close; Akeris stunned | 0.5 (0.3 if stunned) + 0.2 | no | crush, guard | `grab-wind`: every arm opens wide (the telegraph), then a lunge of ≈ 120 su (`sheet-grab.png`) |
| cross (2–3 arms) | guard | 0.45 + 0.18, then 0.8 open | no | guard | `crossW`: the arms crossed far back (the telegraph), then a lunge of ≈ 145 su and a scissor cut (`sheet-cross.png`, `sheet-cross-block.png`) |
| slash (0–1 arms) | guard | hits at 0.42 and 0.68, then 0.6 | no | guard | `slashW`/`slashA`: its own two swords overhead, two cuts down (`sheet-slash.png`) |
| crush | a grab that lands | 1.0 | no | — | `crush`: it lifts him in all its arms and squeezes; bones break; Akeris dies (`sheet-crush.png`) |
| hurt / stagger / stun | a hit / the sacred counter / the fast descent | 0.25 / 1.3 / 1.2 | no | guard | as the other enemies; stars |
| death | its last health | the ink smoke's | no | — | `fx/ink-smoke` (`sheet-death.png`) |

**Arms torn off** (§8) leave a dark stump, and the attacks change with the arms left (§8, *By arms left*).

## 5. Weapons and gear

Eight short swords (six extra arms and its own two); not items.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| wave | each thrust | an arc of air and ink, ≈ 120 tall with a red core, rolling along the floor at 700 su/s for 300 su | ≤ 0.43 |
| stars over Akeris | Akeris stunned | three graphite stars over his head, drawn in front of him | 1.5 |
| ink | an arm torn off; the crush | ink puffs | 0.8 |
| hit feedback, block sparks, counter, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.manyArmed.step` | each step | `07-audio/sfx/sfx.md` |
| `sfx.manyArmed.wind` | the burst's telegraph; the scissor cut's telegraph | `07-audio/sfx/sfx.md` |
| `sfx.manyArmed.thrust` | each thrust; each cut of the scissor and the double slash | `07-audio/sfx/sfx.md` |
| `sfx.manyArmed.tangle` | it tangles; the double slash's telegraph | `07-audio/sfx/sfx.md` |
| `sfx.manyArmed.windmill` | the mill turns | `07-audio/sfx/sfx.md` |
| `sfx.manyArmed.grabWind` | the grab's telegraph | `07-audio/sfx/sfx.md` |
| `sfx.manyArmed.crush` | the crush: the pressure creaking, **bones giving way**, and one big snap as Akeris dies (operator, 2026-10-01; an exception to `sfx.md` §4) | `07-audio/sfx/sfx.md` |
| `sfx.manyArmed.snatch` | the chain tears an arm off | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.akeris.hurt`, hits, `sfx.fx.inkSmoke` | blocks, the stun, hits, death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 8) | proposal |
| wave damage, mill damage | the game decides (sandbox: the HUD's test hit) | — |
| the crush | **kills** | operator, 2026-10-01 |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 64 su | the sandbox |

**Behaviour:**

1. **Distance (MA2).** It walks (90 su/s) to stay about 360 su from Akeris: the burst's range.
2. **The burst (MA3).** 0.6 s of telegraph (the arms going back one by one, with their scrape), then one thrust per arm
   0.08 s apart; each pushes a wave about 120 su tall, with a red core, along the floor (700 su/s, 300 su). Answers: **a jump
   at the right moment clears the whole burst**; rolling goes through a wave; **the shield stops each wave**, but **a wave
   never opens the counter**, not even a just block (operator, 2026-10-01: the next wave is already on its way).
3. **The sixth in a row (MA4).** Each wave stopped by the shield counts; **the sixth in a row stuns Akeris for 1.5 s**
   (operator) — he cannot move — and it rushes at him (340 su/s) and grabs him (a 0.3 s telegraph). **The sacred shield never
   breaks**; the ice shield spends a use per wave as always (and can break). A wave that hits or is dodged resets the count.
4. **Tangled (MA5).** After a burst its arms are crossed for **1.0 s**: the opening to close in and strike.
5. **Close (MA6).** Within 170 su it alternates **the mill** (0.5 s of telegraph with the arms raised, then 0.5 s of turning
   blades within 175 su; **no shield stops it**: step away or roll) and **the grab** (0.5 s with every arm wide, then a lunge;
   rolling escapes it).
6. **The crush (MA7).** If the grab catches Akeris, it lifts and crushes him in all its arms for 1.0 s, with bones breaking,
   and he dies (operator), curse or not.
7. **The chain (MA8).** Each chain blade that reaches it **tears off an arm** (no damage): with fewer arms the burst has fewer
   thrusts — **with fewer than six it can no longer stun him**.
8. **By arms left (MA12; operator, 2026-10-01).** Every attack uses only the arms it has:
   - **6 arms** — all of the above: the burst of six, the mill, the grab and the crush.
   - **4–5 arms — the burst in pairs.** Two arms stab together, 0.24 s between pairs: three waves with 5 arms, two with 4.
     They are further apart, so one jump may not clear them all. The mill is shorter (150 su). It can still grab and crush.
   - **2–3 arms — the scissor cut.** No burst and no grab, since it can no longer hold him. It keeps ≈ 230 su; it crosses its
     arms far back (0.45 s, with the scrape), lunges ≈ 145 su and cuts in a scissor (reach 170 su). Then it stays open 0.8 s.
     The shield stops the cut, and a sacred just block opens the counter (G16). Close, it alternates the scissor and a small
     mill (130 su).
   - **0–1 arms — desperate.** It walks at him (150 su/s) and cuts twice with its own two swords (at 0.42 and 0.68 s). The shield
     stops both cuts, and a sacred just block opens the counter.
9. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles; the strokes never change; the waves and the mill move smoothly.
- A burst without its 0.6 s telegraph, or a grab without its open arms.
- The sacred shield breaking.
- Gore beyond the operator's bone sound: no blood; the crush ends in ink.
- It never comes back once defeated.

## 10. Acceptance

1. In guard it keeps ≈ 360 su away; the burst plays as `sheet-burst.png`, with the scrape first.
2. A well-timed jump clears all six waves (`sheet-jump.png`); rolling goes through.
3. Blocking six waves in a row stuns Akeris 1.5 s and it rushes and grabs him (`sheet-block.png`); the crush kills him with
   the bone sound (`sheet-crush.png`).
4. After a burst it stays tangled 1.0 s and strikes reach it (`sheet-tangle.png`).
5. Close, the mill goes through the shield (`sheet-mill.png`); the grab is escaped by rolling (`sheet-grab.png`).
6. Each chain blade tears off an arm (`sheet-chain.png`); with 4–5 arms the burst comes in pairs (`sheet-pairs.png`); with
   2–3 it cuts in a scissor, which the shield stops and a just block counters (`sheet-cross.png`, `sheet-cross-block.png`);
   with 0–1 it cuts twice with its own swords (`sheet-slash.png`).
6a. No wave ever opens the counter; the waves are ≈ 120 su tall with a red core.
7. At its last health it dissolves (`sheet-death.png`) and never comes back.

## 11. Exports

From the zone 2 sandbox (`maExportAll()`, the sounds with `maExportSfx()`): `sprites/sheet.png`, seven single poses, thirteen
frame sheets (`burst`, `jump`, `block`, `crush`, `tangle`, `chain`, `mill`, `grab`, `pairs`, `cross`, `cross-block`, `slash`,
`death`) and nineteen screenshots in `captures/`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| MA1 | Look | tall and stooped under a hooded shroud, eyes and mouth sewn, six extra arms at three heights with short rusted swords |
| MA2 | Distance | keeps ≈ 360 su; walks at 90 su/s |
| MA3 | The burst | 0.6 s telegraph, one thrust per arm 0.08 s apart, waves 120 su tall with a red core (operator), 700 su/s, 300 su; jump, roll or shield; no counter (operator) |
| MA4 | The sixth in a row | stuns 1.5 s (operator) and it rushes and grabs; the sacred never breaks (operator); ice spends uses |
| MA5 | Tangled | 1.0 s after each burst (the proposal said 0.5; 1.0 lets Akeris close in from the burst's range) |
| MA6 | Close | alternates the mill (unblockable, 175 su) and the grab (rolling escapes) |
| MA7 | The crush | kills, with bones breaking (operator) |
| MA8 | The chain | tears off an arm each time; fewer arms, fewer thrusts; fewer than six cannot stun |
| MA9 | Counter | never on the waves (operator); only on the scissor cut and the double slash |
| MA10 | Health | 8 |
| MA11 | Sound | step, the arms' scrape, thrusts, tangle, mill, the grab's telegraph, the crush (bones), the snatch; through the zone's echo |
| MA12 | By arms left | 6: everything; 4–5: the burst in pairs, a shorter mill, still the grab; 2–3: the scissor cut and a small mill, no grab; 0–1: two cuts with its own swords (operator asked for it) |
