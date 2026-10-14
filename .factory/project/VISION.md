---
project: saviors-paradox
factory_version: 4.3.0
created: 2026-10-14
---

# saviors-paradox — vision

## Vision statement

Savior's Paradox is a dark, hand-drawn 2D side-view roguelike action-platformer in which Akeris
descends the procedurally assembled dungeon beneath the Temple of Time to recover the Time Clock, his
race's sacred relic, unaware that the one behind the world's end is himself, across three timelines.
This project is a **demo**: the first 5 of the dungeon's 20 zones, each closed by a boss, ending in a
cinematic that teases the rest of the adventure.

Story context (full game): Akeris wakes from a vision that the world has days left because someone
used the Time Clock. He enters the dungeon whose last floor holds the Time Chamber, guarded by the
Time Guardian. Three versions of Akeris exist: the Savior (the player), Future Akeris (who tries to
stop him reaching the last floor) and Corrupted Akeris (corrupted by the clock, waiting on the last
floor). Akeris is both the cause and the salvation of the world's destruction, yet neither ever
happens: each death resets time, which is why death is permanent and the dungeon rebuilds itself. He
can only save the world by completing three successful incursions, finding in each a gem for the
three hollows of the sacred sword he always carries without knowing what it is. Ancient spirits of
the dungeon, who have lived through every reset, reveal the story piece by piece; only in the third
incursion does Akeris understand that he is fighting himself, which leads to the final fight against
the most powerful Corrupted Akeris, beatable only with the 3 gems. The demo only sows suspicion; the
whole truth and what the demo may never say are in `reference/01-story/premise.md`.

## Genre

2D side-scrolling action-platformer; roguelike (permadeath; every zone assembled anew each run from
hand-drawn rooms joined by the run's seed) with metroidvania-style traversal (climbing, wall to wall,
swinging from rings and vines).

## Core loop

Explore a procedurally assembled zone (about 40 rooms) → fight enemies for XP and coins, find altars
off the main path and choose whether to take what they hold, talk to spirits for lore and hints →
spend XP on weapon and shield upgrades and on the special shields' uses → defeat the zone boss and
choose one of its 2 abilities → take the way down into the next, harder zone (potions refill; the
special shields do not). On death the run and its slot are wiped and Akeris restarts at zone 1 on a
new layout; the spirits remember him. What sends the player round again: reaching deeper and hearing
more of the story — each spirit tells one new fragment per run.

## Mechanics

The controls are listed in full under *Input scheme*. Numbers given here are the operator's; every
other gameplay number is fixed by the game, never by a sandbox, whose numbers are stand-ins.

### Movement

- **Walk and run:** A/D walk; holding the key speeds the walk into a run.
- **Jump:** a tap of Space is the normal jump; holding Space is the high jump (released before the
  normal height, the rise stops there), to a side with A/D. W does not change the jump.
- **Fast descent:** S in the air; it stuns enemies where it lands.
- **Roll:** Shift rolls, with brief invulnerability against hits and projectiles. It travels further
  than first drafted (sandbox ≈ 330 su in 0.46 s, invulnerable the first 0.32 s; the game decides). It
  cuts whatever Akeris is doing — a strike of any weapon, the shield's pushback, a chain-blade action
  (the chains come back), the aerial attack. It does not cut being hurt, the counter, drinking,
  hanging or the walls. Space while rolling jumps out keeping the roll's speed (held: the high jump);
  Shift in the air is an air roll with the same invulnerability, once per jump.
- **Rolling always dodges:** every enemy and boss attack can be passed by a well-aimed roll, so Akeris
  can always reposition and strike from another angle. The one exception is the gargoyle's earthquake
  of stone spikes, which only a jump clears. Ground effects — poison pools, spore clouds, venom
  puddles, floor webs — are not attacks: they are avoided by not standing in them.
- **Crouch:** Left Ctrl, to pass through tunnels and low gaps (and to go unheard by the Blind Ghoul).
- **Falls:** falling into an abyss, black water, an open grave or a chasm costs health and returns
  Akeris to the last firm ground; during a curse it kills.
- **Vines (zone 4):** jumping and clicking at a vine grabs it by hand, with any weapon equipped; it
  swings like a ring (A/D swing, Space lets go, a click to the next vine).

### Combat

- **Melee:** repeated left clicks are the combo (diagonal slash → rising slash → thrust); W + click is
  the overhead strike; a click in the air is the aerial attack.
- **Block:** right click held raises the equipped shield, strapped to the back forearm; it lowers on
  release. It is the only block; a weapon never blocks.
- **Perfect block against a melee hit** (the shield raised just before it lands):
  - sacred shield — the counter: 1 s of ultra-fast strikes with afterimages, an aura and a "COUNTER!"
    callout (with the chain blades equipped, an ultra-fast ranged burst). Only the sacred shield
    counters;
  - ice shield — the attacker is frozen 1.5 s, its defence lowered while frozen (stone enemies and the
    Dragon are slowed instead);
  - fire shield — the attacker burns 1.5 s, losing health (fire creatures and stone do not burn);
  - a block at any other moment only stops the hit.
- **Projectiles** are dodged or blocked, never split. A perfect block sends one back, faster, at its
  thrower and damages it (the ice shield also freezes it 0.5 s, the fire shield burns it 0.5 s); a
  reflect is not a counter.
- **Elements:** only the fire shield blocks fire attacks without damage, and only the ice shield ice
  attacks; with another shield Akeris takes the hit. No enemy of the demo has ice attacks.
- **Defeated enemies stay defeated** for the whole run — every enemy, in the demo and the full game.
- **Status effects:** on enemies — freeze, slow, burn, stun, poison; on Akeris — levitation, slow
  (webs), poison, stun, being held (vines, cages, grabs), being pushed. Two grabs kill outright (see
  *Win / lose*).
- **Hit feedback:** hitstop, hand-lettered callouts, sparks, dust puffs, blade trails, afterimages, a
  contact shadow; no screen shake; defeated enemies dissolve into ink smoke.

### The chain blades

- Always carried: a pair of hook blades, one in each hand, each on its own chain. Equipped, the mouse
  aims and a left click throws toward it; the throws alternate hands.
- **They are tools more than weapons:** their damage is very low. They are for hooking and moving,
  closing on an enemy fast, snatching what enemies hold, knocking down the enemies whose contracts say
  so, and anchoring to the floor (operator, 2026-10-14; this replaces the 2026-10-13 proposals P1–P4
  of `hook-blades-balance.md`).
- **What a throw does** is decided by its target and the key held:
  - an enemy: a strike; if it hits, the blade bites for a moment, and a second click while it bites
    pulls Akeris to the enemy and he strikes on arrival;
  - a click at a ring or a wall acts at once; otherwise a click released before 0.18 s is the strike,
    and held past it becomes the area spin, lasting while held;
  - W + click: the overhead arc; S + click: anchor into the floor (frees Akeris from the golem's
    levitation);
  - snatch what an enemy holds (the knight's shield, the gravedigger's spade, the skeleton's skull);
    hook a boss part;
  - climb: Space, then a click at the wall beside him; in the air, a click toward another wall within
    reach pulls him across and he hangs there;
  - a ring in reach (on the ground, above him; in the air, also level with him or a little below;
    aiming picks the ring nearest the aim): hook it and hang.
- **The chain never immobilizes:** the strike, the arc and the spin never interrupt an enemy or push
  it back; an enemy's own reaction to the chain happens at most once every 5 s; freeing Akeris from a
  strangler vine always works. After four chain hits in a row a boss lets out a sound blast that pushes
  Akeris away without damage (no shield stops it, a roll passes it). The zone 5 heavies answer two
  ranged chain hits with a lunge, and a shield knight's raised shield stops a frontal chain strike.
- **Hanging from a ring:** a hit never makes him let go; only Space (or dying) does. One hand holds the
  chain and the free hand starts with its hook blade: a click throws it to the next ring, hand over
  hand; the wheel swaps the free hand between the blade and the equipped shield; right click with the
  blade throws it at range (strike, snatch, hook a boss part — never pull, climb or anchor), with the
  shield it blocks; a sacred perfect block counters with the free blade without letting go, and the
  shield comes back after. Abilities work; potions do not.

### Equipment and items

- **Altars:** weapons, shields and scrolls lie on stone altars in rooms off the main path, placed by
  each zone's construction technique (its `layout.md`). What an altar holds is visible; G takes it,
  and taking it is the player's choice — the weapons already carried may be stronger, since they are
  upgraded with XP. XP flies to Akeris by itself; coins are taken by walking over them.
- **Weapons:** 5 slots. The sacred sword is always carried, dormant and weak, melee only (it
  activates with the first gem, not in the demo); the chain blades are always carried, starting at a
  low level; the spear (the longest reach), the flail (hits along the ball's path) and the hammer (the
  slowest, the most knockback) are found on altars, go to the first free slot and are drawn at once.
  The wheel cycles the weapons carried and 1–5 pick one; any weapon can be moved to any slot in the
  pause menu. He can change weapon while levitating.
- **Shields:** a run starts with the sacred shield only (unbreakable; it stops physical attacks, not
  fire or ice). The ice shield (10 uses: one per block, melee or projectile) and the fire shield (4
  uses: one per fire attack it stops) are found on altars, stored on pickup, and equipped only in the
  pause menu. They are **not** refilled on entering a zone: their uses are bought back with XP. The
  last use breaks the shield and staggers Akeris; a broken shield stays on the forearm, drawn broken,
  and cannot block until it is repaired with more XP and a curse.
- **Potions:** carry 3, refilled on entering each zone; never found on altars. Hold F to drink;
  Akeris stands still; letting go of F early or being hit cancels without spending it; afterwards the
  weapon held before is back in hand. No drinking while hanging.
- **Scrolls:** 3 per zone, read at once on pickup (a hit interrupts the reading and the scroll goes
  back to its altar). Health: raises maximum health and refills it. Attack and ability: raises the
  damage of weapons and abilities. Cursed: kill 10 enemies without taking damage; any damage during it
  kills Akeris; success grants rage for 3 min (his eye streak burns wider), ending early on a zone
  change.
- **Curses add up:** a shield repair and the cursed scroll share one count (4/10 becomes 4/20); every
  reward comes when the total is reached; a curse survives a zone change.
- **XP and upgrades:** enemies drop XP by type. It is spent in the full inventory on weapon levels (7
  levels, demo cap 3; 1→2 costs 1000 XP, 2→3 costs 3000 XP; every level raises the weapon's damage; a
  level does not change the drawing), on the shields' 3 levels, on restoring the special shields' uses
  and on repairs.
- **Coins:** dropped by enemies, lost on death. The home-menu shop button shows "locked".
- **Abilities:** 3 equipped at once, on Q, E and R. After each boss the game pauses on a choice between
  its 2 abilities (two cards; A/D, Enter); the one chosen goes to the first empty slot, or to Q when
  all three are full. Abilities change only there.
- **The torch (zone 4):** G next to a torch takes it in the free hand (an altar in reach comes first)
  and G again lays it down burning; it burns the webs and curtains Akeris touches and what its flame
  touches; while it is carried the shield cannot be raised; a hit drops it; it is never thrown.

### World, spirits and menus

- **Zones:** each zone is about 40 rooms (36–44) with a main path of 13 — start, corridors, combat
  rooms, shafts, the antechamber with the warning spirit, the boss room, the way down — and branches
  that end in altars, the lore spirit and lookouts. Each zone fields only its own enemies, in the
  shares of its `layout.md` (*The mix*); the hardest guards the last combat room of the main path.
  After the boss, reaching the foot of the way down starts the next zone.
- **Zone hazards and aids:** drifting platforms and the abyss (zone 1); black water, cracked
  stalactites that noise or the chain bring down, and noise — running, landing, striking and blocking
  are heard, walking is not (zone 2); open graves and tombstones as cover (zone 3); poison pools waded
  at 60 % while poisoned, floor webs and web curtains, rotten roots, vines, torches (zone 4); gaps into
  the chasm and merlons as cover (zone 5). The zone 5 wind is ambience only: it never moves Akeris.
- **Spirits:** 2 per zone (lore, off the main path; warning, before the boss door). They are pale,
  translucent ghosts — a round head with two dark eyes and a shroud trailing to a wisp, floating, with
  no eye streak — anonymous, with no name or portrait, speaking in a processed whispered "ancient
  language". H near one talks; the game pauses and the HUD hides; Enter moves to the next line at once.
  Each spirit has 3 fragments and tells one new fragment per run; a line heard for the first time
  cannot be closed; once all three are heard it offers *Hear it again* / *Go on*, and Esc closes only a
  replay. They remember Akeris across deaths. Akeris never speaks.
- **Map:** M opens it and pauses the game; M or Esc closes it. It is revealed as Akeris passes, belongs
  to the run (saved with it, lost on death) and each zone starts blank. It marks altars, spirits, the
  boss door, the way down and unexplored passages; no fast travel and no player marks. A circular
  minimap at the top right, north up.
- **Boss rooms:** sealed with bars, chains and a padlock on entering (with an autosave) until the boss
  dies; per-boss stage elements (hanging slabs, cover, stalactites, coffins, roots, merlons) and no
  rings. The Dragon's room is 3 × 2 rooms, in the open air; the bridge above it falls when it wakes.
- **Enemy scaling:** enemies are stronger in each successive zone.
- **Pause:** Esc stops everything (cooldowns, rage, curses): Akeris and his stats, the full inventory,
  Resume, Save (to the run's own slot) and Quit to title (asks, autosaves, then the loading screen). In
  the pause menu and the map only the music sounds.
- **Cinematics:** the intro plays as a teaser on every launch while the game loads and ends on the
  title screen; New game plays the descent; the outro follows the Dragon. Both cinematics can be
  skipped from the first viewing by holding Enter or Esc for 5 s.

### Bosses

Each boss's contract (`reference/03-characters/bosses/<boss>/contract.md`) holds its phases, numbers
and room.

1. **Golem** (zone 1) — a carved rock with one eye, floating among its slabs. It tears rocks from the
   floor and throws them (the shield stops them, a perfect block returns them). A visible ring
   levitates Akeris (the anchor pulls him down; otherwise he falls after a while). Every weapon damages
   it and the chain cracks it. Rage at half health: a red eye and a roar, the slabs and the floor's ends
   sink, a rock rain during which it cannot be reached. Finisher: the chain into its eye.
2. **Giant Bat** (zone 2) — sleeps hanging from the roof; only its eyes show in the dark. A stunning
   screech (the slabs cover), a dive the sacred perfect block counters, small-bat swarms. The chain in a
   wing drags it down; big stalactites dropped with the chain bring it down; on the floor its wings
   tear; every few hits it pushes Akeris away without damage. Rage: faster, the middle torches blown
   out, a shield of small bats, a slam whose floor wave a slab, a jump or a roll avoids. It flees as a
   swarm.
3. **Skeleton** (zone 3) — the oldest of the dead, on its bier. Unblockable air slashes (sword high:
   crouch; sword low: jump or a tombstone; a roll passes both), bone throws (the shield stops them, a
   perfect block returns them), hands from the floor (the hanging coffins are safe), a heavy chop. After
   its first death it **always** reassembles (1.2 s). Snatching its skull with the chain takes health
   from its second life, and a second later a guttural roar throws Akeris away and the skull returns.
   Phase 2 at half health.
4. **Giant Spider** (zone 4) — in the roof's web lattice: web shots that slow and leave floor webs,
   poison spit leaving puddles, eggs that hatch spiderlings, the drop. Tired, she hangs by one thread
   that one chain throw cuts. Out of her reach, she comes down and hunts Akeris. Rage: she comes down to
   charge and sweep, and the storm inside her cocoon is her only untouchable time. Her webs burn with
   the fire shield and torches.
5. **Dragon** (zone 5, threshold boss: every 5 zones holds the strongest boss of its tier) — three
   phases. Ground: claw, an unblockable bite, low and high breath, tail, earthquake. Air: gusts, wind
   slashes, dive, fire rain. Rage: both in turn, plus floor eruptions telegraphed by glowing cracks.
   Fire is blocked only by the fire shield (one use per breath or rain). With its head down, the chain
   on its chipped horn pins it and its neck takes damage; at its last mark only horn and neck end it.
   Its death is slow and sad; then the ability choice, then the outro.

### Abilities

| Boss | Ability A | Ability B |
|---|---|---|
| Golem | Inverse Gravity — nearby enemies float helpless for 2 s | Stone Orbit — 3 rocks orbit Akeris, stop projectiles and strike |
| Giant Bat | Screech — a cone of sound that stuns enemies | Swarm — five bats chase the nearest enemies and bite them |
| Skeleton | Air Slash — an unblockable slash along the floor | Reassemble — once per zone, rise at 30 % health on death |
| Giant Spider | Web — a web that slows enemies in an area | Venom Edge — for a few seconds the weapons poison what they hit |
| Dragon | Breath — a ground-level flame (the "Flare" some contracts name) | Earthquake — the fast descent releases a shockwave |

## Win / lose conditions

- **Win:** defeat the Dragon (zone 5) and choose its ability. The outro plays in the Dragon room:
  Akeris walks out into rising fog, Future Akeris stands behind him and charges his corrupted sword, a
  massive clock tick cuts the strike before it lands, and the last card reads "To be continued…". Then
  the title screen; the slot is kept, marked won, and cannot be continued.
- **Lose:** health reaches zero; any damage during a curse; or an instant-kill grab (the Blind Ghoul's
  bite, the Many-Armed's crush). After the ink smoke the death screen shows the zone reached, enemies
  defeated, time, the XP and coins lost, the wiped slot and, for a curse, its cause; New game restarts
  in the same slot at zone 1 on a new layout, without the intro, or the player returns to the title.

## Content scope

| Content | Count |
|---|---|
| Zones (demo / full game) | 5 / 20 |
| Rooms per zone | about 40 (36–44), main path 13; about 10 min straight to the boss, about 30 min explored whole |
| Biomes | 5 — Suspended Sanctuary (floating ruins in an immense cavern), Echo Caverns (closed caves), Sunken Graveyard (yard and catacombs), Rotting Canopy (underground jungle), Dragon Battlements (ruined ramparts) |
| Bosses | 5 — Golem, Giant Bat, Skeleton, Giant Spider, Dragon |
| Normal enemy types | 20 (4 per zone, listed below) |
| Weapons | 5 (sacred sword, chain blades, spear, flail, hammer); 7 levels, demo cap 3 |
| Shields | 3 (sacred, ice, fire); 3 levels each |
| Abilities | 10 (2 per boss); 3 equipped |
| Scrolls | 15 (3 per zone) |
| Spirits | 10 (2 per zone, 3 fragments each) |
| Potions carried | 3 |
| Save slots | 3 |
| Cinematics | 3 — the intro (10 shots, 45 s), the descent (about 4 s), the outro (11 shots, 43.5 s) |
| Screens | 10 — title, save slots, settings, HUD, pause / full inventory, map, dialogue, the ability choice, death, loading |
| Music | 20 cues — title, 5 zones, a calm and a fight cue for each of the 5 bosses, the intro, the descent, the outro and the Dragon's fall; each looping cue has a lite version for the pause menu and the map |
| Languages | 2 (English, Spanish) |
| Playable characters | 1 (Akeris, the Savior) |

Normal enemies per zone (each contract: `reference/03-characters/enemies/zone-N/<enemy>/contract.md`):

1. Shield Knight (an eye-shield that stops frontal attacks; snatched with the chain), Rune Sentinel (a
   knee-high stone that charges rolling; only downward strikes reach it), Wandering Eye (a floating eye
   throwing a fast ink stone), Mace Brute (unblockable smash, blockable sweep).
2. Small Bats (a swarm woken by noise; one hit kills), Blind Ghoul (hunts by clicks: upright movement
   gives Akeris away, standing still or crouching does not; its grab kills), Ceiling Crawler (follows
   Akeris along the roof and drops on him), Many-Armed (six extra arms with short swords; thrust waves;
   its crush kills).
3. Skeleton Archer, Gravedigger (digs graves and rises from them), Wraith (passes through walls; solid
   only while attacking), Ossuary Many-Armed (a variant with bare bone arms and a bone cage).
4. Spiderlings (broods in egg sacs across the zone), Spore Pod (a poison cloud), Strangler Vine (holds
   Akeris; one chain throw frees him), Mantis (fast bursts; rolling through it leaves it open).
5. Drakeling (a fire-spitting young of the Dragon), Gargoyle (a statue among decorative ones that wakes
   and dives), Elite Shield Knight, Fire Mace Brute (the zone 1 brute hardened by fire). Future Akeris is
   glimpsed as a distant watcher on some walls.

## Reference games

- **Hollow Knight** — takes: platforming, the 2D side view, the dark dungeon atmosphere; rejects: none
  stated.
- **Dead Cells** — takes: the roguelike structure, the full procedural rebuild of every zone each run,
  the side view; rejects: its look — Savior's Paradox must never be mistaken for Dead Cells or for games
  of that aesthetic.
- **Hades** — takes: the roguelike run structure, the dungeon aesthetic; rejects: the top-down view.
- **God of War** — takes: the currency-based weapon upgrade (red orbs there; XP here); rejects: none
  stated.
- **The Last of Us** — takes: the clickers' hunting by sound, for the Blind Ghoul; rejects: none stated.
- **The operator's `duelo.html` animation and design document** — the original visual and mechanical
  reference; takes: pencil on paper, stick figures, comic impact effects, the fights; rejects: its
  "boiling" line — every stroke is static.
- **The approved references and their sandboxes** (`.factory/project/reference/`) — take: how
  everything looks, moves and sounds, and how rooms and screens are laid out; reject: their code, their
  keys (browser stand-ins) and their stand-in numbers.

## Session shape

- **Session length:** no time limit per zone; exploration is free and rewarded. A zone takes about 10
  min straight to the boss and about 30 min explored whole; an incursion (all 20 floors, in the full
  game) can last hours.
- **Saving:** 3 save slots. New game takes the first empty slot (all full: the player chooses one to
  overwrite, with a question); Continue opens the most recent run not won; Load opens the three slots.
  Manual save from the pause menu, to the run's own slot; autosave on quitting to the title (keeping the
  position, the zone map and everything carried) and on entering a boss room. Death wipes the slot; a
  won slot is kept, marked won. Slots cannot be deleted.
- **Progression:** within a run, everything is kept. Across deaths nothing is kept; the spirits
  remember earlier conversations (narrative only). The settings belong to the computer, not to a slot.

## Input scheme

Keyboard and mouse, the only supported input; no rebinding. These are the game's controls;
`reference/00-game/controls.md` copies them as tables.

| Context | Input | Action |
|---|---|---|
| Moving | A / D | walk; held, the walk speeds into a run |
| | Space | tap: jump; held: high jump (A / D to a side) |
| | S (in the air) | fast descent |
| | Shift | roll; in the air, air roll (once per jump); Space while rolling jumps out |
| | Left Ctrl | crouch |
| Fighting | Left click, repeated | melee combo; in the air, the aerial attack |
| | W + left click | overhead strike |
| | Right click, held | raise the shield (block, perfect block, reflect) |
| | Q / E / R | the three equipped abilities |
| | Hold F | drink a potion |
| | Mouse wheel / 1–5 | cycle / pick a weapon |
| Chain blades equipped | Left click (mouse aims) | throw: strike, second click while it bites to pull, snatch, hook a boss part, ring, wall to wall |
| | Left click held past 0.18 s | area spin |
| | W + left click / S + left click | overhead arc / anchor into the floor |
| | Space, then left click | climb the wall beside him |
| Hanging (ring or vine) | A / D, Space | swing, let go |
| | Left click | throw to the next ring |
| | Mouse wheel | free hand: hook blade or shield |
| | Right click | free hand: ranged throw, or block |
| World | G | take what is on an altar; take or lay down a torch (zone 4) |
| | H, Enter | talk to a spirit, next line |
| | Esc (dialogue) | close a replay only |
| | M | map (pauses) |
| | Esc | pause menu |
| Map open | W A S D / arrows / drag; wheel or Q / E; Enter | move the view; zoom across three levels; centre on Akeris; M or Esc closes |
| Menus | mouse, or W / S / arrows + Enter; Esc | choose; back or close |
| Cinematics | hold Enter or Esc 5 s | skip |

## Target platform

Windows desktop, fullscreen, with the screen resolution detected automatically, running at the
monitor's refresh rate.

## Client constraints

- Flutter desktop, targeting Windows, with Flame — the stack the approved
  `reference/08-engineering/` builds on, adopted by the operator as the best option unless the
  architect finds a better one.
- Object-oriented programming, Domain-Driven Design and Clean Code, as `reference/08-engineering/`
  sets them out.
- Design patterns such as Decorator and Flyweight, and DDD tactical patterns — whichever give optimal
  performance while complying with DDD and Clean Code.
- The game is built optimized: the sandboxes are references for look, feel and numbers only; their
  code is not ported.
- The architect decides everything else the stack needs.
- All art is created within the project: pencil drawing on paper, stick-figure characters with round
  heads, dungeon setting; more refined than the reference animation — not childish, eerie.
- Characters follow the operator's sketches. A single elongated eye emits a ray-like streak that
  represents the timeline: **Savior** — red streak, torn cape with holes; **Future Akeris** — red
  streak, battered and broken (not yet corrupted), fully torn cape, curved battered sword, very dirty
  look; **Corrupted Akeris** — purple streak, holds the clock.
- Music, sound effects and voices are made within the project; nothing recorded or taken from outside
  it.
- Spirit voices are processed whispered syllables imitating an ancient language.
- Audience: all ages, with a muted, melancholic, eerie tone; no blood or gore — death is ink.
- Text in English and Spanish, selectable in the settings; every player-visible string is a
  translation key.
- Settings: music volume, sound-effect volume, language.
- Zones are generated procedurally; no zone is the same in two incursions.
- Personal project; no deadline.

### The approved references

`.factory/project/reference/` holds the operator's approved pieces — markdown contracts, exported
images and playable sandboxes; only what its `README.md` index marks `approved` exists. This vision
owns what the game is, its controls and its gameplay numbers; a reference owns how something looks,
moves, sounds or is laid out, and `08-engineering/` how the code is written. Where a reference and this
vision disagree, the operator settles it and one of the two is revised; where a reference is
ambiguous, an agent stops and asks. The pillars of `00-game/pillars.md` break ties this vision leaves
open.

| Part | Where |
|---|---|
| pillars, tone, glossary, controls (a copy) | `reference/00-game/` |
| story, spirits' dialogue, intro and outro | `reference/01-story/` |
| art direction, palette, strokes, the shared dungeon method, effects | `reference/02-art-direction/` |
| Akeris, his weapons and shields as he holds them; Future and Corrupted Akeris; every enemy and boss | `reference/03-characters/` |
| each zone's biome, layout and enemy mix, hazards and boss room | `reference/04-zones/zone-N-<biome>/` |
| items, altars, drops, potions, scrolls | `reference/05-items/` |
| every screen | `reference/06-ui/` |
| music, sound effects, voices | `reference/07-audio/` |
| architecture, patterns, coding standards, testing, the tester's checklist | `reference/08-engineering/` |

### Art direction

How things look and move is `reference/02-art-direction/ART_DIRECTION.md` and the pieces it points to.
Animation adapts to gameplay, never the reverse.

- **Nothing trembles:** no line boil, no per-frame jitter, no screen shake. Each stroke is seeded once
  and identical in every frame; only real motion moves. The cinematics' short circuits are the only
  flashes, and the intro's sixth shot, where the whole picture shakes as one piece, the only shake.
- **Pencil on old paper:** ink lines, graphite hatching, a paper texture with an edge vignette; the
  colours are the closed list of `reference/02-art-direction/palette/palette.md`.
- **The dungeon is drawn as masonry,** never as outlined tiles.
- **Akeris is about 26 % of the screen height,** animated on a jointed rig; the cape is driven by his
  state; the shield is strapped to the back forearm; chain throws alternate hands.
- **Enemies and bosses** use the same static strokes; the humanoid enemies use Akeris's rig.

## Non-goals

- Zones 6–20.
- Any fight against Future Akeris (he appears in the intro's dream, as a distant watcher in zone 5 and in
  the outro).
- The fight against Corrupted Akeris, including the Time Clock's accelerate/rewind zone.
- Sword gems and sacred-sword activation.
- The shop and suits (the button shows "locked").
- Game modes.
- Settings beyond music volume, sound-effect volume and language; key rebinding.
- Gamepad and touch input.
- Any platform other than Windows.
- Weapon levels 4–7.
- Fast travel and player marks on the map; deleting a save slot.

## Success criteria

- Every combat mechanic of Akeris and of the 5 bosses works as specified.
- The game matches the approved references in how it looks, moves and sounds.
- Animations and zones are well executed.
- Each zone is a completely different biome, with enemies that may look alike but have distinct
  mechanics.
- The dungeon, enemies and bosses read as dark and refined, not crude.
- It reads as its own game, never as Dead Cells or another game of that aesthetic.

## Assumptions and open questions

Everything in this section is **soft**: unconfirmed by the client, and open to challenge by the
architect and the planner.

- **Open question:** what each of a zone's 8 altars holds, how the spear, flail, hammer and special
  shields are spread across the five zones, and whether a weapon found on an altar carries its own
  level — the operator; `05-items/` and each zone's `layout.md` do not fix it.
- **Open question:** how much stronger enemies get per zone — the game decides; no reference sets it.
- **Open question:** XP awarded per enemy type — the game decides.
- **Open question:** the perfect-block window (the sandbox's 0.2 s is a stand-in) — the game decides.
- **Open question:** the shields' level effects and costs, and the cost of restoring uses and of a
  repair (the sandbox's numbers are stand-ins) — the game decides.
- **Open question:** how low the chain blades' damage goes — the game decides, within "very little".
- **Assumption:** a demo run lasts about 50 min straight to about 2.5 h explored whole — derived from 5
  zones × 10–30 min.
- **Assumption:** the spirits' look is the ghost drawn in `06-ui/dialogue/` and the interface sandbox;
  `03-characters/spirits/` holds no piece of its own yet.

## Risks

- The art looks crude or childish instead of eerie — the operator's main concern.
- The game drifts from the approved references. The previous attempt failed as a whole because the
  plan was not well defined; the references exist so that every agent builds from the same
  definition.
- The volume of content (5 multi-phase bosses, 20 enemy types, 9 chain uses, 3 cinematics, 20 music
  cues) combined with full procedural generation may overrun the plan.
- Real-time action performance on the required stack.
