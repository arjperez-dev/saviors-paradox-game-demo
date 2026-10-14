# Title screen

- **Status:** approved 2026-09-30 · §1, §2 and *New game* changed by the operator 2026-10-13 (the intro ends in
  Akeris running up to the mouth; *New game* plays the descent)
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: I, or the «Pantalla de inicio» button;
  «Ranuras» switches the stand-in slots) · **Image:** [`title.png`](title.png) (1920×1080)
- **Sources:** `VISION.md` §Mechanics (Coins: the locked shop), §Session shape (Saving), §Client constraints
  (settings on the home screen), §Non-goals (shop), §Assumptions (the list of screens) ·
  `01-story/cinematics/intro.md` (shot 10, «When it plays», S5) · `01-story/cinematics/outro.md` (S6) · `00-game/controls.md` §4 (G10) ·
  `06-ui/save-slots/save-slots.md` · `06-ui/settings/settings.md` · `06-ui/pause-menu/pause-menu.md` (the sheet)

## 1. Purpose

Where the game starts and where every run ends up: start a new run, go on with the last one, load another,
change the settings or leave. It is the last shot of the intro held still: the mouth of the dungeon,
Akeris before it and the title over it. **The intro plays when the game opens and ends here:** Akeris runs in
from the left and stops where this screen shows him, the title writes itself and the options fade in
(changed by the operator 2026-10-13). **New game plays the descent:** from where he stands Akeris walks into the arch
and down the stair into the dark (about 4 s, `music.descent`), then zone 1; *Continue* and *Load* skip it.

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| the game starts: at the end of the intro (its run-in, `intro.md` shot 10), or when it is skipped (from black, 0.4 s); *Quit to title* in the pause menu (after the autosave and the loading screen, `06-ui/loading/`); *Title screen* on the death screen; the end of the outro | a run starts (New game, Continue, Load) or the game is left (Exit) | there is no run behind it | nothing: it fills the screen |

## 3. Layout

A 1920×1080 frame (**hu**) scaled by `screen height ÷ 1080`; on wider screens the scene grows at both
sides and everything else keeps its place. Numbers are what the sandbox draws (`TS` in `sandbox.html`).

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| scene | whole screen | ground line at y 900 | paper, a darker sky at the top and a soft vignette; far hills and towers in graphite (intro, shot 6); a hillside with **the broken arch** centred at x 1400 (opening 330 wide, springing at y 560): the left pillar whole, the right one broken, the ring fallen on the right, its stones on the ground; under the arch, **a stair goes down to the right into the dark**, its steps fading out | — |
| Akeris | scene | standing at x 960 on the ground, 1.5× the game's size, facing the arch | drawn as the game draws him, **alive**: breathes, his cape sways and his streak waves (the game's idle). The sacred sword in hand and the sacred shield; the Savior's red streak | — |
| title | over the arch | centred at (1400, 196), 128 px, two pencil rules under it | `Savior's Paradox`, in ink with a faint second pass; the same in both languages (`intro.md`) | — |
| options | left column | buttons 470 × 64 from (170, 372), 16 apart | `New game`, `Continue`, `Load`, `Settings`, `Shop`, `Exit`. *Continue* shows, right-aligned, where it goes: `Zone 1 · Slot 2`. *Shop* shows a padlock and `Locked` | the saved runs |
| note | under the column | (174, 868), 26 px | only for a button that cannot be used: why (§4) | — |
| hint | bottom right | right edge 1750, y 1012, 24 px | `W S or arrows · Enter choose` | — |
| exit question | centre | as the pause menu's: box (560, 380) 800 × 290, buttons (640, 572) and (980, 572) | `Leave the game?` · `Your runs stay saved.` · `Leave` / `Stay`, focus on `Stay` | — |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| opening | fades in from black | 0.6 s |
| focused | the button takes the thick ink frame with an inner line | keyboard focus; on opening, *Continue* if there is a run to continue, else *New game* |
| hovered | the button's paper brightens; the focus does not move | the mouse over it |
| no run to continue | *Continue* is faint; focused, the note says `There is no run to continue.` | no slot holds a run that is not won |
| nothing saved | *Load* is faint; focused, the note says `There are no saved runs.` | the three slots are empty |
| shop | always faint, with the padlock and `Locked`; focused, the note says `The shop does not open in the demo.` | `VISION.md` §Non-goals |
| denied | the frame flashes; nothing happens | Enter or a click on a faint button (0.35 s) |
| sheet open | the scene stays behind a wash; the save slots or the settings sheet on top | Load, New game with the three slots full, Settings |
| exit asked | the question over a darker wash; only its two buttons answer | Exit |
| leaving | fade to black, then the loading screen and the run (`06-ui/loading/`), or the descent for a new game, or the game closes | a run chosen, or *Leave* (0.4 s) |

## 5. Navigation and actions

| Input (as `controls.md` names it) | Effect |
|---|---|
| W / S or the up / down arrows | move the focus along the column (G10) |
| Enter (or a click) | does the focused button |
| Esc | closes the exit question; on the title itself, nothing |
| mouse: point | hover only |

| Button | Does |
|---|---|
| New game | a new run in **the first empty slot**: the descent (the options fade out; Akeris walks into the arch and down the stair into the dark, about 4 s, `music.descent`), then zone 1 (`intro.md` «When it plays»; changed by the operator 2026-10-13). If the three slots are full, opens the save slots to choose one to overwrite (`save-slots.md`) |
| Continue | opens **the last run played** without asking: the run whose save is the most recent, won runs left out |
| Load | opens the save slots (`save-slots.md`) |
| Settings | opens the settings (`settings.md`) |
| Shop | nothing: locked (`VISION.md`) |
| Exit | asks; `Leave` closes the game (the runs are already saved), `Stay` closes the question |

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.title.logo` | Savior's Paradox | Savior's Paradox | title (the logo; not translated) | — |
| `ui.title.newGame` | New game | Nueva partida | button | 20 |
| `ui.title.continue` | Continue | Continuar | button | 20 |
| `ui.title.continueWhere` | Zone {zone} · Slot {slot} | Zona {zone} · Ranura {slot} | inside *Continue*, right | 22 |
| `ui.title.load` | Load | Cargar | button | 20 |
| `ui.title.settings` | Settings | Ajustes | button | 20 |
| `ui.title.shop` | Shop | Tienda | button | 20 |
| `ui.title.locked` | Locked | Bloqueada | inside *Shop*, right | 12 |
| `ui.title.exit` | Exit | Salir | button | 20 |
| `ui.title.noRun` | There is no run to continue. | No hay ninguna partida que continuar. | note | 50 |
| `ui.title.noSaves` | There are no saved runs. | No hay partidas guardadas. | note | 50 |
| `ui.title.shopNote` | The shop does not open in the demo. | La tienda no abre en la demo. | note | 50 |
| `ui.title.exitAsk` | Leave the game? | ¿Salir del juego? | exit question | 34 |
| `ui.title.exitNote` | Your runs stay saved. | Tus partidas siguen guardadas. | exit question | 40 |
| `ui.title.exitYes` | Leave | Salir | exit question | 12 |
| `ui.title.exitNo` | Stay | Seguir | exit question | 12 |
| `ui.title.hint` | W S or arrows · Enter choose | W S o flechas · Enter elegir | hint | 40 |

Zone numbers are digits; the slot number is 1–3.

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed; `07-audio/` fixes them in step 3.8) |
|---|---|---|---|
| open | from black | 0.6 | `music.title` starts, soft (`VISION.md`: menu track soft) |
| Akeris | breathes, the cape sways, the streak waves | continuous | — |
| focus moves | the frame jumps | — | `sfx.ui.move` |
| choose | — | — | `sfx.ui.confirm` |
| denied | the frame flashes | 0.35 | `sfx.ui.denied` |
| a run starts | fade to black; the title music fades with it | 0.4 | — |

Nothing trembles: the scene is drawn once per screen size and never redrawn differently; only Akeris
moves, as he does standing still in the game.

## 8. Never

- Never a run behind the title: nothing of a run moves or counts while it shows.
- *Continue* never asks which run, and never opens a won run.
- The shop never opens and never shows its contents (`VISION.md` §Non-goals).
- No settings other than music volume, sound-effect volume and language (`VISION.md` §Non-goals).
- The logo is not translated and is not drawn with a font other than the game's hand.
- No colour outside `palette.md`: the only colour is Akeris's red streak.

## 9. Acceptance

1. At 1920×1080 the layout matches `title.png` within 2 hu; on wider screens the scene grows at the sides
   and nothing moves.
2. With runs saved, the focus starts on *Continue*, which shows the zone and slot of the most recent run
   that is not won; Enter starts it at once (`title.png`).
3. With nothing saved, *Continue* and *Load* are faint, the focus starts on *New game*, and Enter on a
   faint button only flashes it (`captures/inicioVacio.png`).
4. *Shop* is always faint with a padlock and `Locked`; focused, the note explains (`captures/inicioTienda.png`).
5. *New game* starts in the first empty slot; with the three full it opens the slots to overwrite one.
6. *Exit* asks with the focus on `Stay` (`captures/inicioSalir.png`); Esc closes the question.
7. Esc on the title does nothing; W/S and the arrows move the focus; the mouse hovers and clicks.
8. Akeris breathes, his cape sways and his streak waves; nothing else moves.

## 10. Proposals for the operator

**All approved by the operator on 2026-09-30** (U37–U42), as the sandbox does them.

**Decided by the operator before drafting (2026-09-30):** the mouth of the dungeon behind the title (the
last shot of the intro) with the options in a column; *Continue* opens the last run without asking;
*Load* opens the three slots; *New game* goes to the first empty slot and, with the three full, asks
which to overwrite.

| # | Question | Proposal |
|---|---|---|
| U37 | Which run is "the last"? | The one saved most recently that is not won (a load counts as playing it). *Continue* says where it goes: `Zone 1 · Slot 2` |
| U38 | What do unusable buttons do? | Stay in the column, faint and focusable, with a note saying why; Enter only flashes them. The shop is always so, with a padlock |
| U39 | Does Exit ask? | Yes, with the focus on `Stay`, as *Quit to title* does. The runs are always saved, so it never warns of a loss |
| U40 | And Esc on the title? | Nothing: there is nowhere to go back to (it never opens the exit question) |
| U41 | How does the title start? | From black in 0.6 s, with `music.title`; a chosen run fades to black in 0.4 s |
| U42 | Is Akeris still? | Alive, as in the pause menu: breath, cape and streak, with the sword and the sacred shield; the same drawing every time, whatever the saved runs carry |
