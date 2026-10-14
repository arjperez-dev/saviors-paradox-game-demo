# Gargoyle — character contract

- **Status:** approved (step 3.15; operator, 2026-10-08)
- **Kind:** enemy (zone 5, the Dragon Battlements); the room enemy of the combat rooms
- **Sandbox:** the zone 5 sandbox, [`../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`](../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html):
  in the `bastion` and `ward` rooms, among stone gargoyles that are only decoration (*Ir a… gargola*, *combate*, *patio*) ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 5: *Gargoyle (statue that wakes and dives)*) · `00-game/controls.md` §Combat
  (the roll; G7: a projectile blocked just before impact flies back at its thrower; G16) · `03-characters/akeris/weapons/hook-blades.md`
  §6 (the chain does not immobilize; each own reaction to the chain at most once every 5 s) · `04-zones/zone-5-dragon-battlements/hazards.md`
  (the merlons) · the operator's approval of the proposal GA1–GA10 (2026-10-08) with the operator's additions: **the earthquake of stone
  spikes** when it crashes into the floor, **dodged only by jumping**; **the cutting wings**, a gust of cutting air in the shape
  of an X that **the shield stops**; some stone gargoyles left as **decoration**
- **Built on:** the Dragon's curved pencil pieces (`zdShape`, `zdLimb`, `zdWing`…), in stone
- **Code name:** `gargoyle` · **Español:** gárgola

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

A statue of the walls that is not a statue: a crouched stone demon with horns curving back, stone wings, bone claws and hollow
eyes. Asleep it is one more gargoyle on a pedestal — but **in profile**, with its ink outline, where the decorative ones stand
**from the front**, duller, like part of the walls (operator, 2026-10-08); gravel falling from it gives it away too. Awake an ember lights in its eyes and its cracks glow faintly. Heavy and vertical where the drakeling is
light and ranged: it rises over Akeris, its shadow grows on the floor, and it falls like a stone; the floor answers with a row of
spikes. On the floor it claws, beats its wings and throws cutting air; then it flies back to a perch and turns to stone again.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height, crouched (stone) | ≈ 170 | Akeris = 192; drawn at 0.5 su per unit |
| height, standing hunched | ≈ 200 | — |
| wings | open ≈ 450 tip to tip; folded like a cloak behind | stone, ragged, with a tear |
| pedestal | 96 × 164 | the height of a merlon and its cap |
| hover before the dive | ≈ 260 above Akeris's floor | its shadow below |

**Silhouette test:** a hunched horned figure with folded wings, on a pedestal, **in profile** (the decorative ones face the front). Never the drakeling (warm `wood`, small, a lizard
with a tail), never the Dragon.

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| body, head, limbs | stone `#8c8478` (far limbs `#6e675d`) | 1.3 + **a 1.2 px ink outline around the silhouette** | carved ribs, fixed cracks |
| wing membrane | `#5f5950` (the far one `#4f4a43`) | — | veins |
| horns, claws, fangs | `#b8b0a1` | — | rings on the horns |
| eyes | hollow `#16120f`; awake, `fire` `#e0782c` with a `#ffd166` core, glowing above the darkness | — | — |
| cracks, awake | `fire` at 35 % under the ink line | — | — |
| pedestal | `#77716a`, its cap `#8a847b` | 1.1 | ashlar joints |
| the X gust | `#e8e4d6` with an ink edge | 2.5 | three speed lines |
| the spikes | `#8a8276`, a pale edge | 1 | — |

No new colour family: the zone's stone. **Static:** nothing on it trembles; the wingbeat moves, the drawing does not boil.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| stone | spawn; back on a perch with Akeris gone | — | yes | wake | crouched on its pedestal or merlon, wings folded, eyes hollow (`stone`); gravel falls from the real one when Akeris is within 600 su |
| wake | Akeris within 400 su, or a blow | 0.6 | no | rise | head up, jaw open, wings half open, eyes lit, chips of stone (`wake`) |
| rise | wake, petrify, flinch in the air | ≤ 1.4 | no | hover | flies up over Akeris (`fly0`–`fly5`) |
| hover | over Akeris | **0.6** | no | dive | wings spread high, looking down; **its shadow grows on the floor**; the spot is fixed 0.15 s before (`hover`) |
| dive | hover | ≈ 0.2 | no | stuck | falls straight down, wings tight (`dive`) |
| stuck | it hits the floor (the earthquake starts) | **1.2** | no | walk | crouched, a fist on the stone (`slam`): open to blows |
| walk | stuck, after an attack | ≤ 4.5 in all | yes | clawTel, buffetTel, galeTel, toPerch | hunched, heavy steps (`walk0`, `walk1`) |
| clawTel / claw | Akeris within 170 su | **0.4** / 0.45 | no | walk | an arm raised back / swept forward (`clawTel`, `claw`) |
| buffetTel / buffet | Akeris within 170 su, every third close attack | **0.5** / 0.5 | no | walk | wings raised / swept (`buffetTel`, `buffet`) |
| galeTel / gale | Akeris 260–900 su away on its level | **0.5** / 0.45 | no | walk | wings raised high back / swept forward (`galeTel`, `gale`) |
| toPerch / petrify | after ≈ 4.5 s on the floor | ≤ 3 / **1.5** | no | rise (or stone) | flies to the pedestal or whole merlon farthest from Akeris and turns to stone (`stone`) |
| flinch | the chain (once every 5 s), its gust returned | 0.5 | no | walk / rise | it cringes (`flinch`) |
| stun | a just block with the sacred shield | 1.5 | no | walk | hunched, head down (`stun`); in the air it falls |
| dead | 0 health | — | no | — | it falls to the floor and **breaks into pieces of stone** that stay as rubble |

## 5. Weapons and gear

None: its weight, its claws and its wings.

## 6. Effects

| Effect | When | Look |
|---|---|---|
| gravel | the real one, asleep, Akeris within 600 su | a few small grey bits falling from it every 0.7 s (the decorative ones never) |
| the shadow | hover | a dark ellipse on the floor under it, growing for 0.6 s |
| the cracks | the earthquake's warning (0.45 s) | a jagged ink line with a pale edge running along the floor to both sides, drawn above the darkness |
| the spikes | the earthquake | stone spikes ≈ 70–86 su high rising in a wave from 90 to 650 su on both sides, ≈ 1000 su/s; they sink again; above the darkness |
| the X gust | the cutting wings | two curved cutting slashes crossing in an X, pale, with speed lines; returned, it flies back faster |
| chips | it is hit | small stone chips |
| defeat | 0 health | dust, chunks flying and a pile of rubble left on the floor (no ink: it is stone) |

## 7. Sounds

All `sfx.gargoyle.*` (`07-audio/sfx/sfx.md`, *Enemies of zone 5*; WAV in `07-audio/sfx/enemies/`).

| Id | When |
|---|---|
| `wake` | it wakes (stone cracking, a hoarse screech); softer before a close attack, and after petrify |
| `flap` | it takes off; a heavy wingbeat; the buffet |
| `dive` | the dive: air whistling down |
| `slam` | it crashes into the floor |
| `quake` | the earthquake: a low rumble and the spikes bursting in a row |
| `claw` | the claw |
| `gale` | the cutting wings |
| `land` | it perches |
| `stone` | a blow on stone (asleep, petrified, or a decorative one) |
| `hurt` | it is hit: stone chipping and a grunt |
| `die` | it breaks apart |

## 8. Mechanics

Numbers are the sandbox's; **the game decides**.

| # | Rule |
|---|---|
| GA1 | **Who:** a stone gargoyle (§1–§3). |
| GA2 | **Where:** **one gargoyle per gargoyle room** (the rooms' plan: never with drakelings; operator 2026-10-08), on a pedestal — `wallWalk` 1600, `bastion` 2050, `ward` 880, `breach` 2560, `watchEnd` 480. **Real** half of the times (70 % in the combat rooms `bastion` and `ward`), seen **in profile**; otherwise **decorative**, seen **from the front**, duller and without the ink outline, like part of the background. Seeds 1–3: 5–8 real, 2–4 decorative. |
| GA3 | **Wakes** when Akeris comes within 400 su (or it is hit): 0.6 s. Asleep and petrified it is stone: **nothing hurts it** (¡CLANG!), and the decorative ones only ring. |
| GA4 | **The dive:** it rises to ≈ 260 su over Akeris; **0.6 s warning** (its shadow grows on the floor; the spot is fixed 0.15 s before); it falls straight down at 1500 su/s: **3** of damage. It only ever falls where its whole body fits on solid floor (never over a gap, never into a wall: the spot moves up to 320 su into the room). A melee hit from above: **any raised shield stops it**, whichever way Akeris faces; the just block does what each shield does (sacred: the counter, stunned 1.5 s; ice: slowed 2 s; fire: only a block — stone does not burn). **Rolling dodges it.** If it falls on a merlon, the merlon breaks. Then it stays **stuck 1.2 s**, open to blows. |
| GA4b | **The earthquake of stone spikes** (operator): the dive's impact sends **cracks** along the floor to both sides (0.45 s warning, the full reach shown), then **stone spikes rise in a wave** from 90 to 650 su on both sides (≈ 1000 su/s; each up 0.1 s, held 0.35 s, sinks 0.3 s): **2** of damage, once per earthquake. **Only jumping saves Akeris** (operator, 2026-10-08): the roll does not, the shield does not. The spikes stop at gaps and walls. **An exception to "rolling always dodges"**, decided by the operator for this attack only. |
| GA5 | **On the floor** (≈ 4.5 s): it walks at 130 su/s toward Akeris. Close (≤ 170 su): **the claw** (0.4 s warning, **2**; any shield stops it; the just block of each shield; rolling dodges it) and, every third close attack, **the buffet** (0.5 s warning; no damage, it **pushes** Akeris ≈ 250 su — half with the shield raised; near a gap it can throw him in; rolling dodges it). |
| GA6 | **The cutting wings** (operator): from 260 to 900 su, a 0.5 s warning (wings raised high back) and **a gust in an X** at chest height, straight, 560 su/s: **2**. **Any shield stops it** (the ice shield spends a use); **its just block returns it** at the gargoyle (−1, it flinches; returned with the ice shield, slowed 2 s). **Rolling dodges it.** |
| GA7 | **Back to stone:** after ≈ 4.5 s on the floor it flies to the pedestal or whole merlon farthest from Akeris (never one a drakeling or a decorative gargoyle holds) and **turns to stone 1.5 s** (nothing hurts it), then dives again. If Akeris leaves, it stays stone. |
| GA8 | **How it is beaten:** **6** health. Weapons take 1 — **the hammer 2** (it breaks stone). Fire does not burn it; ice slows it (half speed 2 s), never freezes it. **The chain blades** hurt it at range but cannot pull it (too heavy); **its own reaction to the chain:** it cringes 0.5 s — at most once every 5 s. The sacred shield's just block on the claw or the dive opens the counter (stunned 1.5 s; the counter's blows take 1 each). The fast descent on it takes 1. |
| GA9 | **Defeat:** it falls and breaks into pieces of stone; the rubble stays. Over a gap it is lost. **Sounds:** §7. |
| GA10 | **Never:** an attack without its warning (dive 0.6 s, earthquake 0.45 s, claw 0.4 s, buffet 0.5 s, gust 0.5 s); an attack the roll does not dodge **except the earthquake**, which a jump always clears; spikes too high to jump (≤ 86 su; a jump rises ≈ 257); being hurt while it looks like stone; holding Akeris still; going through walls or leaving its room. |

## 9. Never

- An attack without its warning.
- An attack the roll does not dodge, except the earthquake (only jumping; operator).
- An earthquake a jump cannot clear.
- Taking damage as stone (asleep, petrified) — or looking like stone while it can be hurt.
- Being held still by chain hits (its reaction, at most once every 5 s).
- A decorative gargoyle that moves.
- Its colours on the drakeling, or the drakeling's on it.

## 10. Acceptance

Tested in the sandbox (2026-10-08):

1. Asleep on its pedestal it wakes at 400 su; the cycle: stone → wake → rise → hover → dive → stuck → walk → claw.
2. The dive takes 3; with the shield raised, 0; the sacred just block opens the counter (stunned); rolled through, 0.
3. The earthquake takes 2 standing at 300 su; **jumping as the spike comes, 0**; rolling through it, 2 (by design); with the shield, 2.
4. The claw takes 2; blocked, 0; the sacred just block, the counter (6 → … it loses 1 per counter blow); rolled, 0.
5. The buffet pushes Akeris ≈ 250 su with no damage; rolled through, it does not push.
6. The X gust takes 2; with the sacred, ice (one use) or fire shield, 0; its just block returns it and the gargoyle loses 1; rolled through, 0.
7. Petrified, a blow does nothing; the sword takes 1, the hammer 2; two chain throws take 2 and it cringes only once (once every 5 s).
8. Defeated it breaks and leaves rubble. A decorative one (from the front), hit, only rings.
9. A random player against them (40 runs of 40 s per seed, seeds 1–3, in their rooms, with sword, chain blades, hammer and spear and each shield): no errors; a gargoyle never inside the stone, never out of its room, never stuck in a state; **no damage while rolling except from the spikes** (by design); ≈ 80 dives, ≈ 80 earthquakes and ≈ 60 gusts per seed.
10. The rooms' plan, seeds 1–3: never a gargoyle and a drakeling in the same room; one gargoyle per gargoyle room (5–8 real, 2–4 decorative).

## 11. Exports

- [`sprites/sheet.png`](sprites/sheet.png): the 16 poses, and each alone (`sprites/<pose>.png`)
- [`sprites/sheet-fly.png`](sprites/sheet-fly.png), [`sheet-dive.png`](sprites/sheet-dive.png), [`sheet-claw.png`](sprites/sheet-claw.png), [`sheet-buffet.png`](sprites/sheet-buffet.png), [`sheet-gale.png`](sprites/sheet-gale.png)
- [`captures/`](captures/): stone among the decoration, waking, the shadow, the dive, the cracks, the spikes, jumping over them, the claw, the buffet, the cutting wings, the shield, the gust returned, petrified, the chain, the hammer, defeated, a decorative one (17)
- The sandbox exports it all with `ggExportAll()` and the sounds with `ggExportSfx()`.

## 12. Chain balance (step 3.17, *approved* 2026-10-13)

HB1 flagged it (37 %; it is stone, too heavy for the chain). **HB2, the pounce:** after two chain hits in a row from range (> 200 su, no
5 s pause), at most once every 5 s. On the floor: 0.5 s warning (`pounceTel`: crouched, wings up and back, claws raised;
`sfx.gargoyle.pounce`, `¡GRRAAAH!`), a low leap at 860 su/s up to 460 su (only where its whole body fits on the floor; `pounce`): **2**,
no shield stops it, **rolling dodges it**; landing beside Akeris, its claw (0.4 s warning), otherwise 0.6 s open. In the air: its usual
dive at once (the 0.6 s shadow warning). Frames: `sprites/sheet-pounce.png`. Measured after: 36 % (still under 60 %; see
`../../../akeris/weapons/hook-blades-balance.md`).
