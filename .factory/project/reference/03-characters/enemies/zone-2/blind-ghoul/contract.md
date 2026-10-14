# Blind Ghoul — character contract

- **Status:** approved 2026-10-01 (BG1–BG10 approved as the sandbox does them)
- **Kind:** enemy (zone 2, the Echo Caverns)
- **Sandbox:** the zone 2 sandbox, [`../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html`](../../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html):
  *Ir a… combate* (the default enemy); `N` makes it attack · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 2: *Blind Ghoul — detects Akeris when he runs, not when he walks*) ·
  `04-zones/zone-2-echo-caverns/biome.md` §A.5 (noise) · `01-story/dialogue/zone-2.md` («Walk, do not run. Some things down
  here hunt by the noise») · `00-game/controls.md` (G16) · the operator's decisions of 2026-10-01 (it hunts like the
  clickers of *The Last of Us*: small clicks to echolocate, and moving inside the radius it hears brings it running; sewn eyes;
  walking crouched does not give Akeris away; its grab kills, with a 0.5 s telegraph, a grab sound and a bite sound; from
  stealth one strike kills it, from the front it takes the normal number of hits)
- **Built on:** Akeris's skeleton at 1.0×, hunched
- **Code name:** `blindGhoul` · **Español:** necrófago ciego

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals BG1–BG10 (§12) were approved by the operator on 2026-10-01.

## 1. Identity

One of those who came down: hunched and starved, sickly skin stretched on the bones, ribs like dark slits, a spine of sharp
vertebrae, a long skull seen in profile with a low brow and one deep socket **sewn shut** with thread that weeps ink, a torn
ear, a long lipless jaw that always shows its teeth, four long claws on each hand and strips of rag hanging (operator,
2026-10-01: more dread). Now and then, wandering, its head jerks to one side, listening. It
cannot see. It clicks its tongue and listens to what comes back. A player reads at once: it is listening (the click and its
ring), I must not move upright while the ring passes, and if it hears me it will run at me. It is the zone's dread: the
lore spirit's «walk, do not run» is about it.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 170 hunched (Akeris's 192 standing) | Akeris's skeleton, the back bent forward |
| head | a long skull in profile, ≈ 1.1× Akeris's; a torn ear ≈ 30 back | the sewn socket, its ink tear and the teeth always visible |
| claws | four per hand, 28–34 long, thin and curved | open wider in the grab |
| hit reach of its claws | 150 | the sandbox |

**Silhouette test:** a hunched pale figure with a big bald head, pointed ears and claws hanging to its knees; never a
skeleton (it has skin) and never a zombie with eyes.

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| skin | `#bab29f` (a sickly `stone`) | outline 2.3; limbs 4.2–4.6 inside a 6.2–6.6 ink line; knees and elbows as knobs | `ink` at .2–.26 |
| ribs, spine | ribs as `ink` slits at .72 with a `paperLight` edge; eight sharp vertebrae; a vein | 1.5; vertebrae 1.2 | — |
| rag | `#3f3a33`, with three hanging strips | 1.8; strips 2.2 | `ink` at .4 |
| the sewn socket | a deep `ink` hollow at .7, a pale thread across it and four cross stitches; an `ink` tear down the cheek to a drop | thread 1.4, stitches 1.2, tear 2.1–2.6 | — |
| mouth | lipless: seven long `paper` teeth top and bottom always showing; open, `#0c0908`; the jaw drops past its limit in the bite | 1.2 | — |

No new colour, no glow. In the dark it is seen only where there is light, and by its click rings.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| wander | spawn, sniff | — | yes | click, hunt, scream | `idle`, walking slowly (60 su/s) to and fro around its spot, pausing; ribs heave slowly; every 2.4 s its head jerks to one side and back (a real, quick motion, never a tremble) |
| click | wander, hunt; every 1.2–2.0 s (0.9 hunting) | 0.4 | no | wander, hunt | `listen`: head raised and tilted, mouth ajar; the ring opens (`sheet-click.png`) |
| hunt | a noise | — | yes | sniff | walks fast (210 su/s) to where it sounded, clicking more often |
| sniff | hunt, arriving; losing Akeris | 1.2 | no | wander | `sniff`: head down, snuffling (the opening) |
| scream | detecting Akeris | 0.55 | no | chase | `scream`: head back, mouth wide, claws back (`sheet-detect.png`) |
| chase | scream, after an attack | — | yes | claw, grab | runs at him (330 su/s), arms trailing |
| claw | chase | 1.05 | no | chase | `clawWind` 0.5 s (the telegraph: crouched, claws back), `clawHit1`, `clawHit2` (`sheet-claw.png`) |
| grab | chase | 0.5 + 0.22 + 0.55 | no | chase, bite, stagger | `grabWind` 0.5 s (the telegraph: arms up and wide, claws open, with `sfx.blindGhoul.grabWind`), `grabLunge`: it throws itself forward 180 su (`sheet-grab.png`) |
| bite | a grab that lands | 1.05 | no | feed | it pulls him against itself (0.25), rears its head back while **the jaw unhinges** (to 0.65, the jaw creaking), snaps into his neck with a burst of ink — never blood — and thrashes twice slowly; Akeris dies at 1.05 (`sheet-grab.png`, `sfx.blindGhoul.bite`); drawn in front of him |
| hurt | a hit from the front | 0.25 | no | chase | `hurt` |
| stagger | the just block against its grab; the sacred counter | 1.3 | no | chase | `hurt`, swaying; graphite stars |
| stun | the fast descent beside it | 1.2 | no | chase | the same |
| death | its last health; one stealth strike | the ink smoke's | no | — | `fx/ink-smoke` (`sheet-stealth.png`) |

## 5. Weapons and gear

None: its claws and teeth.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| **click ring** | click | a ring that opens from its head to 450 su in 0.7 s: two pencil circles and a dashed one; in the dark it also lightens the darkness as it passes (`biome.md` §A.4) | 0.95 |
| stars | stagger, stun | three graphite stars | the state's |
| hit feedback, block sparks, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.blindGhoul.click` | each click | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.shriek` | it detects Akeris | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.step` | each step (×0.55 walking, ×1 running) | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.claw` | each swipe of the claw | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.grabWind` | the grab's telegraph starts | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.jawOpen` | the bite begins to open its jaw (0.25 s in) | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.bite` | the snap into the neck and the tearing of the two thrashes (0.65 s in) | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.sniff` | sniff | `07-audio/sfx/sfx.md` |
| `sfx.blindGhoul.moan` | after a click while wandering, one time in three | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.shield.just`, hits, `sfx.fx.inkSmoke` | blocks, hits, death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | 6 from the front (sandbox; **the game decides**); **one melee strike from stealth** | operator, 2026-10-01 |
| claw damage | the game decides (sandbox: the HUD's test hit, per swipe) | — |
| the grab | **kills** (operator, 2026-10-01) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 54 su | the sandbox |

**Behaviour:**

1. **It clicks to hear (BG2).** Wandering, every 1.2–2.0 s it stops, tilts its head and clicks; the ring opens to 450 su
   in 0.7 s. **While the ring is out, if it reaches Akeris and he is moving upright** (walking or running with a direction
   held, in the air, rolling, diving, the spin, the pull; landing and striking are noises, BG4), it detects him. **Standing still or walking crouched (S)
   inside the ring does not give him away** (operator, 2026-10-01); the strike itself is silent until it lands.
2. **Close by it hears steps (BG3).** Within 160 su it hears Akeris walking upright even without clicking; crouched, it
   does not.
3. **Noise draws it (BG4).** Any noise of `biome.md` §A.5 within its reach plus 200 su sends it fast to where it sounded,
   clicking more often; finding nothing, it sniffs for 1.2 s and wanders there. A stalactite brought down with the chain
   is a noise too: it can be used to lure it.
4. **Detected (BG5).** It shrieks (0.55 s) and runs at him. It loses him only if he gets 1100 su away or out of its level
   for 2 s; then it sniffs and wanders again.
5. **The claw (BG6).** 0.5 s crouched with the claws back (the telegraph), then two swipes (0.56 s and 0.76 s). The shield
   stops each; the sacred just block opens the counter; ice and fire as G16.
6. **The grab (BG7).** Its pattern is claw, grab, claw, claw, grab. **0.5 s with the arms up and wide** (the telegraph, with
   its own sound), then it throws itself forward 180 su. **Only the roll** (its invulnerability) **or the just block** with
   any shield escapes it: the just block throws it off balance for 1.3 s (the opening). A shield held without timing does
   not stop it. **If it catches him, it bites and Akeris dies** (with the bite's sound), curse or not.
7. **Stealth (BG8).** A melee strike (or the counter) while it has not detected Akeris **kills it at once**. The chain or a
   stalactite only hurt it and wake it.
8. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles; the strokes never change; the click ring moves smoothly.
- It never sees: no light, eye or glance gives it Akeris, only sound.
- It never detects a still or crouched Akeris through its ring; it never grabs without the 0.5 s telegraph and its sound.
- Gore: the bite is a snap of the jaw and a growl, no blood (`07-audio/sfx/sfx.md` §4).
- It never comes back once defeated.

## 10. Acceptance

1. Wandering, it clicks every 1.2–2.0 s and the ring opens to 450 su (`sheet-click.png`).
2. Standing still or crouched inside the ring, Akeris is not detected (`sheet-crouch.png`); walking upright inside it he is:
   it shrieks and runs (`sheet-detect.png`).
3. A melee strike while it has not detected him kills it in one blow (`sheet-stealth.png`).
4. From the front it takes 6 hits; its claw plays as `sheet-claw.png` and the shield stops it.
5. Its grab plays as `sheet-grab.png`: 0.5 s of telegraph with its sound; if it lands, the bite plays and Akeris dies.
6. The roll or the just block escapes the grab (`sheet-escape.png`); a shield held without timing does not.
7. A noise sends it to where it sounded, and it sniffs there.

## 11. Exports

From the zone 2 sandbox (`ghExportAll()`, the sounds with `ghExportSfx()`): `sprites/sheet.png`, eleven single poses, seven
frame sheets (`click`, `detect`, `crouch`, `stealth`, `claw`, `grab`, `escape`) and fourteen screenshots in `captures/`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| BG1 | Look | hunched and starved, sickly skin, ribs as dark slits, sharp vertebrae, a long skull in profile with one deep socket sewn shut that weeps ink (operator: sewn eyes, more dread), a torn ear, lipless teeth, four long claws, hanging rags; the head jerks now and then |
| BG2 | Clicking | every 1.2–2.0 s (0.9 hunting); a ring of 450 su in 0.7 s; moving upright inside it while it is out gives Akeris away; still or crouched does not (operator) |
| BG3 | Close steps | within 160 su it hears upright steps without clicking |
| BG4 | Noise | any noise within its reach + 200 su draws it there; then it sniffs 1.2 s |
| BG5 | Chase | shrieks 0.55 s, runs at 330 su/s; loses him at 1100 su or off its level for 2 s |
| BG6 | Claw | 0.5 s telegraph, two swipes; the shield stops them; the sacred just block opens the counter |
| BG7 | Grab | 0.5 s telegraph with its sound (operator), a 180 su lunge; only the roll or the just block escapes (the just block staggers it 1.3 s); caught, it bites and Akeris dies (operator) |
| BG8 | Stealth | one melee strike while undetected kills it (operator); the chain does not count |
| BG9 | Health | 6 from the front (operator: «the normal») |
| BG10 | Sound | wet broken clicks with a rattling throat, a moan now and then, a shriek of several dissonant voices, bare steps with nails scraping, the claw, the grab's telegraph (a hoarse breath and accelerating clicks), opening the mouth (something breaking as the jaw unhinges, and a roar), the bite (the snap and a tearing rip on each thrash, a growl), sniffing; all through the zone's echo (operator: more dread) |
