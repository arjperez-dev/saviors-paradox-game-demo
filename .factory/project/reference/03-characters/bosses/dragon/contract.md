# The Dragon — character contract

- **Status:** approved 2026-10-13 (operator: «me gustó mucho como quedó el dragón en general»; step 3.15; DG1–DG18 approved by the operator on 2026-10-12 with its
  three open decisions: **three phases** (ground, air, rage); **the bite cannot be blocked**; at the end **the choice
  first, then the ending**)
- **Kind:** boss (zone 5, the Dragon Battlements; the demo's last and strongest boss)
- **Sandbox:** the zone 5 sandbox, [`../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`](../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html)
  (*Ir a… jefe*; walking 280 su past the door seals the room; 2.5 s later it wakes) · scenarios `#dg-<name>` (§11) ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Bosses (Dragon: «fire bursts (low and high breath), earthquakes when slamming into the floor,
  wind slashes from its wings, floor eruptions telegraphed by glowing cracks; plus claw (blockable), bite, flight with wind
  gusts, dive; fire blocked by the fire shield; finisher: hook the horn and strike the neck»), §Abilities (*Breath*,
  *Earthquake*), §Mechanics (the fire shield: 4 uses against the dragon), §Win · `01-story/dialogue/zone-5.md` (the warning
  spirit: «When the floor glows…», «The merlons will take the fire for you…», «The fire shield drinks its breath…», «When it
  lowers its head, hook its horn with your chain, and strike the neck») · `../../../04-zones/zone-5-dragon-battlements/boss-room.md`
  (the arena, approved), `hazards.md` (the merlons) · `../../akeris/weapons/hook-blades.md` §6 (the chain does not hold
  still) · `00-game/controls.md` (G7, G16) · `../giant-spider/contract.md` (the shape of this contract, the bar and the
  choice) · the approved stand-in (`boss-room.md`: its drawing asleep and awake is the base)
- **Built on:** the stand-in's pieces (`zdShape`, `zdHead`, `zdWing`, `zdTube`, `zdSpines`, `zdPlates`, `zdTalons`), now
  articulated: hips, shoulders, four legs, an S neck, the head, the tail and two wings that move between key poses
- **Code name:** `dragon` · **Español:** el dragón

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

The last guard the wall-builders found, old and scarred: it has forgotten why it guards, not how. It sleeps coiled on its
broken tower over the highest bastion; when the doors seal it wakes, roars and leaps down. It fights first on the stones,
then in the open air over the bastion, and at last in a rage with red eyes and fire between its scales, when the cracks of
the floor burst into columns of fire. Its fire glows between the plates of its belly before each breath. When it lowers its
head, the chain finds its chipped horn. A player reads: watch the belly and the neck; keep behind the stones when it
breathes; when the head is down, hook the horn and strike the neck.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| length | ≈ 1000–1100 from tail to snout | the stand-in at 0.78 (`DG.K`); Akeris = 192 |
| standing height | ≈ 250 to the back, ≈ 440 to the head, ≈ 560 to the wing tips | the head rises to ≈ 600 roaring |
| torso | ≈ 410 × 160, its belly ≈ 90 above the floor | belly plates with fire between them |
| head | ≈ 155 long; two ringed horns, **one chipped** (the finisher's) | the ember eye with a slit pupil; red in the rage |
| neck | an S of ≈ 330, its plates along the throat | lowers to put the head on the floor in front (≈ 545 su ahead of its middle) |
| wings | arm, elbow, wrist, four finger bones, scalloped membrane with a tear | span ≈ 900 in flight |
| tail | ≈ 600, spines (one chipped), a spade tip | sweeps ≈ 860 su behind its middle |
| in flight | its feet line 380 su over the floor (belly ≈ 470, the torso's middle ≈ 540) | in reach of the chain from the floor and of a jump from the hanging walks |

**Silhouette test:** a long four-legged body with a raised S neck, two horns and huge leathery wings, seen side on. Never
the drakeling (small, wood-coloured, an ink outline), never the gargoyle (stone, hunched), never the giant bat.

## 3. Palette and strokes

| Part | Colour | Stroke width (su, before 0.78) | Hatching |
|---|---|---|---|
| body, neck, tail, head | `iron` `#5a554e`; far legs `#46413b` | 2.2–3 | pencil scales (a pattern of the stand-in's arcs, ink at .28) and the shade below |
| spines, gorget | the fire shield's iron `#5d4637` | 1.2–1.5 | — |
| horns, talons, teeth, wing claws | `bone` `#ddd6c6` | 0.9–1.8 | rings on the horns |
| membrane | `#35302a` (far `#2b2622`) | 2 | veins `rgba(163,154,138,.18)` |
| belly plates | `#a39a8a` | 1.2 | the fire between them `#e0782c` |
| eye | `#e0782c` ember with an ink slit; **red `#9e1218` in the rage** (the other bosses' red eyes) | 1.8 | — |
| fire (breaths, rain, columns, mouth) | `flame` `#e8872e` / `#ffd978`, glow `rgba(255,160,70,…)`, embers `#e8872e` | 1.6 | — |
| wind (gusts, slashes) | `rgba(232,228,214,…)` with an ink edge | 5.5 / 10 | — |
| dust wave | `#a39a8a`, `#8b8273` | 1.4–2.2 | — |

No new colour. In the dark: its eye (red in the rage), the glow of its chest, and all its fire are drawn over the darkness.
**Nothing trembles:** every stroke is seeded per part; the same frame drawn twice gives the same pixels (tested); the body
moves smoothly between key poses.

## 4. Animations

| Animation | Entered from | Duration (s) | Exits to | Look |
|---|---|---|---|---|
| asleep | the zone placed | — | wake | the approved stand-in drawing: coiled on its tower, wing folded, smoke from the nostril, breathing every two bars (`sleep`) |
| wake | 2.5 s after the doors seal (the bridge falls) | 0.7 | roar | it rises on the tower, the wings half open |
| roar | wake, 28, 14 | 1.5 | leap, take-off, the rage | head thrown up, jaws open, wings spread; no damage, no push; **untouchable** (`roar`) |
| leap | the wake's roar | 1.15 | ground | from the tower to the bastion in one arc; dust; no damage (`sheet-wake.png`) |
| ground | — | — | an attack, turn, hop | walks to keep 420–700 su from Akeris (`stand`, `walk`) |
| turn | Akeris behind for 0.9 s (and not in the tail's reach) | 1.0 | ground | **a real turn for a huge body** (operator, 2026-10-12): the neck swings up and back first, it rears on its hind legs with the wings pressed in until the body is almost vertical (the same from both sides), turns there — the change of side fades over 0.14 s, pivoting on its hind feet — and comes down facing the other way; the tail follows last; a step and dust on landing (`turn`, `sheet-turn.png`). It never squashes or folds; in the air a change of side fades over 0.25 s between wingbeats |
| hop | Akeris > 1150 su away | 1.0 | ground | a wing-assisted hop of up to 1300 su toward him |
| claw | ground | 0.5 + 0.45 | ground, stunned | the near forepaw raised, then brought down ahead (`clawTel`, `claw`, `sheet-claw.png`) |
| bite | ground | 0.45 + 0.16 + 0.14 | head down | head thrown back, jaws open; then thrown ≈ 450 su forward (`biteTel`, `bite`, `sheet-bite.png`) |
| low breath | ground | 0.7 + 1.2 | ground | the belly glows, it breathes in, the head goes low; the flame sweeps the floor (`lowTel`, `low`, `sheet-breathLow.png`) |
| high breath | ground | 0.7 + 1.0 | ground | the neck raised, then a horizontal jet at the hanging walks' height (`highTel`, `high`, `sheet-breathHigh.png`) |
| tail | ground, Akeris behind | 0.5 + 0.16 + 0.45 | ground | the tail curls up, then sweeps low behind (`tailTel`, `tail`, `sheet-tail.png`) |
| quake | ground | 0.6 + 0.25 | head down | it rears on its hind legs and slams its forepaws (`quakeTel`, `quake`, `sheet-quake.png`) |
| head down | bite, quake, dive, landing | 1.2 (2.0 resting) | rise | the head on the floor in front, panting; the chipped horn in the chain's reach (`down`) |
| pinned | the chain on the horn | 1.5 | rise | the head held to the floor by a chain from the horn to a blade stuck in the stone (`pinned`, `sheet-horn.png`) |
| stunned | the sacred just block on a claw | 1.5 | ground | stars over the head |
| take-off | 28; every ground round in the rage | 0.9 | air | three huge wingbeats (`sheet-phase2.png`) |
| air | — | — | an air attack, land | flaps over Akeris, to one side of him (≈ 280 su), its feet 380 su up; **the whole wing turns on the shoulder as an open fan** (down full, up half-folded), 1.3× span in flight, the body rising and falling with each beat (`fly`, `sheet-fly.png`) |
| gusts | air | 0.5 + 0.6 | air | wings pulled back, then strong beats (`gustTel`, `sheet-gust.png`) |
| wind slashes | air | 0.5 + 0.35 | air | wings raised high, then swept down (`slashTel`, `sheet-slash.png`) |
| dive | air | 0.7 + flight | head down | wings back, the head down; it crosses diagonally (`dive`, `sheet-dive.png`) |
| fire rain | air | 0.6 + 1.8 | air | the belly glows above; it flies across spitting downward (`rain`, `sheet-rain.png`) |
| land | every three air attacks | 0.8 | head down (rest) | it comes down to the stones (`sheet-rest.png`) |
| eruption call | the rage | 0.45 | ground, air | it roars at the floor, the head low (`sheet-phase3.png`) |
| finish | its last mark | — | pinned | collapsed on the bastion, the head on the floor, panting, the eye half shut; waits (`finish`, `sheet-finish.png`) |
| dying | the neck struck while pinned | 2.8 | — | it collapses and dissolves in ink and embers (`dead`, `sheet-death.png`) |

**Motion (operator, 2026-10-12: «mejorar las animaciones»).** Every attack has its weight and anticipation: the claw
leans back on the hind legs and throws its weight forward; the bite coils (head back, body back and low) and springs; the
breaths **swell the chest and neck** while it breathes in, the head drawing back before it drops (low) or rises (high);
the tail sweep counterweights the body forward and looks back over the shoulder; the quake crouches, rears and slams
with a compression; take-off crouches 0.2 s and jumps on the first beat; the landing brakes with open wings; the leap
crouches on the tower; the rests pant (head lifting with each breath, the jaw opening in rhythm); death buckles the legs
and drops the head before the ink. **Secondary motion:** what is drawn follows the pose with a little lag — the head
0.035 s, the wings 0.06 s (the back fingers later), the body 0.045 s, the tail 0.13 s — so neck, wings and tail overlap
and follow through; idle, it breathes and its tail sways. The neck is shorter-looking than the stand-in's (the head
lower and closer, the neck thicker). Static pencil: seeded strokes, the same frame drawn twice gives the same pixels.

## 5. Weapons and gear

None: its claws, its jaws, its tail, its wings and its fire.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| belly glow | every breath, the rain, the blast | the fire grows between the belly and throat plates and in the chest; an ember at the nostril | the telegraph |
| low breath | DG6 | a short jet from the mouth to the floor, then flame tongues along the floor: a bright front band (300 su) running out to 900 su, dying behind it; stops at the first whole merlon (flames on its face) | 1.2 |
| high breath | DG7 | a horizontal jet, thin at the mouth and thick at its front, 230–420 su above the floor, out to 1300 su | 1.0 |
| dust wave | the quake, the dive's landing | dust humps and ink arcs running both ways along the floor | to 1200 su |
| wind slash | DG11 | a pale crescent with an ink edge and three streaks behind | its flight |
| gust | DG10 | pale wind lines streaming from the wings toward Akeris | 0.6 |
| fire rain | DG13 | five fire blobs with trails, each with **its shadow on the floor** where it will land; they go out at once (sparks, a hiss) | their fall |
| glowing cracks | DG14 | the floor's cracks (1200, 2400, 3500) glow brighter for 1 s | 1.0 |
| fire column | DG14 | a column of flame 300 su wide rising ≈ 900 su | 0.45 |
| dive shadow | DG12 | a dashed ink ellipse that darkens and closes where it will land | 0.7 |
| horn chain | DG15 | a chain from the chipped horn to a hook blade stuck in the stone | 1.5 |
| heat blast | DG16 | flames closing on its chest (0.4 s), then three ember rings opening | 1.0 |
| frost | the ice shield's just block | three pale ice dots by its head (slowed) | 2 |
| ink and embers | its end | ink puffs and embers rising from the whole body as it fades | 2.8 |
| callouts | `call.roar` *GRRAAAH!* · *¡GRRAAAH!*; `crack`, `thud`, `clang`, `fwoom`, `burn`, `chain`, `frost`, `reflect` (`02-art-direction/fx/`) | — | — |

## 7. Sounds

Redone on 2026-10-12 (operator): a deeper, bigger, beast-like voice (three detuned saws through two formants, a
sub-octave, a torn throat, the breath), every attack with its own tell and its own blow, the fire that lasts as long as
the breath, and Akeris's blows against its scales.

| Sound id | Trigger |
|---|---|
| `sfx.dragon.roar` (3 takes), `.roarRage`, `.growl`, `.pant` | waking, taking flight, the bite's and the eruption's call; the rage; turning, stunned; resting and at its last mark |
| `sfx.dragon.inhale`, `.breathLow`, `.breathHigh` | the breath drawn in (breaths, rain); the fire streams (1.2 s, 1.0 s) |
| `sfx.dragon.step` (4), `.wing` (3), `.takeoff`, `.hurt` (4), `.fall`, `.die` | its body |
| `sfx.dragon.claw`, `.bite`, `.tail`, `.slam`, `.quake` | the ground attacks |
| `sfx.dragon.gale`, `.slash`, `.dive`, `.fireRain` | the air attacks (the dive's impact is `slam`) |
| `sfx.dragon.crackGlow`, `.eruption`, `.heatBlast`, `.hornHook` | the cracks; the columns; its blast; the horn hooked |
| `sfx.dragon.hitSword`, `.hitSpear`, `.hitHammer` (also the flail and the fast descent), `.hitChain` | Akeris's blows on its body: thick scale, more weight than on other enemies (the generic hit sounds are silenced against it) |
| `sfx.dragon.hitNeck`, `.hitHorn`, `.hitCounter`, `.hitGuard` | the pinned neck (soft, with its bellow); the horn not hooked (bone); the counter; a blow that rings off (`CLANG!`) |

All in `07-audio/sfx/sfx.md` §2 (bosses), WAV in `07-audio/sfx/bosses/dragon-*.wav` (34 ids, 69 files, peak 0.89). Reused:
the drakeling's spit for each blob and its embers at the end, the fire brute's coal hiss when a blob goes out, the shields',
the doors' and the bridge's sounds. The music (`music.dragon.calm`, `.fight`, `music.outro`) is the approved one.

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | **42 marks**, three phases of 14 (28: the air; 14: the rage) | DG3 |
| damage taken | weapons 1 (the chain too); the neck while pinned 2; the counter up to 4; the fast descent on the lowered head 1; a wind slash sent back 1 | DG15, Damage |
| damage dealt | claw 2, bite 3, tail 2, quake wave 2, wind slash 2, dive 3, fire-rain blob 2, eruption 2; the breaths 1 a tick (one every 0.3 s, at most 3) | DG4–DG14 |
| statuses | fire never burns it; ice slows it (half speed 2 s), never freezes it | Damage |
| cannot be hurt | asleep, waking, roaring, dying; at its last mark, only horn + neck | Damage, DG17 |
| XP and coins | the game decides | `VISION.md` §Assumptions |

**Behaviour:**

1. **Wake (DG2).** Asleep on its tower. 2.5 s after the doors seal it wakes, the bridge falls, `music.dragon.fight`
   starts; it roars 1.5 s (no damage, no push) and leaps down to the bastion.
2. **Phase 1, on the ground (DG4–DG9; 42 → 28).** It walks to keep 420–700 su (from its middle); farther than 1150 su, it
   hops toward Akeris with its wings; with Akeris behind it for 0.9 s, the tail, or it turns. Its plan: claw, low breath,
   bite, quake, high breath, bite, low breath, claw — each only when it reaches; on a hanging walk, the high breath. Pause
   1.6 s.
3. **Claw (DG4).** The paw raised 0.5 s, then down ahead (60–470 su): 2. Any shield stops it (the ice spends a use); the
   sacred just block opens the counter and **stuns it 1.5 s**; the ice just block **slows it 2 s**; the fire just block
   blocks (fire does not burn it). Rolling passes it.
4. **Bite (DG5, operator: not blockable).** Head back 0.45 s, then thrown ≈ 450 su (reaches ≈ 830 su ahead): 3. **No
   shield stops it**; rolling or stepping back passes it. Then **head down 1.2 s**.
5. **Low breath (DG6).** Belly glow and breath in 0.7 s; the flame sweeps the floor from its mouth out to 900 su in 1 s and
   lasts 1.2 s: a front band of 300 su up to 170 su high hurts 1 a tick (every 0.3 s, at most 3). **The first whole merlon
   ahead stops it** (that breath counts one of its three) and covers whoever stands behind; the hanging walks are above it;
   jumping over the front clears it; **the fire shield** raised toward it stops the whole breath for **one use**; the sacred
   and the ice do not. Rolling through the front passes it. No fire stays on the floor.
6. **High breath (DG7).** The neck raised 0.7 s; a jet 230–420 su above the floor runs out to 1300 su (band 380 su): on a
   hanging walk or jumping, 1 a tick; **standing or crouching on the floor it passes over**; the fire shield (one use);
   rolling through it at its front.
7. **Tail (DG8).** Only with Akeris behind it: the tail curls 0.5 s and sweeps low 150–860 su behind (2). Jump or roll;
   any shield.
8. **Earthquake (DG9).** It rears 0.6 s and slams: a dust wave runs both ways at 1100 su/s to 1200 su (2 if standing on the
   floor when the front passes). **Jump or roll it**; a hanging walk is safe; no shield. Then head down 1.2 s.
9. **Phase 2, in the air (DG10–DG13; 28 → 14).** It roars and takes off. It flies to one side of Akeris, ≈ 280 su, its
   feet 380 su up: the chain reaches its belly from the floor and a jump reaches it from a hanging walk. If it stays out of
   his reach 0.8 s it comes lower and closer, fast (720 su/s) and does not attack until it reaches him (**never more than 5 s
   out of reach**: 3.7 s at most in the tests). Its plan: gusts, slashes, dive, rain, slashes, dive, gusts, rain; **every
   three it lands and pants 2 s with its head down**, then takes off again.
10. **Gusts (DG10).** Wings back 0.5 s; for 0.6 s the wind pushes Akeris ≈ 250 su away (half with a shield raised toward
    it); no damage; rolling passes it.
11. **Wind slashes (DG11).** Wings high 0.5 s; two crescents (600 su/s) aimed at Akeris's chest from above and below its
    chest, crossing there in an X (2 each). Any shield; **the just block sends one back** (−1); rolling passes them; a merlon
    stops them.
12. **Dive (DG12).** Its shadow grows where Akeris is (0.7 s; the point is fixed 0.15 s before); it crosses diagonally at
    1700 su/s (3 on contact) and on landing **the earthquake's wave**; then head down 1.2 s. Rolling or stepping aside; any
    shield stops the blow, not the wave (jumped, or rolled through: a roll the way it dives passes both).
13. **Fire rain (DG13).** The belly glows above 0.6 s; it flies across 1500 su spitting **five blobs**, evenly spread, each
    with its shadow where it will land (2). Merlons and hanging walks stop them (a blob counts against a merlon); **the
    fire shield stops the whole rain for one use**; rolling passes them. They go out at once on the floor.
14. **Phase 3, the rage (DG14; 14 → 0).** At 14 it roars: **red eyes**, fire between its scales. It alternates: three
    attacks on the ground, takes off, three in the air, lands (head down 1.2 s)… All its attacks, pauses 1.0 s, telegraphs
    × 0.85 (never under 0.4 s). Added, on the ground and in the air: **the eruptions** — it roars at the floor and **two
    cracks glow 1.0 s**, the one nearest Akeris and the next, then burst into columns of fire (300 su wide, ≈ 900 su high,
    2). Not blockable; roll or step away.
15. **The horn (DG15).** With its head down (after bite, quake, dive, landing), **a chain throw at its chipped horn pins
    the head 1.5 s**; blows to the **neck** take **2**. Its own reaction to the chain: at most once every 5 s; otherwise,
    and with the head up, the chain only hurts (1).
16. **Its heat blast (DG16).** Four chain hits in a row (no 5 s pause; the hook counts) and it opens its wings (0.4 s, the
    embers closing) and beats hot air: Akeris within 900 su is thrown ≈ 300 su away, **no damage**, his chains back. Rolling
    passes it. It does not stop its own attack.
17. **The finisher (DG17).** A blow that would leave it at 0 leaves it at its last mark: it falls (from the air too) with
    its head on the floor, panting, and **waits**. **Only hooking the horn and striking the neck ends it**; every other blow
    rings `CLANG!` (also the fast descent). The pin here has no 5 s limit.
18. **Its end and the choice (DG18; operator: the choice first).** It collapses on the bastion and dissolves in ink and
    embers; 2.6 s after the blow, **the choice** (§9). **After** taking an ability, the doors open
    (`sfx.bossDoor.open`) and **`music.outro`** plays. *Changed by the operator 2026-10-14
    (`01-story/cinematics/outro.md`, «Before the outro»; step 3.18, proposed):* the death is slower and sad — the fight
    music drains into a lone low line (`music.dragon.fall`), it sinks, its last breath goes toward Akeris, its eye dims
    slowly, Akeris lowers his sword, then the ink (7 s in all); as the last of it goes, the room clock starts
    (`sfx.clock.room`); the choice 7.9 s after the blow. The outro is played in this room (the zone 5 sandbox, step 3.18).
19. **Rolling always dodges (operator's rule).** Every attack passes while Akeris rolls (the whole roll): tested at every
    instant from 0.02 to 0.42 s before contact (`dgRollSweep()`); for the long fires (breaths, the wave) the roll has to
    cross the front, not run with it.
20. **Fire (operator).** Only the fire shield stops its fire (4 uses: one a breath or a rain); the merlons stop it and break
    after 3 breaths or impacts, for the fight; **no fire stays on the floor**.
21. **Defeated, it stays defeated** for the run.

## 9. HUD and the choice

| Element | Where | Look | Texts |
|---|---|---|---|
| boss health (DG3) | top centre (`hud.md` §3.3): name at y 62, bar at y 100, 620 × 26 | the bar's shape filled with its iron, pencil scales and a vein of ember; the lost part pale, draining; **marks at the thirds** (28, 14) | `boss.dragon.name`: *The Dragon* · *El dragón* |
| the roar | over it | the hand-drawn call | `call.roar`: *GRRAAAH!* · *¡GRRAAAH!* (the skeleton's) |
| the choice (DG18) | as the other bosses' | two cards; A/D; Enter to the first empty slot Q/E/R | `ui.reward.titleDragon`: *The Dragon leaves one of its abilities* · *El dragón deja una de sus habilidades*; `ui.reward.slot`, `ui.reward.hint` as the others |

**Its abilities** (`sprites/abilities.png`; how they work in play is their own step; cooldowns are the sandbox's):

| Id | Name | Text | Icon | Cooldown |
|---|---|---|---|---|
| `breath` | *Breath* · *Aliento* | *A ground-level flame.* · *Una llamarada a ras de suelo.* | a dragon's head and a flame along the ground | 12 s |
| `earthquake` | *Earthquake* · *Terremoto* | *The fast descent releases a shockwave.* · *El descenso rápido suelta una onda.* | a blow coming down and the wave's arcs | 14 s |

## 10. Never

- Nothing trembles: it moves smoothly between poses; strokes never change; it never shakes when hit.
- No attack without its telegraph seen and heard: the raised paw, the head thrown back, the glowing belly and the breath
  drawn in, the raised neck, the curled tail, the rearing, the pulled-back or raised wings, the growing shadow, the
  glowing cracks, the closing embers.
- A roll that fails to pass an attack; a shield other than the fire shield stopping its fire; fire left on the floor.
- Hurt asleep, waking, roaring or dying; finished by anything but horn and neck.
- Its reaction to the chain more than once every 5 s; the chain holding it still.
- More than ≈ 5 s out of Akeris's reach; out of the room or inside its stone (the hanging walks hang in front of it).
- The doors opening before the choice; the choice before its end.
- Gore: it dissolves in ink and embers; no blood.

## 11. Acceptance

Tests of 2026-10-12, in the zone 5 sandbox (seed 1 unless said; scenarios `dgRun(name)` / `#dg-<name>`, `dgAll()`):

1. Asleep it is the approved drawing; when the doors seal it wakes, the bridge falls, it roars and leaps
   (`despierta`, `sheet-wake.png`); `music.dragon.calm` → `.fight`.
2. Claw: 2 standing; 0 with any shield; the sacred just block counters (stunned, −3 by the counter); the ice just block
   slows it (and spends a use); the fire just block blocks; rolling 0 (`zarpazo*`, `aturdido`).
3. Bite: 3 standing and **3 with the shield raised**; rolling 0; stepping back 0; then head down (`mordisco*`, `cabezaBaja`).
4. Low breath: 2 (two ticks) in front of the merlon; 0 behind the merlon (the merlon loses one of its three); 0 on a hanging
   walk; 0 with the fire shield (4 → 3 uses); 2 with the sacred; rolling through 0 (`aliento*`).
5. High breath: 1 on a hanging walk; 0 standing or crouching on the floor; 0 with the fire shield (one use); rolling 0
   (`alientoAlto*`).
6. Tail: 2; jumping 0; rolling 0; shield 0 (`coletazo*`). Earthquake: 2 standing; jumping 0; rolling 0; hanging walk 0;
   shield 2 (`terremoto*`).
7. The horn: head down + chain on the horn → pinned 1.5 s; the neck −2; within 5 s of the last pin the chain only hurts
   (−1) (`cuerno*`). Four chain hits in a row → its heat blast pushes ≈ 260–300 su without damage; rolling 0
   (`rafagaCalor*`). The fast descent on the lowered head −1 (`descenso`).
8. Phases: at 28 it roars and takes off (`fase2`); at 14 the rage, red eyes (`fase3`).
9. Air: gusts push 252 su (126 with the shield; rolling 0); slashes 2, shield 0, just block returns one (−1), rolling 0
   (`rafagas*`, `tajos*`); dive 3 + wave 2, rolling (the way it dives) 0, shield stops the blow (wave 2) (`picado*`); rain
   2, behind a merlon 0, fire shield 0 for one use, rolling 0 (`lluvia*`); it lands and rests every three (`posa`).
10. Eruptions: 2 standing on the glowing crack; rolling 0; stepping away 0 (`erupcion*`).
11. The finisher: at the last mark it falls and waits, the sword rings `CLANG!`; horn + neck end it (`remate`,
    `remateCuerno`); it dissolves; 2.6 s later the choice (`muerte`, `eleccion`; since 2026-10-14 7.9 s, the scenes' times moved to match); after taking it the doors open and
    `music.outro` plays (`puertas`).
12. Turn: `giro` (1.0 s, never squashed). Rolling sweep (`dgRollSweep()`): rolling 0.02–0.42 s before contact never takes damage while rolling, for the claw,
    bite, both breaths, tail, quake, slashes, dive, rain and eruption (for the high breath on a hanging walk, a roll started
    more than 0.14 s early ends before the jet arrives: the jet then hits).
13. Random player (`dgFuzz(40, 60)`, seeds 1–3: 120 fights of 60 s; sword, chain blades, hammer and spear; each shield;
    starting at 42, 29 and 15): **no failures** — no errors, **no damage while rolling** (565 attacks passed rolling), never
    inside the stone nor out of the room (it or Akeris), never stuck in a state, at most **3.4 s** out of reach in the air (after the animation rework: 3.33, 3.39, 3.08 s);
    counted: 166 claws, 256 bites, 170 low and 94 high breaths, 79 tails, 184 earthquakes, 237 gusts, 296 slash pairs, 189
    rains, 136 eruption calls, 38 pins, 354 heat blasts, 117 landings to rest; 1 504 hits taken, 1 088 marks dealt (random
    players almost never kill it: 2 finishers reached).
14. Duelist (`dgDuel(20, 180)`: sword, swapping to the chain blades for the horn and the air; blocks, just blocks the claw,
    rolls the rest, jumps the waves): kills it in all 20 fights, 48.0 s on average, 8 damage taken (after the animation rework; before, 45.8 s and 8.6). Against the Giant
    Spider in the zone 4 sandbox, a duelist with the sword: 41.7 s and 18.2 damage (20/20).
15. The zone's tests unchanged: `boss.js` (the room: seals, wakes, the bridge, 60 s of random fight never out of the room nor
    in the stone, doors after `done`, reset), the four zone 5 enemies' scenarios, `int/allfz.js` (seeds 1–3) and
    `int/fz4b.js` (seeds 1–3).

## 12. Exports

From the zone 5 sandbox (`dgExportAll()`, the sounds with `dgExportSfx()`, the room with `dgExportRoom()`):
`sprites/sheet.png`, 28 single poses, `abilities.png`, 20 frame sheets (`turn`, `fly`, `wake`, `claw`, `bite`, `breathLow`,
`breathHigh`, `tail`, `quake`, `horn`, `blast`, `phase2`, `gust`, `slash`, `dive`, `rain`, `rest`, `phase3`, `finish`,
`death`) and 73 screenshots in `captures/` (one per scenario; three in the dark; the bar, the choice, the open doors). The
room's `jefe.png`, `jefeDespierto.png`, `jefeVencido.png` again, with the dragon. 69 WAV in `07-audio/sfx/bosses/`.

## 13. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| DG1 | Look | the approved stand-in articulated: long head, two ringed horns (one chipped), S neck, torn wings, belly plates, spade tail; ≈ 1000 su; iron, fire-iron spines, bone horns and talons; ember eye; fire glows between the belly plates before each breath; old, scarred |
| DG2 | Wake | the room's (2.5 s; the bridge; `music.dragon.fight`) + a 1.5 s roar (no damage) + a leap from the tower |
| DG3 | Health | 42 marks, three phases of 14; the bar with marks at the thirds; *The Dragon* · *El dragón* |
| DG4 | Claw | 0.5 s; 2; any shield; sacred just → counter (stunned 1.5 s); ice slows, fire does not burn; roll |
| DG5 | Bite | 0.45 s; ≈ 450 su; 3; no shield (operator); roll or step away; head down 1.2 s |
| DG6 | Low breath | 0.7 s; 900 su sweep, 1.2 s, 1 / 0.3 s, at most 3; fire shield (1 use), merlons (3), hanging walks above; roll |
| DG7 | High breath | 0.7 s; 230–420 su; safe on the floor or crouched; fire shield; roll |
| DG8 | Tail | Akeris behind; 0.5 s; 2; jump or roll; any shield |
| DG9 | Earthquake | 0.6 s; a dust wave both ways to 1200 su (2); jump or roll; hanging walks safe; no shield; head down 1.2 s |
| DG10 | Gusts | 0.5 s; ≈ 250 su push, no damage (half shielded); roll |
| DG11 | Wind slashes | 0.5 s; two crescents in an X at the chest, 600 su/s, 2; any shield; just returns one (−1); roll |
| DG12 | Dive | 0.7 s; the point fixed 0.15 s before; 3; lands with the quake; any shield stops the blow, not the wave; head down 1.2 s |
| DG13 | Fire rain | 0.6 s; five blobs that go out at once (2); merlons, fire shield (one use for the rain), roll |
| DG14 | Rage | at 14: red eyes, fire between the scales; ground and air in turn; pauses 1.0 s; the eruptions: cracks glow 1.0 s, two columns (2), one nearest Akeris; not blockable |
| DG15 | The horn | head down → chain on the chipped horn pins it 1.5 s; the neck 2; once every 5 s; head up, only damage |
| DG16 | Heat blast | four chain hits in a row: 0.4 s, Akeris thrown ≈ 300 su, no damage; roll |
| DG17 | Finisher | at its last mark it falls and waits; only horn + neck; other blows `CLANG!`; ink and embers |
| DG18 | What it leaves | the choice first (*Breath*, *Earthquake*), `ui.reward.titleDragon`; then the doors and `music.outro` (operator) |

**Built differently from the letter of the proposal, to be checked by the operator:** the hanging walks hang in front of
it (it is not blocked by them; the low breath passes under them, the high breath along them); the low breath is a front
that sweeps out (the burning band is 300 su behind the front), so rolling *through* the front passes it; the dive's wave
is the quake's; between 5.0 s of out-of-reach and its attacks, in the air it comes lower (≈ 470 su) and faster to Akeris.
