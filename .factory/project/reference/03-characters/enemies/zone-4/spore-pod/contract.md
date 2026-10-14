# Spore Pod — character contract

- **Status:** approved 2026-10-05 (VP1–VP12 as the sandbox does them, with the longer telegraphs)
- **Kind:** enemy (zone 4, the Rotting Canopy); rooted, it never moves
- **Sandbox:** the zone 4 sandbox, [`../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`](../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html):
  the pods live in the rot rooms whatever the room's enemy (*Ir a… combate*, *charcos*, *ramas*) · **Pose sheet:**
  [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 4: *Spore Pod (toxic cloud)*), §Mechanics (status effects: poison) ·
  `04-zones/zone-4-rotting-canopy/biome.md` §A.4 (the spores are atmosphere; the toxic cloud is the pod's), `hazards.md` (the
  poison of the pools, the torches) · `01-story/dialogue/zone-4.md` («Mind the pods. Mind the pools.») ·
  `00-game/controls.md` G7, G16 and the glossary (*reflect*, *fire attack*) · the operator's decisions of 2026-10-05 (the
  proposal; no fireball: Akeris has no Flare in zone 4; the fire shield only by the reflect rule; the cloud poisons as the
  pools do; a small cloud on death; fire clears the clouds; only on the floor) and after playing it (longer telegraphs: «aumenta el tiempo de ataque»: the swell 1.2 s, the spit 0.9 s)
- **Built on:** its own shape (no skeleton)
- **Code name:** `sporePod` · **Español:** vaina de esporas

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

A pale fungus bulb rooted in the mud of the rot rooms, with ink veins and three pores in a row — the mark of the three
hollows. It does not walk; it breathes. Come close and it swells, its pores light up and it hisses, then it bursts into a
cloud of poison; from afar it spits a spore that bursts where it lands. A player reads: a bulb that swells means step back;
after the burst, while it lies deflated, strike; never strike while it swells. Its cloud is the danger, not its body. Fire is
its end.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 70 (a knee and a half; Akeris = 192) | swollen ≈ 77, deflated ≈ 39 |
| width | ≈ 46 at mid height; ≈ 61 swollen | a short neck over five rootlets in the mud |
| pores | three in a row at two thirds of its height | the mark of the three hollows |
| spore | 7 su radius | — |
| cloud | 150 su radius (burst); 90 su (spore, death) | a dotted edge: as far as it poisons |

**Silhouette test:** a pale bulb on rootlets with three dark dots across it. Never a mushroom (no cap with gills: those are
scenery), never an egg sac (those hang from threads, white), never an animal (no legs, no face).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| body | pale fungus `#c9bea7` (`biome.md` §A.3) | 2 | ink at 13 % |
| cap | rotten wood `#857a66` | 1.4 | — |
| veins | ink at 55 % | 1 | — |
| pores | `#2a2520`; lit with the poison drip `#a6b04c` while swelling or spitting | 1 | — |
| spore | the poison `#7a8638`, a drip highlight | 1.6 | — |
| cloud | the poison glow `rgba(150,170,60,·)` in soft blots, spores in `#a6b04c`, a dotted ink edge | 1.1 | — |
| burnt | `#1f1b18` | 2 | — |
| frozen | the ice shield's blue over the body at 45 % | — | — |

No new colour. In the dark only its pores show (brighter when it swells) and its clouds, faint.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| idle | spawn, spent, spit | — | yes | swell, spit | breathing: it swells a little and back (`idle`) |
| swell (the telegraph) | idle, Akeris within 300 su | 1.2 | no | spent | it grows a third wider, the pores light up (`swell`); it hisses |
| burst | swell | — | — | spent | the cloud comes out of it (`sheet-burst.png`) |
| spent | burst | 4.5 | no | idle | deflated and wrinkled, slowly filling again (`spent`); the cloud is gone at 3 s |
| spit (the telegraph) | idle, Akeris at 300–700 su | 0.9 | no | idle | it leans back, the pores light up (`spit`); then the spore flies (`sheet-spit.png`) |
| hit | a hit | 0.25 | no | — | it squashes a little |
| frozen | its spore reflected with the ice shield | 0.5 | no | — | blue (`frozen`), everything stops |
| death | its last health | 0.9 | no | — | it deflates and fades in ink (`sheet-open.png`); burnt: black, a flame (`burnt`, `sheet-torch.png`) |

## 5. Weapons and gear

None: its cloud and its spore.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| the cloud | the burst; a spore bursting; death | soft blots of the poison glow with spores turning inside and a dotted edge; it grows in 0.35 s, rises 12 su/s and fades in its last 0.8 s; it never crosses rock | 3 (burst), 2 (spore), 1.5 (death) |
| spore bits | the burst | poison drips thrown up | 0.7 |
| the spore | the spit | a green ball with two fading copies along its arc | its flight |
| the flash | fire touches a cloud | orange sparks; the cloud goes | 0.3 |
| reflect, block sparks, callouts | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.sporePod.swell` | it starts to swell (the telegraph) | `07-audio/sfx/sfx.md` |
| `sfx.sporePod.burst` | it bursts | `07-audio/sfx/sfx.md` |
| `sfx.sporePod.spit` | it spits a spore | `07-audio/sfx/sfx.md` |
| `sfx.sporePod.pop` | a spore bursts | `07-audio/sfx/sfx.md` |
| `sfx.sporePod.hurt` | it is hit | `07-audio/sfx/sfx.md` |
| `sfx.sporePod.die` | its last health (not by fire) | `07-audio/sfx/sfx.md` |
| `sfx.sporePod.flash` | fire clears a cloud | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.burn`, `sfx.fx.reflect`, shield sounds, `sfx.zone4.poison` | burnt; a reflected spore; blocks; each poison bite | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | 3 | proposal |
| where | on the floor of the rot rooms, never in a pool nor by a door: `pools` (one), `boughs` (two: the left floor and a root), `clearing` (two), `poolEnd` (one); about 18 in a zone of seed 1 | operator: only on the floor |
| the cloud | poisons as the pools do: −1 health a second inside and 2 s after, the first 0.5 s after entering; the chip *Envenenado*; with a curse active, the first bite kills (`hazards.md`) | operator |
| XP and coins | the game decides | `VISION.md` §Assumptions |

**Behaviour:**

1. **Rooted (VP1).** It never moves. It acts only while Akeris is in its room, on about its height (260 su) and with nothing
   solid between them; otherwise it breathes.
2. **The burst (VP2).** When Akeris comes within **300 su**, it swells for **1.2 s** (pores lit, a hiss: the telegraph; operator: longer) and
   bursts into a **cloud of 150 su** that lasts **3 s**, rising slowly. Then it lies **deflated 4.5 s**: the cloud has gone at
   3 s, so it is **open 1.5 s** before it breathes again.
3. **The spore (VP3).** Between **300 and 700 su**, it leans back for **0.9 s** (the telegraph; operator: longer) and spits a spore in an arc to
   Akeris's feet (0.7–1.3 s of flight); it bursts where it lands into a **cloud of 90 su, 2 s**. Then 2.5 s before another.
4. **The cloud (VP4).** Inside it Akeris is **poisoned** as in a pool (operator). No shield stops it and the roll does not pass
   through it: get out, or do not go in. It never crosses rock: a wall or a ceiling closes it.
5. **The shield and the spore (VP5).** A spore is a projectile (`controls.md` G7, G16): a block stops it, but it bursts in
   front of Akeris (110 su ahead: outside its cloud if he does not step forward); **the just block with any shield sends it
   back** and it takes 1 from the pod; sent back with **the ice shield** it also **freezes** it 0.5 s, with **the fire shield**
   it also **burns** it — and fire kills it (VP8).
6. **Hits (VP6).** It takes **3 hits**. **A hit while it swells bursts it at once**, in Akeris's face: the strike is for after
   the burst, while it lies open. **The chain** takes 1 from 340 su (and bursts it if it swells: the safe way); **the dive** on
   it takes 1.
7. **Death (VP7, operator).** It deflates and lets out a **last small cloud** (90 su, 1.5 s): finishing it up close has a
   price.
8. **Fire (VP8, operator).** **A fallen torch** whose flame reaches it (within 60 su) burns it at once, with no cloud; so does a
   burning web under it, and the spore sent back with the fire shield. **Fire clears any cloud it touches**, with a short
   flash and **no harm to anyone** (operator). There is no fireball in zone 4: Akeris has no Flare until the dragon (operator).
9. **In the dark (VP9).** Only its pores show, brighter as it swells, and its clouds, faint.
10. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy). A pod is not a room enemy: it lives beside
    whatever enemy the room has.

## 9. Never

- Nothing trembles: it breathes and swells smoothly; strokes never change.
- It never moves, never hangs from a ceiling, never grows in a pool.
- A burst never comes without the full 1.2 s swell, unless a hit, the chain or the dive bursts it.
- A spore never comes without its 0.9 s lean.
- A cloud never crosses rock, never poisons outside its dotted edge, and never is stopped by a shield.
- Fire never hurts Akeris when it clears a cloud.

## 10. Acceptance

1. It breathes (`captures/respira.png`); close, it swells and bursts (`sheet-burst.png`); stepping back when it swells, the
   cloud does not reach (`sheet-back.png`).
2. Inside the cloud Akeris loses 1 a second and 2 s more (`captures/dentro.png`).
3. A hit while it swells bursts it in his face (`sheet-pop.png`); while it lies open, three hits defeat it and it lets out its
   last small cloud (`sheet-open.png`).
4. From afar its spore lands at his feet and bursts (`sheet-spit.png`); a block bursts it in front; the just block sends it
   back and takes 1 (`sheet-block.png`); with the ice shield it freezes the pod, with the fire shield it burns it dead
   (`sheet-reflect.png`).
5. The chain takes 1 from afar and bursts it if it swells (`sheet-chain.png`).
6. A fallen torch burns it; fire clears a cloud without harm (`sheet-torch.png`).
7. In the dark only its pores and clouds show (`captures/oscuridad.png`, `captures/oscuridadNube.png`).

## 11. Exports

From the zone 4 sandbox (`vpExportAll()`, the sounds with `vpExportSfx()`): `sprites/sheet.png` (six poses, the spore and the
cloud), six single poses, nine frame sheets (`burst`, `back`, `pop`, `open`, `spit`, `block`, `reflect`, `chain`, `torch`) and
twenty screenshots in `captures/`. Tests: the 18 scenarios `vp*` (`vpAll()`), the list of pods (`vpList()`) and the random
player `vpFuzz()` (96 fights of 60 s, in turn in every kind of room with pods, half with the chain, a third with the ice
shield and a third with the fire shield: never poisoned without a cloud or a pool, never through rock, never a burst without
its full telegraph or a hit, never a spore without its lean, never moving, never back from defeat, never stuck, never more
than 30 clouds or 12 spores).

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| VP1 | Look | a pale fungus bulb on rootlets, ink veins, a cap, three pores in a row (the mark); no new colour; it breathes |
| VP2 | The burst | within 300 su: 1.2 s swell (operator: longer) (pores lit, hiss), a 150 su cloud for 3 s; deflated 4.5 s (open the last 1.5 s) |
| VP3 | The spore | 300–700 su: 0.9 s lean (operator: longer), a spore in an arc to his feet, a 90 su cloud for 2 s; 2.5 s between spores |
| VP4 | The cloud | poisons as the pools do (operator); no shield, no roll; never through rock |
| VP5 | Shield and spore | a block bursts it in front; the just block (any shield) sends it back: −1; the ice shield also freezes 0.5 s, the fire shield burns it dead (operator: the reflect rule) |
| VP6 | Hits | 3; a hit, the chain or the dive while it swells bursts it at once; the chain from 340 su |
| VP7 | Death | deflates and lets out a small cloud (90 su, 1.5 s) (operator) |
| VP8 | Fire | a fallen torch burns it at once; fire clears clouds with no harm (operator); no fireball in zone 4 (operator) |
| VP9 | Dark | only the pores and the clouds, faint |
| VP10 | Place | only on the floor of the rot rooms (operator), never in a pool or by a door; 1–2 per room |
| VP11 | Health and numbers | 3 health; every number is the sandbox's |
| VP12 | Sound | swell, burst, spit, pop, hurt, die, flash; no echo or reverb (the jungle) |
