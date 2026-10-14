# The Golem — boss contract

- **Status:** approved 2026-10-01 (J1–J12 approved as the sandbox does them)
- **Kind:** boss (zone 1, the Suspended Sanctuary)
- **Sandbox:** the zone 1 sandbox, [`../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`](../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html):
  *Ir a… jefe*, then walk in: the doors seal and it wakes. `N` makes it start its next attack when it is waiting ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Bosses (Golem), §Abilities (Golem), §Mechanics (status effects:
  levitation; boss rooms) · `00-game/controls.md` (S + click: anchor; G7: a projectile blocked at the
  last moment flies back, projectiles are never split) · `00-game/pillars.md` · `01-story/characters.md`
  (the sanctuary's keeper, cut from its own stone) · `01-story/zones-narrative.md` (zone 1: the
  stones forgot how to fall) · [`../../../04-zones/zone-1-suspended-sanctuary/boss-room.md`](../../../04-zones/zone-1-suspended-sanctuary/boss-room.md) ·
  `06-ui/hud/hud.md` §3.3 (boss health), §3.1 (lasting states) · `06-ui/pause-menu/pause-menu.md`
  (abilities) · the operator's decisions of 2026-10-01 (below)
- **Operator's decisions (2026-10-01):** in the rage its eye turns red and it roars; the rain has more rocks
  and it cannot be reached for those 3 s; no rings in its room; in phase 2 more rocks, kept readable, and more
  of its levitation and its pull on the rocks; every weapon damages it and the chain cracks it (and takes
  more); two phases; its two abilities come with their icon, their texts and the choice when it
  dies (how they work in play is their own step); its rocks follow G7: the shield stops them and the
  just block sends them back, they are never split (`VISION.md` still says «split», see 5.1)
- **Built on:** its own shape (a carved rock with an eye; no skeleton)
- **Code name:** `golem` · **Español:** el gólem

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

The sanctuary's keeper: a block of the sanctuary's own masonry, cut round and floating, with the
sanctuary's one-handed clock carved around a single pale eye and two broken chains hanging from its
sides (it was once held down). It sleeps in the middle of its room, under the middle slab, until the
doors seal. At a glance a player reads: huge, slow, far up, watching me; the floor is about to break.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| rock | ≈ 252 × 216 (13 sides) | Akeris = 192 |
| eye | radius 31, in a socket of 38, inside the clock face (radius 56, twelve marks, one hand) | — |
| hover | its centre 370 above the floor (± 8, slow bob) | its underside ≈ 260 above the floor |
| asleep | its centre 230 above the floor, under the middle slab | — |
| hit radius | 100 su around a line through its centre (± 64 high) | the sandbox |

**Silhouette test:** a big rounded block with seams, a clock face and one eye, hanging chains; it can
never be read as one of the floating stones (they have no eye and no clock) or as the wandering eye
(small, round, with threads).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| rock | `#a49a88` (the stand-in's) | 2.8 | `ink` at .3 on the lower half; the masonry seams `ink` at .5 |
| clock face | `ink` at .75 | 1.6; marks 1.2–2; the hand 3 | — |
| socket | `#6f675a` | 2.2 | — |
| eye white, iris, pupil | `paperLight` `#efe6d6`, `ink` at .25, `ink`; **in the rage the iris red `#9e1218` and six red veins** (operator, 2026-10-01) | 1.6 | — |
| lids | `#b8ae9b` (the floating stones') | 1.6 | `ink` at .28 |
| cracks | `ink`; in the rage phase a `paperLight` line beside each | 2.4 → 1.2 | — |
| rocks | `#a49a88`, a `paperLight` edge light | 2 | `ink` at .32 |
| the levitation radius | `ink`, dashed | 1.4 (telegraph) → 2.6 | — |

No glow. The only new colour is the rage's red eye, the dark red of Akeris's streak.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| asleep | the room, before it seals | — | yes | wake | eye closed (`sleep`), slow bob |
| wake | 1.4 s after the doors seal | 1.2 | no | idle | the eye opens; it rises and goes to its first gap |
| idle | wake, after each attack | its pause (1.1; rage 0.8) | no | the next attack | eye at .75 (`watch`), it follows Akeris |
| tear (the telegraph) | idle | 0.7 | no | rocks rise | the eye narrows (`aim`); under Akeris and beside him the floor cracks, a shadow grows and a rock peeks out and shakes |
| rocks rise, orbit, throw | tear | 0.45 + 0.9 (rage 0.6) + one each 0.4 s (rage 0.3) | no | idle | the rocks leave the floor, circle it and fly at Akeris one by one |
| levitation radius | idle | 0.9 telegraph + 2.6 (rage 3.0) | no | idle | eye wide (`wide`); a dashed ring grows around it; when it acts, pebbles rise inside |
| the pull (phase 2) | the radius | with it | no | throw | during the telegraph three rocks crack out of the floor under it and circle it; when the radius ends it throws them one each 0.45 s (if Akeris still floats, it waits for him to come down, up to 1.5 s) |
| move | idle | 1.3 | no | idle | it swoops from one gap to the other, dipping 140 su under the middle slab |
| roar (phase change) | half its health | 1.6 | no | idle | eye wide and red; `GROAAAR!` and three dashed ink rings spreading from it; the slabs' chains snap, the floor's two ends break away |
| rock rain (phase 2) | idle | 3.0 + the last rock | no | idle | it roars, rises to 600 su (out of every reach) and stays 3 s; rocks fall from the ceiling, each one first a shadow on the floor (0.7 s); then it comes back down |
| drop | its last health | 0.5 | no | fallen | it falls to the floor and tilts |
| fallen | drop | until the finisher | yes | finish | eye half open (`fallen`) |
| finish | the chain into its eye | 0.4 | no | crumble | the eye cracks |
| crumble | finish | 1.4 | no | gone | it breaks into fourteen stones that fall and stay; the eye fades |

## 5. The room in the fight

Built on [`boss-room.md`](../../../04-zones/zone-1-suspended-sanctuary/boss-room.md) (its slabs and
rings do not move):

- **Its two places** are the gaps between the slabs (1220 and 1980 su into the room). The room has no
  rings (operator, 2026-10-01: with the chain blades an attack near a ring hooked it instead of striking). The slabs are where Akeris stands to strike it, and they are **cover**: a rock that meets a
  slab breaks on it.
- **The rage phase** breaks the room: the three slabs' chains snap one after another and the slabs
  sink; the floor's two ends (640 su each) break away and sink. The stones forgot how to fall
  (`zones-narrative.md`): they sink about 520 su and float there. The floor left is 1920 su wide; a
  fall off it is the zone's abyss (`hazards.md`), back onto the floor that is left.
- **When it dies**, everything that sank rises back into place in 1.5 s, so both doors can be reached.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| floor crack | tear | seven ink lines from the spot, a shadow, the rock peeking out | 0.7 |
| rock break | a rock meets stone, a shield or Akeris | five grey chips | 0.55 |
| reflect | a just block | the shield's ring and sparks, `WHOOSH!` (`fx/reflect`) | 0.26 |
| crack | a chain strike or a rock sent back | one more crack on it (up to eight), grey chips | — |
| rain shadow | rain | an ink ellipse that darkens where the rock will land, pebbles from the ceiling | 0.7 |
| drop, crumble | its end | dust both ways, `THUD!`, stones | — |

## 7. Sounds

All in `07-audio/sfx/sfx.md` §2 *Bosses* (`sfx/bosses/`): `sfx.golem.wake`, `.tear`, `.throw`,
`.rockBreak`, `.fieldTel`, `.field`, `.crack`, `.roar`, `.slabFall`, `.floorBreak`, `.rainMark`,
`.rainHit`, `.drop`, `.finish`, `.crumble`. Also existing: `sfx.fx.reflect`, the shield sounds,
`sfx.hit.clang` (a hit while it cannot be hurt), `sfx.akeris.hurt`, `sfx.akeris.levitate`, the boss
doors and `music.golem.calm` / `music.golem.fight` (`boss-room.md`).

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 30; the rage at 15) | — |
| damage taken | the game decides (sandbox: any weapon 1; the chain blades, strike, spin or overhead arc, 2 and a crack; a rock sent back 2 and a crack; frozen, double) | operator, 2026-10-01 |
| damage dealt | the game decides (sandbox: the HUD's test hit, for every rock) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |

**Behaviour:**

1. **Wake (J2).** It sleeps until the doors seal (`boss-room.md`); 1.4 s later it opens its eye and
   rises (the fight music starts); it goes to the far gap, away from the door Akeris came in by.
2. **Rhythm (J3).** Phase 1: tear, levitation radius, move. Phase 2: tear, radius with the pull, rain,
   radius with the pull, move: the radius twice as often (operator, 2026-10-01).
3. **Tear (J4).** Rocks (3; rage 5, 150 su apart) crack out of the floor where Akeris stands and to each side:
   standing on a crack when it breaks hurts (the roll's invulnerability passes). They orbit it at
   178 su (touching one hurts) and fly at Akeris one by one at 950 su/s. **Any shield stops them**
   (the ice shield spends a use); **the just block sends them back** into it (2 and a crack; sent back
   by the ice or fire shield it also freezes or burns it 0.5 s, G16). A slab stops them too.
4. **Levitation radius (J5).** A dashed ring of 360 su around it, drawn for 0.9 s before it acts (the
   telegraph), then 2.6 s. Inside it when it acts, Akeris levitates (`akeris/animations.md`):
   helpless, he rises 150 su, and 0.8 s later it throws a rock at him (no shield while floating; the
   rocks circling it do not hurt him while he floats, only the one it throws).
   **With the chain blades, S + click drives the chain into the floor and pulls him down**
   (`controls.md`), and that ring cannot lift him again. Without it he floats 4 s and falls.
5. **Reaching it (J6).** It floats out of reach of most strikes from the floor (only the rising
   second strike of the ground combo touches its underside). A jumping strike reaches it; from the
   slabs every strike does; the chain blades reach it from the floor and crack it.
6. **Rage (J7).** At half its health it roars (1.6 s; it cannot be hurt) and breaks the room (§5); its
   cracks show pale and **its eye turns red**; it roars (`GROAAAR!`, ink rings, `sfx.golem.roar`) here and at every rain.
   Its tear throws 5 rocks; its radius grows to 400 su for 3.0 s and **pulls three
   rocks** out of the floor under it, which it throws when the radius ends (one each 0.45 s); and the
   rock rain joins its rhythm: **it rises to 600 su and cannot be reached for 3 s** (any hit `CLANG!`)
   while a rock falls every 0.2 s (15 rocks): one on Akeris, one where he is going, one anywhere on the
   floor left, in turn; each with its shadow 0.7 s before; it hurts within 58 su. Cannot be blocked:
   read the shadows and move, or roll.
7. **Finisher (J8).** At its last health it drops to the floor and waits. **Only the chain into its eye
   ends it** (a chain strike or the spin at it); other strikes `CLACK` off. It cracks, breaks into
   stones, the room comes back (§5), the doors open (`boss-room.md`).
8. **Its ability (J9).** As the dust settles (1.6 s) the game pauses on **the choice**: two cards,
   *Inverse Gravity* and *Stone Orbit*, with their icon, name and text; A / D choose, Enter takes it
   into the first empty ability box (Q, E, R; all full: Q). §9.
9. **It cannot be hurt** while asleep, waking, roaring, up during the rain (3 s), falling or crumbling (`CLANG!`).
10. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. HUD and the choice

| Element | Where | Look | Texts |
|---|---|---|---|
| boss health (J10) | top centre (`hud.md` §3.3): its name at y 62, the bar at y 100, 620 × 26 | the health bar's shape filled with its stone `#a49a88`, hatched, with masonry joints, over the dark tube; the lost part pale, draining; a mark at half (the rage) | `boss.golem.name`: *The Golem* · *El gólem* |
| levitation (J11) | the lasting-states row (`hud.md` §3.1, U8) | a chip: three rising pebbles and an arrow up, and the way out | `ui.hud.levitate`: *Levitating · S + click* · *Levitando · S + clic* |
| the roar | over it, in the world | the hand-drawn call, as the hit calls | `call.roar`: *ROAAAR!* · *¡GROAAAR!* |
| the choice (J12) | the middle of the screen, the game paused and darkened | a title and two paper cards (420 × 300) with the icon at 2.2×, the name and the text; the chosen card's frame thick; under them, where it goes and the keys | `ui.reward.title`: *The Golem leaves one of its abilities* · *El gólem deja una de sus habilidades*; `ui.reward.slot`: *Goes to {key}* · *Va a {key}*; `ui.reward.hint`: *A / D choose · Enter take* · *A / D elegir · Enter tomar* |

**Its abilities** (`sprites/abilities.png`; cooldowns are the sandbox's, the game decides):

| Id | Name | Text | Icon | Cooldown |
|---|---|---|---|---|
| `inverseGravity` | *Inverse Gravity* · *Gravedad inversa* | *Nearby enemies float helpless for 2 s.* · *Los enemigos cercanos flotan indefensos 2 s.* | a floor line, two bodies floating over it on dashed lines, two arrows up | 12 s |
| `stoneOrbit` | *Stone Orbit* · *Órbita de piedra* | as `pause-menu.md` | three stones on a dashed ring around a dot (the stand-in, now its own) | 8 s |

## 10. Never

- Nothing trembles: the bob, the chains, the orbit, the sinking stones move smoothly; nothing boils.
- No attack without its telegraph: the floor cracks before rocks tear out, the ring is drawn before it
  lifts, the shadow is on the floor before a rock falls.
- Its rocks are never split (G7).
- The room never stays broken after it dies; the doors never open before it dies.
- It never comes back once defeated.

## 11. Acceptance

1. Asleep it matches `sleep`; when the doors seal it wakes as `sprites/sheet-wake.png` and the fight music starts.
2. The tear plays as `sheet-tear.png`; standing on a crack hurts.
3. The shield stops its rocks; the just block sends one back and it takes 2 (`sheet-block.png`).
4. The radius lifts Akeris; S + click with the chain blades brings him down (`sheet-field.png`).
5. It is reached from the slabs, jumping and with the chain, which cracks it (`sheet-reach.png`).
6. At half its health the slabs and the floor's ends sink (`sheet-rage.png`); the rain plays as `sheet-rain.png`.
7. At zero it drops; only the chain ends it; the room comes back and the doors open (`sheet-finish.png`).
8. Its health shows at the top centre (`captures/barra.png`); the choice gives one ability (`captures/eleccion.png`).

## 12. Exports

From the zone 1 sandbox (`golExportAll()`, the sounds with `golExportSfx()`): `sprites/sheet.png`,
seven single poses, `abilities.png`, eight frame sheets and sixteen screenshots in `captures/`.

## 13. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| J1 | Look | a round block of the sanctuary's masonry with the one-handed clock carved around one eye, two broken chains; no new colour |
| J2 | Wake | asleep under the middle slab; 1.4 s after the doors seal it opens its eye and rises to its gap |
| J3 | Rhythm and places | it floats 370 su high in the two gaps between the slabs (no rings); phase 1 tear → radius → move; phase 2 tear → radius with the pull → rain → radius with the pull → move |
| J4 | Tear | the floor cracks under and beside Akeris (0.7 s), 3 rocks (rage 5) orbit and fly at 950 su/s; shields stop them, the just block sends them back (2 and a crack), slabs are cover |
| J5 | Levitation | a 360 su ring drawn 0.9 s, acting 2.6 s; inside, Akeris floats and gets a rock; S + click with the chain blades pulls him down |
| J6 | Reaching it | jumping, from the slabs, and the chain from anywhere; from the floor only the combo's rising strike touches it |
| J7 | Rage | at half health: red eye and a visible roar; the slabs and the floor's ends sink and float; 5 rocks per tear; the radius (400 su, 3.0 s) twice per round and it pulls 3 rocks it throws at the end; rock rain: it roars and rises out of reach for 3 s while 15 rocks fall (one each 0.2 s, shadow 0.7 s before) |
| J8 | Finisher | at zero it drops and waits; only the chain into its eye ends it; the room rises back |
| J9 | Its ability | the choice right after: two cards, A / D and Enter, into the first empty box |
| J10 | Boss health | top centre, 620 × 26, its stone with masonry joints and the half mark |
| J11 | Levitation chip | in the lasting-states row, with the way out written |
| J12 | Damage | 30 health; any weapon 1, the chain 2 and a crack, a rock sent back 2 |
