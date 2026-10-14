---
project: saviors-paradox
factory_version: 4.2.0
created: 2026-09-29
---

# saviors-paradox — vision

## Vision statement

Savior's Paradox is a dark, hand-drawn 2D side-view roguelike action-platformer in which Akeris
descends a procedurally generated ancient dungeon to recover the Time Clock, his race's sacred relic,
unaware that the one behind the world's end is himself, across three timelines. This project is a
**demo**: the first 5 of the dungeon's 20 zones, each closed by a boss, ending in a cinematic that
teases the rest of the adventure.

Story context (full game): Akeris wakes from a vision that the world has days left because someone
used the Time Clock. He enters the dungeon whose last floor holds the Time Chamber, guarded by the
Time Guardian. Three versions of Akeris exist: the Savior (the player), the Future Traveller (who
tries to stop him reaching the last floor) and the Corrupted Akeris (corrupted by the clock, waiting
on the last floor). Akeris is both the cause and the salvation of the world's destruction, yet
neither ever happens. He can only save the world by completing three successful incursions, finding
in each the gems of the sacred sword he always carries without knowing what it is. Ancient spirits
of the dungeon, who have lived through every reset of every Akeris, reveal the story piece by piece;
only in the third incursion does Akeris understand that he is fighting himself, which leads to the
final fight against the most powerful Corrupted Akeris, beatable only with the 3 gems.

## Genre

2D side-scrolling action-platformer; roguelike (procedural zones, permadeath) with metroidvania-style
traversal (climbing and swinging with the chain blades).

## Core loop

Explore a procedurally generated zone → fight enemies for XP and coins, find scrolls, weapons and
shields, talk to spirits for lore and hints → spend XP on weapon and shield upgrades → defeat the
zone boss and take one of its 2 abilities → enter the next, harder zone (potions and special shields
refill). On death the run is wiped and Akeris restarts at zone 1 on a new layout; the spirits
remember him. What sends the player round again: reaching deeper and learning more of the story.

## Mechanics

- **Movement:** A/D move (walk, run); Space jumps; W/S steer the jump vertically; jump + S is a fast
  descent that stuns enemies; Shift rolls, with brief invulnerability; Left Ctrl crouches, to pass
  through tunnels and low gaps.
- **Melee:** left click attacks with the equipped weapon — diagonal slash, rising slash, thrust,
  overhead strike, aerial attack.
- **Block:** right click raises the equipped shield, which is strapped to Akeris's forearm. It is the
  only block; there is no high/low block.
- **Counter:** blocking just before impact, or splitting a projectile in the air, triggers 1 s of
  ultra-fast strikes with afterimages, an aura and a "COUNTER!" callout; with the chain blades
  equipped it triggers an ultra-fast ranged burst.
- **Chain blades:** always available: a pair of hook blades, one in each hand, each on its own chain.
  When equipped, the mouse aims and left click throws them: ranged attack, area spin, overhead arc, pull toward an enemy, snatch objects (the knight's shield, the
  skeleton's skull), hook onto boss parts, climb walls (near a wall: jump + left click), grab ceiling
  rings and swing (A/D to swing, Space to release), anchor into the floor (the only escape from the
  golem's levitation).
- **Weapons:** 5 slots. The sacred sword is always carried, dormant and weak (it activates with the
  first gem, which is not in the demo); the chain blades (the pair of hook blades) are always carried,
  starting at a low level;
  3 free slots for the spear, the flail and the hammer, found in the map. Switched with the mouse wheel
  or the number keys through the quick inventory.
- **Shields:** sacred shield (unbreakable; block and counter), ice shield (freezes enemies, raises
  counter-burst damage; 10 hits), fire shield (blocks fire attacks; 4 dragon blasts). Special shields
  refill on entering each zone. All 3 can be carried; the equipped one is changed only in the
  pause/inventory menu.
- **Potions:** carry 3, refilled on entering each zone. Hold F to drink, or select one with the wheel
  and hold attack.
- **Abilities:** 3 equipped at once, triggered with Q, E, R and shown in the quick inventory. Each
  boss drops one of its 2 abilities at random (no ability shared between bosses); after each boss the
  player may swap one equipped ability.
- **Scrolls:** 3 per zone — health; attack and ability; cursed (kill 10 enemies without taking
  damage; any damage during the challenge kills Akeris instantly; success grants a rage attack boost
  for 3 min, ending early on zone change).
- **XP and upgrades:** enemies drop XP according to their type. XP is spent in the full inventory to
  upgrade weapons, the sacred shield or the special shields. Weapons have 7 levels, capped at 3 in
  the demo; level 1→2 costs 1000 XP, 2→3 costs 3000 XP.
- **Coins:** enemies drop coins; they are lost on death. The home-menu shop button shows "locked".
- **Spirits:** approach and press H to talk, Enter to advance. They speak in a processed "ancient
  language" voice, remember past runs (offering to replay or skip), hint at unlockable powers and at
  the gem-shaped holes in Akeris's sword.
- **Map:** one map per zone on M, revealed as the player explores; a circular minimap.
- **Boss rooms:** doors sealed with bars, chains and a padlock until the boss dies; per-boss stage
  elements (hanging platforms, cover, rings) help Akeris dodge ground attacks or reach the boss.
- **Enemy scaling:** enemies are stronger in each successive zone.
- **Status effects:** levitation (golem), slow (web), poison, freeze, stun.
- **Hit feedback:** hitstop, handwritten onomatopoeia, sparks, dust puffs, blade trails, afterimages;
  no screen shake; defeated enemies dissolve into ink smoke.
- **Pause:** Esc opens the pause menu (manual save, full inventory and stats).

### Bosses

1. **Golem** (zone 1) — levitating rock with a tracking eye; tears rocks from the floor, orbits and
   throws them (dodge or split them, which counts as a block and opens a counter); a visible radius
   levitates Akeris if he enters it (escape by anchoring the chain into the floor); cracks under chain
   hits; rage phase with a rock rain in which its slabs crumble and the floor shrinks; finisher: chain
   into its eye.
2. **Giant Bat** (zone 2) — wakes hanging from the ceiling; stunning screech; blockable dive (opens a
   counter); summons small-bat swarms, later used as a shield; wings can be torn; hooked by a wing and
   dragged to the ground (shockwave dodged from a hanging platform); only its eyes show in the dark;
   stalactites can be dropped on it with the chain; dissolves into a fleeing swarm.
3. **Skeleton** (zone 3) — unblockable air slashes at range (dodge by jumping or behind tombstones,
   which break); blockable bone throws (open a counter); bony hands from the ground; reassembles once
   after its first "death" unless its skull is snatched with the chain.
4. **Giant Spider** (zone 4) — web shots that slow; eggs that hatch weak mini-spiders; poison spit
   leaving puddles; hangs from a thread (cut it with the chain to drop and stun it); floor webs slow
   and are burned by the fire shield.
5. **Dragon** (zone 5, threshold boss: every 5 zones holds the strongest boss of its tier) — fire
   bursts (low and high breath), earthquakes when slamming into the floor, wind slashes from its
   wings, floor eruptions telegraphed by glowing cracks; plus claw (blockable), bite, flight with wind
   gusts, dive; fire blocked by the fire shield; finisher: hook the horn and strike the neck.

### Abilities

| Boss | Ability A | Ability B |
|---|---|---|
| Golem | Inverse Gravity — nearby enemies float helpless for 2 s | Stone Orbit — 3 rocks orbit Akeris, stop projectiles and strike |
| Giant Bat | Screech — stunning cone wave | Swarm — bats that chase enemies |
| Skeleton | Air Slash — unblockable ranged slash | Reassemble — once per zone, revive at 30% health on death |
| Giant Spider | Web — slows enemies in an area | Venom Edge — weapons poison for a few seconds |
| Dragon | Breath — ground-level flame | Earthquake — the fast descent releases a shockwave |

## Win / lose conditions

- **Win:** defeat the Dragon (zone 5). The outro plays: the Future Traveller Akeris appears, the
  screen cuts to black and a message says this is only the beginning of the adventure.
- **Lose:** health reaches zero, or damage is taken during the cursed-scroll challenge. The run ends,
  all progress and coins are lost, the save slot is wiped, and play restarts at zone 1 on a new
  procedural layout.

## Content scope

| Content | Count |
|---|---|
| Zones (demo / full game) | 5 / 20 |
| Biomes | 5 — Suspended Sanctuary (floating ruins), Echo Caverns (caves), Sunken Graveyard (cemetery and catacombs), Rotting Canopy (underground jungle), Dragon Battlements (ruined ramparts) |
| Bosses | 5 — Golem, Giant Bat, Skeleton, Giant Spider, Dragon |
| Normal enemy types | 20 (4 per zone, listed below) |
| Weapons | 5 (sacred sword, chain blades, spear, flail, hammer); 7 levels, demo cap 3 |
| Shields | 3 (sacred, ice, fire) |
| Abilities | 10 (2 per boss); 3 equipped |
| Scrolls | 15 (3 per zone) |
| Spirits / NPCs | 10 (2 per zone) |
| Potions carried | 3 |
| Save slots | 3 |
| Cinematics | 2 — intro (a silhouette like Akeris, only its purple eye streak visible); outro |
| Languages | 2 (English, Spanish) |
| Music | 1 track per zone = 5 (menu and boss tracks: soft) |
| Playable characters | 1 (Akeris, the Savior) |

Normal enemies per zone (\* existed in the original design document):

1. Shield Knight\* (sword and eye-shield that blocks frontal attacks; shield snatched with the chain),
   Rune Sentinel (small rolling rock that charges), Wandering Eye (floating eye firing a slow beam),
   Mace Brute\* (unblockable overhead smash, blockable sweep).
2. Small Bats\* (swarm, one-hit kills), Blind Ghoul (detects Akeris when he runs, not when he walks),
   Ceiling Crawler (drops on Akeris), Many-Armed\* (six extra arms with short swords, thrust waves).
3. Skeleton Archer, Gravedigger (rises from graves), Wraith (passes through walls; vulnerable only
   while attacking), Ossuary Many-Armed (variant with different mechanics).
4. Spiderlings, Spore Pod (toxic cloud), Strangler Vine (traps Akeris; freed with the chain), Mantis
   (fast bursts that force blocking).
5. Drakeling (fire spitter), Gargoyle (statue that wakes and dives), Elite Shield Knight\*, Fire Mace
   Brute (mace brute with a fire attack).

Biome hazards and boss-room aids: drifting platforms and chasms (1); dripping water and darkness lit
only by torches, droppable stalactites (2); fog, open graves, breakable tombstones as cover (3); roots,
poison pools, spores, vines to swing over poison, torches that burn webs (4); side wind, gaps between
merlons, merlons as cover against fire (5). Every boss room has hanging platforms.

## Reference games

- **Hollow Knight** — takes: platforming, the 2D side view, the dark dungeon atmosphere; rejects:
  none stated.
- **Dead Cells** — takes: the roguelike structure, the full procedural rebuild of every zone each run
  (positions of everything change), the side view; rejects: none stated.
- **Hades** — takes: the roguelike run structure, the dungeon aesthetic; rejects: the top-down view.
- **God of War** — takes: the currency-based weapon upgrade (red orbs there; XP here); rejects: none
  stated.
- **The operator's `duelo.html` animation and design document** — the original visual and
  mechanical reference; takes: pencil on paper, stick figures, comic impact effects, the fights
  described above; rejects: its "boiling" line — every stroke is static.
- **The operator's `akeris-sandbox.html`** (`.factory/project/reference/`, detailed in
  `ART_DIRECTION.md` beside it) — the approved look and animation reference; takes: its look and
  animation, which win on how things look and move; rejects: its controls and its gameplay numbers,
  which are browser stand-ins.

## Session shape

- **Session length:** no time limit per zone; exploration is free and rewarded; an incursion (an
  attempt at all 20 floors, in the full game) can last hours.
- **Saving:** 3 save slots. Manual save from the pause menu without leaving the run (for example to
  keep a run and start another); autosave on quitting (keeping the position in the zone map and
  everything carried); autosave on entering a boss room. Death wipes the slot.
- **Progression:** within a run, everything is kept. Across deaths nothing is kept; the spirits
  "remember" earlier conversations (narrative only).

## Input scheme

Keyboard and mouse, the only supported input.

## Target platform

Windows desktop, fullscreen, with the screen resolution detected automatically.

## Client constraints

- Flutter desktop, targeting Windows.
- Object-oriented programming, Domain-Driven Design and Clean Code.
- Design patterns such as Decorator and Flyweight, and DDD tactical patterns — whichever patterns
  give optimal performance while complying with DDD and Clean Code.
- The architect decides everything used besides Flutter.
- All art is created within the project: pencil drawing on paper, stick-figure characters with round
  heads, dungeon setting; more refined than the reference animation — not childish, eerie.
- Characters follow the operator's sketches. A single elongated eye emits a ray-like streak that
  represents the timeline: **Savior** — red streak, torn cape with holes; **Future Traveller** — red
  streak (not yet corrupted), fully torn cape, curved battered sword, very dirty look;
  **Corrupted** — purple streak, holds the clock.
- Music (one per zone) and sound effects composed within the project; external assets are allowed
  only if official and copyright-free, and original composition is preferred.
- Spirit voices are processed sounds imitating an ancient language.
- Audience: all ages, with a muted, melancholic, eerie tone.
- Text in English and Spanish, selectable in the settings on the home screen.
- Settings: music volume, sound-effect volume, language.
- Zones are generated procedurally; no zone is the same in two incursions.
- Personal project; no deadline.

### Art direction

The approved look and animation are the operator's sandbox and
`.factory/project/reference/ART_DIRECTION.md`, which holds the detailed rules and numbers. This
subsection changes no control, key binding or gameplay number; animation adapts to gameplay, never
the reverse.

- **Nothing trembles:** no line boil, no per-frame jitter, no screen shake. Each stroke's
  hand-drawn irregularity is seeded once and identical in every frame; only real motion moves
  (characters, cape, chains, projectiles, particles, a slow torch sway).
- **Pencil on old paper:** ink lines, graphite hatching, a paper texture with an edge vignette. The
  only colours are warm torchlight, the red eye streak (purple for the other timelines' streaks),
  and the ice-blue and fire accents of the shields and effects.
- **The dungeon is drawn as masonry,** never as outlined tiles: arches, pillars, chains, darkness, a
  far wall in parallax.
- **Akeris is about 26 % of the screen height.** His crouch and roll are drawn lowered to fit the
  game's crouching height.
- **Akeris is animated on a jointed rig:** his feet stay planted on the floor, walking blends
  continuously into running with speed, and every change of posture crossfades.
- **The cape is driven by Akeris's state,** not by free cloth physics; it is torn, with holes.
- **Eye and streak:** a black almond eye with a soft glow and a streak trailing behind it.
- **Gear:** the sacred sword is melee only. While the sword is equipped, the hook blades hang from
  the belt; while the hook blades are equipped, the sword is sheathed on the back. Swapping weapons
  plays a hand-reach animation.
- **The shield** is strapped to the back forearm: edge-on at the hip when lowered, in front of the
  face and chest when raised.
- **Chain throws alternate hands,** and each blade draws its own chain.
- **Hit feedback:** hand-lettered callouts, sparks, dust puffs, a blade trail during the strike, and
  a contact shadow.
- **Enemies and bosses** use the same static strokes; the humanoid enemies use Akeris's rig.

## Non-goals

- Zones 6–20.
- Any fight against the Future Traveller Akeris (he appears only in the outro).
- The fight against the Corrupted Akeris, including the Time Clock's accelerate/rewind zone.
- Sword gems and sacred-sword activation.
- The shop and suits (the button shows "locked").
- Game modes.
- Settings beyond music volume, sound-effect volume and language.
- Gamepad and touch input.
- Any platform other than Windows.
- Weapon levels 4–7.

## Success criteria

- Every combat mechanic of Akeris and of the 5 bosses works as specified.
- Animations and zones are well executed.
- Each zone is a completely different biome, with enemies that may look alike but have distinct
  mechanics.
- The dungeon, enemies and bosses read as dark and refined, not crude.

## Assumptions and open questions

Everything in this section is **soft**: unconfirmed by the client, and open to challenge by the
architect and the planner.

- **Open question:** how much stronger enemies get per zone — the operator.
- **Open question:** XP awarded per enemy type — the operator.
- **Open question:** the exact timing window for "just before impact" on the counter — the operator.
- **Open question:** upgrade levels and XP costs for the sacred shield and the special shields — the
  operator.
- **Open question:** size of a procedural zone and target length of a demo run — the operator.
- **Assumption:** screens are home (new game, continue, load, settings, locked shop, exit), settings,
  save-slot selection, pause/inventory and stats, map, dialogue, death, and the 2 cinematics —
  assumed from the mechanics described.
- **Assumption:** music is one track per zone; whether the menu and boss fights have their own tracks
  was not stated.
- **Open question:** clarifying-sweep items never asked: a game this must not be mistaken for; what
  has been tried before and did not work.

## Risks

- The art looks crude or childish instead of eerie — the operator's main concern.
- The volume of mechanics (5 multi-mechanic bosses, 20 enemy types, 9 chain uses) combined with full
  procedural generation may overrun the plan.
- Real-time action performance on the required stack.
