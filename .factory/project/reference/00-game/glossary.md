# Glossary

- **Status:** approved 2026-09-30 (step 3.6 changes *special shield* and adds *altar*, *broken shield* and *repair*)
- **Sources:** `VISION.md` (every section) · `08-engineering/architecture.md` §2 (the features)
- **Read by:** everyone. It is the game's **ubiquitous language** (`08-engineering/architecture.md`
  §2): the same word, the same meaning, in conversation, in the references and in the code
  (`08-engineering/coding-standards.md` §2). A task that names domain types cites it.

Each term has its code name (the type or identifier the code uses), its meaning, and the Spanish name
the translator and the story use. The Spanish names of places, enemies and bosses are the player-visible
ones; the rest are for conversation. The code is English only.

A term that has a different meaning in two contexts is listed under each, and that is intended. A
word not listed here is not part of the language yet: the architect or the planner proposes it to the
operator before using it in a contract.

---

## 1. The story

| Term | Code name | Meaning | Español |
|---|---|---|---|
| Akeris | `Akeris` | the player's character, the Savior; the only playable character | Akeris |
| Savior | — | the timeline of Akeris the player controls: red eye streak, torn cape with holes | el Salvador |
| Future Akeris | `FutureAkeris` | the Akeris from the future who tries to stop the Savior reaching the last floor: red streak, fully torn cape, curved battered sword, very dirty. In the outro of the demo, and in a short circuit of the intro's dream. `VISION.md` calls him *the Future Traveller*; the references call him Future Akeris | Akeris del futuro |
| Corrupted Akeris | `CorruptedAkeris` | the Akeris corrupted by the clock, waiting on the last floor; purple streak, holds the clock. Not in the demo | Akeris corrupto |
| timeline | — | one of the three versions of Akeris; the colour of the eye streak shows which | línea temporal |
| eye streak | — | the ray-like trail from Akeris's single elongated eye; it represents the timeline | estela del ojo |
| Time Clock | `TimeClock` | the sacred relic of Akeris's race; someone used it, and the world has days left | el Reloj del Tiempo |
| Time Chamber | — | the room on the dungeon's last floor that holds the clock | la Cámara del Tiempo |
| Time Guardian | — | who guards the Time Chamber. Not in the demo as a character: only a silhouette in the intro | el Guardián del Tiempo |
| Temple of Time | — | what the intro's card calls the dungeon (`cinematic.intro.card`) | el templo del tiempo |
| sacred sword | `SacredSword` | the sword Akeris always carries without knowing what it is; dormant and weak until its first gem | espada sagrada |
| gem | — | one of the three stones that fit the gem-shaped holes of the sacred sword, one per successful incursion. Not in the demo | gema |
| spirit | `Spirit` | an ancient spirit of the dungeon that has lived through every reset; tells the story piece by piece, remembers past runs. Two per zone | espíritu |
| ancient language | — | the processed, unreadable speech of the spirits | lengua antigua |
| intro, outro | `Cinematic` | the two cinematics: a silhouette like Akeris with only its purple streak visible; Future Akeris appears, cut to black | intro, final |

## 2. The run (`run`, `save`, `narrative`)

| Term | Code name | Meaning | Español |
|---|---|---|---|
| run | `Run` | one attempt from zone 1 until death or victory. Everything is kept within it; nothing across deaths | partida |
| incursion | — | in the story, an attempt at all 20 floors; in the demo, the word the spirits use for a run. Code says `Run` | incursión |
| zone | `Zone` | one floor of the dungeon, generated from the run's seed and closed by a boss. 5 in the demo, 20 in the full game | zona |
| biome | `Biome` | a zone's look, hazards and enemies; each zone is a different biome | bioma |
| seed | `Seed` | the number every random choice of a run comes from | semilla |
| threshold boss | — | the boss of every fifth zone, the strongest of its tier; the Dragon in the demo | jefe umbral |
| death | `RunEnded` (lost) | health reaches zero, or damage during the cursed challenge: the run, its coins and its save slot are wiped | muerte |
| victory | `RunEnded` (won) | the Dragon defeated; the outro plays | victoria |
| enemy scaling | — | enemies are stronger in each later zone | escalado de enemigos |
| save slot | `SaveSlot` | one of 3 places a run is saved; manual save from pause, autosave on quitting and on entering a boss room | ranura de guardado |
| memory | `SpiritMemory` | what the spirits remember of past runs; survives death, and only changes what they say | memoria |

## 3. Akeris and his gear (`akeris`, `arsenal`, `chain`, `abilities`, `inventory`)

| Term | Code name | Meaning | Español |
|---|---|---|---|
| posture | `Posture` | what Akeris's body is doing: standing, walking, running, jumping, crouching, rolling, blocking, attacking… | postura |
| roll | — | Shift; a roll with brief invulnerability. Space while rolling jumps out of it with its speed (D) | voltereta |
| air roll | — | Shift in the air: a somersault with the roll's invulnerability, once per jump (D) | voltereta en el aire |
| high jump | — | holding Space: a higher jump, straight up or to the side with A/D; a tap is the normal jump | salto alto |
| fast descent | — | S in the air; drops fast and stuns enemies where it lands | descenso rápido |
| crouch | — | Left Ctrl; passes through tunnels and low gaps | agacharse |
| loadout | `Loadout` | what Akeris has equipped: a weapon, a shield, three abilities | equipo |
| weapon | `Weapon` | one of 5: sacred sword, chain blades, spear, flail, hammer. 7 levels, the demo stops at 3; each level raises its damage (D-I8) | arma |
| slot | — | one of the 5 weapon places: the sword and the chain blades always, 3 free for what is found | ranura |
| chain blades | `ChainPair` | the pair of hook blades, one in each hand, each on its own chain; always carried. Also *hook blades* | espadas-gancho |
| throw | — | a chain blade thrown where the mouse aims; the throws alternate hands | lanzamiento |
| pull | — | the chain drags Akeris to an enemy | tirón |
| snatch | — | the chain takes an object from an enemy: the knight's shield, the skeleton's skull | arrebatar |
| hook | — | the chain fastens to a boss part, a ring or a wall | enganchar |
| swing | — | hanging from a ceiling ring by the chain, A/D to swing, Space to let go | balanceo |
| free hand | — | while hanging from a ring, the hand not on the chain. It holds its hook blade, and the wheel swaps it for the shield; right click throws or blocks with it (`controls.md` §3.1) | mano libre |
| anchor | — | the chain driven into the floor; the only escape from the golem's levitation | anclaje |
| shield | `Shield` | strapped to the back forearm; raised with right click. Sacred (unbreakable), ice (10 hits), fire (4 dragon blasts) | escudo |
| special shield | — | the ice or the fire shield; found once per run, **not refilled** on entering a zone: its uses are bought back with XP (D, `05-items/items.md` D-I3). A perfect block against a melee hit with the ice shield freezes the attacker, with the fire shield burns it, 1.5 s each; a normal block only stops the hit; neither opens a counter | escudo especial |
| block | — | the raised shield stopping an attack; the only block, no high or low | bloqueo |
| perfect block | — | the shield raised just before a hit lands: against a melee hit, with the sacred shield, it opens a counter; against a projectile it reflects it | bloqueo justo |
| counter | `CounterTriggered` | a perfect block with the **sacred shield** against a melee hit gives 1 s of ultra-fast strikes (with the chain blades, a ranged burst). No other shield opens it | contraataque |
| reflect | — | a perfect block against a projectile sends it back, faster, at its thrower, and it damages the thrower when it hits (reflected with the ice shield it also freezes it 0.5 s; with the fire shield it burns it 0.5 s); no counter. Projectiles are never split | devolver |
| fire attack, ice attack | — | an attack of fire or of ice. Only the fire shield blocks fire, and only the ice shield blocks ice, without damage; any other shield lets the hit through. Every other attack is plain, and any shield blocks it | ataque de fuego, ataque de hielo |
| altar | `Altar` | the stone pedestal where a weapon, shield or scroll waits; G takes it (D) | altar |
| broken shield | — | a special shield with no uses left: drawn broken, it cannot block until repaired with XP and a curse (D) | escudo roto |
| satchel | `Satchel` | what Akeris carries besides weapons and shields: potions. Scrolls are read at once when taken, never carried (D, `05-items/items.md` I4) | zurrón |
| potion | `Potion` | carry 3, refilled on entering each zone; hold F to drink, then the weapon held before comes back; never while hanging | poción |
| scroll | `Scroll` | 3 per zone: health; attack and ability; cursed | pergamino |
| cursed challenge | `CursedChallenge` | the cursed scroll's test: kill 10 enemies without taking damage; any damage kills Akeris | desafío maldito |
| rage | — | the cursed challenge's reward: an attack boost for 3 min, or until the zone changes | furia |
| ability | `Ability` | one of 10, two per boss; 3 equipped, on Q, E and R | habilidad |
| ability drop | — | a boss gives one of its 2 abilities at random; after it, one equipped ability may be swapped | botín de habilidad |
| XP | `Xp` | dropped by enemies by type; spent in the full inventory to upgrade weapons and shields | experiencia |
| coin | `Coins` | dropped by enemies; lost on death; the shop is locked in the demo | moneda |
| quick inventory | — | the weapons, potions and abilities on screen; only the weapons are switched from it, with the wheel or keys 1–5 | inventario rápido |
| full inventory | — | in the pause menu: equipment, upgrades, stats, the equipped shield | inventario completo |

## 4. Combat (`combat`)

| Term | Code name | Meaning | Español |
|---|---|---|---|
| hit | `HitLanded` | a resolved collision between an attack and a body, with damage | golpe |
| engagement | `Engagement` | one exchange of attacks between Akeris and one enemy | enfrentamiento |
| blockable, unblockable | — | whether an attack can be stopped by the shield; every attack is one or the other | bloqueable, imbloqueable |
| status effect | `StatusEffects` (the set on one body) | levitation (golem), slow (web), poison, freeze (the ice shield; lowers defence), burn (the fire shield; loses health), stun | estado alterado |
| hitstop | — | the game holding still for an instant when a hit lands, instead of shaking the screen | pausa de impacto |

## 5. On screen (`rendering`, `hud`)

| Term | Code name | Meaning | Español |
|---|---|---|---|
| hit | — | in drawing: the spark and the callout of a landed hit (compare §4) | impacto |
| callout | `Callout` | hand-lettered onomatopoeia or word at a hit: *COUNTER!* | onomatopeya |
| stroke | `StrokeGeometry` | one hand-drawn line, generated once from its seed; identical every frame | trazo |
| afterimage | — | the fading copies Akeris leaves during a counter | imagen residual |
| ink smoke | — | what a defeated enemy dissolves into | humo de tinta |
| blade trail | — | the arc a blade leaves during a strike | estela de hoja |
| su | — | sandbox unit: Akeris standing is 192 su (`02-art-direction/ART_DIRECTION.md` §3) | — |
| map, minimap | — | the zone map on M, revealed as explored; the circular minimap in the HUD | mapa, minimapa |

## 6. Places (`dungeon`)

| Zone | Code name | Biome | Español |
|---|---|---|---|
| 1 | `suspendedSanctuary` | Suspended Sanctuary — floating ruins, drifting platforms, chasms | Santuario Suspendido |
| 2 | `echoCaverns` | Echo Caverns — caves, dripping water, darkness lit by torches | Cavernas del Eco |
| 3 | `sunkenGraveyard` | Sunken Graveyard — cemetery and catacombs, fog, open graves | Cementerio Hundido |
| 4 | `rottingCanopy` | Rotting Canopy — underground jungle, roots, poison pools, spores | Dosel Podrido |
| 5 | `dragonBattlements` | Dragon Battlements — ruined ramparts, side wind, merlons | Almenas del Dragón |

| Term | Code name | Meaning | Español |
|---|---|---|---|
| room | `Room` | one part of a zone | sala |
| hazard | `Hazard` | a part of a biome that hurts or hinders: chasms, poison pools, wind… | peligro |
| boss room | `BossRoom` | the room that closes a zone: sealed with bars, chains and a padlock until the boss dies; always has hanging platforms | sala del jefe |
| ceiling ring | — | a ring the chain can hook to swing | argolla |

## 7. Enemies and bosses (`enemies`, `bosses`)

| Zone | Enemy | Code name | Español |
|---|---|---|---|
| 1 | Shield Knight | `shieldKnight` | caballero con escudo |
| 1 | Rune Sentinel | `runeSentinel` | centinela rúnico |
| 1 | Wandering Eye | `wanderingEye` | ojo errante |
| 1 | Mace Brute | `maceBrute` | bruto del mazo |
| 2 | Small Bats | `smallBats` | murciélagos pequeños |
| 2 | Blind Ghoul | `blindGhoul` | necrófago ciego |
| 2 | Ceiling Crawler | `ceilingCrawler` | reptador del techo |
| 2 | Many-Armed | `manyArmed` | el de muchos brazos |
| 3 | Skeleton Archer | `skeletonArcher` | arquero esqueleto |
| 3 | Gravedigger | `gravedigger` | sepulturero |
| 3 | Wraith | `wraith` | espectro |
| 3 | Ossuary Many-Armed | `ossuaryManyArmed` | el de muchos brazos del osario |
| 4 | Spiderlings | `spiderlings` | arañitas |
| 4 | Spore Pod | `sporePod` | vaina de esporas |
| 4 | Strangler Vine | `stranglerVine` | enredadera estranguladora |
| 4 | Mantis | `mantis` | mantis |
| 5 | Drakeling | `drakeling` | dragoncillo |
| 5 | Gargoyle | `gargoyle` | gárgola |
| 5 | Elite Shield Knight | `eliteShieldKnight` | caballero con escudo de élite |
| 5 | Fire Mace Brute | `fireMaceBrute` | bruto del mazo de fuego |

| Zone | Boss | Code name | Abilities (A · B) | Español |
|---|---|---|---|---|
| 1 | Golem | `golem` | Inverse Gravity · Stone Orbit | gólem |
| 2 | Giant Bat | `giantBat` | Screech · Swarm | murciélago gigante |
| 3 | Skeleton | `skeleton` | Air Slash · Reassemble | esqueleto |
| 4 | Giant Spider | `giantSpider` | Web · Venom Edge | araña gigante |
| 5 | Dragon | `dragon` | Breath · Earthquake | dragón |

| Term | Code name | Meaning | Español |
|---|---|---|---|
| brain | `…Brain` | an enemy's behaviour, one strategy per kind (`08-engineering/design-patterns.md`) | cerebro |
| phase | `BossPhase` | one stage of a boss fight: the golem's rage, the skeleton reassembled… | fase |
| part | `BossPart` | a piece of a boss the chain can hook or break: a wing, a slab, a horn | parte |
| finisher | — | the last blow that ends a boss: chain into the golem's eye, the horn and neck of the dragon | remate |
