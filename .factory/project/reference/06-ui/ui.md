# User interface

- **Status:** approved 2026-09-30 (the index; each piece has its own status in `../README.md`)
- **Mock:** [`sandbox/sandbox.html`](sandbox/sandbox.html), one playable sandbox for every screen
- **Sources:** `VISION.md` §Mechanics, §Session shape, §Assumptions (the list of screens) ·
  `_templates/ui.md` · `02-art-direction/ART_DIRECTION.md` · `02-art-direction/palette/palette.md`
- **Read by:** any task that draws a screen, a menu or the HUD; the tester, to find a screen's
  acceptance list.

## 1. The pieces

One folder per screen. Each holds `<piece>.md` (layout, states, navigation, text keys, motion and sound,
never, acceptance, proposals), `<piece>.png` (the screen at 1920×1080) and `captures/` (one PNG per
test scenario of the sandbox). Every PNG is exported from the sandbox, never drawn by hand.

| Piece | Folder | What it is | Export |
|---|---|---|---|
| HUD | [`hud/`](hud/hud.md) | while playing: portrait and health bar, XP and coins, the quick inventory, the minimap | `#exportar-hud` |
| Pause menu | [`pause-menu/`](pause-menu/pause-menu.md) | Esc: Akeris and his numbers, the full inventory, upgrades, save, quit to the title | `#exportar-pausa` |
| Map and minimap | [`map/`](map/map.md) | M: the zone revealed as Akeris passes; the minimap of the HUD | `#exportar-mapa` |
| Dialogue | [`dialogue/`](dialogue/dialogue.md) | H next to a spirit: a sheet at the bottom, each line written by hand | `#exportar-dialogo` |
| Title screen | [`title/`](title/title.md) | the mouth of the dungeon, Akeris and the logo; New game, Continue, Load, Settings, the locked Shop, Exit | `#exportar-pantallas` |
| Save slots | [`save-slots/`](save-slots/save-slots.md) | the three runs on rich cards; load one, or choose one to overwrite | `#exportar-pantallas` |
| Settings | [`settings/`](settings/settings.md) | music volume, sound-effect volume, language | `#exportar-pantallas` |
| Death screen | [`death/`](death/death.md) | after the ink smoke: what the run came to and what was lost; New game or the title | `#exportar-pantallas` |
| Loading screen | [`loading/`](loading/loading.md) | between a run and the title: the hourglass in pencil on black, saving and loading | `#exportar-carga` |

## 2. How the screens connect

```text
start ─► title ──New game──► (save slots, only if all three are full) ─► intro ─► zone 1
           │  ──Continue───► loading ─► the last run played
           │  ──Load───────► save slots ─► loading ─► the chosen run
           │  ──Settings───► settings ─► title
           │  ──Exit
playing ─► HUD; Esc ─► pause menu (Quit to title ─► loading ─► title); M ─► map; H ─► dialogue
death ───► death screen ─► loading ─► New game (same slot) or title
outro ───► title (the slot is kept, marked as won)
```

## 3. What every screen shares

- **Frame.** A 1920×1080 reference frame (**hu**), scaled by `screen height ÷ 1080`; sheets are centred
  and, on wider screens, only the background grows.
- **Look.** Paper sheets with a seeded pencil border, `Patrick Hand` lettering, ink and `paper` from
  the palette. Nothing trembles: every box, rule and letter has its seed.
- **Focus.** The focused box or button takes the thick ink frame with an inner line; the mouse
  brightens what it points at and acts with a click.
- **Keys.** W A S D or the arrows move the focus, Enter chooses, Esc goes back (G10,
  `00-game/controls.md`). Spending or losing something takes two steps or a question with the focus
  on the safe answer.
- **Text.** Every player-visible string is a translator key with its English and Spanish text, listed
  in its piece's §6.
- **Sound.** The ids in each piece are proposals; `07-audio/` fixes them in step 3.8.
