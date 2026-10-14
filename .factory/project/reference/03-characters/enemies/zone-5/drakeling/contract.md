# Drakeling — character contract

- **Status:** approved (step 3.15; operator, 2026-10-07)
- **Kind:** enemy (zone 5, the Dragon Battlements); the zone's fire spitter
- **Sandbox:** the zone 5 sandbox, [`../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`](../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html):
  the drakelings live perched on the merlons of several open rooms of the zone, whatever the room's enemy (*Ir a… combate*,
  *adarve*, *patio*, *brecha*) · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 5: *Drakeling (fire spitter)*), §Mechanics (Shields: the fire shield blocks
  fire attacks) · `02-art-direction/fx/elements/elements.md` (fire: only the fire shield stops it) · `00-game/controls.md`
  §Combat (the roll's brief invulnerability; G7: a projectile blocked just before impact flies back at its thrower; G16) ·
  `03-characters/akeris/weapons/hook-blades.md` §6 (the chain does not immobilize; each own reaction to the chain at most
  once every 5 s) · `04-zones/zone-5-dragon-battlements/hazards.md` (the merlons) · the operator's approval of the proposal
  DR1–DR9 as it stood (2026-10-07: «ok apruebo sigue adelante»), including no fire left on the floor (DR7) · the operator's
  review (2026-10-07: «mejora la animación de muerte, más que el dragoncito te persiga y tenga más tipos de ataque; recuerda
  que esta debe ser la zona más difícil de la demo»): the chase, the dive, the fan, the flame breath, the new death
- **Built on:** the Dragon's stand-in drawing (`zdShape`, `zdHead`, `zdWing`…), small: one family
- **Code name:** `drakeling` · **Español:** dragoncillo

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

A young of the Dragon, nesting in the walls: the Dragon small, of the same family, four legs, ragged leather wings, short
horns, the ember eye and the fire glowing in its throat. Asleep, folded on top of a merlon, it looks like a small gargoyle.
Awake it hunts: it follows Akeris across its room at the height of a jump and mixes four attacks — the spit (every third one
a fan of three), the dive, the flame breath at close range and the bite. A player reads: the throat lights up, it breathes in,
fire comes; it rises and folds its wings, it dives. Take cover behind a merlon, raise the fire shield, roll, or jump at it
with a blow. Zone 5 is the hardest of the demo: one drakeling is a fight, two are a danger.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height, perched | ≈ 110 to the head | Akeris = 192; drawn at 0.3 of the Dragon's units |
| length | ≈ 230 from the tail tip to the snout | — |
| wings | open ≈ 260 tip to tip; folded flat along the back | ragged, with a tear |
| head | the Dragon's head at 0.7 of the body's scale: a young's proportions | two short ringed horns |
| hover | ≈ 230 above Akeris's floor | in reach of a jump with a blow |

**Silhouette test:** a small four-legged winged lizard with a long tail and a horned head. Never the Gargoyle (stone,
still, a statue), never the Dragon (≈ 1000 su), never a bat (no legs, no tail).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| body, neck, tail, head | `wood` `#6e5f4d`, scales in pencil | 0.8 inner + **a 1.2 px ink outline around the whole silhouette** (at its size an inner stroke would be a thread) | scale arcs at 28 % |
| far legs and wing, spines | `fire` iron `#5d4637` | — | — |
| wing membrane | `mortar` `#35302a` (the far one `#2b2622`) | — | veins at 18 % |
| belly plates | `rock` `#a39a8a` | — | — |
| horns, talons, teeth | `bone` `#ddd6c6` | — | rings |
| eye, the glow in the aim | `fire` `#e0782c` | — | — |
| frozen | the ice shield's pale blue over it at 40 % | — | — |

No new colour. Warmer than its father (`iron`), so it reads against the zone's grey stone and is never taken for the
Gargoyle.

## 4. Animations

Poses are kept as sprites (`sprites/<pose>.png`); the flight is a wingbeat in 8 frames (`sprites/sheet-fly.png`).

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| sleep | spawn, Akeris gone (it flies back to its merlon) | — | yes | wake | crouched on the merlon, head on its claws, wings folded, eyes shut (`sleep`) |
| wake | Akeris within 500 su (and 420 su up or down), a hit, its merlon broken | 0.5 | no | fly | head up, jaw open, wings up: a screech (`wake`) |
| fly | wake, after an attack, after a stun | — | yes | aim, diveTel, breathTel, biteTel, toPerch | a wingbeat in 8 frames, legs tucked (`fly0`–`fly7`) |
| toPerch / perched | every three attacks, on the nearest whole merlon not next to Akeris (or its floor spot) | 0.8–1.6 | — | aim, breathTel, biteTel, fly | perched, wings folded (`perch`) |
| aim | spit ready | **0.6** | no | spitRec | head back, throat and chest glowing, wings raised, an ember in the mouth; it turns to Akeris until 0.12 s before (`aim`, `aimP`) |
| spitRec | the spit (every third, a fan of three) | 0.35 | no | fly / perched | head forward, jaw open (`spit`) |
| diveTel | in flight, Akeris on the floor 200–640 su away | **0.5** | no | dive | it rises 70 su and folds its wings; a dashed line marks the point it will strike; the target is fixed 0.15 s before |
| dive | the warning | ≤ 0.75 | no | diveOpen, fly, stun | head first, wings folded, at 980 su/s, tilted along its path |
| diveOpen | the dive reaches the floor | 0.7 | no | fly | on the floor, open to blows |
| breathTel | Akeris within 300 su of its mouth, a clear line | **0.5** | no | breath | it breathes in: the throat glows, the head goes back (`aim`) |
| breath | the warning | 0.8 | no | fly / perched | a cone of flame from the open jaw, 290 su long (`spit`) |
| biteTel | Akeris within 140 su on its level | **0.3** | no | bite | head drawn back, jaw open (`biteTel`) |
| bite (biteRec) | the bite | 0.5 | no | fly | lunging, jaw closed on air (`bite`) |
| down | the chain's reaction, its own fireball returned | until it lands | no | stun | it falls |
| stun | down, the sacred shield's just block on the bite or the dive | 1.0 (1.5 after the counter) | no | fly | on its side, wings drooped (`stun`), stars |
| dead | 0 health | ≈ 2.5 | no | — | in the air it falls spinning, wings limp; it hits the floor with a burst of embers and lies on its side (`dead`); 0.6 s later it starts to turn into ink, 1.5 s after landing it is gone; over a gap it falls into the chasm |

## 5. Weapons and gear

None: its fire and its teeth.

## 6. Effects

| Effect | When | Look |
|---|---|---|
| the throat's glow | the aim | the chest and the belly plates glow `fire`, an ember in the mouth |
| the fireball | the spit | `02-art-direction/fx/elements/elements.md` §2 (fireball, embers behind) |
| returned | a just block with the shield that stops it | `reflect`, then it flies back at the drakeling (aimed at it, faster) |
| burning | its fireball returned with the fire shield; the fire shield's just block on the bite | a flame on it, `burn` |
| frozen | the ice shield's just block on the bite, its fireball returned with ice | the pale blue over it; frozen in the air it falls |
| the dive's warning | diveTel | a dashed `fire` line from it to the point it will strike |
| the flame breath | breath | a cone of `fire` and `fireIn` tongues from the jaw, drawn above the darkness; it goes out on the stone (no fire on the floor) |
| defeat | 0 health | it falls spinning; on the floor a burst of embers, then ink smoke rising, like every enemy |

## 7. Sounds

All `sfx.drakeling.*` (`07-audio/sfx/sfx.md`, *Enemies of zone 5*; WAV in `07-audio/sfx/enemies/`).

| Id | When |
|---|---|
| `wake` | it wakes (a hoarse screech); softer, on the bite's warning |
| `flap` | it takes off |
| `inhale` | the spit's and the flame breath's warning: it breathes in, the throat crackles |
| `spit` | the fireball leaves |
| `dive` | the dive: a screech falling, the air torn |
| `breath` | the flame breath: a short roar of fire |
| `bite` | the teeth snap |
| `hurt` | it is hit |
| `land` | it perches, or falls to the floor |
| `die` | it is defeated |
| `embers` | it hits the floor defeated: embers crackling out |

## 8. Mechanics

Numbers are the sandbox's; **the game decides**.

| # | Rule |
|---|---|
| DR1 | **Who:** a young of the Dragon; drawn as the Dragon small (§1–§3). |
| DR2 | **Where:** **one** per drakeling room, on top of one merlon — `wallWalk` (1760 or 2860), `bastion` (1240 or 2760), `ward` (1300), or the stub of wall of the `breach` (1600) — never in a gargoyle's room (the rooms' plan: `04-zones/zone-5-dragon-battlements/layout.md`, operator 2026-10-08), never in the towers nor in the boss room; it is not the room's enemy. Seeds 1–3: 6–8 in the zone. How common each enemy is per zone is decided after zone 5. |
| DR3 | **Movement — it hunts** (the operator's review): wakes at 500 su; flies at ≈ 230 su above Akeris's floor and **follows him across its room**, keeping 280–420 su on its side (330 su/s; 420 su/s when he gets away); every three attacks it perches on the nearest whole merlon not next to Akeris (0.8–1.6 s) and attacks from there too. It never leaves its room nor goes through stone; when Akeris leaves, it flies back to its merlon and sleeps. If its merlon breaks, it takes off. |
| DR4 | **The spit:** a 0.6 s warning, then **a fireball straight at Akeris's chest** (560 su/s, **2** of damage); **every third spit is a fan of three** (±0.2 rad, each 2); then 1.6 s before another attack; from 220 to 700 su and only with a clear line (a merlon in the line counts: it stops it). **Fire:** only the fire shield stops it (one use); a just block with it **returns it** (aimed back at the drakeling): −1, **burns it 0.5 s** and **knocks it down 1 s**. The sacred and ice shields do not stop fire (`elements.md`). **Rolling dodges it always.** **The merlons stop it**, and every fireball wears one (3 break it): the drakelings strip the wall walk of its cover. |
| DR5 | **The bite:** if Akeris is within 140 su on its level, a 0.3 s warning and a bite (**1** of damage, a push, no knockdown). A melee hit: any shield stops it; the just block does what each shield does (G16: sacred, the counter, it is stunned 1.5 s and the counter's blows take 1 each; ice, frozen 1.5 s; fire, burning). **Rolling dodges it.** Then it flies away. |
| DR5b | **The dive** (the operator's review): in flight, with Akeris on the floor 200–640 su away, 45 % of the times it may: a **0.5 s warning** (it rises and folds its wings; a dashed line marks the point; the target is fixed 0.15 s before), then it dives at 980 su/s at where Akeris was: **2** of damage. A melee hit: any shield stops it; the just block does what each shield does (sacred: the counter, it is stunned 1.5 s). **Rolling dodges it** at any moment of the roll. If it reaches the floor it stays **0.7 s on the stone, open to blows**; then 1.8 s before another attack. |
| DR5c | **The flame breath** (the operator's review): Akeris within 300 su of its mouth and a clear line: a **0.5 s warning** (it breathes in), then a **cone of flame** 290 su long (±0.3 rad) for 0.8 s: **1 every 0.3 s** while Akeris is in it (3 at most). Only the fire shield stops it (one use for the whole breath); the sacred and ice shields do not. **Rolling dodges it.** A merlon between it and Akeris (crouched behind it, or standing if it covers him) stops it entirely and loses one (once per breath). Then 2.2 s before another attack. |
| DR6 | **How it is beaten:** **3** health. In flight it is reached by a jump with a blow (the blade's sweep, measured on each weapon's real blade: sword, spear, hammer and flail all reach it) or by the chain blades at range (they do not interrupt it). **Its own reaction to the chain:** the chain hooks it and **brings it down to the floor, stunned 1 s** — at most once every 5 s; otherwise only the damage. **Its own fireball returned** knocks it down 1 s. Frozen it takes double. Over a gap, knocked down, it falls into the chasm. **Defeated** in the air it falls spinning, hits the floor with a burst of embers and turns into ink (≈ 2.5 s); over a gap it is lost in the chasm. |
| DR7 | **No fire on the floor** (operator): a missed fireball goes out on the stone in sparks. The floor that burns is the Dragon's. |
| DR8 | **Sounds:** §7. |
| DR9 | **Never:** an attack that rolling does not dodge (the spit, the fan, the dive, the flame breath, the bite); standing still under the chain's blows; more than 2 s out of reach of a jump with a blow; going through walls. |

## 9. Never

- An attack the roll does not dodge.
- Fire the sacred or ice shield stops (fireball, fan or flame breath).
- An attack without its warning (spit 0.6 s, dive 0.5 s, flame breath 0.5 s, bite 0.3 s).
- Being held still by chain hits (its reaction, at most once every 5 s).
- Flying out of reach of a jump with a blow for more than 2 s, or leaving its room.
- Fire left burning on the floor.
- Its colours on the Gargoyle, or the Gargoyle's on it.

## 10. Acceptance

Tested in the sandbox (2026-10-07; again after the review, the same day):

1. Asleep, it wakes at 500 su and flies 0.5 s later.
2. Its fireball takes 2; with the sacred shield raised, still 2; with the fire shield, 0 (one use); a just block with the fire shield returns it: the drakeling −1, burning, knocked down.
3. Rolling through the fireball and through the bite: no damage.
4. Crouched behind a merlon: no damage; the merlon loses one (3 → 2).
5. The bite takes 1; blocked, 0; the sacred just block opens the counter (it is stunned; the counter takes it down to 1).
6. The chain brings it down and stuns it; a second chain within 5 s only hurts it (3 → 2 → 1, one down).
7. Standing, the sword does not reach it in the air; three jumps with a blow defeat it. Spear, hammer and flail reach it too (each weapon's real blade).
8. The dive takes 2; blocked, 0; the sacred just block opens the counter (it is stunned); rolled through, 0. It reaches the floor and stays open 0.7 s.
9. The third spit is a fan of three fireballs.
10. The flame breath takes 3 (1 every 0.3 s); with the sacred shield raised, still 3; with the fire shield, 0 and one use for the whole breath; rolling through it, 0; crouched behind a merlon, 0 and the merlon loses one (3 → 2).
11. Defeated in the air it falls spinning, lands with embers and is gone 1.5 s after landing.
12. A random player against them (48 runs of 40 s per seed, seeds 1–3, twice, in their rooms, with sword, chain blades, hammer and spear and each shield): no errors; a drakeling never inside the stone, never out of its room, never out of reach more than 2 s; **no damage while rolling** (a jump in the roll's first frame cancels the roll, by design: that is not a roll). Harder than before, as asked: a simple bot that never rolls and ignores the dive and the breath takes ≈ 10–24 per drakeling and wins only 2–5 of 6 fights in 40 s (the chain blades 2.2 s; the sword 5.1 s when it wins). The random player across the whole zone and the boss room test: unchanged.

## 11. Exports

- [`sprites/sheet.png`](sprites/sheet.png): the 12 poses, and each alone (`sprites/<pose>.png`)
- [`sprites/sheet-fly.png`](sprites/sheet-fly.png), [`sheet-spit.png`](sprites/sheet-spit.png), [`sheet-bite.png`](sprites/sheet-bite.png), [`sheet-down.png`](sprites/sheet-down.png), [`sheet-dive.png`](sprites/sheet-dive.png), [`sheet-breath.png`](sprites/sheet-breath.png)
- [`captures/`](captures/): asleep on its merlon, flying, the warning, the spit, the fire shield, the fireball returned, the merlon taking the fire, the bite, the chain, stunned, a jump with a blow; the dive's warning and the dive, the fan, the flame breath's warning and the breath, the death falling and its embers (18)
- The sandbox exports it all with `dkExportAll()` and the sounds with `dkExportSfx()`.
