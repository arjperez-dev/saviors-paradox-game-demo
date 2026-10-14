# The Giant Spider — character contract

- **Status:** approved 2026-10-06 (step 3.14; GA1–GA19 as the sandbox does them: the cocoon, the hunt, the sound blast against the chain)
- **Kind:** boss (zone 4, the Rotting Canopy)
- **Sandbox:** the zone 4 sandbox, [`../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`](../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html)
  (*Ir a… jefe*; walking 280 su past the door seals the room and she wakes) · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Bosses (Giant Spider: «web shots that slow; eggs that hatch weak mini-spiders; poison spit
  leaving puddles; hangs from a thread (cut it with the chain to drop and stun it); floor webs slow and are burned by the
  fire shield»), §Abilities (*Web*, *Venom Edge*) · `01-story/dialogue/zone-4.md` (the warning spirit: «When she tires, she
  hangs by a single thread. Cut it with your chain», «Her webs will hold you. Fire does not care for webs», «Her young hatch
  weak») · `04-zones/zone-4-rotting-canopy/boss-room.md` (the arena, approved), `hazards.md` (webs, torches, the torch in
  the hand) · `00-game/controls.md` §Combat (the roll's invulnerability, G7, G16) · `../golem/contract.md` (the rock rain:
  out of reach while it rains) · the operator's decisions of 2026-10-06: the proposal GA1–GA14; **in the rage she comes
  down to the floor**; **a moment like the golem's**: she climbs out of reach and attacks many times, to be dodged, until
  she comes back down («hay un momento donde la puedes alcanzar y te ataca múltiples ataques que tienes que esquivar
  hasta que vuelve a estar a nivel para atacarla»); one chain throw cuts the thread; the young do not grow; **the torches
  can be carried in the hand** (`hazards.md`), not thrown; and, after a first look: **make clear when she cannot be
  hit** («que ella se envuelva en su telaraña para protegerse mientras te deja caer ráfagas de veneno, arañitas y otros
  ataques») and **she hunts Akeris through the whole room** («si te pones fuera de su alcance mientras está en el techo
  debería de bajar a buscarte para atacarte»); and the chain must not hold her still: «deberían hacer que los bosses se molesten y te lancen una ráfaga
  sonora que te aleja» (`../../akeris/weapons/hook-blades.md` §6)
- **Built on:** its own shape (no skeleton)
- **Code name:** `giantSpider` · **Español:** araña gigante

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

The thing that weaves in the roots of the world above: a spider of ink as wide as the room is high, hanging curled from a
single white thread in the dark of the roof. On her abdomen, in bone, **the mark of the three hollows**; on her head, eight
pale eyes in a cluster; under them, two fangs that drip the zone's bile-green venom. Awake she crawls upside down through
the web lattice of the roof and attacks from above; tired, she hangs by one thread, and that thread is the way to bring her
down. In her rage she comes down to the floor among her own webs, and once a round she climbs back into the lattice and
lets the roof rain on Akeris. A player reads: watch the thread; burn her webs; when she climbs, dodge.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| leg span | ≈ 500 (feet at ± 250 standing) | at 1.2× her drawing scale |
| height standing | ≈ 300 (abdomen top 360 above the floor, the feet on it) | Akeris = 192 |
| abdomen | 226 × 192, above and behind the head | the mark: three bone rings in a row |
| head | 115 × 96 | eight eyes: two big in front, six around |
| fangs | ≈ 36, with a venom drop at each tip | open when she spits |
| legs | eight, two segments each with hairs, the knees high and outward | the back four drawn under the abdomen |

**Silhouette test:** a round abdomen over a smaller head and eight long high-kneed legs, seen from the front. Never a
spiderling (small, seen side on), never the Ceiling Crawler (long, segmented), never the Giant Bat (wings).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| abdomen | dark bark `#40372f`, ink outline | 2.8 | pale at 10 %; two pale stripes and three chevrons |
| head | `#544a3f`, ink outline | 2.6 | pale at 8 % |
| legs | `#62574b` inside ink | 10 / 8.6 | short ink hairs |
| the mark | bone `#ddd6c6` rings with an ink hollow | 1.4 | — |
| eyes | pale `rgba(239,230,214,.95)`; red `#9e1218` in the rage | — | — |
| venom | the zone's poison `#7a8638`, drips `#a6b04c` (`palette.md`) | — | — |
| thread, webs | `rgba(239,230,214,…)` (the zone's web) | 1.3; 2.2 glowing | — |

No new colour. In the dark: her eyes (red in the rage), the glowing thread when she is tired, the venom she drips, the
webs she throws and the puddles' faint glow.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| asleep | the zone placed | — | yes | wake | curled, hanging from her thread in the middle of the roof, eyes shut (`sleep`) |
| wake | 1.2 s after the doors seal | 1.8 | no | climb | eyes open, legs unfold, she lowers on her thread to 420 su and hisses (`sheet-wake.png`) |
| climb | wake, low, the tired thread | 1.0 (1.2 from the floor) | no | roof | up her thread to the lattice (`hang`) |
| roof | climb, an attack | — | yes | an attack, tired | upside down in the lattice, the feet holding the threads, beside and above Akeris (`roof`) |
| the web shot | roof, floor | 0.6 + 0.45 | no | roof, floor | the spinnerets glow (`web`) |
| the spit | roof, floor | 0.7 + 0.45 | no | roof, floor | the fangs open (`spit`) |
| the eggs | roof, floor | 0.5 + 0.45 | no | roof, floor | the spinnerets glow; sacs fall |
| seek, drop telegraph, drop | roof, the storm's end | ≤ 0.8 + 0.6 + fall | no | low, stunned | over Akeris; her shadow grows; she falls with her legs spread (`drop`, `sheet-drop.png`) |
| low | the drop | 0.8 | no | climb (floor in the rage) | on the floor, open |
| tired | every three attacks | 0.6 + 2.5 | no | climb, fall | down (or up, in the rage) to hang 290 su above the floor by **one glowing thread**, panting (`hang`) |
| fall, down | the thread cut | fall + 3.0 | no | climb (floor in the rage) | on her back, legs kicking (`down`, `sheet-thread.png`) |
| roar, weave, descend | half health | 1.4 + 1.2 + 1.0 | no | floor | red eyes, a hiss, **in her cocoon**; two big webs fall to the floor; she comes down (`rage`, `sheet-rage.png`) |
| floor | the rage | — | yes | an attack, the storm, tired | walks among her webs, keeping ≈ 340 su (`stand`) |
| charge | floor | 0.5 + run + 0.45 | no | floor, recoil | the near front legs raised (the telegraph; a dashed line shows how far), then a run of ≤ 650 su (`charge`, `sheet-charge.png`) |
| sweep | floor, Akeris within 240 su | 0.45 + 0.45 | no | floor, recoil | two front legs raised, then swept low (`sweep`, `sheet-sweep.png`) |
| recoil | the charge or the sweep blocked | 0.5 | no | floor | open |
| storm | every other three attacks in the rage | 0.6 + 4.0 + 0.35 | no | the drop | she climbs into the lattice and **wraps herself in her cocoon**; untouchable; then she tears it (`sheet-storm.png`) |
| hunt | Akeris out of her reach 1.2 s (phase 1) | crawl + 0.6 + walk | no | climb | she crawls to the lattice's edge, drops on a thread near him, chases him on the floor (320 su/s) and makes two close attacks (the charge, the sweep); then she walks back under the lattice and climbs (`sheet-hunt.png`) |
| stunned | the storm's drop | 1.5 | no | floor | stars; open to every hit |
| stun | the counter, the dive | 1.6 | no | climb, floor | stars |
| dying | her last health | 2.4 | no | — | falls on her back, the legs fold up, she melts into ink (`dead`, `sheet-death.png`) |

## 5. Weapons and gear

None: her fangs, her legs, her webs and her eggs.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| the web ball | the web shot | a pale knot of threads in an arc | its flight |
| her floor web | where the ball lands (240 su; at most three of hers, the oldest dries away), or two big ones (520 su) in the rage | the zone's floor web (`hazards.md`) | until burnt |
| venom drops | the spit, the storm | bile-green drops; in the storm, an ink shadow on the floor that grows 0.7 s before each lands | their fall |
| puddles | where the venom lands (130 su, 6 s; the storm's 90 su, 4 s) | flat bile-green with bubbles | 6 / 4 |
| egg sacs | the eggs | pale sacs on the floor, swelling the last 0.8 s | 3 |
| **the sound blast** | four chain hits in a row (GA19) | pale rings closing on her (0.4 s), then three pale rings opening to 700 su; `call.hiss` | 1.0 |
| **the cocoon** | the storm, the roar, the weave | a white shell of web that covers her whole, wrapped round and round, tied to the roof by four threads, with a pale glow; in the dark it stays pale. **Only inside it she cannot be hit** (`CLANG!` and a spark on the web). It tears into falling shreds when she drops | the storm |
| the glowing thread | tired | the thread thicker and pale, with a halo | the tired |
| the drop's shadow | drop telegraph | a dashed ink ellipse that darkens and closes | 0.6 |
| the charge line | charge telegraph | a dashed line along the floor to where she will stop | 0.5 |
| wrapped | a web sent back at her | her own threads across her body | 1.5 |
| stars, sparks, callouts | as every boss | `02-art-direction/fx/`; `call.hiss`: *HSSSSS!* · *¡SSSSSS!* | — |

## 7. Sounds

| Sound id | Trigger |
|---|---|
| `sfx.giantSpider.wake` | she wakes |
| `sfx.giantSpider.hiss` | the charge's and the sweep's telegraph |
| `sfx.giantSpider.step` | her steps on the floor |
| `sfx.giantSpider.thread` | the drop's telegraph (the thread hums) |
| `sfx.giantSpider.drop`, `.land` | the drop; landing (also the fall and her death) |
| `sfx.giantSpider.web`, `.webLand` | the web shot; the web landing or sticking |
| `sfx.giantSpider.spit`, `.splash` | the spit; a venom drop landing |
| `sfx.giantSpider.lay` | the eggs |
| `sfx.giantSpider.weave` | the rage's two webs |
| `sfx.giantSpider.charge`, `.sweep` | the charge; the sweep |
| `sfx.giantSpider.pant` | tired on her thread |
| `sfx.giantSpider.cut` | the chain cuts the thread |
| `sfx.giantSpider.hurt`, `.roar`, `.die` | a hit; the rage and the storm; her end |
| `sfx.giantSpider.blast` | the sound blast against the chain (GA19) |

All in `07-audio/sfx/sfx.md` §3 (bosses), WAV in `07-audio/sfx/bosses/giantSpider-*.wav`. The spiderlings' and the
shields' sounds are the existing ones.

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | 30; the rage at 15 (as the Giant Bat) | proposal |
| damage taken | any weapon 1 (the chain too; four chain hits in a row annoy her: GA19); cutting the thread 2 and she falls; the counter up to 4; a web sent back with the fire shield 1, a venom drop sent back 1; frozen, double | proposal |
| damage dealt | the drop, the charge, the sweep: the common hurt (−2 in the sandbox); the web: *Lento* 2 s; the venom and its puddles: poisoned as the zone's pools; a spiderling's bite: 1 | proposal |
| XP and coins | the game decides | `VISION.md` §Assumptions |

**Behaviour:**

1. **Asleep (GA2).** Curled on her thread in the middle of the roof. 1.2 s after the doors seal she wakes (1.8 s), hisses
   and climbs into the lattice; `music.giantSpider.fight` starts.
2. **Phase 1, the lattice (GA3).** Upside down under the roof (her body ≈ 520 su above the floor), she keeps beside and
   above Akeris (in the middle 1000 su, where the roof is high). Her plan: web, spit, drop, eggs, web, drop. **She is
   reached by the chain, or by a well-timed jumping blow** (the arena's roof is 668 su: a jump with the sword reaches her
   abdomen, as with the golem).
3. **The web shot (GA4).** The spinnerets glow (0.6 s); a ball of web arcs to Akeris's feet. Where it lands on the floor it
   leaves a **floor web of 240 su** that slows as the zone's (40 %) and burns as the zone's; at most **three of hers** (the
   oldest dries away). If it hits Akeris he is **slowed 2 s** and a web is left at his feet. The shield stops it; **the
   just block sends it back** and she is **wrapped 1.5 s** (no attack); with the fire shield it also burns her (−1), with the
   ice shield it freezes her 1.5 s. **Rolling passes it.**
4. **The spit (GA5).** The fangs open and drip (0.7 s); three drops in an arc around Akeris (110 su apart) leave **puddles
   of venom (6 s)** that poison as the zone's pools (1 a second, and 2 s after). The shield stops each drop; the just block
   sends one back (−1). **Rolling passes them.**
5. **The eggs (GA6).** Two sacs (three in the rage) fall to the floor; **3 s later spiderlings hatch** (the zone's: weak,
   one hit, `../../enemies/zone-4/spiderlings/contract.md`). A blow, the chain or the dive breaks a sac before it hatches.
   Never more than **six** spiderlings. They do not grow (operator).
6. **The drop (GA7).** She moves over Akeris (never over a hanging root: whoever stands on one is safe) and **her shadow
   grows on the floor** while the thread hums (0.6 s; she stops aiming 0.12 s before); she falls. **Any raised shield stops
   it** (it comes from above); **the sacred just block opens the counter** and she is stunned 1.6 s; **rolling passes it.**
   Then she stays **low 0.8 s** — open to every blow — and climbs back.
7. **She tires (GA8).** Every three attacks she lowers on **one thread** to 290 su above the floor and pants 2.5 s; **the
   thread glows**. **One chain throw on it cuts it** (from the floor, under her, or from a hanging root): she falls on her
   back (−2) and **kicks 3 s**, open to everything; then she spins a thread and climbs. Left alone, she climbs back. The
   sword also reaches her while she hangs (jumping).
8. **The rage (GA9, operator).** At 15: red eyes, a long hiss (untouchable, `CLANG!`); she **weaves two big webs (520 su)**
   on the floor and **comes down**. On the floor she walks among her webs (they never slow her), keeps ≈ 340 su and attacks:
   **the charge** (front legs raised 0.5 s with a line on the floor; a run of up to 650 su that never turns; the shield stops
   it and she recoils, open; the sacred just block counters; **jumping over or rolling through passes it**), **the sweep**
   when Akeris is within 240 su (0.45 s; the same defences), and the web, the spit and the eggs, all with telegraphs
   × 0.75 (never under 0.4 s).
9. **The storm (GA10, operator: like the golem's rain, inside her cocoon).** Every other three attacks in the rage she
   hisses, climbs into the lattice and **wraps herself in her cocoon** (GA17): **untouchable for 4 s**. From inside:
   **three bursts of venom** (at 0.4, 1.6 and 2.8 s; three drops each, 150 su apart around Akeris, each with its shadow
   growing on the floor as it falls; a drop that hits poisons him, each leaves a small puddle 4 s), **two web shots** and
   **two spiderlings** lowered on their threads. At 4 s she **tears the cocoon** (0.35 s, shreds falling) and **drops**:
   dodged (roll), blocked or countered, she lands **stunned 1.5 s**, back within reach. The other times, she tires on her
   thread (GA8) from the floor.
9a. **Only the cocoon protects her (GA17).** She cannot be hit only while wrapped: the storm, and the roar and weave that
   open the rage. Anywhere else, whatever reaches her hurts her.
9b. **The hunt (GA18).** In phase 1, if Akeris stays **out of her reach for 1.2 s** (on the floor beyond the high lattice,
   by the doors), she hisses, crawls to the lattice's edge, **drops on a thread near him and chases him on the floor**
   (320 su/s, her webs never slow her): **two close attacks**, the charge and the sweep, with their telegraphs and
   defences; rolling passes them. Then she walks back under the lattice and climbs. If he comes back under the lattice
   she leaves sooner. **On a hanging root** she does not drop: she throws web and spit at his feet up there, 0.5 s apart,
   until he comes down. In the rage she is on the floor and always chases him.
9c. **Annoyed by the chain (GA19, operator).** Four chain hits in a row (no 5 s pause between them) and she hisses (0.4 s:
   pale rings closing on her) and lets out **a sound blast**: Akeris, within 700 su, is **pushed ≈ 300 su away without
   damage** and his chains come back (a vine drops him). No shield stops it; **rolling passes it**. Never inside her
   cocoon. It does not stop her own attack.
10. **Her end (GA11).** At zero she falls on her back, her legs fold up, the sacs dry, her young die, and she melts into
    ink; her webs that are not burning dry away; the doors open (`boss-room.md`) and, 2.6 s later, **the choice** (§9).
11. **Rolling always dodges (GA12, operator's rule).** The drop, the charge and the sweep are passed by a roll at any moment
    of contact; the web and the drops by a roll begun ≥ 0.1 s before they touch (`gsRollSweep()`). The puddles and her floor
    webs are ground, not attacks: they are dodged by not standing in them.
12. **Fire (GA13).** Her webs burn as the zone's: the fire shield touching them, a fallen torch, or **the torch carried in
    the hand** (`hazards.md`), and never come back. The four torches of the room are the way to clear her rage webs.
13. **She cannot be hurt** asleep, waking, in her cocoon (roaring, weaving, the storm) or dying; the counter takes at most 4.
    The chain never holds her still (`../../akeris/weapons/hook-blades.md` §6).
14. **Defeated, she stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. HUD and the choice

| Element | Where | Look | Texts |
|---|---|---|---|
| boss health (GA14) | top centre (`hud.md` §3.3): name at y 62, bar at y 100, 620 × 26 | the bar's shape filled with her dark bark (reddish in the rage) crossed by pale web threads; the lost part pale, draining; a mark at half | `boss.giantSpider.name`: *The Giant Spider* · *La araña gigante* |
| the hiss | over her, in the world | the hand-drawn call | `call.hiss`: *HSSSSS!* · *¡SSSSSS!* |
| the choice (GA15) | as the golem's | two cards | `ui.reward.titleGiantSpider`: *The Giant Spider leaves one of its abilities* · *La araña gigante deja una de sus habilidades*; `ui.reward.slot`, `ui.reward.hint` as the golem's |

**Her abilities** (`sprites/abilities.png`; how they work in play is their own step; cooldowns are the sandbox's):

| Id | Name | Text | Icon | Cooldown |
|---|---|---|---|---|
| `web` | *Web* · *Tela* | *A web that slows enemies in an area.* · *Una tela que frena a los enemigos en un área.* | a round web | 12 s |
| `venomEdge` | *Venom Edge* · *Filo de veneno* | *For a few seconds your weapons poison what they hit.* · *Durante unos segundos, tus armas envenenan lo que golpean.* | a blade with three drops | 16 s |

## 10. Never

- Nothing trembles: she crawls, falls and kicks smoothly; strokes never change.
- No attack without its telegraph: the glowing spinnerets, the open fangs, the growing shadow, the raised legs and their
  line, the venom drops' shadows.
- A drop over a hanging root; a charge that turns; a roll that fails to pass the drop, the charge or the sweep.
- Hurt inside her cocoon; untouchable outside it; out of reach for longer than the storm's 4 s plus its drop.
- Akeris left out of her reach for long: she always comes down to hunt him (never more than 4 s in the tests).
- More than three of her small webs, or more than six spiderlings, at once.
- A web of hers that comes back once burnt; the doors opening before she dies.
- Gore: she melts into ink; no blood.

## 11. Acceptance

1. Asleep she matches `sleep`; when the doors seal she wakes as `sheet-wake.png` and the fight music starts.
2. The web shot slows and leaves a web; the shield stops it; the just block wraps her (`sheet-web.png`, `captures/tela*.png`).
3. The spit leaves puddles that poison; rolling passes the drops (`sheet-spit.png`).
4. The eggs hatch spiderlings; a blow breaks a sac first (`sheet-eggs.png`).
5. The drop: the shadow, the fall; the shield stops it; the sacred just block counters (`sheet-drop.png`); rolling passes it
   and a hanging root is safe (`sheet-dodge.png`).
6. Tired, she hangs by one glowing thread; the chain cuts it and she kicks on her back (`sheet-thread.png`).
7. At half health: red eyes, two webs, she comes down (`sheet-rage.png`); the charge and the sweep (`sheet-charge.png`,
   `sheet-sweep.png`).
8. The storm: she wraps herself in her cocoon (untouchable 4 s), three bursts of venom with their shadows, webs and young;
   she tears it and drops, 1.5 s stunned (`sheet-storm.png`, `captures/capullo.png`, `capulloRasga.png`).
8a. By a door, out of her reach, she comes down and hunts Akeris (`sheet-hunt.png`, `captures/caza.png`); on a hanging root
    she keeps throwing at him (`captures/raizTela.png`).
9. The torch in the hand burns her webs (`sheet-torch.png`).
9b. Four chain hits in a row and she blasts Akeris away without hurting him (`sheet-blast.png`, `captures/rafaga.png`).
10. At zero she melts into ink and the doors open (`sheet-death.png`); her bar (`captures/barra.png`) and the choice
    (`captures/eleccion.png`); in the dark her eyes and her venom (`captures/oscuridad.png`, `furiaOscuridad.png`).

## 12. Exports

From the zone 4 sandbox (`gsExportAll()`, the sounds with `gsExportSfx()`): `sprites/sheet.png`, twelve single poses,
`abilities.png`, fifteen frame sheets (`wake`, `web`, `spit`, `eggs`, `drop`, `dodge`, `thread`, `rage`, `charge`, `sweep`,
`storm`, `blast`, `hunt`, `torch`, `death`) and forty-two screenshots in `captures/` (two in the dark, the bar and the choice). Tests: the 39
scenarios `gs*` (`gsAll()`, `gsProbe(name, T)`), the roll sweep (`gsRollSweep()`: Akeris rolls 0.02–0.38 s before each
attack's contact) and the random player `gsFuzz(runs, secs)` (fights of 90 s, half with the chain aimed at her thread when
she tires, a quarter with the fire shield and a quarter with the ice shield, sometimes taking a torch: never hurt while
rolling, never hurt while untouchable, never stuck in a state, never out of her room, never more than three small webs or
six young, never the shield raised with a torch in the hand, the room never open before her end, the choice always after it, never
more than 4 s out of her reach without her coming down; 2026-10-06, after the cocoon and the hunt: 30 fights without
failures, 60 hunts, 144 sound blasts, at most 3.4 s out of her reach). The chain against every enemy: `balanceReport()`.

## 13. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| GA1 | Look | an ink spider ≈ 500 su across, the mark of the three hollows on the abdomen, eight pale eyes, dripping fangs |
| GA2 | Wake | curled on her thread; 1.2 s after the seal she wakes, hisses and climbs into the lattice |
| GA3 | Phase 1 | upside down in the lattice, beside and above Akeris; reached by the chain or a well-timed jump |
| GA4 | The web shot | 0.6 s; a floor web of 240 su (three at most); hit: slowed 2 s; the just block wraps her |
| GA5 | The spit | 0.7 s; three drops, puddles of 6 s that poison as the pools |
| GA6 | The eggs | two (three) sacs; spiderlings 3 s later; a blow breaks a sac; six at most; they do not grow (operator) |
| GA7 | The drop | the shadow 0.6 s; any shield stops it; the sacred just block counters; never over a hanging root; low 0.8 s |
| GA8 | She tires | every three attacks, one glowing thread 290 su up for 2.5 s; one chain throw cuts it (operator): −2, on her back 3 s |
| GA9 | The rage | at 15: red eyes, two big webs, she comes down (operator); the charge and the sweep |
| GA10 | The storm | like the golem's rain (operator), in her cocoon: untouchable 4 s; three bursts of venom, webs, young; she tears it, drops, then stunned 1.5 s |
| GA11 | Her end | on her back, into ink; the doors; the choice |
| GA12 | Rolling | always dodges her attacks (operator's rule) |
| GA13 | Fire | her webs burn as the zone's, also with the torch in the hand (operator) |
| GA14 | Boss health | top centre, her bark with web threads and the half mark |
| GA15 | Her abilities | *Web* (12 s) and *Venom Edge* (16 s) |
| GA16 | Health | 30 (the rage at 15); weapons 1, the cut 2, the counter up to 4 |
| GA17 | The cocoon (operator) | only inside her white cocoon she cannot be hit: the storm, the roar and the weave |
| GA19 | The sound blast (operator) | four chain hits in a row: 0.4 s telegraph, Akeris pushed ≈ 300 su without damage; rolling passes it |
| GA18 | The hunt (operator) | out of her reach 1.2 s, she comes down near Akeris, chases him and attacks twice; on a hanging root, web and spit until he comes down |
