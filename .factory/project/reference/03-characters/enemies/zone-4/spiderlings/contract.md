# Spiderlings — character contract

- **Status:** approved 2026-10-05 (SP1–SP12 as the sandbox does them, with the nests in every room with sacs)
- **Kind:** enemy (zone 4, the Rotting Canopy); a swarm
- **Sandbox:** the zone 4 sandbox, [`../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`](../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html):
  they live in their nests whatever the room's enemy («Enemigo»; by default none); *Ir a… nido*, *charcos*, *hueco*, *telas*,
  *combate* · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 4: *Spiderlings*), §Bosses (the Giant Spider's eggs hatch weak mini-spiders: its
  contract, not this one) · `04-zones/zone-4-rotting-canopy/biome.md` §A.4 (egg sacs, white threads), `hazards.md` (floor webs,
  torches, fire) · `01-story/dialogue/zone-4.md` («Keep away from the white threads», «Fire does not care for webs») ·
  `02-art-direction/ART_DIRECTION.md` §5 · the operator's decisions of 2026-10-05 (the proposal as it stood: the bite does not
  poison; a burning web kills the ones on it and they never cross a flame; passing under the sacs or stepping on the web tears
  them) and of the same day after playing it (nests in several rooms of zone 4, not only in the nest; review the mechanics)
- **Built on:** its own shape (no skeleton)
- **Code name:** `spiderlings` · **Español:** arañitas

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

Broods of small ink spiders inside the egg sacs that hang from the roof of several rooms of the zone: every room with sacs is a
nest. When Akeris passes under the sacs, or
steps on the floor web (the web tells them), the sacs tear and each spiderling comes down on its own white thread. They
scuttle in bursts, spread to both sides of Akeris and, in turns, one crouches, lifts its front legs, hisses and leaps at his
chest. A player reads: sacs up there (do not walk under them yet), many of them on both sides (turn), the one that crouches is
the one that jumps. Any hit kills one; the danger is the number. Fire is their end: they never cross a flame.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| body | ≈ 30 long: a round abdomen (≈ 31 × 26) and a small head (≈ 16 × 13) | Akeris = 192 |
| legs | eight, thin and bent; ≈ 85 su tip to tip | knees above the body; the four far legs in a lighter stroke |
| standing height | ≈ 36 to the top of the abdomen; knees ≈ 46 | its feet on the floor |
| leap | an arc that meets Akeris's chest (≈ 110 above his feet) | — |

**Silhouette test:** a round ball on eight bent legs with a pale mark on its back. Never an insect (no wings, six legs or
antennae), never the Giant Spider small (no thread hanging it in the fight, no web shot), never the Ceiling Crawler (it does
not drop on Akeris from the roof).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| abdomen, head | `#2f2a25` (the dark of the small bats) | 1.5 / 1.4 | — |
| the mark of the three hollows | `paperLight` at .72, three small dots | — | — |
| eyes | `paperLight` at .95, a cluster of four dots; larger in the telegraph | — | — |
| legs | `ink`; the far ones at 50 % | 1.4 / 1.2; far 1.1 / 1.0 | — |
| fangs | `ink`, with a drop of the poison accent (`#a6b04c`, `palette.md` §6) | 1.3 | — |
| burnt | `#1f1b18`, no mark, no drop | — | — |

No new colour. In the dark only the eyes show (two pale dots), as the small bats'.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| in the sac | spawn | — | yes | drop | not drawn: the sacs whole (`sprites/sacs.png`) |
| drop | the sacs tear | 410 su at 460 su/s, each 0.14 s after the last | no | scuttle | head down on its thread (`drop`; `sheet-hatch.png`); the sacs torn (`sacs-torn.png`); the thread stays hanging |
| scuttle | drop, leap, right | bursts of 0.3–0.6 s at 240 su/s, pauses of 0.2–0.4 s | yes | wind | `run-1`, `run-2` (legs stepping in pairs); still in the pauses (`stand`), facing Akeris |
| wind (the telegraph) | scuttle, its turn | 0.4 | no | leap | crouched, the front legs raised high, fangs open, larger eyes (`wind`); it hisses; aims until 0.12 s before |
| leap | wind | ≈ 0.4 to his chest, then falls behind | no | scuttle | legs thrown forward (`leap`), tilted with its arc; two fading copies behind (`sheet-attack.png`) |
| flip | the shield stops it | bounces off, then 1.0 on its back | no | right | on its back, legs kicking (`flip`), graphite stars (`sheet-block.png`) |
| right | flip | 0.2 | no | scuttle | it turns over |
| death | a hit, the chain, a just block, a dive, fire | 0.7 | no | — | legs curled under (`curl`), five ink puffs; burnt (`burnt`): three puffs and a small flame (`sheet-web-fire.png`); the last one, `fx/ink-smoke` (`sheet-death.png`) |

## 5. Weapons and gear

None: it bites.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| sac dust | the sacs tear | pale bits of sac falling | 0.7 |
| leap copies | leap | two fading copies along its arc | the leap's |
| ink burst | death | five ink puffs (three if burnt) | 0.6–1.0 |
| small flame | burnt | a flame on its body, shrinking | 0.45 |
| stars | flip, on the floor | three graphite stars | the state's |
| hit feedback, block sparks, callouts | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.spiderlings.hatch` | the sacs tear | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.skitter` | loops while any is out in Akeris's room; stops when the last there dies or he leaves; silent in the pause, the map and a dialogue | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.hiss` | one starts its telegraph | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.leap` | it leaps | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.die` | one dies (not by fire) | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.burn` | one dies by fire | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.shield.just`, hit sounds, `sfx.zone4.webBurn`, `sfx.zone4.torchFall` | blocks, hits, the web and the torch | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| per brood | 3–5 for one cluster of sacs, 4–7 for two (the nest room), by the seed and the room (the big sacs first) | proposal |
| where | a nest in every room with sacs: the pools, the hollow, the webs, the clearing, the nest (two clusters), the root end and the web end; ≈ 26 nests in a zone of seed 1. Not in the antechamber or the boss room: there the sacs are already torn (scenery: the brood went to its mother) | operator, 2026-10-05 |
| health | **one hit kills** any of them | proposal |
| bite | 1 (sandbox; **the game decides**); **no poison** (operator, 2026-10-05); no knock-down; 0.6 s before another bite can land | operator |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit reach | a strike sweeps its arc in front while it lasts and reaches the floor; two at most per strike | the sandbox |

**Behaviour:**

1. **In the sacs (SP2).** They wait inside the egg sacs of their room's roof. Each nest wakes on its own. Two things tear its
   sacs (operator, 2026-10-05): Akeris **passing under them** (within 150 su of a sac) or **stepping on the floor web of their
   room** — the web tells them. Nothing else does: not sight, not noise from elsewhere. Killing one before then is impossible
   (they are inside).
2. **Coming down (SP3).** The sacs tear (bits fall) and each one comes down head first on its own white thread, one every
   0.14 s, to the floor under its sac; the threads stay hanging from the torn sacs. A sac over no floor (a pool, a pit) holds
   none.
3. **Surrounding (SP4).** On the floor they scuttle in bursts (0.3–0.6 s at 240 su/s, then still 0.2–0.4 s) toward their own
   place beside Akeris: half on each side, each at its own distance (140, 174, 208… su), so they never cover one another.
   **They keep to their floor:** never down into a poison pool, never off a ledge, never through a wall, never out of their
   room. If their side does not reach (a door, a pool, a wall), they go round to the other; if neither reaches, as near as
   they can, staggered. **If Akeris leaves their room** they go back under their nest and wait; they come again when he
   returns. **The web is theirs:** it never slows them, while Akeris crosses it at 40 % (`hazards.md`).
4. **The leap (SP5).** In turns — at most two at once, one every 0.6 s, each every 1.4–2.4 s — one between 120 and 360 su
   from Akeris stops, crouches, lifts its front legs and hisses for 0.4 s (the telegraph; it aims until 0.12 s before) and
   leaps in an arc that meets his chest about 0.4 s later. It passes through and lands behind him. The arc never rises more
   than 230 su above its floor (also when Akeris jumps) and never reaches farther than 400 su (when he runs away during the
   telegraph). It does not leap if Akeris is out of its room, on a ledge far above or below, falling into a pool, behind a
   wall, or if a flame lies between them. If it meets a wall it bounces and falls; one that lands in a poison pool dies.
5. **Answers (SP6).** **One hit kills**, in the air or on the floor (a strike counts along its whole arc while it lasts, two
   at most); **the chain** kills the one it reaches; the dive kills the ones it lands among (140 su). **The shield** stops a
   leap from the front: it bounces off and lies **on its back 1 s**, legs kicking (an easy kill), then turns over (0.2 s).
   **The just block** with any shield kills it. **The roll** passes through the leap.
6. **Bite (SP7).** A leap that meets Akeris bites for 1 and he cannot be bitten again for 0.6 s; it does not knock him down and
   **it does not poison** (operator). The spider goes on past him, slower. Hanging from a vine, the bite (and the shield's
   push) swings him instead of pushing him.
7. **Fire (SP8, operator 2026-10-05).** Fire kills them: **the just block with the fire shield** burns the one it stops
   (`controls.md` G16: the leap is a melee attack; a normal block with it flips the spider as any shield does); **a fire
   projectile** burns the first one it meets and goes out (only once Akeris has Flare, the dragon's: not in zone 4); **a fallen
   torch's flame** burns the ones that touch it; **a burning floor web kills
   every one on it** as the fire runs along it (0.6 s, `hazards.md`); **a burning web curtain** burns the ones beside it.
   Knocking the nest's second torch over onto the web
   while they cross it burns the brood.
8. **Never across a flame (SP9, operator).** They never walk into a flame: they stop 30–78 su short of it (staggered, so they
   do not pile up) and do not leap over it. A fallen torch, which keeps burning for the run, closes the way for them.
9. **In the dark (SP10).** Only the eyes of the ones out show; in the sacs, nothing.
10. **Defeated, they stay defeated** for the run (operator, 2026-10-01; every enemy). The torn sacs stay torn. A nest is not
    a room enemy: it lives beside whatever enemy the room has.

## 9. Never

- Nothing trembles: the legs step smoothly and the strokes never change.
- They never come out without Akeris passing under the sacs or stepping on the web of their room.
- They never stand in a poison pool, float over a gap, enter a wall or leave their room; they never pile up in one place.
- A leap never comes without its crouch, its raised legs and its hiss, and never turns in the last 0.12 s.
- More than two leaping at once.
- A spiderling surviving a hit, or walking through fire, or leaping over it.
- A poisoned bite.
- Being slowed by a web.

## 10. Acceptance

1. In the sacs nothing shows but the sacs (`sacs.png`); walking under them tears them and they come down on their threads
   (`sheet-hatch.png`); stepping on the nest's web does it too (`captures/tela.png`).
2. On the floor they spread to both sides of Akeris (`captures/rodean.png`); each leap plays as `sheet-attack.png`, with the
   hiss first.
3. Standing still, a leap bites for 1; a second bite cannot land within 0.6 s; the bite does not poison.
4. The shield stops a leap and it lies on its back 1 s (`sheet-block.png`); the just block kills it (`sheet-just.png`); the
   just block with the fire shield burns it, a normal block with it flips it (`sheet-fire-shield.png`); rolling, nothing (`captures/rueda.png`).
5. One strike kills one, in the air or on the floor (`sheet-strike.png`); the chain kills one (`sheet-chain.png`).
6. A torch knocked onto the web while they are on it burns them all (`sheet-web-fire.png`); a fallen torch stops them
   (`sheet-torch-wall.png`); a fire projectile burns one (`captures/bola.png`).
7. The last one curls up and fades in ink (`sheet-death.png`) and the brood never comes back; the sacs stay torn.
8. By a door they go round to the other side and do not pile up (`sheet-wall.png`); when Akeris leaves the room they go back
   under the nest (`sheet-home.png`); in the pools room they never go down into the poison, and one thrown into it dies
   (`sheet-pools.png`); the hollow's nest wakes when Akeris walks onto its web (`captures/hueco.png`).
9. In the dark only the eyes of the ones out show (`captures/oscuridad.png`).

## 11. Exports

From the zone 4 sandbox (`spExportAll()`, the sounds with `spExportSfx()`): `sprites/sheet.png`, nine single poses, the sacs
whole and torn, thirteen frame sheets (`hatch`, `attack`, `block`, `just`, `strike`, `chain`, `fire-shield`, `web-fire`,
`torch-wall`, `death`, `wall`, `home`, `pools`) and twenty-eight screenshots in `captures/`. Tests: the 27 scenarios `sp*`
(`spAll()`), the list of nests (`spNestList()`) and the random player `spFuzz()` (104 fights of 60 s, in turn in every kind of
room with a nest, sometimes leaving the room and coming back: never torn without passing under or stepping on the web, never
more than two leaping, never a leap without its telegraph, never a bite while rolling or falling into a pool, never alive in a
flame for more than two steps, never across a flame, never floating, sunk, in a pool, in the rock or out of its room, never a
leap higher than 370 su, never three piled in one place, always back under the nest when Akeris leaves, never stuck).

**Fixed after the operator played it (2026-10-05).** With one brood tied to the room's enemy, these went wrong: by a door
four of seven piled up in the same place inside the doorway; with Akeris in the air the leap rose 491 su (near the roof);
running away during the telegraph made a 900 su/s leap; out of the room they waited at the door instead of going home; on a
vine the bite pushed him as if standing; a bite could land while he fell into a pool; and they all shared one floor height,
which only worked in a flat room. Now each nest is its own, each spider walks its own floor, and the checks above hold.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| SP1 | Look | a round dark abdomen with the three hollows in pale dots, a small head with a cluster of pale eyes, eight thin bent legs (≈ 85 su), fangs with a drop of the poison accent; no new colour |
| SP2 | Waking | inside the sacs of their room's roof; passing under them (150 su) or stepping on their room's web tears them (operator); each nest on its own |
| SP3 | Coming down | each on its own thread, one every 0.14 s; the threads and torn sacs stay |
| SP4 | Surrounding | bursts of 240 su/s and pauses; half on each side of Akeris, each at its own distance; the other side if one does not reach; on their own floor and in their room; home when he leaves; the web never slows them |
| SP5 | The leap | in turns, two at most; 0.4 s crouch, raised legs and hiss; an arc to his chest (at most 230 su up, 400 su across); lands behind; into a pool, dies |
| SP6 | Answers | any hit kills (also on the floor); the chain and the dive kill; the shield flips it 1 s; the just block kills; the roll passes through |
| SP7 | Bite | 1, with 0.6 s before another; no knock-down; no poison (operator) |
| SP8 | Fire | the just block with the fire shield, a fallen torch, a burning web or curtain kill them (and a fire projectile, once Akeris has Flare); the web kills every one on it (operator) |
| SP9 | Flames | they never cross or leap over a flame (operator); a fallen torch closes the way |
| SP10 | Dark | only the eyes of the ones out show |
| SP11 | Group and place | 3–7 per brood, by the seed; **a nest in every room with sacs** of zone 4 (operator, after playing it): the pools, the hollow, the webs, the clearing, the nest, the root end, the web end; torn sacs (scenery) in the antechamber; the nest gets a second torch beside its web (`layout.md`) |
| SP12 | Sound | hatch, skitter (loop), hiss (the telegraph), leap, death, burn; no echo or reverb (the jungle) |
