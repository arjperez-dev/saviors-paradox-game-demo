# Zone 5 — Dragon Battlements: biome

- **Status:** approved 2026-10-07 (step 3.15)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Sheet:** [`sheet.png`](sheet.png) ·
  **Captures:** [`sandbox/captures/`](sandbox/captures/)
- **Sources:** `VISION.md` §Scope (Dragon Battlements, ruined ramparts; side wind, gaps between merlons, merlons as cover
  against fire), §Bosses (Dragon: fire bursts, earthquakes, wind slashes, floor eruptions telegraphed by glowing cracks) ·
  `01-story/zones-narrative.md` (zone 5: walls Akeris's people built, not to keep things out, but to keep something from
  coming up; someone watches Akeris from the walls, walks the way he walks) · `01-story/dialogue/zone-5.md` («Keep behind
  the stones when it breathes», «The merlons will take the fire for you, until they break», «Someone has been watching you
  from the walls») · `01-story/cinematics/outro.md` (changed by the operator 2026-10-14: Future Akeris appears right behind Akeris, in the fog of the Dragon room) · `07-audio/music/music.md`
  (`music.zone5`, `music.dragon.calm`, `.fight`, approved) · zone 4 (`../zone-4-rotting-canopy/`), whose sandbox, generator,
  size and rules it keeps · the operator's answers to the proposal and to the first sandbox (2026-10-07)
- **Read by:** the tasks that draw and play zone 5; with [`layout.md`](layout.md), [`hazards.md`](hazards.md) and
  [`boss-room.md`](boss-room.md)

---

## A.1 Identity

The walls Akeris's people raised **so that something would not come up**: the merlons look **down**. The ramparts cross an
immense chasm underground, with no sky; far below, a glow of embers. It is the most open place of the game and the only
one where the wind blows. Three kinds of place:

- **the wall walk** (*adarve*): the walk on top of the wall, open to the chasm, with merlons, torn banners and braziers;
  the wind blows here;
- **the tower** (*torre*): guardrooms, stairs and armouries of masonry inside, with arrow slits that let in thin bars of
  the glow from below; darker, no wind;
- **the breach** (*brecha*): what the Dragon burned or threw down: scorched stone, charred beams, ash floors and gaps
  into the void; wind too.

The player must understand at once two things: **the merlons shelter you from fire, until they break**, and **a gap is
a fall**. The wind is felt, not fought: it rises and falls slowly, it moves the embers, the ash and the banners, and **it never
moves Akeris** (operator, 2026-10-07).

**The zone's hint** (operator, 2026-10-07, proposal Z60): the spirits say it in words («Someone has been watching you from
the walls. He walks the way you walk»), and **the one who watches is seen** (operator, 2026-10-08: «que sea más visible o al
menos que se sienta que te están vigilando a lo lejos»): in most rooms that have a far wall, far off, a figure like Akeris
stands behind the merlons of the far wall, seen from the waist up — cape in strips, hooded head — dark, outlined only by a
thin warm rim of the chasm's glow; **his eye and its battered red streak** (Future Akeris's defective streak: broken in
pieces, some shifted, some without the bright red) glow above the darkness with a faint red halo. **His head turns slowly
to follow Akeris**, so the streak always trails away from where he looks. When Akeris comes within **650 su**, he ducks
behind the merlons (1.1 s), the eye goes out last (0.6 s), and that place is empty for the rest of the run. Nothing on him
moves or trembles but the turn of the head and the duck. The outro (`01-story/cinematics/outro.md`, shot 4; changed by the operator
2026-10-14) is the first time he is seen whole and up close: right behind Akeris, in the fog of the Dragon room.

**And in the depths** (operator, 2026-10-08: «más tétrico, en el fondo de alguna de las capas más profundas»): in some open
rooms where the near one is not (`wallWalk`, `bastion`; half of them, at least 2 a zone), far away between the deepest walls, a
lone needle of rock rises from the chasm and on top of it **he stands, tall, still, leaning, his sword dragging**; his battered
streak hangs **down** from his eye, broken, as if it dripped, glowing above the darkness. He moves only with the deep layer's
parallax. When Akeris crosses the room's middle, he fades in 2.5 s and does not come back in the run.

## A.2 Layers, back to front

| Layer | Contents | Parallax | Palette and hatching |
|---|---|---|---|
| far wall | other ramparts in silhouette, five bands stepping down into the chasm, each darker; towers with merlons and arches; a few arrow slits lit from below; at the bottom of everything, **the glow of the chasm** (fixed, never flickering) | 0.22 (tile 3000 × 2900 su, repeats sideways) | `far` `#3d3832`; walls in near-black at 42–82 %; glow in `torchlight` `rgba(255,160,70,·)` 0–26 % |
| middle | buttresses coming down from top to bottom with their string courses, broken bridges between them, hoist chains that go down and are lost | 0.5 (tile 3000 × 2250 su, repeats both ways) | near-black at 82 % |
| tower wall | only in tower rooms: dark masonry with **arrow slits** (a stone frame, a dark slot and a thin line of the glow) | 1 (it hides the far layers) | `stone` darkened to 62 %; the line in `torchlight` 5–70 % |
| play layer | flagstone floors and the face of the wall below them; vaults (tower) or the cavern's rock far above (wall walk, breach); gaps with broken edges; merlons, braziers, banners, the sentry box, racks, barrels, charred beams, rubble, claw marks; the far wall where the watcher stands | 1 | §A.3 |
| foreground | near-black chains and tatters of banners hanging from the top of the view, passing faster | 1.3 | `ink` at 90 % |
| **embers and ash** | over the play layer and Akeris (§A.4) | 1 | `flame` outer, `rock` |
| **darkness** | the whole view darkened, with holes of light (§A.4) | screen | `rgba(9,7,6,a)`: a = 0.45 on the wall walk and the breach, 0.72 in the tower |
| paper overlay | grain, stains and edge vignette (unchanged) | screen | `palette.md` §1 |

**Camera:** Akeris at **60 %** of the view height, as in zones 1–4. It follows, snaps to the pixel and never shakes.

## A.3 Stone, ash and iron

Units are `su`; **32 su = 1 tile**. Never drawn as outlined tiles. **No new colour** (proposal Z51): the dungeon's `stone`,
`mortar`, `pillar`, `hollow` and `rock`; soot in `ink`; the embers in `flame`; the glow in `torchlight`; banners in
`parchmentDark` with the three hollows in `ink` (the mark of zone 3: the walls are Akeris's people's); iron in `iron`.

| Kind | Where | How it is drawn | Collision |
|---|---|---|---|
| flagstone floor | every room | the top edge is the floor: a thick straight stroke; a row of flagstones with their joints and a string course 24 su down; below, the masonry face of the wall, darkening to near black 330 su down. In the breach, soot over the top 260 su and **ash** on the edge (flat grey heaps, a cold ember) | solid from the edge to the room's bottom |
| broken edge | every floor that ends at a gap | broken stones jutting out down the face and a crack | — |
| **gap into the chasm** | `hazards.md` | nothing under it: dark going down, and at the very bottom a faint glow | none: falling is the fall (`hazards.md`) |
| ceiling | wall walk, breach | the cavern's rock, dark, far above (40 su under the room's top), with teeth of rock hanging | solid |
| vault | tower | masonry, darkening upward, with corbels every ≈ 400 su; in the gatehouse, **murder holes** | solid |
| walls | room sides, what closes a dead end | masonry, darkened; over a passage, a lintel of voussoirs | solid |
| hanging walk | the boss room | a broken piece of wall walk hanging from two chains | solid, 40 su thick |

Chains and rings are drawn in `ink` with `rock` over it, so they read against the dark.

## A.4 Props, light, embers and life

| Prop | Where | Light | Moves? |
|---|---|---|---|
| **brazier**: an iron bowl on three legs, with its coals | 1–2 per room by template (`bz`) | a hole in the darkness of **450 su**; five tongues of flame | the flames sway; **only light** (operator, 2026-10-07): nothing knocks it over |
| **banner**: torn `parchmentDark` cloth with the three hollows **painted on it** (they move and bend with the cloth), on a pole 300 su high | wall walk and breach rooms (`banner`) | — | **the wind lifts it** (§A.5); in calm it hangs, waving slowly |
| **merlon of cover** | `hazards.md` | — | breaks under fire |
| the far wall across the chasm, pale, with its merlons | `wallWalk`, `bastion`, `watchEnd`, the boss room | — | no |
| **the one who watches** | behind the far wall's merlons of most rooms that have one (§A.1): body under the darkness, rim and eye above it | — | turns his head after Akeris; ducks when Akeris comes near |
| the sentry box, the horn and the bones of the sentry | `watchEnd` | — | no |
| weapon racks with rusted spears and swords, barrels, benches | towers, `armoryEnd` | — | no |
| the portcullis, raised, its teeth under the vault | `gatehouse` | — | no |
| charred beams, scorch on the stone, rubble | breach rooms | — | no |
| claw marks on a block of the wall; a huge scale | the antechamber | — | no |
| the stair Akeris came down by (from the broken merlon of zone 4) | start | — | no |
| the stair down into the depths, under an arch | the way down | — | no |
| the broken tower where the Dragon sleeps; cracks in the floor | the boss room | — | no |
| a fallen merlon, the lookout | every lookout dead end | — | no |

**Light** (proposal Z52): the view is dark at **45 % on the wall walk and the breach** (the glow from below lights them)
and **72 % in the tower**; crossing a passage, the darkness changes slowly (about 0.4 s). Light comes from the braziers
(450 su), the altar candles (360 su), **Akeris's eye** (300 su at 85 %) and fire (220 su). Nothing flickers.

**Embers and ash** (proposal Z53), the zone's identity, as the spores were zone 4's: orange **embers** rising slowly from
the chasm and fading as they rise (22 per cell), grey **flakes of ash** falling and rocking (16 per cell); none in the
towers. **Only atmosphere: they do no harm.** They **show the wind**: they lean and drift with it as it rises and falls. They move, they never tremble.

## A.5 Ambient effects and sound

| Effect or sound | Where | Id |
|---|---|---|
| zone music, light version in the pause and the map | in play | `07-audio/music/music.md`, `music.zone5` (approved) |
| the air of the walls (loop) | in play, under the music | `sfx.amb.zone5` (`07-audio/sfx/sfx.md`) |
| fire on a merlon / a merlon breaks | the merlons | `sfx.zone5.merlonHit`, `sfx.zone5.merlonBreak` |
| falling into the chasm | a gap | `sfx.zone5.fall` |
| boss doors | boss room | `sfx.bossDoor.seal`, `sfx.bossDoor.open` |
| the Dragon's calm and fight | boss room | `music.dragon.calm`, `music.dragon.fight` (approved) |

**The wind** (proposal Z55, operator 2026-10-07): **smooth, never in gusts that come and go**: its strength rises and falls
slowly (two slow waves, 9 and 23 s; from 10 % to 85 %, changing at most ≈ 0.35 a second), toward one side per room (by the
seed); the embers, the ash and the banners lean with it. **Only ambience: it never moves Akeris**, on the ground or in the
air, and **it has no sound of its own**: the zone's music carries the wind. None in the towers or the boss room (there,
the Dragon's wings).

**The sound of the place** (proposal Z59): **the music's wind**: the walls' loop keeps only a very low steady breath, the
embers crackling far below and the deep fire's rumble (0.16); **no gust sounds** (operator, 2026-10-07: «quita el viento y
ya ya que la música tiene ese sonido incorporado»). No echo, no reverberation, no noise mechanic. The spirits of zone 5 speak at **0.88** (warning) and **1.06** (lore) (`07-audio/voice/voice.md`).

## A.6 Enemies and boss

| Enemy | Contract |
|---|---|
| Drakeling | `03-characters/enemies/zone-5/drakeling/contract.md` (step 3.15, approved): one per drakeling room, on a merlon of an open room; never with a gargoyle (`layout.md`, the rooms' plan) |
| Gargoyle | `03-characters/enemies/zone-5/gargoyle/contract.md` (step 3.15, approved): one per gargoyle room, on a pedestal; real (in profile) or decorative (from the front); never with drakelings (`layout.md`, the rooms' plan) |
| Elite Shield Knight | `03-characters/enemies/zone-5/elite-shield-knight/contract.md` (step 3.15, to come) |
| Fire Mace Brute | `03-characters/enemies/zone-5/fire-mace-brute/contract.md` (step 3.15, to come) |
| **boss:** the Dragon | `03-characters/bosses/dragon/contract.md` (step 3.15, to come); its room is [`boss-room.md`](boss-room.md) |

Until they are made, the dummy and the enemies of zones 1–3 stay selectable as stand-ins (*Enemigo*); the zone 4 enemies
live in their templates' rooms, so none appear here; the boss room has a Dragon stand-in (asleep on its tower; standing in
the fight; «Dragón (sustituto): vencido» opens the doors).

## A.7 Proposals for the operator (Z51–Z53, Z55, Z59, Z60; layout, hazards and the boss room have the rest)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z51 | Colours | the dungeon's stone, soot, the embers of fire, the torchlight glow; banners of `parchmentDark` with the three hollows; **no new colour** |
| Z52 | Darkness | 45 % on the wall walk and the breach, 72 % in the tower; braziers 450 su, Akeris's eye 300 su; never flickering |
| Z53 | Embers and ash | rising embers and falling ash, atmosphere only; they lean with the wind |
| Z55 | The wind (operator, 2026-10-07: «el viento no debería de arrastrar a akeris»; «debería de sentirse más smooth») | rises and falls slowly, no gusts; ambience only: never moves Akeris; no sound of its own (the music has it) |
| Z59 | Sound of the place | the music carries the wind; the loop keeps a very low breath, embers and the deep rumble (0.16); no gust sounds; no echo, no reverberation; spirits at 0.88 and 1.06 |
| Z60 | The one who watches (operator, 2026-10-07: «deberías poder ver su silueta en algunas partes que sean poco perceptible») | a far silhouette on the pale far wall of some rooms; **changed** (operator, 2026-10-07: «que en algunas partes del fondo de la escena a lo lejos se vea la estela magullada que tiene el akeris del futuro pero que no se note tanto»): only his battered red streak, gliding slowly in the far background, in 70 % of the possible places (at least 3 a zone, by the seed); at 700 su it fades in 1.2 s and is gone for the run ; **changed again** (operator, 2026-10-08: he could not be seen — the darkness covered him): the silhouette back, behind the merlons, with a warm rim; the eye and streak drawn above the darkness; the head follows Akeris; at 650 su he ducks |

## A.8 Never

- Outlined tiles, or a floor edge drawn so rough it hides where the feet go.
- A gap that cannot be seen: its broken edges and its darkness always show it.
- Embers or ash that hurt, or that hide where the floor or a gap is.
- Anything that trembles: embers, ash, banners and flames move; strokes and light never change.
- Sky: the roof is the cavern's rock.
- A flickering light; a brazier that falls.
- A wind that moves Akeris, that comes and goes in gusts, or that sounds apart from the music.
- The one who watches up close, moving toward Akeris, or speaking: he is only seen far off (the outro is his: changed by the operator 2026-10-14, he stands behind Akeris in the Dragon room).
- A colour not in `palette.md`.

## Acceptance

1. The layers of A.2 appear in order at their parallax; the far tiles repeat with no seam; tower rooms hide the far layers behind their wall.
2. The darkness is 45 % on wall walk and breach rooms and 72 % in tower rooms; each light opens its hole.
3. Embers rise and ash falls in every open room; none hurts; they lean with the wind, which never changes suddenly.
4. The one who watches stands behind the far merlons of most rooms with a far wall: a dark figure with a thin rim, his red eye and streak glowing above the darkness, his head following Akeris; within 650 su he ducks out of sight and does not come back in the run (`vigia.png`).
5. The camera keeps Akeris at 60 % of the view height.
