# Small Bats — character contract

- **Status:** approved 2026-10-01 (SB1–SB10 approved as the sandbox does them)
- **Kind:** enemy (zone 2, the Echo Caverns); a swarm
- **Sandbox:** the zone 2 sandbox, [`../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html`](../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html):
  *Ir a… combate* (the default enemy); `N` wakes them or sends a dive · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 2: *Small Bats — swarm, one-hit kills*), §Bosses (the Giant Bat
  summons small-bat swarms) · `04-zones/zone-2-echo-caverns/biome.md` §A.5 (noise) · `00-game/controls.md` (G16) ·
  `02-art-direction/ART_DIRECTION.md` §5 · the operator's decisions of 2026-10-01 (they sleep hanging from the roof until
  noise wakes them, like the stalactites; they dive in a group and climb back; 3–6 per group)
- **Built on:** its own shape (no skeleton)
- **Code name:** `smallBats` · **Español:** murciélagos pequeños

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals SB1–SB10 (§12) were approved by the operator on 2026-10-01.

## 1. Identity

Small dark bats that sleep in the roof of a cave in a row, wings closed, until a noise wakes them. Then they
drop, open their wings and circle over Akeris in a figure of eight; one at a time, one flies to his side,
shrieks and folds its wings, and dives at him. A player reads: a cluster in the roof (quiet here), a flock
(watch who shrieks), one coming (hit it or block it). Any hit kills one.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| body | 34 long, ≈ 18 wide; two pointed ears | Akeris = 192 |
| wingspan | ≈ 120 open | membrane with three fingers, scalloped between them |
| hanging | ≈ 45 tall, upside down, wings closed, ears down | from the roof, 36 su apart |
| circling height | ≈ 270 above Akeris's feet | over his head |

**Silhouette test:** a dark body with two ears and two scalloped wings; hanging, a closed bud with ears below.
Never a bird (no beak, no feathers) and never the Giant Bat (a tenth of its size).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| body, ears | `#2f2a25` (the roosting bats of the biome) | 1.5 | `paperLight` at .09 (hanging) |
| wings | the same at .92 | 1.2; arm bones 1.4–1.6 | finger bones in `paperLight` at .25 |
| eyes | `paperLight` `#efe6d6`, two dots; larger while shrieking | — | — |

No new colour. In the dark only the eyes show (as the Giant Bat's, `VISION.md`).

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| hang | spawn | — | yes | drop | `hang` of `sprites/sheet.png`; still |
| drop | a noise; one of them killed | 0.4 each, 0.09 apart | no | fly | turns over and opens its wings (`sheet-wake.png`) |
| fly | drop, rise | — | yes | set | wings beat 6.5 times a second (`fly-up`, `fly-mid`, `fly-down`); a figure of eight over Akeris |
| set | fly, its turn | ≤ 0.7 | no | wind | flies to 300 su beside Akeris, 250 above his feet |
| wind (the telegraph) | set | 0.5 | no | dive | stops, folds its wings, opens its mouth (`wind`); shrieks; aims at his chest until 0.15 s before |
| dive | wind | until it passes | no | rise, daze | wings swept back (`dive`), two or three fading copies behind (`sheet-attack.png`) |
| rise | dive, daze | 0.6 | no | fly | beats faster back to the eight |
| daze | a normal block; hitting rock | falls, 1.0 on the floor | no | rise | tumbling (`daze`), graphite stars on the floor (`sheet-block.png`) |
| death | one hit | — | no | — | a small burst of ink (five puffs); the last one, `fx/ink-smoke` (`sheet-death.png`) |

## 5. Weapons and gear

None: it bites.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| dive copies | dive | two or three fading copies along its line | the dive's |
| ink burst | death | five ink puffs | 0.7–1.1 |
| stars | daze, on the floor | three graphite stars | the state's |
| hit feedback, block sparks, callouts | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.smallBats.wake` | the swarm wakes | `07-audio/sfx/sfx.md` |
| `sfx.smallBats.flutter` | loops while any is awake; stops when the last dies; silent in the pause, the map and a dialogue | `07-audio/sfx/sfx.md` |
| `sfx.smallBats.screech` | one starts its telegraph | `07-audio/sfx/sfx.md` |
| `sfx.smallBats.dive` | it dives | `07-audio/sfx/sfx.md` |
| `sfx.smallBats.die` | one dies | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.shield.just`, hit sounds | blocks and hits | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| per group | 3–6, by the seed | operator, 2026-10-01 |
| health | **one hit kills** any of them | `VISION.md` |
| bite | 1 (sandbox; **the game decides**); no knock-down; 0.6 s before another bite can land | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit reach | 44 su around a bat; a strike sweeps its arc in front while it lasts (§ below) | the sandbox |

**Behaviour:**

1. **Asleep (SB2).** They hang in a row from the roof over their spot. They do not see: only **noise** wakes
   them (`biome.md` §A.5: running, landing, striking, a clang) **made under them**: between the first and the last
   bat, and up to 330 su to each side (operator, 2026-10-01). Walking under them never does; noise farther away
   neither. Killing one (the chain reaches them) wakes the rest.
2. **Flock (SB3).** Awake, they circle over Akeris in a figure of eight (≈ 190 su across, 270 above his
   feet), inside their room and under the roof.
3. **Dive (SB4).** In turns — at most two at once, one every 0.6 s, each every 1.6–2.8 s — one flies to his
   side (300 su away, 250 up), shrieks and folds its wings for 0.5 s (the telegraph; it aims until 0.15 s
   before) and dives in a straight line at 650 su/s toward where his chest was. It passes through and climbs
   back; if it hits rock it is dazed.
4. **Answers (SB5).** Strike it as it comes: **one hit kills**, and a strike counts along its whole arc in
   front of Akeris while it lasts (they are small and fast); the chain and a falling stalactite kill them
   too. **The shield** stops a dive from the front or from above: the bat bounces and falls dazed
   for 1 s (an easy kill). **The just block** with any shield kills it. The roll passes through it.
5. **Bite (SB6).** A dive that meets Akeris bites for 1 and he cannot be bitten again for 0.6 s; it does
   not knock him down.
6. **In the dark (SB7).** Awake, only their eyes show; asleep, nothing. **While they sleep, noise made under them shows the
   echo ring** — the same noise that wakes them (as near a cracked stalactite, `biome.md` §A.4); **once awake,
   no more rings appear for them** and older ones vanish (operator, 2026-10-01).
7. **Defeated, they stay defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles: the wings beat smoothly and the strokes never change.
- They never wake from sight, or from walking.
- A dive never comes without its shriek and its fold, and never turns in the last 0.15 s.
- More than two diving at once.
- A bat surviving a hit.

## 10. Acceptance

1. Asleep they match `hang` of `sprites/sheet.png`; walking under them leaves them asleep; running or
   landing near them wakes them (`sheet-wake.png`).
2. Awake they circle over Akeris; each dive plays as `sheet-attack.png`, with the shriek first.
3. Standing still, a dive bites for 1; a second bite cannot land within 0.6 s.
4. The shield stops a dive and the bat falls dazed (`sheet-block.png`); the just block kills it (`sheet-just.png`).
5. One strike kills one (`sheet-strike.png`); the chain kills one (`captures/cadena.png`).
6. The last one dissolves in ink smoke (`sheet-death.png`) and the swarm never comes back.
7. In the dark only the eyes of the awake ones show (`captures/oscuridad.png`).

## 11. Exports

From the zone 2 sandbox (`btExportAll()`, the sounds with `btExportSfx()`): `sprites/sheet.png`, seven single
poses, six frame sheets (`wake`, `attack`, `block`, `just`, `strike`, `death`) and thirteen screenshots in `captures/`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| SB1 | Look | a small dark body with pointed ears and scalloped wings with three fingers; pale dot eyes; no new colour |
| SB2 | Waking | asleep in a row in the roof; only noise made under them wakes them (operator: under them, up to 330 su to each side); walking never; killing one wakes the rest |
| SB3 | Flock | a figure of eight ≈ 270 su over Akeris |
| SB4 | Dive | one at a time (two at most), flies to his side, shrieks and folds 0.5 s, dives at 650 su/s in a straight line, passes and climbs back |
| SB5 | Answers | any hit kills; a strike counts along its arc while it lasts; the shield bounces it (dazed 1 s); the just block kills it; the roll passes through |
| SB6 | Bite | 1, with 0.6 s before another; no knock-down |
| SB7 | Dark and echo | only the eyes of the awake ones show; the noise under them that wakes them shows the echo ring, and no more appear once awake (operator) |
| SB8 | Group | 3–6 per group, by the seed (operator) |
| SB9 | Sound | wake, flutter (loop), shriek (the telegraph), dive, death; all through the zone's echo |
| SB10 | Where | in combat rooms, under the roof over the foe spot; the Giant Bat's summoned swarms are its contract |
