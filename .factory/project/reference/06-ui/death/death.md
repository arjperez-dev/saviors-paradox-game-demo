# Death screen

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: U, «Morir», or two hits from the
  dummy at low health) · **Image:** [`death.png`](death.png) (1920×1080)
- **Sources:** `VISION.md` §Core loop, §Win / lose conditions (Lose), §Session shape (Saving: death wipes
  the slot), §Mechanics (Coins) · `03-characters/akeris/animations.md` §5.8 (death) ·
  `02-art-direction/fx/ink-smoke/ink-smoke.md` · `01-story/cinematics/intro.md` (S5) ·
  `05-items/scrolls/scrolls.md` (the curse) · `06-ui/pause-menu/pause-menu.md` (the sheet) · `06-ui/title/title.md`

## 1. Purpose

The run is over and the player sees what it came to: how far Akeris got, how many he defeated, how long
it lasted and what was lost. Then a new run in the same slot, or the title.

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| Akeris's death (health at zero, or damage during the curse: `VISION.md` §Lose), **when his ink smoke has gone**: 0.35 s before the death animation ends (`animations.md` §5.8, ≈ 3.25 s after the blow) | *New game* or *Title screen* | **yes**: the world stays as he left it, with nothing of him | the game, frozen, under an ink wash; **the HUD is hidden** |

When it opens **the slot is wiped** (`VISION.md`): the save holds nothing of this run any more. The run's
summary is counted at the moment of death.

## 3. Layout

1920×1080 frame (**hu**), the sheet centred; numbers as the sandbox draws them (`DSL`).

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| wash | whole screen | — | `vignette` ink over the frozen game | — |
| sheet | centre | x 560–1360, y 150–940 | the pause menu's paper sheet | — |
| title | sheet, top | centred at (960, 236), 60 px | `The run is over` | — |
| cause | under the title | centred, y 290, 28 px | only for a curse death: `The curse took you.` | cause |
| rows | sheet | five rows from y 386, 60 apart; icon at x 646, name at x 680, value right-aligned at x 1290, 32 px; faint rules between | zone reached (a door) `1 · Suspended Sanctuary`; enemies defeated (an ink cross) `23`; time (an hourglass) `42 min`; experience lost (the mote) `2350`; coins lost (the coin) `14` | the run at death |
| wiped | sheet | centred, y 740, 28 px, and under it y 778, 26 px | `Slot 2 is wiped.` · `The next run starts at zone 1, on a new path.` | slot |
| buttons | sheet, bottom | two 330 × 64 at (620, 830) and (970, 830) | `New game` (focus) and `Title screen` | — |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| opening | the wash and the sheet fade in and the sheet settles 14 hu | 0.6 s |
| waiting | nothing can be chosen yet: a held key or a click from the fight does nothing | the first 0.6 s |
| focused | the button takes the thick ink frame; on opening, *New game* | keyboard focus |
| hovered | the button's paper brightens | the mouse over it |
| curse | the cause line shows | the curse killed him (`scrolls.md`) |

## 5. Navigation and actions

| Input | Effect |
|---|---|
| A / D, W / S or the arrows | move the focus between the two buttons |
| Enter (or a click) | does the focused button |
| Esc, M, H, Q / E / R, F… | nothing |

| Button | Does |
|---|---|
| New game | a new run **in the same slot**: zone 1 on a new layout, straight away, **without the intro** (S5); Akeris with the sacred sword, the chain blades and the sacred shield, nothing else |
| Title screen | the title; the slot shows as empty, and *Continue* goes to another run if one is left (`title.md` U37) |

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.death.title` | The run is over | La partida ha terminado | title | 26 |
| `ui.death.curse` | The curse took you. | La maldición te ha llevado. | cause | 40 |
| `ui.death.zone` | Zone reached | Zona alcanzada | row | 20 |
| `ui.death.kills` | Enemies defeated | Enemigos vencidos | row | 20 |
| `ui.death.time` | Time | Tiempo | row | 20 |
| `ui.death.xp` | Experience lost | Experiencia perdida | row | 20 |
| `ui.death.coins` | Coins lost | Monedas perdidas | row | 20 |
| `ui.death.wiped` | Slot {n} is wiped. | La ranura {n} se ha borrado. | under the rows | 34 |
| `ui.death.again` | The next run starts at zone 1, on a new path. | La próxima empieza en la zona 1, por otro camino. | under the rows | 56 |
| `ui.death.newGame` | New game | Nueva partida | button | 18 |
| `ui.death.toTitle` | Title screen | Pantalla de inicio | button | 18 |

The zone row's value is `{n} · ` and `zone.<id>.name`; the time uses `ui.time.hm` and `ui.time.m`
(`save-slots.md` §6). `ui.hud.death` (`hud.md`) still shows during the death animation, before the sheet.

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed) |
|---|---|---|---|
| death | Akeris's death and ink smoke (`animations.md` §5.8); the zone music fades out | ≈ 3.25 | the game's |
| open | wash and sheet fade in, the sheet settles | 0.6 | `sfx.ui.runOver`: a single low note; no music |
| focus moves | the frame jumps | — | `sfx.ui.move` |
| choose | the loading screen (`06-ui/loading/`), then zone 1 or the title | ≥ 1.8 | `sfx.ui.confirm` |

Nothing trembles; the world behind is frozen, and nothing of Akeris is left in it.

## 8. Never

- No way to keep anything of the run: no "continue", no revive, no reload of the wiped slot.
- No intro after a death (S5).
- Nothing chosen in the first 0.6 s.
- No numbers the run did not have; experience and coins are what he carried at death.
- No skull, no blood, no red: the screen stays in ink and paper (`00-game/tone.md`).

## 9. Acceptance

1. At 1920×1080 the layout matches `death.png` within 2 hu: the hall frozen, Akeris gone, the sheet with
   the five rows, `Slot 2 is wiped.` and the focus on *New game*.
2. The sheet opens when the ink smoke has gone, never during the fall; the HUD is hidden behind it.
3. When it opens, the slot is empty on the title and in the save slots.
4. A death by the curse adds `The curse took you.` (`captures/muerteMaldicion.png`).
5. *New game* starts zone 1 in the same slot without the intro; *Title screen* opens the title.
6. Keys and clicks in the first 0.6 s do nothing; Esc, M and H never open anything.
7. English fits (`captures/muerteEn.png`).

## 10. Proposals for the operator

**All approved by the operator on 2026-09-30** (U52–U55), as the sandbox does them.

**Decided by the operator before drafting (2026-09-30):** a sheet with the summary (zone reached, enemies
defeated, time, XP and coins lost, the slot wiped) with *New game* in the same slot and *Title screen*.

| # | Question | Proposal |
|---|---|---|
| U52 | When does it open? | When the ink smoke has gone (0.35 s before the death animation ends), fading in over 0.6 s; nothing is chosen during that time, so a key still held from the fight does not skip it |
| U53 | Where is the focus? | On *New game*: going round again is the game's loop (`VISION.md` §Core loop) |
| U54 | Is the cause shown? | Only for the curse, because it kills at any damage and the player may not see why; a blow needs no line |
| U55 | What counts as "enemies defeated"? | Every enemy dissolved in this run, bosses included; the time is the run's play time (pause, map, dialogue and menus do not count) |
