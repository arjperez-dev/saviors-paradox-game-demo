# The Giant Bat — boss contract

- **Status:** approved 2026-10-02 (GB1–GB16 approved as the sandbox does them)
- **Kind:** boss (zone 2, the Echo Caverns)
- **Sandbox:** the zone 2 sandbox, [`../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html`](../../../04-zones/zone-2-echo-caverns/sandbox/sandbox.html):
  *Ir a… jefe*, then walk in: the doors seal and it wakes. `N` makes it start its next attack when it is waiting ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Bosses (Giant Bat: «wakes hanging from the ceiling; stunning screech; blockable dive
  (opens a counter); summons small-bat swarms, later used as a shield; wings can be torn; hooked by a wing and
  dragged to the ground (shockwave dodged from a hanging platform); only its eyes show in the dark; stalactites
  can be dropped on it with the chain; dissolves into a fleeing swarm»), §Abilities (Giant Bat: Screech, Swarm) ·
  `00-game/controls.md` (S + click; G16) · `01-story/characters.md` (the blind thing that lives on the echoes of the
  caves) · [`../../../04-zones/zone-2-echo-caverns/boss-room.md`](../../../04-zones/zone-2-echo-caverns/boss-room.md) ·
  [`../../enemies/zone-2/small-bats/contract.md`](../../enemies/zone-2/small-bats/contract.md) (its swarms) ·
  `06-ui/hud/hud.md` §3.3, §3.1 · the golem's contract (the boss bar, the choice) · the operator's decision of
  2026-10-02 (the proposal as made; then: the hook must not keep it on the floor, and every so many hits a wave that pushes Akeris away without hurting him; in the rage it moves and attacks much faster)
- **Built on:** its own shape (a bat seen from the front; no skeleton)
- **Code name:** `giantBat` · **Español:** el murciélago gigante

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals GB1–GB16 (§13) were approved by the operator on 2026-10-02.

## 1. Identity

The blind thing that lives on the echoes of the caves: a bat as wide as the room's slabs, dark leather and fur, huge
ears, a nose-leaf, four fangs and two small pale eyes — the only thing of it that shows in the dark. It sleeps hanging
upside down from the middle of the roof of its room. A player reads: enormous and fast, always overhead; when its
ears open it is about to scream; when its wings fold it is about to fall on me; bring it down and it is mine.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| wingspan | ≈ 670 (wings open) | Akeris = 192; the room's slabs are 400 wide |
| body | ≈ 80 wide, ≈ 120 tall; head ≈ 64 wide, ears ≈ 75 tall | — |
| wing | arm ≈ 100, forearm ≈ 86, three fingers ≈ 40–122; a thumb claw | the skin gathers between the fingers |
| cruise height | body ≈ 470 above the floor (≈ 400 with one wing torn, ≈ 330 with both) | a jumping strike from the floor reaches its underside; from a slab, all of it |

**Silhouette test:** a wide black W with two tall ears in the middle. Never a bird (no beak, no feathers), never a
dragon (no tail, no scales), never a small bat (ten times their size).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| body, head, ears | `#2a2622` | 2.4–2.6 | `paperLight` at .07–.08; fur ticks at .18 |
| wing skin | `rgba(44,39,34,.95)` | edge 2.2 | `paperLight` at .05 |
| wing bones | `ink`, with a `paperLight` line at .32 | arm 5, forearm 4.2, fingers 2.6 | — |
| eyes | `paperLight`; **red `#9e1218` in the rage** | 1.4 | — |
| fangs | `paperLight` | 1 | — |
| torn wing | the skin ends in a zigzag; with the wing broken, bare fingers with tatters | 1.2 | — |

The rage's red eyes repeat the golem's (operator, 2026-10-01: the red iris of the rage). No other new colour.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| sleep | the room | — | yes | wake | `sleep`: hanging upside down from the roof by its claws, wings wrapped, eyes shut |
| wake | the doors seal (+1.4) | 1.9 | no | cruise | eyes open and a screech (0–0.5), it lets go and turns over (0.5–1.1), opens its wings and rises (`sheet-wake.png`) |
| cruise | wake, after an attack | 1.3 (rage 0.9) | no | its next attack | `fly-up`/`fly-down`: a wingbeat each 0.53 s, to one side of Akeris (400 su), changing side after each attack |
| screech | cruise | ≤ 0.8 + 0.7 + 0.5 | no | cruise | flies to 380 su up and 420 su to one side; `screech`: ears and mouth open, rings closing on its mouth (the telegraph); the cone (`sheet-screech.png`) |
| dive | cruise | 0.6 (0.35 after a stun) + the fall + 0.25 + 0.7 | no | cruise | `fold`: wings folding (the telegraph), then `dive` in a straight line at Akeris, skims the floor and climbs (`sheet-dive.png`) |
| swarm / shield | cruise | 0.8 | no | cruise | `call`: wings up, mouth open, calling (`sheet-swarm.png`, `sheet-shield.png`) |
| slam (rage) | cruise | 0.6 + 0.55 + the fall + 1.3 | no | rise | climbs over Akeris, `screech` pose with its shadow on the floor (the telegraph), drops like a stone; `down` on the floor (`sheet-slam.png`) |
| hooked | a chain blade in it | ≤ 1.4 | no | drag, rise | beating hard against the chain |
| drag | S + click | 0.35 | no | down | pulled down to the floor in front of Akeris (`sheet-chain.png`) |
| down | the counter, a stalactite, the drag, a dive into a slab | falls, then 1.6 / 1.8 / 2.0 / 1.0 | no | rise | `down`: flat on the floor, wings spread, stars (the opening; `sheet-counter.png`, `sheet-stalactite.png`) |
| roar (rage) | half its health | 1.8 | no | cruise | `rage`: red eyes, a long screech and ink rings (`sheet-rage.png`) |
| flee (death) | its last health | 2.4 | no | — | it falls and bursts into 28 small bats that fly up and away through the roof (`sheet-flee.png`) |

## 5. The room in the fight

Built on [`boss-room.md`](../../../04-zones/zone-2-echo-caverns/boss-room.md) (approved; nothing moves):

- **The two hanging slabs** (250 su up) are where Akeris strikes it from, **cover from the screech** (the cone does not
  pass through rock) and **the escape from the slam's wave**; it never slams onto a slab, always beside one.
- **The three big cracked stalactites** fall only to the chain. One falling on it takes 3 and brings it down (§8.6).
- **The four torches**: in the rage the wind of its wings blows out **the two in the middle** (they smoke and their light
  goes); when it dies they burn again. In the middle of the room only its eyes are left.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| screech telegraph | screech | three dashed rings closing on its mouth | 0.7 |
| screech cone | screech | an ink wedge of 57° opening to 950 su: five arcs and a pale fill on its front; in the dark the same in `paperLight` | 0.5 + 0.4 |
| stars over Akeris | the screech stuns him | three graphite stars, drawn over him | 1.2 |
| dive trail | dive | three fading copies of it | the dive |
| slam shadow | slam | an ink ellipse darkening on the floor | 0.55 |
| floor wave | slam | a crack running along the floor and a hump of stones and dust, both ways (`paperLight` in the dark) | to the walls |
| torches out | rage | smoke from the two middle torches | 1.1 |
| wing torn | three hits on a wing on the floor | ink puffs, `CRACK!` | 0.9 |
| roar | wake, rage | three dashed ink rings | 1.4 |
| repel | every 5 hits | a dashed ring shaking round it (the telegraph), then two ink rings opening to 340 su, dust, `WHOOSH!` over Akeris | 0.25 + 0.45 |

## 7. Sounds

All in `07-audio/sfx/sfx.md` §2 *Bosses* (`sfx/bosses/`): `sfx.giantBat.wake`, `.flap`, `.screechTel`, `.screech`,
`.diveTel`, `.dive`, `.crash`, `.call`, `.hook`, `.drag`, `.tear`, `.hurt`, `.slamTel`, `.slam`, `.shock`, `.roar`,
`.repel`, `.torchOut`, `.flee`. Its swarms use the small bats' (`sfx.smallBats.wake`, `.die`). Also existing: the shield sounds,
`sfx.akeris.hurt`, `sfx.chain.back`, the boss doors and `music.giantBat.calm` / `music.giantBat.fight` (`boss-room.md`).

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 30; the rage at 15) | proposal |
| damage taken | the game decides (sandbox: any weapon 1, the chain blades too; a stalactite 3; the counter's first 4 strikes 1 each; frozen, double) | proposal; operator, 2026-10-02 |
| damage dealt | the game decides (sandbox: the HUD's test hit for the dive, the slam and its wave; a small bat's bite 1) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |

**Behaviour:**

1. **Wake (GB2).** It sleeps until the doors seal; 1.4 s later it opens its eyes and screams (the fight music starts),
   lets go, turns over and opens its wings.
2. **Rhythm (GB3).** Phase 1: screech, dive, swarm, dive. Phase 2: shield, screech, dive, slam, screech, dive (it
   screams twice a round). Between attacks it flies to one side of Akeris.
3. **The screech (GB4).** It stops in the air 380 su up; ears and mouth open with rings closing on its mouth for
   **0.7 s** (the telegraph, with its echolocation clicks); then the cone: 57° wide, 950 su long, toward where Akeris
   was. Caught in it, **Akeris is stunned 1.2 s** (he cannot move; stars) and it **dives at once** (0.35 s telegraph).
   **No shield stops it** (it is sound). Out of the cone, **under or behind a slab**, or rolling as the front passes,
   it misses.
4. **The dive (GB5).** It folds its wings (**0.6 s**, a short shriek; it aims until 0.12 s before) and falls in a
   straight line at Akeris at 1250 su/s, skims the floor and climbs. **Any shield stops it**; **the sacred just
   block opens the counter and it crashes to the floor** (1.6 s down; the counter's strikes take up to 4); the ice or
   fire just block also freezes or burns it (G16). Rolling passes through it. A dive into a slab brings it down 1 s.
5. **The swarm (GB6).** It calls five small bats from the roof (never more than six alive): they chase Akeris and
   bite (1, then 1 s of grace); one hit kills any; a sweep kills up to two; the shield stops them.
6. **Bringing it down (GB7).**
   - **The chain in a wing:** a chain blade that reaches it while it is slow — cruising, screeching or calling, never
     in the dive nor while it climbs back — hooks a wing (1.4 s, the chip *Hooked · S + click*); more chain blades
     while it is hooked do nothing. **S + click** drags it to the floor in front of Akeris: 2 s down.
   - **It cannot be kept down** (operator, 2026-10-02): after a drag it cannot be hooked for 8 s, after a hook it
     shook off for 5 s, and after getting up from any fall for at least 4 s.
   - **The stalactites:** a big one dropped on it with the chain takes 3, takes its shield with it and brings it down
     1.8 s.
   - **The counter** (§8.4).
7. **Wings (GB8).** On the floor, a strike on a wing (the one on Akeris's side) tears it; **three tear it apart**.
   With a wing broken it flies 70 su lower and 20 % slower and its dive reaches 700 su instead of 1500; with both,
   140 su lower and 40 % slower.
8. **The rage (GB9, GB16).** At half its health it roars (1.8 s): **its eyes turn red**, the wind of its wings **blows out
   the two middle torches** (only its eyes are left there) and it calls **the shield**: eight small bats circling it.
   While one is left, **every hit is taken by one of them** (`CLACK!`); a stalactite takes them all.
   **From then on it is much faster** (operator, 2026-10-02): it flies 50 % faster and beats its wings faster; its
   telegraphs are 28 % shorter but never under 0.4 s (the screech 0.5 s, the dive 0.43 s, the slam 0.4 s); the dive and
   the slam's drop are 28 % faster; it rests 0.55 s between attacks instead of 1.3 (phase 1) and calls faster.
9. **The slam (GB10, rage).** It climbs over Akeris (never over a slab), hangs 0.55 s screaming with its shadow on the
   floor (the telegraph) and drops like a stone: under it hurts; **a wave runs along the floor both ways** at 950 su/s
   to the walls and hurts whoever stands on the floor — **only a hanging slab or a jump avoids it** (rolling does not).
   Then it lies on the floor 1.3 s.
10. **Its end (GB11).** At its last health it falls and **bursts into a fleeing swarm** that flies up through the roof;
    the middle torches burn again, the doors open (`boss-room.md`) and, 2.2 s later, **the choice** (§9).
11. **The repel (GB15; operator, 2026-10-02).** Every 5 hits that hurt it, its wings shake for 0.25 s (the telegraph) and
    it lets out a wave of air: within 340 su **Akeris is pushed away (≈ 280 su, with a small hop) without losing health**;
    if it was on the floor it gets up at once, and if it was hooked it shakes the chain off. Never in the middle of the counter.
12. **It cannot be hurt** asleep, waking, roaring (`CLANG!`) or fleeing.
13. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. HUD and the choice

| Element | Where | Look | Texts |
|---|---|---|---|
| boss health (GB12) | top centre (`hud.md` §3.3): its name at y 62, the bar at y 100, 620 × 26 | the health bar's shape filled with its leather `#4a423a`, hatched, with wing fingers drawn in it; the lost part pale, draining; a mark at half (the rage) | `boss.giantBat.name`: *The Giant Bat* · *El murciélago gigante* |
| hooked (GB7) | the lasting-states row (`hud.md` §3.1) | a chip: a short chain with its hook, and the way to drag it | `ui.hud.hooked`: *Hooked · S + click* · *Enganchado · S + clic* |
| the screech | over it, in the world | the hand-drawn call | `call.screech`: *SKREEEE!* · *¡IIIIIIK!* |
| the choice (GB13) | as the golem's | two cards | `ui.reward.title`: *The Giant Bat leaves one of its abilities* · *El murciélago gigante deja una de sus habilidades*; `ui.reward.slot`, `ui.reward.hint` as the golem's |

**Its abilities** (`sprites/abilities.png`; how they work in play is their own step; cooldowns are the sandbox's):

| Id | Name | Text | Icon | Cooldown |
|---|---|---|---|---|
| `screech` | *Screech* · *Chillido* | *A cone of sound that stuns enemies for 1.5 s.* · *Un cono de sonido que aturde a los enemigos 1,5 s.* | a bat's head in profile and three arcs | 10 s |
| `swarm` | *Swarm* · *Enjambre* | *Five bats chase the nearest enemies and bite them.* · *Cinco murciélagos persiguen a los enemigos más cercanos y los muerden.* | three small bats | 14 s |

## 10. Never

- Nothing trembles: the wings beat smoothly, the strokes never change.
- No attack without its telegraph: the ears and the rings before the screech, the folded wings before the dive, the
  shadow before the slam.
- A shield stopping the screech, or the screech passing through a slab.
- The slam landing on a slab, or its wave reaching a slab.
- The middle torches staying dark after it dies; the doors opening before it dies.
- Gore: it dissolves into bats; no blood.
- It never comes back once defeated.

## 11. Acceptance

1. Asleep it matches `sleep`; when the doors seal it wakes as `sheet-wake.png` and the fight music starts.
2. The screech plays as `sheet-screech.png` and stuns; under a slab it misses (`sheet-screech-slab.png`); the shield does not help; rolling does.
3. The dive plays as `sheet-dive.png`; the shield stops it; the sacred just block counters and it crashes (`sheet-counter.png`).
4. The swarm chases and bites; a hit kills each (`sheet-swarm.png`).
5. The chain in a wing and S + click drag it down (`sheet-chain.png`), and it cannot be hooked again for 8 s; a stalactite brings it down (`sheet-stalactite.png`).
6. On the floor its wings tear (`sheet-wings.png`); torn, it flies lower and slower.
7. At half its health: red eyes, the middle torches out, the shield (`sheet-rage.png`, `sheet-shield.png`).
7a. Every 5 hits the repel pushes Akeris away without hurting him and it gets up (`sheet-repel.png`).
8. The slam's wave hurts on the floor and not on a slab (`sheet-slam.png`, `sheet-slam-slab.png`).
9. At zero it flees as a swarm, the torches burn again, the doors open (`sheet-flee.png`); its bar (`captures/barra.png`) and the choice (`captures/eleccion.png`).

## 12. Exports

From the zone 2 sandbox (`gbExportAll()`, the sounds with `gbExportSfx()`): `sprites/sheet.png`, ten single poses,
`abilities.png`, fifteen frame sheets and twenty-one screenshots in `captures/` (two in the dark).

## 13. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| GB1 | Look | a bat seen from the front, ≈ 670 su across; dark leather, huge ears, nose-leaf, four fangs, two small pale eyes (red in the rage) |
| GB2 | Wake | hanging from the middle of the roof; 1.4 s after the doors seal: eyes, a screech, it lets go, turns and opens its wings |
| GB3 | Rhythm | phase 1 screech → dive → swarm → dive; phase 2 shield → screech → dive → slam → screech → dive |
| GB4 | The screech | 0.7 s telegraph; a 57° cone, 950 su; stuns 1.2 s and it dives at once; no shield stops it; slabs cover; rolling passes |
| GB5 | The dive | 0.6 s telegraph; straight at 1250 su/s; shields stop it; the sacred just block counters and it crashes 1.6 s |
| GB6 | The swarm | five small bats that chase and bite (1); one hit kills each; never more than six |
| GB7 | Bringing it down | the chain in a wing (only while it is slow) + S + click (2 s down; then 8 s without a hook); a stalactite (3, 1.8 s down); the counter |
| GB8 | Wings | on the floor, 3 hits tear a wing; torn: lower, slower, a shorter dive |
| GB9 | Rage | at 15: red eyes, the two middle torches blown out, a shield of eight small bats that takes every hit |
| GB10 | The slam | over Akeris, never over a slab; 0.55 s telegraph; a floor wave both ways that only a slab or a jump avoids |
| GB11 | Its end | falls and bursts into a fleeing swarm; torches back; doors open; the choice 2.2 s later |
| GB12 | Boss health | top centre, 620 × 26, its leather with wing fingers and the half mark |
| GB13 | Its abilities | *Screech* (10 s) and *Swarm* (14 s) with their icon and texts; the choice as the golem's |
| GB14 | Damage | 30 health; any weapon 1 (the chain too), a stalactite 3, the counter up to 4; it cannot be hurt while it roars |
| GB16 | The rage's pace | 50 % faster flight, telegraphs × 0.72 (never under 0.4 s), dive and drop × 1.28, 0.55 s between attacks (operator) |
| GB15 | The repel | every 5 hits, 0.25 s telegraph, a wave that pushes Akeris ≈ 280 su away without damage; it gets up if it was down (operator) |
