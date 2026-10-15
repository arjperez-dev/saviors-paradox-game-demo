# Map and minimap

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: M in the items hall; the minimap is in
  the HUD) · **Images:** [`map.png`](map.png) (the map over the paused game at 1920×1080) and
  [`minimap.png`](minimap.png) (the minimap alone, transparent, at the 1080 scale)
- **Sources:** `VISION.md` §Mechanics (Map, Boss rooms, Spirits), §Session shape (Saving) ·
  `00-game/controls.md` §4 (M, G10, G11) · `00-game/glossary.md` (map, minimap, room, boss room) ·
  `01-story/characters.md` (the two spirits of each zone) · `01-story/dialogue/rules.md` (heard in full) ·
  `05-items/items.md` §2 (altars) · `06-ui/hud/hud.md` · `06-ui/pause-menu/pause-menu.md` (the sheet) ·
  `02-art-direction/ART_DIRECTION.md` (static stroke) · `02-art-direction/palette/palette.md`
- **Asked by the operator (2026-09-30):** the map is **revealed as Akeris passes** (what he has had near
  him, cell by cell); it is a **sketch of rooms** in pencil; besides the rooms and Akeris it marks the
  **altars**, the **spirits**, the **boss door and the way down**, and the **passages not explored yet**.

## 1. Purpose

Where Akeris is in the zone, what he has seen of it and what is left: the altars still holding something,
the spirits with something new to say, the passages he has not taken, and the way to the boss. The
minimap answers the same at a glance while he plays; the map (M) is the whole zone, with the game
stopped.

## 2. When it shows

| Piece | Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|---|
| minimap | with the HUD (`hud.md` §2) | with the HUD | no | the game, top right |
| map | M while playing (`VISION.md`) | M or Esc (G11) | **yes**: nothing moves, no timer runs | the game, frozen, under an ink wash; **the HUD is hidden** |

The map does not open during death, a zone change, a dialogue, a cinematic or the pause menu; the pause
menu does not open while the map is open (Esc closes the map instead).

## 3. Layout

A 1920×1080 reference frame (**hu**), scaled by `screen height ÷ 1080`, as the HUD. Zone distances are in
**su** (`02-art-direction/ART_DIRECTION.md` §3); the game multiplies them by its *k*. Numbers are what
the sandbox draws (`MZ`, `MM`, `MAP_L` and `MAP_LV` in `sandbox.html`).

### 3.1 The map (M)

The same sheet as the pause menu, centred; on wider screens only the wash grows.

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| wash | whole screen | — | `vignette` ink (`rgba(14,11,9,.62)`) over the frozen game | — |
| sheet | centre | x 120–1800, y 60–1020 | the pause menu's sheet (`pause-menu.md` §3) with one rule under the header (y 167) and one over the legend (y 903) | — |
| zone name | sheet, top left | (170, 116), 64 px | `Suspended Sanctuary` | zone |
| zone number | sheet, top right | right edge 22 left of the close button, y 120, 32 px | `Zone 1` | zone |
| close button | sheet, top right | a button 56 tall with an `Esc` key cap, right edge 1750, y 92–148 (U28) | `Close` | — |
| view | sheet | x 170–1750, y 190–880 (1580 × 690), a faint pencil frame | the zone as a sketch of rooms (§3.3), only where revealed (§4), with its marks (§3.4) | zone layout, revealed cells, marks |
| zoom marks | view, bottom right | three dots of 5, 18 apart, centre y 860 | filled up to the current level | zoom level |
| legend | sheet, bottom | one row at y 936 from x 186: each mark at 28 hu and its name 28 px, 34 apart | the eight marks of §3.4 | — |
| hint | sheet, bottom right | right edge 1750, y 990, 24 px | `W A S D or arrows, or drag · wheel or Q / E zoom · Enter: Akeris · M or Esc close` | — |

**Zoom levels** (U20): **zone** (the whole zone fits the view; 0.062 hu per su for the sandbox's zone),
**near** (0.14 hu/su; the map opens here, centred on Akeris), **close** (0.28 hu/su). The view never
leaves the zone: when the zone is narrower or shorter than the view, it is centred.

### 3.2 The minimap (HUD, top right)

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| disc | top-right | centre (W − 152, 152), radius **110**; a thin outer ring at 116, as the portrait's | paper (`paper` at .93): what is not revealed stays blank | — |
| map | the disc | **0.09 hu per su**, Akeris always in the centre, north up (never turns) | the same sketch and marks as the map, at 0.75 size; whatever falls outside the disc is cut | revealed cells, marks |
| map key | the disc, bottom left | a 32 box at 135° from the centre, 0.72 radius in | the key cap `M` | — |

W is the screen's width in hu. The minimap belongs to the HUD: it hides when the HUD hides, and it fades
to 30 % when Akeris passes behind it (`hud.md` U5). The HUD's top-left and bottom-left groups do not move.

### 3.3 The sketch

| Part | How it is drawn | Palette |
|---|---|---|
| rock | everything revealed that is not a room: stone grey with graphite hatching at 7 hu | `stone` (minus 22), `graphite` |
| room | its inside in light paper; its walls in ink, 2 hu; its floor thicker, 3.2 hu. The sandbox's rooms are rectangles; the zone's generator (step 3.9) gives each room's outline, and the map draws that outline | `paperLight`, `ink` |
| door | a gap in the wall the size of the opening, with a short ink jamb at each end | `paperLight`, `ink` |
| platforms | a short ink line, 2.8 hu: ledges, drifting platforms, a boss room's hanging slabs (with their chains dashed up to the ceiling) | `ink` |
| chasm | no floor line; the bottom of the room darkens into the pit with dense hatching | `pit` |
| the boss door, sealed | three bars across the opening and a line down it, until the boss dies | `ink` |
| unrevealed | nothing: the sheet's paper | — |

### 3.4 The marks

Drawn by hand like everything else, each with its seed, at 1× on the map's near level (0.75× zone,
1.25× close) and 0.75× on the minimap. A mark shows only when its place is revealed.

| Mark | Drawing (at 1×) | States | Data source |
|---|---|---|---|
| **Akeris** | his paper head (radius 10, ink 2.6) with the black almond eye on the side he faces, and his **streak** trailing behind, about 32 long, waving as in the game (purple for Corrupted Akeris, defective for Future Akeris, as the HUD; 1.5× wider during rage) | where he is and which way he faces. On the map, if panned off the view, he waits at the view's edge at 55 % | position, facing |
| **altar** | a stone slab 22 × 8; on it, the object as a paper diamond, with its two candles lit | **holds something**: diamond and candles lit · **taken**: the slab alone, faded, **struck through** | altars (`05-items/items.md` §2) |
| **spirit** | a paper wisp: a round head with two ink eyes and a tail | **something new to say**: `…` over the head · **heard in full**: drawn at 45 %, no `…` | spirits, heard (`01-story/dialogue/rules.md`) |
| **boss door** | an iron padlock on two crossed chains, on the boss room's door | **sealed** · **open**: the shackle sprung, no chains (the boss is dead) | boss state |
| **way down** | a dark arch with a pale arrow pointing down | — (it shows once its place is revealed) | the zone's exit |
| **not explored** | a dashed arrow, 26 long, from a door into the blank side | a door with one side revealed and the other not; it disappears when the other side is revealed | doors, revealed cells |

The marks never say what an altar holds or what a spirit will say: the map says *where*, the world says
*what* (U22).

## 4. How it is revealed

- The zone is divided into **cells of 100 su**. A cell is revealed when its centre is within
  **700 su** of Akeris's body (about what the camera shows) **and** inside the room he is in, or in the
  **160 su** band of that room's walls. The band shows walls and rock, **never the inside of another
  room**: a room is seen only from within it. A door therefore shows its far side as a *not explored*
  arrow until Akeris goes through.
- Cells are checked 10 times a second (sandbox: `MZ.every`); a cell, once revealed, stays revealed for
  the rest of the zone.
- The edge between revealed and blank is soft, as if smudged by a finger: the sandbox draws the revealed
  cells into a mask of 4 px per cell, a disc of 0.9 cell per cell, and scales it up smoothly. It grows
  as Akeris walks; it never moves or flickers.
- **What is kept:** the revealed cells of the current zone are part of the run: saved with it in its slot
  (`VISION.md` §Saving: "keeping the position in the zone map") and lost with it on death. Entering the
  next zone starts a blank map (its layout is new).

## 5. Navigation

| Input (as `VISION.md` and `controls.md` name it) | Effect |
|---|---|
| M (playing) | opens the map, at the near level, centred on Akeris |
| M or Esc (map open), or a click on *Close* | closes it (G11); Esc does not open the pause menu |
| W / A / S / D or the arrows (held) | move the view, 760 hu per second (U19) |
| mouse: drag with the left button | moves the view with the paper |
| mouse wheel | zoom in or out one level, keeping the point under the pointer still |
| Q / E | zoom out / in one level (U21) |
| Enter | centres the view on Akeris again |
| everything else (attack, block, the wheel's weapon swap, 1–5, F, G, H, R) | nothing while the map is open |

The minimap takes no input.

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `zone.suspendedSanctuary.name` | Suspended Sanctuary | Santuario Suspendido | map title | 26 |
| `zone.echoCaverns.name` | Echo Caverns | Cavernas del Eco | map title | 26 |
| `zone.sunkenGraveyard.name` | Sunken Graveyard | Cementerio Hundido | map title | 26 |
| `zone.rottingCanopy.name` | Rotting Canopy | Dosel Podrido | map title | 26 |
| `zone.dragonBattlements.name` | Dragon Battlements | Almenas del Dragón | map title | 26 |
| `ui.map.zone` | Zone {n} | Zona {n} | map, top right | 10 |
| `ui.map.close` | Close | Cerrar | map, top right, beside the `Esc` key cap | 12 |
| `ui.map.legend.akeris` | Akeris | Akeris | legend | 14 |
| `ui.map.legend.altar` | Altar | Altar | legend | 14 |
| `ui.map.legend.altarEmpty` | Taken | Tomado | legend | 14 |
| `ui.map.legend.spirit` | Spirit | Espíritu | legend | 14 |
| `ui.map.legend.spiritHeard` | Heard | Escuchado | legend | 14 |
| `ui.map.legend.unknown` | Unexplored | Sin explorar | legend | 14 |
| `ui.map.legend.boss` | Boss | Jefe | legend | 14 |
| `ui.map.legend.exit` | Way down | Bajada | legend | 14 |
| `ui.map.hint` | W A S D or arrows, or drag · wheel or Q / E zoom · Enter: Akeris · M or Esc close | W A S D o flechas, o arrastra · rueda o Q / E acercan · Enter: Akeris · M o Esc cierran | map, bottom right | 96 |

The zone names come from `00-game/glossary.md` §6. The key cap `M` on the minimap is the key, not a text.

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed; `07-audio/` fixes them in step 3.8) |
|---|---|---|---|
| map opens | the wash and the sheet fade in; the sheet settles 14 hu | 0.18 | `sfx.ui.mapOpen` (a sheet of paper unfolded) |
| map closes | gone at once | — | `sfx.ui.mapClose` |
| zoom | the level changes at once | — | `sfx.ui.move` |
| pan | follows the keys or the mouse | — | — |
| revealing | the blank recedes as the cells are revealed; nothing is redrawn | 0.1 a check | — |
| Akeris's streak | waves as in the game; on the map it waits, because the game's clock is stopped | — | — |
| minimap | moves with Akeris; fades to 30 % behind him (6/s) | — | — |

Nothing trembles: every wall, door, hatch line and mark has its seed and is fixed **to the zone**, not to
the screen, so panning and the minimap slide the drawing without redrawing it. No pulse, no blink: a
spirit with something new shows `…`, it does not flash.

## 8. Never

- The map never shows a room Akeris has not been in, nor its inside through a wall or a door.
- No mark for something not seen: no enemies, no hidden altars, no spirits beyond what was revealed.
- The map never says what an altar holds or what is behind a door.
- The minimap never turns with Akeris and never takes input.
- The game never runs behind the map: no damage, no timers, no enemy moves while it is open.
- No colour outside `palette.md`; red is only Akeris's streak. No hard-coded text.
- No fast travel and no player pins in the demo (not in `VISION.md`).

## 9. Acceptance

1. At 1920×1080 the map matches `map.png` and the minimap `minimap.png`, element by element, within 2 hu;
   on wider screens the sheet stays centred and the minimap keeps its distance to the top-right corner.
2. M opens the map at the near level centred on Akeris and pauses everything (the dummy, cooldowns,
   rage, the curse); M or Esc closes it and the game resumes exactly where it was. Esc with the map open
   never opens the pause menu.
3. A new zone shows only what Akeris has had within 700 su, inside his room and its wall band
   (`captures/mapaInicio.png`); walking reveals more, and it never shrinks.
4. The inside of a room is never revealed from another room; a door with its far side unseen shows the
   *not explored* arrow (`map.png`: the cellar below the corridor, the room above the gallery), which
   disappears once the far side is revealed.
5. An altar holding something shows its diamond and lit candles; a taken one is faded and struck through;
   a spirit with something new shows `…`, one heard in full is faint (`captures/mapaZona.png`).
6. The boss door shows the padlock on its chains and bars until the boss dies, then the open padlock;
   the way down shows once revealed (`captures/mapaJefe.png`).
7. W/A/S/D, the arrows and a drag move the view without leaving the zone; the wheel and Q/E change the
   level (`captures/mapaCerca.png`: close); Enter centres on Akeris.
8. The minimap keeps Akeris in its centre, north up, with the same marks at 0.75 size; it fades to 30 %
   when he passes behind it (`captures/minimapa.png`, `captures/minimapaPuerta.png`: the shaft's door,
   not explored).
9. Saving keeps the revealed cells; death and a new zone start a blank map.

## 10. Proposals for the operator

Decided before drafting (operator, 2026-09-30): revealed as Akeris passes; a sketch of rooms; altars,
spirits, the boss door and the way down, and passages not explored. **All approved by the operator on
2026-09-30** (U18–U27), as the sandbox does them; U21 is recorded as G21 in `00-game/controls.md` §5, marked (D).

| # | Question | Proposal |
|---|---|---|
| U18 | How much does Akeris reveal? | Cells of 100 su within **700 su** of him (about the camera's view), only in the room he is in plus the 160 su band of its walls; the far side of a door stays blank until he goes through |
| U19 | How is the map moved? | W/A/S/D or the arrows (held), or dragging with the mouse; it never leaves the zone |
| U20 | How many zoom levels? | Three: the **whole zone**, **near** (it opens here, on Akeris) and **close** |
| U21 | Which keys zoom? | The mouse wheel, and **Q / E** (free while the map is open; the left hand stays on W A S D). Recorded as G21 in `controls.md`, (D) |
| U22 | Do the marks say *what*? | No: an altar shows that it holds something, not what; a spirit shows that it has something new. The world tells the rest |
| U23 | Where is the minimap and how big? | Top right, a disc of radius 110 hu at 0.09 hu per su (about 1,200 su around Akeris), north up, with the `M` key cap; it fades behind Akeris like the HUD's groups |
| U24 | Does the minimap rotate or zoom? | Neither: always north up, one scale |
| U28 | Can the map be closed with the mouse? | **Yes** (operator, 2026-10-15): a *Close* button with an `Esc` key cap at the top right, the same button as the pause menu's *Resume*; clicking it is pressing Esc. `map.png` and the map captures are exported again from the sandbox when the map is built |
| U25 | Is the map kept across deaths or zones? | No: it is part of the run (saved in its slot); death wipes it and every new zone starts blank, because its layout is new |
| U26 | What happens to the map when the boss dies? | The padlock opens and the bars go; nothing else changes |
| U27 | Is there a title card, a legend? | The zone's name and number at the top, and a legend of the eight marks at the bottom, always shown |

The sandbox's zone (eleven rooms around the items hall: entrance, corridor, cellar, the hall, a shaft, a
gallery, the story spirit's room, a chasm with drifting platforms, the warning spirit's antechamber, the
boss room with hanging slabs, and the way down) is a **stand-in** so the map has something to show. The
zone 1 layout, its size and how it is generated are designed in step 3.9 (`04-zones/zone-1-suspended-sanctuary/layout.md`);
the map draws whatever rooms and doors it produces.
