# Mantis — character contract

- **Status:** approved 2026-10-06 (MA1–MA12 as the sandbox does them, in several rooms)
- **Kind:** enemy (zone 4, the Rotting Canopy); the zone's duelist: fast bursts that force blocking
- **Sandbox:** the zone 4 sandbox, [`../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`](../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html):
  the mantises live in several rooms of the zone, whatever the room's enemy (*Ir a… mantis*: 550 su from the clearing's;
  *nido*, *hueco*) · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 4: *Mantis (fast bursts that force blocking)*) ·
  `04-zones/zone-4-rotting-canopy/biome.md` (palette, darkness), `hazards.md` (torches, webs) · `00-game/controls.md` §Combat
  (the roll's brief invulnerability, G16: what each shield does on a just block against a melee hit, G18) · the operator's
  decisions of 2026-10-06: the proposal MA1–MA9 approved, except that **rolling always dodges** («siempre rodar te permite
  esquivar a los enemigos para golpearlos desde distintos ángulos»), and **it can be found in several rooms of the map**
- **Built on:** its own shape (no skeleton)
- **Code name:** `mantis` · **Español:** mantis

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

A tall, upright mantis of ink, thin as a twig, pale as the zone's fungus, with two serrated bone scythes folded before its
chest as if praying and its wings closed over its back like a dry leaf. Waiting among the ferns it looks like a broken
branch. When it attacks it snaps its wings open and shows, on each, **the mark of the three hollows**, then lunges and
slashes four times in a breath. A player reads: the open wings are the warning; raise the shield, or roll through it and
hit its back.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 210 to the antennae, ≈ 190 to the head | Akeris = 192 |
| body | the abdomen ≈ 104 long, low and behind; the prothorax ≈ 92, a long neck rising forward | — |
| legs | four thin walking legs, knees above the body | the far pair drawn faint |
| scythes | coxa 24, femur 50 (four inner spines), tibia 40 (three spines and a hook) | folded in front of the chest at rest |
| wings | closed ≈ 110 (a dry leaf over the abdomen); open, fanned up behind, ≈ 130 with an eye of bone at 62 % | the mark |
| burst reach | 150 in front of it; the last slash rises to 300 above the floor | — |

**Silhouette test:** a tall twig on four high-kneed legs with two folded scythes and a triangular head with two big eyes.
Never a spiderling (round, eight legs, low), never a strangler vine (rooted, no legs), never a spirit (cream, round).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| body, head | pale fungus `#c9bea7`, ink outline | 1.6–1.7 | segment lines on the abdomen at 45 % |
| wings | rotten wood `#857a66`, ink veins at 55 % | 1.5 | — |
| scythes, eyes | bone `#ddd6c6`, ink spines | 1.5 | — |
| the mark (on the open wings) | bone eye with three ink hollows in a row | 1.3 | — |
| legs | ink (near), `rgba(26,23,21,.5)` (far) | 2.2 / 1.6 | — |
| burnt | `#1f1b18` | — | — |
| frozen | the ice shield's pale blue over it at 45 % | — | — |

No new colour: the zone's pale fungus, rotten wood and bone (`biome.md` §A.3). In the dark only its eyes show (awake), and the
marks of its wings when it opens them.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| lurk | spawn, Akeris gone | — | yes | wake | praying, still, eyes half shut: a broken branch (`lurk`) |
| wake | Akeris within 300 su, or a hit | 0.45 | no | stalk | it lifts its head, the wings flick |
| stalk | wake, the end of any attack | — | yes | display, crouch, lurk | walks in short bursts on high knees, facing Akeris (`walk-1`, `walk-2`) |
| display (the telegraph) | stalk | 0.5 | no | dash | rears up, wings snap open (the mark), scythes raised high (`display`, `sheet-attack.png`) |
| dash | display | ≤ 0.47 | no | burst | leans low and lunges, two fading copies behind (`dash`) |
| burst | dash | 0.7 | no | tired, recover | four slashes 0.16 s apart, near scythe, far, near, both rising; a trail on each (`slash`, `slash-far`, `slash-rise`) |
| tired | the whole burst blocked | 1.0 | no | stalk | head low, scythes dropped to the floor, eyes shut (`tired`, `sheet-block.png`) |
| recover | a slash lands (0.6), or the burst touched nothing (0.9) | 0.6 / 0.9 | no | stalk | it gathers its scythes back |
| crouch, hop | Akeris close (stalk) | 0.12 + 0.62 | no | stalk | a jump back of ≈ 280 su, legs tucked, wings half open (`hop`, `sheet-hop.png`) |
| flinch | hit while stalking | 0.22 | no | stalk | leans back |
| stun | the sacred just block (1.5), the chain in its display (0.8), the dive (1.2) | — | no | stalk | as tired, graphite stars (`sheet-stun.png`) |
| burn | the fire shield's just block, a fallen torch, a burning web | 1.5 | no | stalk | flailing, a flame on its back |
| death | its last health | 1.7 | no | — | flips back in the air, lands on its back with its legs folded up and fades like a dry leaf (`dead`, `sheet-death.png`); burnt: black |

## 5. Weapons and gear

None: its two scythes.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| the mark | display | the bone eye with three hollows on each wing, growing as they open | the display |
| afterimages | dash | two copies behind it, fading | the dash |
| slash trail | each slash | a thin ink arc in front (the last one sweeping up) | 0.1 |
| stars | stun | graphite stars over its head | the stun |
| block sparks, callouts | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.mantis.rustle` | it wakes | `07-audio/sfx/sfx.md` |
| `sfx.mantis.display` | the telegraph | `07-audio/sfx/sfx.md` |
| `sfx.mantis.dash` | the lunge | `07-audio/sfx/sfx.md` |
| `sfx.mantis.slash` | each slash of the burst | `07-audio/sfx/sfx.md` |
| `sfx.mantis.hop` | it hops back | `07-audio/sfx/sfx.md` |
| `sfx.mantis.tired` | the whole burst blocked | `07-audio/sfx/sfx.md` |
| `sfx.mantis.hurt` | it is hit | `07-audio/sfx/sfx.md` |
| `sfx.mantis.die` | its last health (not by fire) | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.burn`, shield sounds | burning; blocks | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | 5 | proposal |
| damage | a slash that lands: Akeris hurt (the common hurt, −2 in the sandbox) and thrown back; the burst ends there | proposal |
| where | on clear floor of several rooms (operator: «en varias salas del mapa»): `clearing` (by the fern, away from the fallen log), `nest` (under the sacs, between the torch and the vine), `hollow` (past the floor web), `rootEnd` (by the fern, away from the altar); 16 in a zone of seed 1. How many per zone and in which rooms is decided with the other enemies after zone 5 (operator, 2026-10-06) | operator |
| XP and coins | the game decides | `VISION.md` §Assumptions |

**Behaviour:**

1. **Lurking (MA1).** It waits praying among the ferns, like a broken branch. It wakes when Akeris comes within **300 su**
   on its floor, or when it is hit. If he leaves its room it walks back to its spot and lurks again.
2. **The telegraph (MA2).** On its floor and within **440 su**, it rears up, **snaps its wings open showing the mark** and
   raises its scythes with a dry hiss, for **0.5 s**; while it warns it turns to face Akeris, afterwards it does not.
3. **The burst (MA3).** It lunges (**900 su/s**, up to 420 su) to stop **90 su** in front of him and slashes **four times,
   one every 0.16 s**, stepping 14 su with each; the last slash rises (up to 300 su above the floor). It never turns during
   the lunge or the burst.
4. **The roll always dodges (MA4, operator).** The roll's invulnerability (0.32 s) passes any slash, and **a roll through
   it leaves it behind him**: its slashes go on forward and miss, and a burst that touches nothing leaves it **open 0.9 s**
   — time to turn and hit its back. Jumping over it works the same way. A roll toward it works from the last part of its
   telegraph to the moment of the first slash, from any distance (`mtRollSweep()`).
5. **A slash that lands (MA5).** Akeris is hurt and thrown back; the burst ends; it gathers itself (0.6 s).
6. **The shield (MA6).** A block stops each slash and pushes Akeris back a little; **the whole burst blocked leaves it open
   1 s** (tired: scythes on the floor). The ice shield spends one use per blocked slash.
7. **The just block (MA7, G16).** On **any** slash, it cuts the burst: with the **sacred** shield, the counter (stunned
   1.5 s; the counter's blows take 2); with the **ice** shield, frozen 1.5 s (hits take double); with the **fire** shield,
   it burns 1.5 s (−1 every 0.5 s).
8. **It hops back (MA8).** Outside its attack it will not be crowded: when Akeris comes within **170 su** it hops back
   ≈ 280 su (on its floor, never into a flame) and soon warns again; then 1.4 s before it hops again. In the air its hops
   cannot be hit. Cornered, it attacks instead.
9. **Hits (MA9).** It takes **5 hits**, in every state but the air of a hop. A hit while it stalks makes it flinch. The
   **chain** takes 1; thrown during its telegraph it **cuts it** and stuns it 0.8 s. The **dive** next to it stuns it 1.2 s
   and takes 1.
10. **Fire (MA10).** A fallen torch or a burning web under it sets it burning 1.5 s; it never walks into a flame nor
    attacks across one.
11. **Its floor (MA11).** It keeps to its own floor and room: never into a pool, off an edge or into a wall; webs do not
    slow it (it is light).
12. **Defeated, it stays defeated (MA12)** for the run (operator, 2026-10-01; every enemy). A mantis is not a room enemy: it
    lives beside whatever the room has.

## 9. Never

- Nothing trembles: it walks, lunges and slashes smoothly; strokes never change.
- A lunge never comes without its full 0.5 s telegraph, and it never turns once the telegraph ends.
- A roll never fails to pass a slash while its invulnerability lasts (operator: rolling always dodges).
- It never slashes more than four times in a burst, nor hits Akeris twice in one burst.
- It never leaves its floor, its room, nor stands in a pool, a wall or a flame.

## 10. Acceptance

1. Lurking it looks like a branch (`captures/acecho.png`); close, it wakes (`despierta.png`).
2. The telegraph shows the mark; it lunges and bursts; a slash knocks Akeris back (`sheet-attack.png`).
3. The shield stops the four slashes and it is left open; a hit takes 1 (`sheet-block.png`).
4. A roll through it passes the burst; Akeris turns and hits its back (`sheet-roll.png`, `rueda.png`, `ruedaTarde.png`).
5. The just block: sacred counter, ice freeze, fire burns it (`sheet-just.png`).
6. Crowded, it hops back (`sheet-hop.png`); the chain in its telegraph and the dive stun it (`sheet-stun.png`).
7. Five hits and it falls on its back and fades; a fallen torch burns it (`sheet-death.png`).
8. In the dark its eyes and its wings' marks show (`captures/oscuridad.png`).

## 11. Exports

From the zone 4 sandbox (`mtExportAll()`, the sounds with `mtExportSfx()`): `sprites/sheet.png`, eleven single poses, seven
frame sheets (`attack`, `block`, `roll`, `just`, `hop`, `stun`, `death`) and eighteen screenshots in `captures/`. Tests: the
17 scenarios `mt*` (`mtAll()`), the list of mantises (`mtList()`), the roll sweep (`mtRollSweep()`: Akeris rolls toward it
at every instant of its attack from 200, 300 and 420 su) and the random player `mtFuzz(runs, secs, mixed)` (fights of 60 s in
turn in the four kinds of room, half with the chain, a third with the ice shield and a third with the fire shield; `mixed`
keeps the nests, pods and vines awake: never a lunge without its full telegraph, never a burst without a lunge, never more
than four slashes, never turning in the lunge or the burst, never hit while rolling or blocking, never off its floor, in a
pool, a wall or another room, never stuck in a state, never in a flame without burning; 2026-10-06: 96 + 96 fights without
failures).
