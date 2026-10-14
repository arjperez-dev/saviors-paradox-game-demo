# Sound effects

- **Status:** approved 2026-10-01
- **Sources:** `VISION.md` §Client constraints (sound composed within the project) · `00-game/tone.md` §3 ·
  `03-characters/akeris/contract.md` §7 · `05-items/items.md` · `06-ui/*/` §7 · `02-art-direction/fx/`
- **Made in:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html), where every id has a seeded recipe
  (`SFX` in the sound block) and sounds at its trigger in play; the *Mesa de sonido* plays each one on
  its own
- **Read by:** any task that plays a sound; the tester, to check the triggers and the mixing rules

**The list is closed: a sound that is not here does not exist.** Every trigger is a game event or an
animation frame, never a keypress. The enemies and the Golem add their own rows in steps 3.10 and 3.11.
Step 3.9 added the zone 1 ambience, its abyss and the boss doors. Step 3.12 adds the zone 2 ambience,
its drops, its black water and its cracked stalactites, and the zone 2 echo (§3). Step 3.13 adds the zone 3
ambience, its open graves, its tombstones and its bell, and the stone of the catacombs (§3).

---

## 1. How to read the tables

- **Id**: `sfx.<owner>.<action>`. The ids proposed in steps 3.5–3.7 keep their names; this step adds
  the ones those pieces left open (hits, effects, the just block, the ambience).
- **Length**: what the file lasts, tail included. `(loop)` files loop with no seam.
- **Variations**: files `-1 … -n`; the game picks one by seed, never the same twice in a row.
- **Volume** (0–1): the play volume. Every file is normalised to −1 dBFS; the game multiplies by this
  value and then by the sound-effect setting (`06-ui/settings/`).
- **At once**: how many of that id may sound together; a new one stops the oldest.
- **Priority**: what is cut first when too many sounds play (see §3).
- **File**: in the folder of its group, under `07-audio/sfx/`. The game copies them to
  `assets/audio/sfx/<group>/`.

## 2. The list

### Akeris — `akeris/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.akeris.step` | each foot contact while walking, running or crouch-walking (gait phase 0 and 0.5, `03-characters/akeris/animations.md`); running ×1.15, walking ×0.85, crouched ×0.5 | a soft boot on stone: a short knock and a low thump | 0.2 | 4 | 0.32 | 2 | low | `akeris-step-1…4.wav` |
| `sfx.akeris.jump` | take-off (state enters `air` going up); high jump ×1.25 | cloth and air: a short rising swish | 0.3 | 2 | 0.35 | 1 | low | `akeris-jump-1…2.wav` |
| `sfx.akeris.land` | feet touch the floor after a fall; louder the faster he fell (×0.4–1.2) | a dull thump with a little grit | 0.35 | 2 | 0.45 | 1 | low | `akeris-land-1…2.wav` |
| `sfx.akeris.dive` | the fast descent (S in the air) hits the floor; with `¡PUM!` | a heavy thud, dust and pebbles | 0.7 | 1 | 0.6 | 1 | normal | `akeris-dive.wav` |
| `sfx.akeris.roll` | a roll or an air roll starts | two cloth swishes and a soft knock | 0.5 | 2 | 0.38 | 1 | low | `akeris-roll-1…2.wav` |
| `sfx.akeris.swap` | the weapon swap's midpoint (0.15 s); not for the potion or the scroll | a blade sliding out and a click | 0.45 | 2 | 0.4 | 1 | low | `akeris-swap-1…2.wav` |
| `sfx.akeris.counter` | a counter starts, on the ground or hanging (with `sfx.shield.just`) | air sucked in, then a sharp slice and a low boom | 0.9 | 1 | 0.7 | 1 | high | `akeris-counter.wav` |
| `sfx.akeris.hurt` | he is hit (state enters `hurt`); never a voice | a dull blow on cloth | 0.4 | 2 | 0.55 | 1 | high | `akeris-hurt-1…2.wav` |
| `sfx.akeris.drink` | the flask reaches his lips (`DRINK.raise`, 0.5 s) | a glass clink and two gulps | 0.9 | 1 | 0.45 | 1 | normal | `akeris-drink.wav` |
| `sfx.akeris.levitate` | levitation starts (the Golem's pull, step 3.11) | air rising, a thin glide upward | 1.4 | 1 | 0.4 | 1 | normal | `akeris-levitate.wav` |
| `sfx.akeris.anchor` | the anchoring hook blade bites the floor | a bite and a taut chain twang | 0.8 | 1 | 0.55 | 1 | normal | `akeris-anchor.wav` |
| `sfx.akeris.death` | death starts (`animations.md` §5.8): the knees, then the fall | two thuds and a fading exhale of air; no voice | 1.6 | 1 | 0.6 | 1 | never cut | `akeris-death.wav` |

### Weapons and the chain — `weapons/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.akeris.swing` | each sacred sword strike, 0.05 s before the snap key (the attack's `o` key) | a clean cut of air with a faint ring of the blade | 0.35 | 3 | 0.5 | 2 | normal | `akeris-swing-1…3.wav` |
| `sfx.spear.swing` | each spear strike, timed as the sword | a thin, fast thrust of air | 0.3 | 2 | 0.48 | 2 | normal | `spear-swing-1…2.wav` |
| `sfx.flail.swing` | each flail strike, timed as the sword | a slow, heavy swish with the chain rattling | 0.55 | 2 | 0.5 | 2 | normal | `flail-swing-1…2.wav` |
| `sfx.flail.chain` | while the flail is carried running or striking, at most every 0.7 s | a short chain rattle | 0.6 | 2 | 0.25 | 1 | low | `flail-chain-1…2.wav` |
| `sfx.hammer.swing` | each hammer strike, timed as the sword | a deep, slow sweep of air | 0.6 | 2 | 0.55 | 1 | normal | `hammer-swing-1…2.wav` |
| `sfx.hammer.slam` | the overhead hammer hits the floor (the ground attack's hit time) | a heavy stone thud, a crack and falling grit, with room | 1.2 | 2 | 0.8 | 1 | high | `hammer-slam-1…2.wav` |
| `sfx.chain.throw` | a hook blade leaves the hand (chain enters `fly`); inside a counter burst ×0.55 | a whistle of air with the chain unrolling | 0.4 | 2 | 0.42 | 2 | normal | `chain-throw-1…2.wav` |
| `sfx.chain.hook` | a hook blade catches a ring | a metallic clank, ringing | 0.6 | 2 | 0.5 | 2 | normal | `chain-hook-1…2.wav` |
| `sfx.chain.bite` | a hook blade bites a wall, an enemy or the floor | a sharp bite and a knock | 0.35 | 3 | 0.5 | 2 | normal | `chain-bite-1…3.wav` |
| `sfx.chain.back` | a hook blade is reeled back (chain enters `back`); a pull ×1.2 | a chain rattle that speeds up and a final click | 0.45 | 2 | 0.35 | 2 | low | `chain-back-1…2.wav` |
| `sfx.chain.spin` | the area spin, looped while it lasts; stops when it ends | air whirling four times a second with the chain | 1 (loop) | 1 | 0.45 | 1 | normal | `chain-spin.wav` |

### Shields — `shields/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.shield.sacred` | a block with the sacred shield (state enters `blockHit`) | a warm wooden-metal knock with a soft bell above it | 0.9 | 2 | 0.62 | 2 | high | `shield-sacred-1…2.wav` |
| `sfx.shield.ice` | a block with the ice shield | a knock and a glassy, crystalline ring | 0.8 | 2 | 0.6 | 2 | high | `shield-ice-1…2.wav` |
| `sfx.shield.fire` | a block with the fire shield | a knock and a whoomph of flame with crackles | 0.9 | 2 | 0.6 | 2 | high | `shield-fire-1…2.wav` |
| `sfx.shield.just` | a just block, layered over the shield's own block, the counter or the reflect | a clear, bright ting | 0.7 | 1 | 0.55 | 1 | high | `shield-just.wav` |
| `sfx.shield.break` | a shield's last use is spent (`¡CRAC!`) | a crack, shards and four falling bell notes | 1.3 | 1 | 0.7 | 1 | never cut | `shield-break.wav` |
| `sfx.shield.restore` | uses bought back with XP in the pause menu | three rising celesta notes over a soft bell | 1 | 1 | 0.5 | 1 | normal | `shield-restore.wav` |
| `sfx.shield.repaired` | a broken shield comes back when its curse is fulfilled (0.6 s after `sfx.curse.end`) | a metal ring and a resolved harp chord | 1.4 | 1 | 0.55 | 1 | normal | `shield-repaired.wav` |

### Combat and effects — `combat/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.hit.blade` | a blade hits an enemy: sword, hook blades, spear, and every counter hit | a dry slice and a short knock | 0.3 | 3 | 0.6 | 3 | normal | `hit-blade-1…3.wav` |
| `sfx.hit.blunt` | a blunt hit: flail and hammer; a stone that hits him or a wall; a reflected stone on its thrower | a dull, deeper knock | 0.4 | 3 | 0.65 | 3 | normal | `hit-blunt-1…3.wav` |
| `sfx.hit.clang` | a hit on an enemy's shield or armour (the enemy contracts say which) | metal on metal, ringing | 0.7 | 2 | 0.6 | 2 | normal | `hit-clang-1…2.wav` |
| `sfx.fx.reflect` | a projectile is reflected (`02-art-direction/fx/reflect/`), with `sfx.shield.just` | a ting and air rushing away fast | 0.7 | 1 | 0.6 | 2 | high | `fx-reflect.wav` |
| `sfx.fx.freeze` | an enemy freezes (`fx/freeze/`) | ice crackling as it forms, and a high chord | 1 | 1 | 0.55 | 2 | normal | `fx-freeze.wav` |
| `sfx.fx.burn` | an enemy catches fire (`fx/burn/`); its burn ticks make no sound of their own | a flame igniting and crackling | 1.5 | 1 | 0.5 | 2 | normal | `fx-burn.wav` |
| `sfx.fx.inkSmoke` | an enemy or Akeris dissolves in ink smoke (`fx/ink-smoke/`); for Akeris at `DEATH.ink` | a soft airy hiss that rises and thins, a few faint bubbles | 1.8 | 1 | 0.5 | 2 | normal | `fx-inkSmoke.wav` |
| `sfx.fire.cast` | a fireball is cast (`fx/elements/`) | a whoomph of flame | 0.7 | 1 | 0.5 | 2 | normal | `fire-cast.wav` |
| `sfx.fire.impact` | a fireball hits anything but a shield that stops it | a burst and crackles | 0.9 | 1 | 0.6 | 2 | normal | `fire-impact.wav` |
| `sfx.ice.cast` | an icicle is cast | an icy whistle falling in pitch | 0.6 | 1 | 0.45 | 2 | normal | `ice-cast.wav` |
| `sfx.ice.impact` | an icicle hits | a crack and shards | 0.8 | 1 | 0.55 | 2 | normal | `ice-impact.wav` |

### Items — `items/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.item.take` | the item flies into his hand (pickup, `05-items/altar/`) | three plucked notes rising and a swish | 0.9 | 1 | 0.5 | 1 | normal | `item-take.wav` |
| `sfx.altar.out` | the altar's candles go out, 0.35 s after the take | two short puffs | 0.6 | 1 | 0.4 | 1 | low | `altar-out.wav` |
| `sfx.scroll.open` | the scroll opens (`READ.swap`) | paper crackling as it unrolls | 0.7 | 1 | 0.45 | 1 | normal | `scroll-open.wav` |
| `sfx.scroll.ink` | the runes rise (`READ.ink`) | a low hum of voices and a run of celesta notes | 1.3 | 1 | 0.45 | 1 | normal | `scroll-ink.wav` |
| `sfx.scroll.crumble` | the paper turns to ink (`READ.done`) | paper crumbling and a soft sigh | 0.8 | 1 | 0.45 | 1 | normal | `scroll-crumble.wav` |
| `sfx.curse.start` | a curse starts, or another adds its 10 (D-I7) | a dark cluster of low voices and a thorn scrape | 1.8 | 1 | 0.55 | 1 | high | `curse-start.wav` |
| `sfx.curse.tick` | each kill that counts | a low plucked tritone and a click | 0.5 | 1 | 0.4 | 2 | normal | `curse-tick.wav` |
| `sfx.curse.end` | the curse is fulfilled; never when it kills him | the cluster opens into a fifth: relief, never triumph | 2.2 | 1 | 0.55 | 1 | high | `curse-end.wav` |
| `sfx.xp.absorb` | an XP mote reaches him (the sandbox's +1000 XP too) | a single soft celesta note, one of five | 0.5 | 5 | 0.3 | 3 | low | `xp-absorb-1…5.wav` |
| `sfx.coin.drop` | a coin hits the floor: each bounce, louder the faster; coming to rest ×0.35 | a coin tink with small bounces | 0.5 | 3 | 0.4 | 3 | low | `coin-drop-1…3.wav` |
| `sfx.coin.take` | a coin is taken (one per coin, 0.06 s apart) | two quick tinks | 0.35 | 2 | 0.4 | 4 | low | `coin-take-1…2.wav` |

### Interface — `ui/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.ui.move` | focus moves in any menu, list or choice; the map zooms | a soft pencil tick | 0.1 | 2 | 0.28 | 2 | low | `ui-move-1…2.wav` |
| `sfx.ui.confirm` | a choice made: start, load, quit, a dialogue choice, a weapon picked to move | a paper tap and two plucked notes | 0.6 | 1 | 0.4 | 1 | normal | `ui-confirm.wav` |
| `sfx.ui.denied` | something that cannot be done: a faint option, Esc on a new line, an ability not ready, a slider at its end | a muted double knock | 0.3 | 1 | 0.35 | 1 | normal | `ui-denied.wav` |
| `sfx.ui.open` | a sheet opens: pause, save slots, settings, a question | a sheet laid down | 0.35 | 1 | 0.35 | 1 | normal | `ui-open.wav` |
| `sfx.ui.close` | a sheet closes or goes back; a dialogue closes | a short paper slide | 0.2 | 1 | 0.3 | 1 | normal | `ui-close.wav` |
| `sfx.ui.equip` | a shield equipped; a weapon left in a new slot | a click and a slide | 0.4 | 1 | 0.4 | 1 | normal | `ui-equip.wav` |
| `sfx.ui.upgrade` | a weapon or shield upgraded | two anvil taps and a rising run | 1.1 | 1 | 0.5 | 1 | normal | `ui-upgrade.wav` |
| `sfx.ui.save` | `Saved in slot N` appears | a quill scratching and a soft note | 0.8 | 1 | 0.4 | 1 | normal | `ui-save.wav` |
| `sfx.ui.slot` | the HUD's weapon slot rises (a weapon swap starts) | a tiny click | 0.15 | 1 | 0.25 | 2 | low | `ui-slot.wav` |
| `sfx.ui.lowHealth` | health crosses down to 30 % (once each time) | a heartbeat, lub-dub | 1 | 1 | 0.5 | 1 | high | `ui-lowHealth.wav` |
| `sfx.ui.mapOpen` | the map opens | a sheet of paper unfolded | 0.5 | 1 | 0.4 | 1 | normal | `ui-mapOpen.wav` |
| `sfx.ui.mapClose` | the map closes | a sheet folded | 0.3 | 1 | 0.35 | 1 | normal | `ui-mapClose.wav` |
| `sfx.ui.dialogueOpen` | a dialogue opens (with `voice.spirit.sigh`) | a sheet laid down and a breath of wind | 0.7 | 1 | 0.35 | 1 | normal | `ui-dialogueOpen.wav` |
| `sfx.ui.dialogueNext` | the next line of a dialogue | a soft page | 0.25 | 1 | 0.25 | 1 | low | `ui-dialogueNext.wav` |
| `sfx.ui.runOver` | the death sheet opens; no music after it | a single low note, piano and low strings | 4 | 1 | 0.6 | 1 | never cut | `ui-runOver.wav` |
| `sfx.ui.slider` | the sound-effect volume changes in the settings, played at the new volume | a small tick | 0.12 | 1 | 0.35 | 1 | low | `ui-slider.wav` |

### Ambience — `ambience/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.amb.zone1` | in play in zone 1, looped under the music; ×0.35 paused, on the map or in a dialogue; stops on the title, loading and death (`04-zones/zone-1-suspended-sanctuary/biome.md` §A.5) | the hollow air of an immense cavern breathing slowly, a faint high draught, far stone creaking as it floats, a distant chain | 8 (loop) | 1 | 0.24 | 1 | low | `amb-zone1.wav` |
| `sfx.amb.zone2` *(step 3.12)* | in play in zone 2, as `sfx.amb.zone1` (`04-zones/zone-2-echo-caverns/biome.md` §A.5) | a closed, very low hollow, a stream under the stone, nine drops always at the same place in the loop, each with its echo, a far stone falling into water | 8 (loop) | 1 | 0.26 | 1 | low | `amb-zone2.wav` |
| `sfx.amb.zone3` *(step 3.13)* | in play in zone 3, as `sfx.amb.zone1` (`04-zones/zone-3-sunken-graveyard/biome.md` §A.5) | wind through the stones with a thin whistle, a far iron gate creaking, low whispers, a big bell tolling very far away | 8 (loop) | 1 | 0.26 | 1 | low | `amb-zone3.wav` |
| `sfx.amb.zone4` *(step 3.14)* | in play in zone 4, as `sfx.amb.zone1` (`04-zones/zone-4-rotting-canopy/biome.md` §A.5) | cicadas that swell and fade, low damp air, drops on leaves, a frog twice, a root giving way, and very far a wooden tick every second | 8 (loop) | 1 | 0.26 | 1 | low | `amb-zone4.wav` |
| `sfx.amb.zone5` *(step 3.15)* | in play in zone 5, as `sfx.amb.zone1` (`04-zones/zone-5-dragon-battlements/biome.md` §A.5) | a very low steady breath (the wind is the music's: operator, 2026-10-07), embers crackling far below, the deep fire's low rumble, a banner pulling at its pole; no gusts | 8 (loop) | 1 | 0.16 | 1 | low | `amb-zone5.wav` |

### Zone 1, the Suspended Sanctuary — `zone-1/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.zone1.fall` | Akeris falls into the abyss: leaves the bottom of the room he was in (`hazards.md`) | air rushing up and away into the deep, a low fading rumble | 1.2 | 1 | 0.55 | 1 | high | `zone1-fall.wav` |

### Zone 2, the Echo Caverns — `zone-2/` *(step 3.12)*

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.zone2.drip` | a drop lands on stone or water within 700 su of Akeris, one in two; volume falls with the distance (`biome.md` §A.4) | a high «plink» that rises, with room and echo | 0.9 | 3 | 0.3 | 2 | low | `zone2-drip-1…3.wav` |
| `sfx.zone2.splash` | Akeris falls into black water (`hazards.md`) | the water closing over him and bubbles rising, with echo | 1.4 | 1 | 0.6 | 1 | high | `zone2-splash.wav` |
| `sfx.zone2.stalCrack` | a cracked stalactite starts to crack: the telegraph (`hazards.md`) | dry snaps in the stone and grit trickling down | 0.8 | 2 | 0.5 | 2 | high | `zone2-stalCrack-1…2.wav` |
| `sfx.zone2.stalFall` | the stalactite hits the floor or the water and breaks | a short rush of air, a heavy stone blow and chips, with echo | 1.2 | 2 | 0.65 | 2 | normal | `zone2-stalFall-1…2.wav` |

### Zone 3, the Sunken Graveyard — `zone-3/` *(step 3.13)*

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.zone3.graveGrab` | Akeris falls into an open grave (`hazards.md`) | earth giving way, bony fingers clattering, a low groan and a pull downwards | 1.3 | 1 | 0.65 | 1 | high | `zone3-graveGrab.wav` |
| `sfx.zone3.stoneCrack` | a projectile hits a tombstone and cracks it | a sharp crack, a short stone knock and chips | 0.6 | 2 | 0.55 | 3 | normal | `zone3-stoneCrack-1…2.wav` |
| `sfx.zone3.stoneBreak` | the third hit breaks the tombstone | the crack, the slab falling, rubble and dust | 1.3 | 2 | 0.65 | 2 | normal | `zone3-stoneBreak-1…2.wav` |
| `sfx.zone3.bell` | a chain blade hits the bell of the `belltower` (once every 0.5 s at most) | a big slightly out-of-tune bell, long and dark | 4 | 1 | 0.5 | 1 | low | `zone3-bell.wav` |

### Zone 4, the Rotting Canopy — `zone-4/` *(step 3.14)*

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.zone4.wade` | Akeris steps into a poison pool; a rotten root falls into one (`hazards.md`) | a thick splash and bubbles | 0.9 | 2 | 0.6 | 2 | normal | `zone4-wade-1…2.wav` |
| `sfx.zone4.poison` | each bite of the poison (once a second while poisoned) | a sizzling hiss and a sour falling note a semitone apart | 0.6 | 2 | 0.45 | 2 | high | `zone4-poison-1…2.wav` |
| `sfx.zone4.vineGrab` | Akeris grabs a vine | leaves shaken and the stem tightening | 0.6 | 2 | 0.55 | 2 | normal | `zone4-vineGrab-1…2.wav` |
| `sfx.zone4.rootCreak` | Akeris stands on a rotten root: the telegraph | wood creaking and cracking | 0.9 | 2 | 0.6 | 2 | high | `zone4-rootCreak-1…2.wav` |
| `sfx.zone4.rootSnap` | the rotten root snaps and falls | a dry crack, splinters and the root falling | 1.1 | 2 | 0.7 | 2 | normal | `zone4-rootSnap-1…2.wav` |
| `sfx.zone4.webStick` | Akeris steps into a floor web | threads stretching and sticking | 0.7 | 2 | 0.45 | 2 | normal | `zone4-webStick-1…2.wav` |
| `sfx.zone4.webBurn` | a web or a curtain catches fire | a breath of fire running along it and crackling | 1.4 | 1 | 0.6 | 2 | normal | `zone4-webBurn.wav` |
| `sfx.zone4.torchFall` | a knocked torch hits the floor | the stake knocking twice and the flame flaring | 1 | 2 | 0.6 | 2 | normal | `zone4-torchFall-1…2.wav` |
| `sfx.zone4.torchTake` | Akeris takes a torch in his hand (G) *(2026-10-06)* | the stake pulled from the earth and the flame flaring | 0.6 | 1 | 0.5 | 1 | normal | `zone4-torchTake.wav` |
| `sfx.zone4.torchDrop` | Akeris puts the torch down on the floor (G) *(2026-10-06)* | the stake laid down and the flame bowing | 0.7 | 1 | 0.5 | 1 | normal | `zone4-torchDrop.wav` |

### Zone 5, the Dragon Battlements — `zone-5/` *(step 3.15)*

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.zone5.merlonHit` | a projectile hits a merlon (fire cracks it) | the stone taking the blow and a breath opening | 0.8 | 2 | 0.6 | 3 | normal | `zone5-merlonHit-1…2.wav` |
| `sfx.zone5.merlonBreak` | the third fire hit breaks a merlon | a crack, the blocks falling and dust | 1.5 | 2 | 0.7 | 2 | normal | `zone5-merlonBreak-1…2.wav` |
| `sfx.zone5.bridgeCrack` | the Dragon wakes and the broken bridge cracks (once for both spans) | the stone groaning, cracks running, gravel falling | 1.2 | 1 | 0.7 | 2 | high | `zone5-bridgeCrack.wav` |
| `sfx.zone5.bridgeFall` | the bridge's spans hit the bastion (once) | a huge blow, blocks bouncing, dust | 2.4 | 2 | 0.8 | 2 | high | `zone5-bridgeFall-1…2.wav` |
| `sfx.zone5.fall` | Akeris falls into the chasm through a gap | air rising and going away | 1.3 | 1 | 0.6 | 1 | high | `zone5-fall.wav` |

### Boss rooms — `boss-room/`

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.bossDoor.seal` | Akeris is fully inside a boss room: the doors seal (`boss-room.md`); every zone | iron bars slam, chains run across, the padlock clicks shut | 1.6 | 1 | 0.7 | 1 | never cut | `bossDoor-seal.wav` |
| `sfx.bossDoor.open` | the boss dies: the padlock breaks and the bars rise; every zone | a padlock cracking, bars scraping up, chains falling slack | 1.8 | 1 | 0.65 | 1 | never cut | `bossDoor-open.wav` |

The dummy of the sandbox borrows sounds (its club whooshes as `sfx.hammer.swing`, its stone flies as
`sfx.chain.throw`): it is a test tool, not an enemy. Each enemy's own sounds come with its contract.

### Enemies of zone 1 — `enemies/` *(step 3.10)*

Each enemy's rows come with its contract (`03-characters/enemies/zone-1/<name>/contract.md` §7). Hits
on an enemy use the combat sounds above (`sfx.hit.clang` on a shield or armour); its death uses
`sfx.fx.inkSmoke`.

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.shieldKnight.step` | each foot contact while the shield knight walks (its gait, phase 0 and 0.5) | an iron boot on stone: a thump and a small clink of plate | 0.3 | 3 | 0.3 | 2 | low | `shieldKnight-step-1…3.wav` |
| `sfx.shieldKnight.raise` | its attack starts: the sword rises (the telegraph) | iron scraping upward to a thin ring | 0.75 | 1 | 0.45 | 1 | high | `shieldKnight-raise.wav` |
| `sfx.shieldKnight.swing` | its cut, 0.03 s before the raise ends | a heavy, low cut of air | 0.5 | 2 | 0.55 | 1 | normal | `shieldKnight-swing-1…2.wav` |
| `sfx.shieldKnight.snatch` | the chain tears its shield away | straps tearing, the chain running, a struck plate | 1.0 | 1 | 0.6 | 1 | high | `shieldKnight-snatch.wav` |
| `sfx.shieldKnight.shieldDrop` | the torn shield hits the floor | an iron slab on stone, bouncing and settling, with room | 1.2 | 1 | 0.55 | 1 | normal | `shieldKnight-shieldDrop.wav` |
| `sfx.shieldKnight.stun` | the fast descent stuns it | its helm rings like a bell | 1.2 | 1 | 0.5 | 1 | normal | `shieldKnight-stun.wav` |
| `sfx.runeSentinel.wake` | the rune sentinel wakes | stone grinding and a low hum rising | 0.9 | 1 | 0.45 | 1 | normal | `runeSentinel-wake.wav` |
| `sfx.runeSentinel.windup` | it rocks back before charging: the telegraph | stone scraping downward, a few pebbles | 0.75 | 1 | 0.5 | 1 | high | `runeSentinel-windup.wav` |
| `sfx.runeSentinel.roll` | loops while it charges; stops with the charge | a rumble with gravel, six knocks a second | 1.0 (loop) | 1 | 0.5 | 1 | normal | `runeSentinel-roll.wav` |
| `sfx.runeSentinel.crash` | its charge stops on a wall or edge; ×0.6 when the fast descent stuns it | stone on stone, with grit and room | 1.0 | 1 | 0.6 | 1 | normal | `runeSentinel-crash.wav` |
| `sfx.wanderingEye.aim` | the wandering eye opens and aims: the telegraph | stone lids grinding and a whistle rising | 0.85 | 1 | 0.45 | 1 | high | `wanderingEye-aim.wav` |
| `sfx.wanderingEye.fire` | the ink stone leaves the eye | a puff of air and ink, a short whistle | 0.6 | 2 | 0.5 | 2 | normal | `wanderingEye-fire-1…2.wav` |
| `sfx.wanderingEye.splash` | the ink stone bursts on stone | a thick splash | 0.7 | 2 | 0.5 | 2 | normal | `wanderingEye-splash-1…2.wav` |
| `sfx.wanderingEye.fall` | it lands at knee height after a fall; ×0.7 when stunned | stone lids clacking and a dull thud | 0.8 | 1 | 0.5 | 1 | normal | `wanderingEye-fall.wav` |
| `sfx.maceBrute.step` | each step of the mace brute | a heavy leather step, the mace swaying | 0.35 | 3 | 0.35 | 2 | low | `maceBrute-step-1…3.wav` |
| `sfx.maceBrute.sweepWind` | the mace goes back and low: the sweep's telegraph | leather creaking, iron scraping | 0.55 | 1 | 0.45 | 1 | high | `maceBrute-sweepWind.wav` |
| `sfx.maceBrute.smashWind` | the mace goes up over the hood: the smash's telegraph | a low growl rising, iron ringing at the top | 0.9 | 1 | 0.5 | 1 | high | `maceBrute-smashWind.wav` |
| `sfx.maceBrute.swing` | the mace starts moving (the smash at rate 0.8) | a low gust of air | 0.55 | 2 | 0.6 | 1 | normal | `maceBrute-swing-1…2.wav` |
| `sfx.maceBrute.slam` | the smash hits the floor; ×0.5 when the fast descent stuns it | the deepest blow of the zone, chips and rumble, with room | 1.4 | 2 | 0.7 | 1 | high | `maceBrute-slam-1…2.wav` |
| `sfx.maceBrute.pull` | it pulls the mace out of the floor | gravel and the iron coming loose | 0.5 | 1 | 0.45 | 1 | normal | `maceBrute-pull.wav` |

### Enemies of zone 2 — `enemies/` *(step 3.12)*

Each enemy's rows come with its contract (`03-characters/enemies/zone-2/<name>/contract.md` §7). In zone 2 they
all go through the zone's echo (§3).

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.smallBats.wake` | the small bats' swarm wakes | a burst of high shrieks and wings opening | 1.2 | 1 | 0.5 | 1 | high | `smallBats-wake.wav` |
| `sfx.smallBats.flutter` | loops while any of the swarm is awake; stops with the last | many small wings beating | 1.0 (loop) | 1 | 0.18 | 1 | low | `smallBats-flutter.wav` |
| `sfx.smallBats.screech` | one starts its telegraph (folds its wings) | one rising shriek | 0.45 | 3 | 0.45 | 2 | high | `smallBats-screech-1…3.wav` |
| `sfx.smallBats.dive` | it dives | a short high whistle of air | 0.4 | 2 | 0.4 | 2 | normal | `smallBats-dive-1…2.wav` |
| `sfx.smallBats.die` | one dies | a falling shriek and a puff of ink | 0.7 | 3 | 0.45 | 3 | normal | `smallBats-die-1…3.wav` |
| `sfx.blindGhoul.click` | the blind ghoul clicks (its ring opens) | an irregular burst of five to seven wet, broken tongue clicks and a rattling throat, with echo | 1.1 | 3 | 0.6 | 2 | high | `blindGhoul-click-1…3.wav` |
| `sfx.blindGhoul.moan` | after a click while wandering, one time in three | a hollow moan that rises and breaks | 1.8 | 2 | 0.4 | 1 | normal | `blindGhoul-moan-1…2.wav` |
| `sfx.blindGhoul.shriek` | it detects Akeris | a shriek of three dissonant voices (a tritone) that tears and falls, ending in a rattle | 1.5 | 1 | 0.8 | 1 | high | `blindGhoul-shriek.wav` |
| `sfx.blindGhoul.step` | each step; ×0.55 walking | a bare foot on rock and nails scraping | 0.4 | 3 | 0.32 | 2 | low | `blindGhoul-step-1…3.wav` |
| `sfx.blindGhoul.claw` | each swipe of its claw | air and nails | 0.45 | 2 | 0.5 | 2 | normal | `blindGhoul-claw-1…2.wav` |
| `sfx.blindGhoul.grabWind` | the grab's telegraph starts (0.5 s) | a hoarse breath rising and cut, clicks speeding up | 0.62 | 1 | 0.7 | 1 | never cut | `blindGhoul-grabWind.wav` |
| `sfx.blindGhoul.jawOpen` | it opens its mouth: the jaw starts to unhinge (0.25 s into the bite, 0.4 s before it) | something breaking (the jaw unhinging, in dry cracks louder each time; operator, 2026-10-01) and a guttural roar that grows to the bite | 0.8 | 1 | 0.75 | 1 | never cut | `blindGhoul-jawOpen.wav` |
| `sfx.blindGhoul.bite` | the bite: the snap into the neck and the two slow thrashes | a dry snap of teeth, then a rough tearing (cloth and leather) on each thrash, and a low growl that lingers (no blood, no bone) | 1.1 | 1 | 0.85 | 1 | never cut | `blindGhoul-bite.wav` |
| `sfx.ceilingCrawler.skitter` | every 0.7 s while the ceiling crawler follows Akeris along the roof | many legs running on rock, and grit | 0.7 | 3 | 0.35 | 2 | low | `ceilingCrawler-skitter-1…3.wav` |
| `sfx.ceilingCrawler.hiss` | it lets itself down: the telegraph (0.35 s) | a hiss rising and the pincers clicking | 0.6 | 1 | 0.55 | 1 | high | `ceilingCrawler-hiss.wav` |
| `sfx.ceilingCrawler.drop` | it falls | a rush of air | 0.4 | 1 | 0.45 | 1 | normal | `ceilingCrawler-drop.wav` |
| `sfx.ceilingCrawler.land` | it hits the floor or a shield | a dull blow and legs flailing | 0.7 | 2 | 0.55 | 2 | normal | `ceilingCrawler-land-1…2.wav` |
| `sfx.manyArmed.step` | each step of the many-armed | a heavy bare foot and the blades knocking together | 0.4 | 3 | 0.35 | 2 | low | `manyArmed-step-1…3.wav` |
| `sfx.manyArmed.wind` | the burst's telegraph (0.6 s): the arms go back one by one; with 2–3 arms, the scissor cut's telegraph | six blades scraping out one after another, rising | 0.8 | 1 | 0.6 | 1 | high | `manyArmed-wind.wav` |
| `sfx.manyArmed.thrust` | each thrust of the burst (one per arm, 0.08 s apart; in pairs with 4–5 arms); each cut of the scissor and the double slash | a short sharp swish and a low push of air | 0.45 | 3 | 0.5 | 4 | normal | `manyArmed-thrust-1…3.wav` |
| `sfx.manyArmed.tangle` | it tangles after the burst (the opening); with 0–1 arms, the double slash's telegraph | the swords clashing, tangled | 0.6 | 1 | 0.45 | 1 | normal | `manyArmed-tangle.wav` |
| `sfx.manyArmed.windmill` | the mill turns | six blades whirling past in a row | 0.7 | 1 | 0.6 | 1 | high | `manyArmed-windmill.wav` |
| `sfx.manyArmed.grabWind` | the grab's telegraph: every arm opens wide | joints creaking and a hoarse breath | 0.6 | 1 | 0.65 | 1 | high | `manyArmed-grabWind.wav` |
| `sfx.manyArmed.crush` | the crush: it squeezes Akeris to death | a low creak of pressure rising in jerks, **bones giving way one after another**, then **one big dry snap** as Akeris dies (at 1.0 s) and silence — the operator's decision (2026-10-01), the one exception to §4's "no bone crunch"; still no squelch, no blood | 1.7 | 1 | 0.9 | 1 | never cut | `manyArmed-crush.wav` |
| `sfx.manyArmed.snatch` | the chain tears an arm off | the chain's rattle, a tearing, a blade falling to the floor | 0.7 | 1 | 0.6 | 1 | normal | `manyArmed-snatch.wav` |
| `sfx.blindGhoul.sniff` | it sniffs, having found nothing | four short sniffs | 0.9 | 1 | 0.4 | 1 | normal | `blindGhoul-sniff.wav` |

### Enemies of zone 3 — `enemies/` *(step 3.13)*

Each enemy's rows come with its contract (`03-characters/enemies/zone-3/<name>/contract.md` §7). In the catacombs
they go through the stone's short reverb (§3). An arrow or the gravedigger's earth on a tombstone also plays `sfx.zone3.stoneCrack` / `.stoneBreak`; falling into the gravedigger's grave plays `sfx.zone3.graveGrab`.

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.skeletonArcher.step` | each step of the skeleton archer | bones rattling, a little earth | 0.3 | 3 | 0.32 | 2 | low | `skeletonArcher-step-1…3.wav` |
| `sfx.skeletonArcher.draw` | the shot (0.7 s) and the volley (0.8 s): it draws the bow — the telegraph | the bone bow creaking in jerks and the string tightening, rising | 0.8 | 2 | 0.55 | 2 | high | `skeletonArcher-draw-1…2.wav` |
| `sfx.skeletonArcher.release` | it lets go | the string snapping and the bow humming | 0.45 | 2 | 0.6 | 3 | normal | `skeletonArcher-release-1…2.wav` |
| `sfx.skeletonArcher.arrow` | the shot flies | a thin whistle passing | 0.5 | 2 | 0.38 | 3 | normal | `skeletonArcher-arrow-1…2.wav` |
| `sfx.skeletonArcher.arrowHit` | an arrow sticks in the ground or a wall, hits a tombstone or its thrower | a dry thunk and the shaft quivering | 0.4 | 3 | 0.5 | 4 | normal | `skeletonArcher-arrowHit-1…3.wav` |
| `sfx.skeletonArcher.volley` | the volley: three arrows to the sky | three strings in a row and three whistles rising | 1.0 | 1 | 0.6 | 1 | high | `skeletonArcher-volley.wav` |
| `sfx.skeletonArcher.rain` | each volley arrow starts to fall on its mark | a whistle falling | 0.7 | 2 | 0.5 | 3 | high | `skeletonArcher-rain-1…2.wav` |
| `sfx.skeletonArcher.bash` | the bash with the bow | a swish and a knock of bone | 0.5 | 2 | 0.55 | 2 | normal | `skeletonArcher-bash-1…2.wav` |
| `sfx.skeletonArcher.hop` | it hops (back, up, over a grave); the chain pulls it | bones clacking at take-off and landing | 0.5 | 2 | 0.45 | 2 | normal | `skeletonArcher-hop-1…2.wav` |
| `sfx.skeletonArcher.collapse` | its last health: it falls apart | bones falling in a cascade, two dull knocks, the skull rolling to a stop | 1.5 | 1 | 0.7 | 1 | never cut | `skeletonArcher-collapse.wav` |
| `sfx.gravedigger.step` | each step of the gravedigger | a heavy boot in the earth and the coat brushing | 0.3 | 3 | 0.34 | 2 | low | `gravedigger-step-1…3.wav` |
| `sfx.gravedigger.measure` | the first time he sees Akeris: he measures him | the spade raised, one hollow iron note, a low grunt | 1.0 | 1 | 0.4 | 1 | normal | `gravedigger-measure.wav` |
| `sfx.gravedigger.dig` | each spadeful (two in the 1 s dig) | the blade biting the earth and the earth thrown | 0.35 | 3 | 0.5 | 3 | normal | `gravedigger-dig-1…3.wav` |
| `sfx.gravedigger.burrow` | he goes into a grave; the chain pulls him out | the earth closing over him, a dull knock | 0.7 | 1 | 0.55 | 1 | normal | `gravedigger-burrow.wav` |
| `sfx.gravedigger.rumble` | under the ground, and again at the 0.6 s warning — the telegraph | a low rumble moving, small knocks | 1.2 | 1 | 0.5 | 1 | high | `gravedigger-rumble.wav` |
| `sfx.gravedigger.rise` | he bursts out with the blow from below | a deep knock, earth bursting, a swing upward, clods falling back | 0.8 | 2 | 0.65 | 2 | high | `gravedigger-rise-1…2.wav` |
| `sfx.gravedigger.swing` | the swing of the spade | a broad swish with a faint iron ring | 0.45 | 2 | 0.55 | 2 | normal | `gravedigger-swing-1…2.wav` |
| `sfx.gravedigger.shove` | the shove with the flat of the spade | a short swish and a dull iron knock | 0.45 | 2 | 0.55 | 2 | normal | `gravedigger-shove-1…2.wav` |
| `sfx.gravedigger.throw` | the toss | the spade sweeping and earth scattering | 0.7 | 2 | 0.5 | 2 | normal | `gravedigger-throw-1…2.wav` |
| `sfx.gravedigger.dirtHit` | the earth hits Akeris, a shield, a tombstone or the floor; the snatched spade lands | a soft knock spreading into crumbs | 0.4 | 3 | 0.45 | 4 | normal | `gravedigger-dirtHit-1…3.wav` |
| `sfx.gravedigger.snatch` | the chain snatches the spade | iron ringing as it is torn away, then landing in the earth | 0.8 | 1 | 0.6 | 1 | high | `gravedigger-snatch.wav` |
| `sfx.gravedigger.collapse` | his last health: he falls on his back | a last grunt, the body on the earth, the spade driven in and ringing | 1.5 | 1 | 0.65 | 1 | never cut | `gravedigger-collapse.wav` |
| `sfx.wraith.whisper` | the wraith veiled, within 900 su, every 2.6 s | breathy whispers in a stone-like reverb over a low hiss | 1.6 | 2 | 0.32 | 1 | low | `wraith-whisper-1…2.wav` |
| `sfx.wraith.breath` | it is about to turn solid (claw, arms from hiding) — the telegraph | a cold rushing breath with a high hiss and a sinking tone | 0.6 | 2 | 0.55 | 2 | high | `wraith-breath-1…2.wav` |
| `sfx.wraith.solid` | it turns solid | a dry crackle, like ice tightening | 0.45 | 2 | 0.5 | 2 | normal | `wraith-solid-1…2.wav` |
| `sfx.wraith.whiff` | a weapon goes through it while veiled | a tearing of air that closes again | 0.5 | 3 | 0.42 | 3 | normal | `wraith-whiff-1…3.wav` |
| `sfx.wraith.scream` | the charge's telegraph | the mask screams: a rising, wavering wail | 0.9 | 2 | 0.6 | 1 | high | `wraith-scream-1…2.wav` |
| `sfx.wraith.claw` | the claw; the arms from hiding | long fingers raking the air | 0.45 | 2 | 0.55 | 2 | normal | `wraith-claw-1…2.wav` |
| `sfx.wraith.dash` | the charge runs and stops in front | a roar of cloth that stops dead | 0.5 | 2 | 0.5 | 2 | normal | `wraith-dash-1…2.wav` |
| `sfx.wraith.stun` | stunned (just block, chain, fast descent) | the cloth humming, the mask buzzing | 0.8 | 1 | 0.45 | 1 | normal | `wraith-stun.wav` |
| `sfx.wraith.shatter` | its last health | the shroud falling, the mask cracking in three, crumbs | 1.4 | 1 | 0.65 | 1 | never cut | `wraith-shatter.wav` |
| `sfx.ossuaryManyArmed.step` | each heavy step of the ossuary's Many-Armed | a heavy foot and the small bones on its shroud tinkling | 0.32 | 3 | 0.36 | 2 | low | `ossuaryManyArmed-step-1…3.wav` |
| `sfx.ossuaryManyArmed.rattle` | the throw's telegraph (0.5 s) and the smash's | every bone rattling over a low groan | 0.6 | 2 | 0.55 | 2 | high | `ossuaryManyArmed-rattle-1…2.wav` |
| `sfx.ossuaryManyArmed.spin` | the thrown arm spinning out and back | a whirring band of air and bones clicking as it turns | 1.3 | 1 | 0.5 | 2 | high | `ossuaryManyArmed-spin.wav` |
| `sfx.ossuaryManyArmed.catch` | the arm back in place | two dry knocks of bone | 0.35 | 2 | 0.45 | 2 | normal | `ossuaryManyArmed-catch-1…2.wav` |
| `sfx.ossuaryManyArmed.cageOpen` | the cage's telegraph (0.6 s): every arm opening | six bones clacking in turn with small swishes | 0.7 | 1 | 0.55 | 1 | high | `ossuaryManyArmed-cageOpen.wav` |
| `sfx.ossuaryManyArmed.cageShut` | the cage slamming shut | a swish and a burst of bones closing, a dull knock | 0.6 | 2 | 0.65 | 1 | high | `ossuaryManyArmed-cageShut-1…2.wav` |
| `sfx.ossuaryManyArmed.crack` | a hit on the cage; an arm torn off or caught; its arm hitting Akeris | a bone cracking | 0.4 | 3 | 0.55 | 3 | normal | `ossuaryManyArmed-crack-1…3.wav` |
| `sfx.ossuaryManyArmed.rebuild` | it rebuilds an arm at a heap of skulls (1.2 s) | bones gathering, rising in pitch, and a final knock | 1.3 | 1 | 0.55 | 1 | normal | `ossuaryManyArmed-rebuild.wav` |
| `sfx.ossuaryManyArmed.smash` | the bone smash | a broad swish and a bone knock on the floor | 0.5 | 2 | 0.6 | 2 | normal | `ossuaryManyArmed-smash-1…2.wav` |
| `sfx.ossuaryManyArmed.collapse` | its last health: it falls apart | bones cascading, a dull knock, the hood sliding down | 1.6 | 1 | 0.7 | 1 | never cut | `ossuaryManyArmed-collapse.wav` |

### Enemies of zone 4 — `enemies/` *(step 3.14)*

Each enemy's rows come with its contract (`03-characters/enemies/zone-4/<name>/contract.md` §7). No echo or reverb: the jungle
muffles (§3). A spiderling burnt by a burning web plays its own `burn` over `sfx.zone4.webBurn`.

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.spiderlings.hatch` | the egg sacs tear (Akeris under them or on the web) | wet cloth tearing three times, then many small legs | 1.3 | 1 | 0.55 | 1 | high | `spiderlings-hatch.wav` |
| `sfx.spiderlings.skitter` | loops while any spiderling is out in Akeris's room; stops with the last there or when he leaves; silent in the pause, the map and a dialogue | many thin legs ticking on wood (whole cycles in 1 s) | 1 (loop) | 1 | 0.2 | 1 | low | `spiderlings-skitter.wav` |
| `sfx.spiderlings.hiss` | one starts its telegraph (0.4 s) | a short high hiss and two fang clicks | 0.5 | 3 | 0.5 | 2 | high | `spiderlings-hiss-1…3.wav` |
| `sfx.spiderlings.leap` | it leaps | legs pushing off and a short whistle of air | 0.35 | 2 | 0.4 | 2 | normal | `spiderlings-leap-1…2.wav` |
| `sfx.spiderlings.die` | one dies (a hit, the chain, a just block, a dive) | a dry shell crack and a puff of ink | 0.5 | 3 | 0.45 | 3 | normal | `spiderlings-die-1…3.wav` |
| `sfx.spiderlings.burn` | one dies by fire | a crackle, a shrinking hiss and a small pop | 0.8 | 2 | 0.5 | 3 | normal | `spiderlings-burn-1…2.wav` |
| `sfx.sporePod.swell` | the spore pod starts to swell (the telegraph, 1.2 s) | a skin stretching, creaking, under a rising hiss | 1.25 | 1 | 0.45 | 2 | high | `sporePod-swell.wav` |
| `sfx.sporePod.burst` | it bursts into its cloud | a wet plop and the cloud blowing out, spores crackling | 1.1 | 2 | 0.6 | 2 | high | `sporePod-burst-1…2.wav` |
| `sfx.sporePod.spit` | it spits a spore | a short pfff | 0.45 | 2 | 0.45 | 2 | normal | `sporePod-spit-1…2.wav` |
| `sfx.sporePod.pop` | a spore bursts into a small cloud | a soft pop and a small puff | 0.55 | 3 | 0.4 | 3 | normal | `sporePod-pop-1…3.wav` |
| `sfx.sporePod.hurt` | it is hit | a soft squelch | 0.3 | 2 | 0.45 | 2 | normal | `sporePod-hurt-1…2.wav` |
| `sfx.sporePod.die` | its last health (not by fire; a burnt pod plays `sfx.spiderlings.burn`) | a long falling whistle as it deflates, a soft thud | 1.2 | 1 | 0.5 | 1 | normal | `sporePod-die.wav` |
| `sfx.sporePod.flash` | fire clears a cloud | a dry flash of air and sparks | 0.7 | 1 | 0.5 | 2 | normal | `sporePod-flash.wav` |
| `sfx.stranglerVine.rise` | the strangler vine uncoils (the telegraph, 0.8 s) | live wood creaking and a hiss of leaves | 0.85 | 1 | 0.45 | 2 | high | `stranglerVine-rise.wav` |
| `sfx.stranglerVine.lash` | the lash | a whistle and a dry crack | 0.45 | 2 | 0.55 | 2 | high | `stranglerVine-lash-1…2.wav` |
| `sfx.stranglerVine.grab` | it catches Akeris | a long creak as the stem coils, a soft thud | 0.6 | 1 | 0.55 | 1 | high | `stranglerVine-grab.wav` |
| `sfx.stranglerVine.squeeze` | each squeeze while he is caught (1 a second) | a tight creak | 0.4 | 2 | 0.45 | 1 | normal | `stranglerVine-squeeze-1…2.wav` |
| `sfx.stranglerVine.cut` | the chain cuts it and frees him | wood snapping | 0.45 | 2 | 0.55 | 2 | high | `stranglerVine-cut-1…2.wav` |
| `sfx.stranglerVine.hurt` | it is hit | green wood knocked | 0.3 | 2 | 0.45 | 2 | normal | `stranglerVine-hurt-1…2.wav` |
| `sfx.stranglerVine.die` | its last health (not by fire; burnt it plays `sfx.spiderlings.burn`) | dry crackling as it shrinks | 1.1 | 1 | 0.5 | 1 | normal | `stranglerVine-die.wav` |
| `sfx.mantis.rustle` | the mantis wakes (Akeris within 300 su, or a hit) | dry leaves unfolding | 0.6 | 2 | 0.4 | 1 | normal | `mantis-rustle-1…2.wav` |
| `sfx.mantis.display` | the telegraph (0.5 s): its wings snap open | a snap of wings and a dry hiss | 0.6 | 1 | 0.55 | 1 | high | `mantis-display.wav` |
| `sfx.mantis.dash` | it lunges | a quick rub of air and legs pushing off | 0.3 | 2 | 0.45 | 2 | high | `mantis-dash-1…2.wav` |
| `sfx.mantis.slash` | each of the four slashes of the burst (every 0.16 s) | a short whistle and a click of chitin | 0.22 | 3 | 0.5 | 4 | high | `mantis-slash-1…3.wav` |
| `sfx.mantis.hop` | it hops back | a short beat of wings | 0.4 | 2 | 0.4 | 2 | normal | `mantis-hop-1…2.wav` |
| `sfx.mantis.tired` | the whole burst blocked: it is left open | two short breaths | 0.7 | 1 | 0.35 | 1 | normal | `mantis-tired.wav` |
| `sfx.mantis.hurt` | it is hit | chitin cracking | 0.3 | 3 | 0.45 | 2 | normal | `mantis-hurt-1…3.wav` |
| `sfx.mantis.die` | its last health (not by fire; burnt it plays `sfx.spiderlings.burn`) | it falls, its legs fold, it crumbles like a dry leaf | 1.2 | 1 | 0.5 | 1 | normal | `mantis-die.wav` |

### Enemies of zone 5 — `enemies/` *(step 3.15)*

Each enemy's rows come with its contract (`03-characters/enemies/zone-5/<name>/contract.md` §7).

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.drakeling.wake` | a drakeling wakes; softer, on the bite's warning | a hoarse screech rising, a young's | 0.7 | 2 | 0.55 | 2 | high | `drakeling-wake-1…2.wav` |
| `sfx.drakeling.flap` | it takes off | leather tightening and air | 0.4 | 2 | 0.35 | 2 | normal | `drakeling-flap-1…2.wav` |
| `sfx.drakeling.inhale` | the spit's warning (0.6 s), the flame breath's (0.5 s) | it breathes in; the throat crackles | 0.7 | 1 | 0.55 | 2 | high | `drakeling-inhale.wav` |
| `sfx.drakeling.spit` | the fireball leaves | a blow of fire that whistles away | 0.7 | 2 | 0.6 | 3 | high | `drakeling-spit-1…2.wav` |
| `sfx.drakeling.dive` | the dive leaves (after its 0.5 s warning) | a screech falling and the air torn | 0.8 | 2 | 0.6 | 2 | high | `drakeling-dive-1…2.wav` |
| `sfx.drakeling.breath` | the flame breath (0.8 s) | a short roar of fire, going out | 1.0 | 1 | 0.6 | 2 | high | `drakeling-breath.wav` |
| `sfx.drakeling.bite` | the bite | the teeth snapping | 0.35 | 2 | 0.55 | 2 | normal | `drakeling-bite-1…2.wav` |
| `sfx.drakeling.hurt` | it is hit | a short croak | 0.45 | 2 | 0.5 | 2 | normal | `drakeling-hurt-1…2.wav` |
| `sfx.drakeling.land` | it perches, or falls to the floor | talons on stone and a light thud | 0.4 | 2 | 0.45 | 2 | low | `drakeling-land-1…2.wav` |
| `sfx.drakeling.die` | it is defeated | a screech fading and the body on the stone | 1.1 | 1 | 0.6 | 2 | normal | `drakeling-die.wav` |
| `sfx.drakeling.embers` | it hits the floor defeated | the fire inside escaping in crackling embers | 0.9 | 1 | 0.5 | 2 | low | `drakeling-embers.wav` |
| `sfx.gargoyle.wake` | a gargoyle wakes; softer before a close attack and after it petrifies | stone cracking and a hoarse screech | 1.0 | 2 | 0.6 | 2 | high | `gargoyle-wake-1…2.wav` |
| `sfx.gargoyle.flap` | it takes off; the buffet | a heavy wingbeat: stone grazing and air pushed | 0.5 | 2 | 0.5 | 2 | normal | `gargoyle-flap-1…2.wav` |
| `sfx.gargoyle.dive` | the dive (after its 0.6 s warning) | air whistling down | 0.55 | 2 | 0.6 | 2 | high | `gargoyle-dive-1…2.wav` |
| `sfx.gargoyle.slam` | it crashes into the floor | a huge blow of stone on stone | 1.2 | 2 | 0.8 | 2 | high | `gargoyle-slam-1…2.wav` |
| `sfx.gargoyle.quake` | the earthquake of spikes | a low rumble and the spikes bursting in a row | 1.4 | 1 | 0.7 | 2 | high | `gargoyle-quake.wav` |
| `sfx.gargoyle.claw` | the claw | bone claws tearing the air | 0.4 | 2 | 0.55 | 2 | normal | `gargoyle-claw-1…2.wav` |
| `sfx.gargoyle.gale` | the cutting wings | a wingbeat and the air leaving in an X, whistling | 0.8 | 2 | 0.6 | 2 | high | `gargoyle-gale-1…2.wav` |
| `sfx.gargoyle.land` | it perches | a dull blow of stone | 0.45 | 2 | 0.5 | 2 | low | `gargoyle-land-1…2.wav` |
| `sfx.gargoyle.stone` | a blow on stone (asleep, petrified, decorative) | a dry ringing knock | 0.35 | 2 | 0.5 | 3 | normal | `gargoyle-stone-1…2.wav` |
| `sfx.gargoyle.hurt` | it is hit | stone chipping and a grunt | 0.45 | 2 | 0.5 | 2 | normal | `gargoyle-hurt-1…2.wav` |
| `sfx.gargoyle.die` | it is defeated | it breaks apart; the pieces bounce and roll | 1.6 | 1 | 0.75 | 2 | normal | `gargoyle-die.wav` |
| `sfx.gargoyle.pounce` | the pounce's warning (0.5 s; step 3.17, HB2, *approved* 2026-10-13) | stone cracking as it crouches and a hoarse stone screech | 0.8 | 2 | 0.55 | 1 | high | `gargoyle-pounce-1…2.wav` |
| `sfx.fireBrute.step` | the fire mace brute's heavy step | leather, the cage swinging, a few ember crackles | 0.4 | 3 | 0.4 | 2 | low | `fireBrute-step-1…3.wav` |
| `sfx.fireBrute.sweepWind` | the sweep's warning (0.5 s) | leather creaking, iron grazing, the embers flaring | 0.6 | 1 | 0.45 | 1 | high | `fireBrute-sweepWind.wav` |
| `sfx.fireBrute.smashWind` | the smash's warning (0.85 s) | a low growl rising and the fire roaring up | 0.95 | 1 | 0.5 | 1 | high | `fireBrute-smashWind.wav` |
| `sfx.fireBrute.swing` | the mace starts moving (the smash at rate 0.8) | a low whoosh with fire in it | 0.6 | 2 | 0.6 | 1 | normal | `fireBrute-swing-1…2.wav` |
| `sfx.fireBrute.slam` | the smash lands; ×0.5 when the fast descent stuns it | the deepest blow, chips of stone and a puff of embers | 1.4 | 2 | 0.75 | 1 | high | `fireBrute-slam-1…2.wav` |
| `sfx.fireBrute.fireWave` | the fire wave runs along the floor | fire rushing both ways and dying out, crackling | 1.1 | 2 | 0.65 | 2 | high | `fireBrute-fireWave-1…2.wav` |
| `sfx.fireBrute.whirl` | the coals' warning (0.6 s); softer when it becomes enraged | three turns of fire over its head, flaring | 0.75 | 1 | 0.5 | 1 | high | `fireBrute-whirl.wav` |
| `sfx.fireBrute.throw` | the coals leave | a whoosh and a burst of crackles | 0.6 | 2 | 0.55 | 2 | normal | `fireBrute-throw-1…2.wav` |
| `sfx.fireBrute.coalHiss` | a coal goes out on the floor | a short hiss and sparks | 0.6 | 3 | 0.4 | 4 | low | `fireBrute-coalHiss-1…3.wav` |
| `sfx.fireBrute.pull` | it pulls the mace free | gravel, iron coming loose, embers falling | 0.55 | 1 | 0.45 | 1 | normal | `fireBrute-pull.wav` |
| `sfx.fireBrute.douse` | the ice just block douses the cage | a long hiss of steam; the embers crackle and fall silent | 1.2 | 1 | 0.55 | 1 | high | `fireBrute-douse.wav` |
| `sfx.fireBrute.die` | it is defeated (then `sfx.fx.inkSmoke`) | a growl fading, the body and the mace on the stone, embers spilling and hissing out | 2.0 | 1 | 0.7 | 1 | normal | `fireBrute-die.wav` |
| `sfx.fireBrute.charge` | the charge's warning (0.6 s; step 3.17, HB2, *approved* 2026-10-13) | a low bellow under the hood, the cage flaring, two pawing stamps | 1.1 | 2 | 0.6 | 1 | high | `fireBrute-charge-1…2.wav` |
| `sfx.eliteKnight.step` | each foot contact of the elite knight while it walks | a heavier iron step | 0.35 | 3 | 0.34 | 2 | low | `eliteKnight-step-1…3.wav` |
| `sfx.eliteKnight.raise` | every attack starts: the warning (combo, thrust, bash, spin) | iron grazing and rising, lower than the zone 1 knight's | 0.8 | 2 | 0.48 | 2 | high | `eliteKnight-raise-1…2.wav` |
| `sfx.eliteKnight.swing` | each cut of the combo, 0.03 s before it lands | a heavy blade through the air | 0.5 | 2 | 0.6 | 2 | high | `eliteKnight-swing-1…2.wav` |
| `sfx.eliteKnight.rise` | the combo's second warning: the blade turns, a step | a short iron scrape and a clink | 0.45 | 2 | 0.48 | 2 | high | `eliteKnight-rise-1…2.wav` |
| `sfx.eliteKnight.thrust` | the thrust leaves | a stamp and the air torn straight | 0.5 | 2 | 0.6 | 2 | high | `eliteKnight-thrust-1…2.wav` |
| `sfx.eliteKnight.bash` | the shield bash leaves | the slab of the shield against a body, ringing low | 0.7 | 2 | 0.7 | 2 | high | `eliteKnight-bash-1…2.wav` |
| `sfx.eliteKnight.guardUp` | the high guard rises | a quick iron scrape and a clink | 0.35 | 2 | 0.4 | 2 | normal | `eliteKnight-guardUp-1…2.wav` |
| `sfx.eliteKnight.yank` | the chain pulls the shield aside (also the hammer, softer) | the chain, the straps creaking, iron pulled | 0.7 | 1 | 0.55 | 2 | high | `eliteKnight-yank.wav` |
| `sfx.eliteKnight.snatch` | the chain tears the shield away | straps bursting, the chain and the iron | 1.1 | 1 | 0.62 | 1 | high | `eliteKnight-snatch.wav` |
| `sfx.eliteKnight.shieldDrop` | the loose shield hits the floor (snatched, or at death) | a tower shield of iron and stone on stone, bouncing | 1.4 | 1 | 0.6 | 1 | normal | `eliteKnight-shieldDrop.wav` |
| `sfx.eliteKnight.spin` | the spinning cut leaves | the air, twice around | 0.7 | 2 | 0.6 | 2 | high | `eliteKnight-spin-1…2.wav` |
| `sfx.eliteKnight.stun` | the fast descent stuns it | the helm ringing like a low bell | 1.3 | 1 | 0.52 | 1 | normal | `eliteKnight-stun.wav` |
| `sfx.eliteKnight.charge` | the long bash's (or running thrust's) warning (0.55 s; step 3.17, HB2, *approved* 2026-10-13) | two iron stamps quickening, iron grazing as the shoulder drops, rattling plates | 0.9 | 2 | 0.55 | 1 | high | `eliteKnight-charge-1…2.wav` |

### Bosses — `bosses/` *(steps 3.11–3.15; the Giant Spider 2026-10-06; the Dragon approved 2026-10-13, its sounds redone 2026-10-12)*

Each boss's rows come with its contract (`03-characters/bosses/<name>/contract.md` §7). Hits on a boss use
the combat sounds above (the Dragon has its own: `sfx.dragon.hit*`); while it cannot be hurt, `sfx.hit.clang`.

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.golem.wake` | it wakes when the doors seal | stone grinding, the lids opening and a low hum rising | 2.2 | 1 | 0.6 | 1 | high | `golem-wake.wav` |
| `sfx.golem.tear` | its tear starts: the floor cracks (the telegraph) and the rocks break out | cracking that rises and a stone torn loose | 1.0 | 1 | 0.55 | 1 | high | `golem-tear.wav` |
| `sfx.golem.throw` | each rock it throws | a heavy gust | 0.5 | 2 | 0.55 | 2 | normal | `golem-throw-1…2.wav` |
| `sfx.golem.rockBreak` | a rock meets stone, a shield or Akeris | stone on stone and chips | 0.6 | 3 | 0.5 | 3 | normal | `golem-rockBreak-1…3.wav` |
| `sfx.golem.fieldTel` | the levitation ring is drawn: the telegraph | air turning and rising | 1.0 | 1 | 0.45 | 1 | high | `golem-fieldTel.wav` |
| `sfx.golem.field` | the ring acts | a hollow floating hum | 2.6 | 1 | 0.5 | 1 | normal | `golem-field.wav` |
| `sfx.golem.crack` | a chain strike or a rock sent back cracks it | a dry snap and splitting stone | 0.7 | 3 | 0.55 | 2 | high | `golem-crack-1…3.wav` |
| `sfx.golem.roar` | the rage starts, and each rock rain | a long, deep roar of stone that rumbles | 2.0 | 1 | 0.7 | 1 | high | `golem-roar.wav` |
| `sfx.golem.slabFall` | a slab's chains snap and it sinks | chains bursting and a slab going down | 1.6 | 2 | 0.6 | 2 | normal | `golem-slabFall-1…2.wav` |
| `sfx.golem.floorBreak` | the floor's two ends break away | a huge crack and stone moving off | 2.0 | 1 | 0.7 | 1 | high | `golem-floorBreak.wav` |
| `sfx.golem.rainMark` | a rock of the rain shows its shadow | pebbles trickling from the ceiling | 0.6 | 2 | 0.35 | 3 | low | `golem-rainMark-1…2.wav` |
| `sfx.golem.rainHit` | a rock of the rain hits the floor | a thud and chips | 0.7 | 3 | 0.55 | 3 | normal | `golem-rainHit-1…3.wav` |
| `sfx.golem.drop` | at its last health it falls to the floor | the deepest blow | 1.6 | 1 | 0.75 | 1 | high | `golem-drop.wav` |
| `sfx.golem.finish` | the chain into its eye: the finisher | the chain, and the eye splitting like stone glass | 1.4 | 1 | 0.7 | 1 | high | `golem-finish.wav` |
| `sfx.golem.crumble` | it breaks into stones | stones falling and rolling | 2.4 | 1 | 0.7 | 1 | high | `golem-crumble.wav` |
| `sfx.giantBat.wake` | it wakes: the doors sealed 1.4 s before | leather peeling apart, a huge screech filling the room, three wingbeats | 2.2 | 1 | 0.9 | 1 | high | `giantBat-wake.wav` |
| `sfx.giantBat.flap` | each downstroke while it flies | a heavy leathery wingbeat and a low push of air | 0.5 | 3 | 0.38 | 2 | low | `giantBat-flap-1…3.wav` |
| `sfx.giantBat.screechTel` | the screech's telegraph (0.7 s) | an intake of breath rising and echolocation clicks speeding up | 0.8 | 1 | 0.6 | 1 | high | `giantBat-screechTel.wav` |
| `sfx.giantBat.screech` | the stunning screech | high, rasping voices shaking (23 Hz), through the cave's echo | 1.5 | 1 | 1.0 | 1 | never cut | `giantBat-screech.wav` |
| `sfx.giantBat.diveTel` | the dive's telegraph (0.6 s) | a short shriek and the wings snapping shut | 0.55 | 1 | 0.65 | 1 | high | `giantBat-diveTel.wav` |
| `sfx.giantBat.dive` | the dive | a mass of air falling | 0.7 | 1 | 0.7 | 1 | normal | `giantBat-dive.wav` |
| `sfx.giantBat.crash` | it hits the floor (counter, stalactite, drag, slab) | a heavy body on rock, leather flopping, a broken squeal | 1.1 | 1 | 0.85 | 1 | high | `giantBat-crash.wav` |
| `sfx.giantBat.call` | it calls the swarm or the shield | a burst of clicks and rising squeals | 1.0 | 1 | 0.65 | 1 | high | `giantBat-call.wav` |
| `sfx.giantBat.hook` | a chain blade hooks a wing | the hook, the leather pulling tight, a squeal | 0.6 | 1 | 0.65 | 1 | normal | `giantBat-hook.wav` |
| `sfx.giantBat.drag` | S + click drags it down | the chain tightening, desperate wingbeats, the blow on the floor | 1.0 | 1 | 0.8 | 1 | high | `giantBat-drag.wav` |
| `sfx.giantBat.tear` | a strike tears a wing on the floor | leather ripping and a squeal of pain | 0.7 | 2 | 0.7 | 2 | normal | `giantBat-tear-1…2.wav` |
| `sfx.giantBat.hurt` | a hit (at most each 0.25 s) | a short squeal | 0.5 | 3 | 0.55 | 2 | normal | `giantBat-hurt-1…3.wav` |
| `sfx.giantBat.slamTel` | the slam's telegraph (0.55 s) | wingbeats lifting it and a screech tightening | 0.7 | 1 | 0.7 | 1 | high | `giantBat-slamTel.wav` |
| `sfx.giantBat.slam` | it drops on the floor | a huge blow, rock cracking, a rumble | 1.6 | 1 | 1.0 | 1 | never cut | `giantBat-slam.wav` |
| `sfx.giantBat.shock` | the floor wave | a rumble moving away and gravel | 1.3 | 1 | 0.7 | 1 | high | `giantBat-shock.wav` |
| `sfx.giantBat.roar` | the rage | a long, deep screech with a growl under it | 2.3 | 1 | 1.0 | 1 | never cut | `giantBat-roar.wav` |
| `sfx.giantBat.repel` | every 5 hits: the wave that pushes Akeris away (no damage) | one huge wingbeat and a gust of air falling, a soft thump | 0.8 | 1 | 0.75 | 1 | high | `giantBat-repel.wav` |
| `sfx.giantBat.torchOut` | the rage blows out the middle torches | a gust and the flame choking | 0.9 | 1 | 0.6 | 1 | normal | `giantBat-torchOut.wav` |
| `sfx.giantBat.flee` | it bursts into a fleeing swarm | a dense flutter and squeals scattering and fading | 2.6 | 1 | 0.85 | 1 | never cut | `giantBat-flee.wav` |
| `sfx.skeleton.wake` | the Skeleton sits up on its bier | bones fitting one by one, the sword raised, a deep groan | 2.4 | 1 | 0.7 | 1 | never cut | `skeleton-wake.wav` |
| `sfx.skeleton.step` | each step of the Skeleton | a heavy bony step and old iron | 0.35 | 3 | 0.4 | 2 | low | `skeleton-step-1…3.wav` |
| `sfx.skeleton.slashWind` | the air slash's telegraph (0.5 s; 0.38 in phase 2); lower, the heavy chop's | the blade humming and rising | 0.7 | 2 | 0.55 | 2 | high | `skeleton-slashWind-1…2.wav` |
| `sfx.skeleton.slash` | the air slash flies | a cut of air going away down the crypt | 0.9 | 2 | 0.6 | 3 | high | `skeleton-slash-1…2.wav` |
| `sfx.skeleton.bones` | it tears its ribs off and throws them | three bony cracks and a swish | 0.6 | 2 | 0.55 | 2 | normal | `skeleton-bones-1…2.wav` |
| `sfx.skeleton.boneHit` | a bone hits Akeris, a shield, a tombstone or the floor | a dry knock of bone | 0.35 | 3 | 0.45 | 4 | normal | `skeleton-boneHit-1…3.wav` |
| `sfx.skeleton.plant` | it drives the sword into the floor | iron biting stone, a deep knock and the blade ringing | 0.6 | 1 | 0.6 | 1 | high | `skeleton-plant.wav` |
| `sfx.skeleton.handsWarn` | the hands' telegraph (0.6 s) | the floor cracking with a low rumble | 0.8 | 2 | 0.5 | 2 | high | `skeleton-handsWarn-1…2.wav` |
| `sfx.skeleton.hands` | the hands burst out of the floor | a knock and many bones clattering | 0.7 | 2 | 0.6 | 2 | normal | `skeleton-hands-1…2.wav` |
| `sfx.skeleton.heavy` | the two-handed chop | a broad swish and a faint ring | 0.8 | 2 | 0.65 | 2 | normal | `skeleton-heavy-1…2.wav` |
| `sfx.skeleton.collapse` | its first death: it falls apart | bones cascading, the sword falling, the skull rolling to a stop | 1.4 | 1 | 0.7 | 1 | never cut | `skeleton-collapse.wav` |
| `sfx.skeleton.gather` | the bones gather (at 0.7 s); it stands again | bones dragging and fitting, rising in pitch | 1.0 | 1 | 0.5 | 1 | high | `skeleton-gather.wav` |
| `sfx.skeleton.roar` | the guttural roar that throws Akeris and takes the skull back | a deep two-voiced groan, a hiss and a blow | 1.8 | 1 | 0.8 | 1 | never cut | `skeleton-roar.wav` |
| `sfx.skeleton.defeat` | its second death | a last groan, bones falling, the skull cracking, the sword ringing on the stone | 2.6 | 1 | 0.75 | 1 | never cut | `skeleton-defeat.wav` |
| `sfx.giantSpider.wake` | she wakes: the doors sealed 1.2 s before | legs unfolding one by one and a long hiss | 1.8 | 1 | 0.75 | 1 | never cut | `giantSpider-wake.wav` |
| `sfx.giantSpider.hiss` | the charge's and the sweep's telegraph | a hiss and the fangs clicking | 0.7 | 2 | 0.6 | 2 | high | `giantSpider-hiss-1…2.wav` |
| `sfx.giantSpider.step` | each step on the floor (the rage) | a chitin tip on the root and a soft thump | 0.3 | 3 | 0.35 | 2 | low | `giantSpider-step-1…3.wav` |
| `sfx.giantSpider.thread` | the drop's telegraph (0.6 s) | the thread humming low, wavering | 0.8 | 1 | 0.5 | 1 | high | `giantSpider-thread.wav` |
| `sfx.giantSpider.drop` | she falls on her thread | the air cut and the thread let go | 0.6 | 1 | 0.6 | 1 | high | `giantSpider-drop.wav` |
| `sfx.giantSpider.land` | she lands (the drop, the fall, her end) | a big thump and the legs on the floor | 0.9 | 2 | 0.8 | 2 | high | `giantSpider-land-1…2.wav` |
| `sfx.giantSpider.web` | the web shot | a dry jet from the spinnerets | 0.5 | 2 | 0.5 | 2 | normal | `giantSpider-web-1…2.wav` |
| `sfx.giantSpider.webLand` | the web lands or sticks; a sac falls | threads slapping and sticking | 0.4 | 2 | 0.45 | 2 | normal | `giantSpider-webLand-1…2.wav` |
| `sfx.giantSpider.spit` | the spit | a gurgle and three drops leaving | 0.6 | 2 | 0.55 | 2 | normal | `giantSpider-spit-1…2.wav` |
| `sfx.giantSpider.splash` | a drop of venom lands | a thick splat | 0.5 | 3 | 0.45 | 4 | normal | `giantSpider-splash-1…3.wav` |
| `sfx.giantSpider.lay` | the eggs | a wet sac pushed out and falling | 0.9 | 1 | 0.5 | 1 | normal | `giantSpider-lay.wav` |
| `sfx.giantSpider.weave` | the rage: her two big webs | threads running and humming | 1.4 | 1 | 0.55 | 1 | high | `giantSpider-weave.wav` |
| `sfx.giantSpider.charge` | the charge | eight legs at once, very fast | 0.8 | 1 | 0.65 | 1 | high | `giantSpider-charge.wav` |
| `sfx.giantSpider.sweep` | the sweep of her legs | two legs cutting the air | 0.5 | 2 | 0.6 | 2 | high | `giantSpider-sweep-1…2.wav` |
| `sfx.giantSpider.pant` | tired on her single thread | panting breaths | 2.4 | 1 | 0.45 | 1 | normal | `giantSpider-pant.wav` |
| `sfx.giantSpider.cut` | the chain cuts her thread | a taut snap and the thread let go | 0.8 | 1 | 0.7 | 1 | never cut | `giantSpider-cut.wav` |
| `sfx.giantSpider.hurt` | she is hit | chitin cracking, deep | 0.4 | 3 | 0.55 | 2 | normal | `giantSpider-hurt-1…3.wav` |
| `sfx.giantSpider.roar` | the rage and the storm | a huge hiss over a growl of chitin | 2.0 | 1 | 0.9 | 1 | never cut | `giantSpider-roar.wav` |
| `sfx.giantSpider.die` | her end | a thump, the legs folding, chitin crumbling away | 2.2 | 1 | 0.8 | 1 | never cut | `giantSpider-die.wav` |
| `sfx.giantSpider.blast` | annoyed by the chain: the sound blast that pushes Akeris away (no damage) | a huge hiss pushing the air, a low thump under it | 1.1 | 1 | 0.85 | 1 | never cut | `giantSpider-blast.wav` |
| `sfx.dragon.roar` | it wakes (take 1), takes flight at 28 (take 2), the bite's telegraph and the eruption call (take 3, softer and higher) | a deep beast roar: three detuned voices through two formants, a sub-octave, a torn throat, the fire behind it | 2.6 | 3 | 0.95 | 1 | never cut | `dragon-roar-1…3.wav` |
| `sfx.dragon.roarRage` | the rage at 14: red eyes | the roar more torn, with fire roaring inside it | 3 | 1 | 1 | 1 | never cut | `dragon-roarRage.wav` |
| `sfx.dragon.growl` | it turns round; stunned by the counter | a low rough growl | 1.4 | 3 | 0.65 | 2 | normal | `dragon-growl-1…3.wav` |
| `sfx.dragon.pant` | resting with its head down (every 1.5 s); waiting at its last mark | deep breaths through the throat, embers in the chest | 1.6 | 2 | 0.55 | 1 | normal | `dragon-pant-1…2.wav` |
| `sfx.dragon.inhale` | the breaths' and the fire rain's telegraph (the chest and neck swell) | a long breath drawn in, the chest crackling, fire rising in the throat | 1 | 2 | 0.7 | 2 | high | `dragon-inhale-1…2.wav` |
| `sfx.dragon.step` | its steps; the claw's and tail's wind-up; a hop's landing; the turn's landing | the weight on the stone (a felt sub), scales and talons | 0.9 | 4 | 0.8 | 3 | low | `dragon-step-1…4.wav` |
| `sfx.dragon.wing` | a wingbeat in flight; the gust's and the slash's telegraph; the hop | old leather cracking and a lot of air, a felt low beat | 0.8 | 3 | 0.65 | 3 | normal | `dragon-wing-1…3.wav` |
| `sfx.dragon.takeoff` | it crouches and takes flight | a push off the stone and three huge wingbeats | 1.6 | 1 | 0.85 | 1 | high | `dragon-takeoff.wav` |
| `sfx.dragon.hurt` | it is hit (four takes) | a short, angry bellow | 0.9 | 4 | 0.75 | 2 | normal | `dragon-hurt-1…4.wav` |
| `sfx.dragon.fall` | at its last mark it falls and waits | a groan and the body on the bastion, stones bouncing | 2.2 | 1 | 0.95 | 1 | never cut | `dragon-fall.wav` |
| `sfx.dragon.die` | its end: the neck struck while pinned | a last bellow, the collapse and the fire inside going out | 3.4 | 1 | 0.95 | 1 | never cut | `dragon-die.wav` |
| `sfx.dragon.claw` | the claw comes down | the arm cutting the air and three talons raking the stone | 0.8 | 3 | 0.8 | 2 | high | `dragon-claw-1…3.wav` |
| `sfx.dragon.bite` | the bite: the head thrown forward | a rush of air, the jaws snapping shut, a grunt | 0.7 | 3 | 0.85 | 2 | high | `dragon-bite-1…3.wav` |
| `sfx.dragon.breathLow` | the low breath (1.2 s) | a roaring fire stream that lasts the whole breath, wavering, with sparks | 1.4 | 1 | 0.9 | 1 | high | `dragon-breathLow.wav` |
| `sfx.dragon.breathHigh` | the high breath (1.0 s) | the same stream brighter, whistling overhead | 1.2 | 1 | 0.9 | 1 | high | `dragon-breathHigh.wav` |
| `sfx.dragon.tail` | the tail sweep | a heavy low sweep of air, scales rattling | 0.8 | 2 | 0.8 | 2 | high | `dragon-tail-1…2.wav` |
| `sfx.dragon.slam` | the earthquake's slam, the dive's landing, the leap from the tower | a huge felt boom on the stone and chips | 1.8 | 2 | 0.95 | 2 | never cut | `dragon-slam-1…2.wav` |
| `sfx.dragon.quake` | the dust wave running both ways | a low rumble rolling away with grit | 1.8 | 1 | 0.85 | 2 | high | `dragon-quake.wav` |
| `sfx.dragon.gale` | the gusts | two wingbeats pushing a wall of air | 1.1 | 2 | 0.8 | 2 | high | `dragon-gale-1…2.wav` |
| `sfx.dragon.slash` | the wind slashes | a wingbeat and two crossing whistles | 0.9 | 2 | 0.8 | 2 | high | `dragon-slash-1…2.wav` |
| `sfx.dragon.dive` | the dive (its impact is `slam`) | a falling scream and the air tearing | 1.2 | 1 | 0.9 | 1 | high | `dragon-dive.wav` |
| `sfx.dragon.fireRain` | the fire rain: the flight across | fire roaring above and five spits | 2 | 1 | 0.8 | 1 | high | `dragon-fireRain.wav` |
| `sfx.dragon.crackGlow` | the cracks glow (1 s before the eruption) | a rumble rising from below, embers crackling | 1.2 | 1 | 0.7 | 2 | high | `dragon-crackGlow.wav` |
| `sfx.dragon.eruption` | a column of fire bursts from a crack | a felt boom from below and a column of roaring fire | 1.5 | 2 | 0.95 | 2 | never cut | `dragon-eruption-1…2.wav` |
| `sfx.dragon.heatBlast` | four chain hits in a row: its heat blast (no damage) | a blow of hot air carrying embers | 1.3 | 1 | 0.85 | 1 | never cut | `dragon-heatBlast.wav` |
| `sfx.dragon.hornHook` | the chain hooks the chipped horn: the head pinned | bone and iron, the head against the floor, the chain rattling, its complaint | 0.8 | 1 | 0.85 | 2 | never cut | `dragon-hornHook.wav` |
| `sfx.dragon.hitSword` | the sword hits its body | a blade biting thick scale: a heavy thud, a scrape and a ring | 0.5 | 3 | 0.7 | 3 | normal | `dragon-hitSword-1…3.wav` |
| `sfx.dragon.hitSpear` | the spear hits its body | a point going in dry through the scale | 0.5 | 3 | 0.7 | 3 | normal | `dragon-hitSpear-1…3.wav` |
| `sfx.dragon.hitHammer` | the hammer, the flail or the fast descent hit its body | a deep blow that makes the scales rattle | 0.7 | 3 | 0.8 | 3 | normal | `dragon-hitHammer-1…3.wav` |
| `sfx.dragon.hitChain` | a chain blade hits its body (or its horn, when it cannot be hooked: `hitHorn`) | the hook biting the scale, a metallic ring | 0.5 | 3 | 0.65 | 3 | normal | `dragon-hitChain-1…3.wav` |
| `sfx.dragon.hitNeck` | a blow to the pinned neck (the weak point) | soft flesh without scales and its bellow | 0.7 | 3 | 0.8 | 3 | high | `dragon-hitNeck-1…3.wav` |
| `sfx.dragon.hitHorn` | the chain on its horn when it cannot be hooked | dry bone | 0.5 | 2 | 0.7 | 2 | normal | `dragon-hitHorn-1…2.wav` |
| `sfx.dragon.hitCounter` | each blow of the counter after a sacred just block | blows that open the scale | 0.8 | 1 | 0.8 | 2 | high | `dragon-hitCounter.wav` |
| `sfx.dragon.hitGuard` | a blow that rings off: roaring, or at its last mark (`CLANG!`) | scale ringing like iron | 0.6 | 2 | 0.7 | 2 | normal | `dragon-hitGuard-1…2.wav` |

### Cinematics — `cinematics/` *(step 3.18, the outro; approved 2026-10-14)*

The outro (`01-story/cinematics/outro.md`, the operator's second 2026-10-14 script) has two clocks that must be heard as
two. The game schedules them (from `dt` and a seed), so the room clock never restarts when the ability is chosen; the
music (`music.dragon.fall`, `music.outro`) carries only the bed. Built and exported from the zone 5 sandbox
(`otExportSfx()`), with a seeded convolution reverb.

| Id | Trigger | Sound | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|---|
| `sfx.clock.room` | the room clock: from the moment the Dragon's ink is gone (right after `sfx.outro.break`, 0.9 s later the first tick), every 1.45 s ± 0.08 (seeded), under the ability choice and the whole outro; in the charge (shot 8) it quickens to 0.6 s and then 0.42 s; ducked to 0.35 in the short circuit and 0.55 under the first card, never stopped until the massive tick | a slow, warped tick and tock: two small bells that do not agree (3.5 % apart) bending down, a soft thud, a long room tail | 1.3 | 4 (1–2 tick, 3–4 tock) | 0.5 | 3 | never cut | `clock-room-1…4.wav` |
| `sfx.clock.corrupt` | the corrupted clock: only in the short circuit (shot 6), one halfway between each two room ticks | huge, metallic, painful: a low inharmonic bell (≈ 73 Hz), a sub drop, a detuned sawtooth cry bending down, a scrape — all heard **through interference** (operator, 2026-10-14): crushed to a few levels (bit-crush), band-limited (180–2400 Hz), a stutter at its start, short dropouts, tape hiss; the room clock stays clean | 2.8 | 3 | 0.9 | 2 | never cut | `clock-corrupt-1…3.wav` |
| `sfx.outro.blow` | shot 3: starts 0.45 s before the cut to black, its impact on the cut (9.0 s) | something that should not exist tearing into the world (operator, 2026-10-14): a breath sucked inwards (a rising swell), then an enormous sub impact (82 → 24 Hz) and a dark, wrong bass — sawtooth tones on D1, E♭1 and A♭1 (a semitone and a tritone apart) and D0, driven through a distortion — a low roar and a rumbling tail of ≈ 3.6 s; no clean note, no glass (unlike `sfx.clock.massive`); the room clock goes on over it; peak −1 dBFS | 4.8 | 1 | 1.0 | 1 | never cut | `outro-blow.wav` |
| `sfx.outro.arrive` | shot 4, Future Akeris's arrival: starts 0.35 s before the flash (10.5 s), its impact on the flash | the same wrong power, bigger and longer: the sucked-in swell, the sub impact, the distorted D1–E♭1–A♭1–D0 stack (2.8 s) and a rumbling tail of ≈ 4.6 s under the whole shot; peak −1 dBFS | 5.6 | 1 | 1.0 | 1 | never cut | `outro-arrive.wav` |
| `sfx.outro.break` | when the Dragon's ink is gone, before the first room tick (operator, 2026-10-14) | something breaking: a sharp crack and a deep thud, a crack that runs down (3.2 → 0.4 kHz), a second smaller crack, about thirty glass and stone shards falling, stone crumbling | 2.4 | 1 | 0.9 | 1 | never cut | `outro-break.wav` |
| `sfx.clock.massive` | shot 10: starts 0.42 s before the cut (34.48 s), its hit on the cut to black (34.9 s); the room clock stops when it starts | **explosive and joined** (operator, 2026-10-14; stereo): a reverse swell rising for 0.42 s, together with the charge's grind shooting up, flows with no gap into the hit; the hit: a noise crack and a kick (150 → 40 Hz), the clock's tick on top, the bass of the *New game* descent (`music.descent`: organ D2 with D1, through the same seeded reverb) clean and saturated, a D1 sub, a low-passed noise explosion sweeping down (4 kHz → 70 Hz), shattering glass, metal and stone (denser in the first 0.8 s, panned, decorrelated reverb), a cracking roar; all through a compressor and a tanh limiter (RMS of the first 1.5 s −4.2 dBFS, peak −1 dBFS); then the bass tail dies away slowly (≈ 9 s) under the last card and hands over to `music.title`, which comes in under it from 39.5 s | 9.6 | 1 | 1 | 1 | never cut | `clock-massive.wav` (stereo) |

## 3. Mixing rules

- **Buses:** music, sound effects (and the ambience) and voice; the settings scale music and effects
  with a square curve (`(v / 10)²`). The voice follows the effects setting.
- **Voices:** at most 24 effects at once. Over that, the oldest `low` goes first, then `normal`.
  `high` is cut only by another `high`; `never cut` is never cut.
- **Dialogue:** the music ducks to half (−6 dB) while a dialogue is open; the ambience drops to 0.35.
- **Paused, on the map, in a dialogue:** the world is stopped, so no world sound starts; loops
  (`sfx.chain.spin`, `sfx.flail.chain`, and the enemies' loops such as `sfx.smallBats.flutter`) fall silent and
  come back when it closes. **In the pause and the map only the music sounds** *(operator, 2026-10-01)*: the
  ambience is silent there too (in a dialogue it drops to 0.35). Interface sounds still play.
- **Positional:** world sounds pan with the source's x on the screen (left −1 to right +1) and drop
  6 dB beyond one screen width; interface sounds are centred. The game decides the exact curve.
- **The echo of zone 2** *(step 3.12)*: in zone 2 every world sound (not the interface, the
  ambience or the voices) also goes through one echo: 0.32 s, feedback 0.36, low-passed at 1.7 kHz,
  wet 0.32 (`04-zones/zone-2-echo-caverns/biome.md` §A.5). The music has its own echoes.
- **The stone of the catacombs** *(step 3.13)*: in zone 3, only while Akeris is in a catacomb room, every
  world sound (not the interface, the ambience or the voices) also goes through a short stone
  reverberation: delays of 55 and 83 ms, feedback 0.42, low-passed at 2.4 kHz, wet 0.3 (a tail of about
  0.2 s) (`04-zones/zone-3-sunken-graveyard/biome.md` §A.5). In the yard, nothing.
- **The jungle of zone 4** *(step 3.14)*: no echo and no reverberation; the jungle muffles
  (`04-zones/zone-4-rotting-canopy/biome.md` §A.5).
- **No pitch tricks:** a sound plays at rate 1, except the spirits' voice (`../voice/voice.md`).

## 4. Never

- A beep, a chime of victory, a fanfare or anything that celebrates loudly (`00-game/tone.md`).
- Gore sounds: no squelch, no blood, no bone crunch; a hit is dry and short. The one exception is `sfx.manyArmed.crush` (bones breaking; the operator, 2026-10-01).
- Akeris's voice: no grunts, no cries, no breath that sounds like a word.
- A sound triggered by a key instead of the event (pressing attack with no strike plays nothing).
- Clipping: no file and no sum of sounds goes over 0 dBFS.

## 5. Acceptance

1. Each trigger in §2 plays its id once, at its volume, with one of its variations.
2. A held loop stops the frame its state ends.
3. With 24 effects playing, a `never cut` sound still plays whole.
4. During a dialogue the music is 6 dB lower and comes back when it closes.
5. Paused, no world sound starts and the loops are silent; the menu sounds play.
6. The settings' sound-effect volume at 0 silences every effect and the ambience, not the music.
7. Every file is 44.1 kHz, 16-bit, mono, peak −1 dBFS.
