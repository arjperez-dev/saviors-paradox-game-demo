# Save slots

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: I, then *Load*; «Ranuras» switches
  the stand-in slots) · **Image:** [`save-slots.png`](save-slots.png) (1920×1080)
- **Sources:** `VISION.md` §Session shape (Saving), §Content scope (3 save slots), §Win / lose conditions ·
  `00-game/glossary.md` (save slot) · `01-story/cinematics/outro.md` (S6) · `06-ui/title/title.md` ·
  `06-ui/pause-menu/pause-menu.md` (the sheet, the boxes, the level marks, Save) · `05-items/items.md` (icons)

## 1. Purpose

The three runs the game keeps, each on a card rich enough to tell them apart at a glance: who Akeris is
in that run, how far he got, and when it was last played. From here a run is loaded, or a slot is chosen
for a new one.

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| *Load* on the title (**load**); *New game* on the title with the three slots full (**new**) | a run chosen; *Back* or Esc (to the title) | there is no run behind it | the title scene under a wash |

What fills the slots (`VISION.md` §Saving): a manual save from the pause menu, the autosave on quitting
and on entering a boss room. **Death wipes the slot.** A won run is kept, marked as won, and cannot be
continued (S6).

## 3. Layout

1920×1080 frame (**hu**), the sheet centred; numbers as the sandbox draws them (`SL`).

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| wash | whole screen | — | `vignette` ink over the title scene | — |
| sheet | centre | x 260–1660, y 70–1010 | the pause menu's paper sheet | — |
| title | sheet, top left | (310, 134), 60 px | `Load` or `New game` | mode |
| why | sheet, top right | right edge 1610, y 140, 28 px | in **new** mode: `The three slots are full. Choose one to overwrite.` | — |
| cards | sheet | three cards 1320 × 208 from (300, 232), 14 apart | one per slot, in order 1–3 (§3.1) | the slots |
| footer | sheet, bottom | `Back` with an `Esc` key cap at (310, 934); hint right-aligned at 1610, 24 px | `W S or arrows · Enter choose · Esc back`; on a won card in **load** mode the hint gives way to `The Dragon fell in this run. It cannot be continued.` | — |
| overwrite question | centre | as the pause menu's | `Overwrite slot 1?` · `The run saved there is lost.` · `Overwrite` / `Keep`, focus on `Keep` | — |

### 3.1 A card

| Element | Position in the card (hu) | Contents |
|---|---|---|
| slot | (30, 32), 30 px | `Slot 2`; on the last run played (`title.md` U37), `· Last played` beside it |
| saved | right edge −30, y 32, 24 px | `Saved 30 Sep 2026, 21:40` (the date of the last save, in the player's language) |
| portrait | a 140 box at (30, 52) | **Akeris as that run carries him**, small (0.42×) and alive like the title's: the weapon in hand, the equipped shield (broken if it is), the streak of that run |
| zone | (204, 78), 34 px | `Zone 1 · Suspended Sanctuary` |
| weapons | five 64 boxes from (204, 106), 8 apart | the five slots in the player's order (`pause-menu.md` U17), icon and three level marks; empty slots dashed |
| shield | a 64 box 16 after them | the equipped shield's icon |
| numbers | from (1000, 84), 30 px | experience (the mote), coins (the coin), and under them `Played: 42 min` (26 px) |
| won | a stamp at (840, 128) | an ink ring tilted −8° with `WON`; the card is greyed in **load** mode |
| empty | the whole card | dashed; `Slot 3`, `Empty slot` (38 px) and under it `Nothing is saved here.` (load) or `A new run starts here.` (new) |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| opening | the wash and the sheet fade in, the sheet settles 14 hu | 0.18 s |
| focused | the card takes the thick ink frame; on opening, the last run played (load) or slot 1 (new) | keyboard focus |
| hovered | the card's paper brightens | the mouse over it |
| won (load) | greyed card with the stamp; Enter flashes it; the footer explains | `won` |
| empty (load) | dashed; Enter flashes it | no run |
| overwrite asked | the question over a darker wash; only its two buttons answer | Enter on a used slot in **new** mode |
| leaving | fade to black; a loaded run passes through the loading screen (`06-ui/loading/`), a new one through the intro | a run loaded, a slot chosen (0.4 s) |

## 5. Navigation and actions

| Input | Effect |
|---|---|
| W / S or the arrows | move the focus: slot 1, 2, 3, *Back* |
| Enter (or a click) | **load:** a run loads at once, where it was saved, with everything it carried; an empty or won slot only flashes. **new:** an empty slot starts the run (the intro, then zone 1); a used one, won or not, asks before overwriting |
| Esc, *Back* | back to the title (the focus returns to the button that opened it); in the question, closes it |

There is no delete: a slot is freed by death or overwritten by a new run (U43).

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.slots.load` | Load | Cargar partida | title | 20 |
| `ui.slots.new` | New game | Nueva partida | title | 20 |
| `ui.slots.newNote` | The three slots are full. Choose one to overwrite. | Las tres ranuras están llenas. Elige una para sobrescribirla. | top right | 70 |
| `ui.slots.slot` | Slot {n} | Ranura {n} | card | 12 |
| `ui.slots.last` | Last played | La última | card, beside the slot | 16 |
| `ui.slots.saved` | Saved {date} | Guardada el {date} | card, top right | 40 |
| `ui.slots.zone` | Zone {n} · {name} | Zona {n} · {name} | card | 40 |
| `ui.slots.played` | Played: {time} | Jugado: {time} | card | 24 |
| `ui.time.hm` | {h} h {m} min | {h} h {m} min | `{time}` from one hour | 14 |
| `ui.time.m` | {m} min | {m} min | `{time}` under one hour (at least 1) | 8 |
| `ui.slots.won` | Won | Ganada | stamp (drawn in capitals) | 8 |
| `ui.slots.wonNote` | The Dragon fell in this run. It cannot be continued. | En esta partida cayó el Dragón. No se puede continuar. | footer | 70 |
| `ui.slots.empty` | Empty slot | Ranura vacía | empty card | 20 |
| `ui.slots.emptyLoad` | Nothing is saved here. | Aquí no hay nada guardado. | empty card, load | 40 |
| `ui.slots.emptyNew` | A new run starts here. | Aquí empieza una partida nueva. | empty card, new | 40 |
| `ui.slots.overAsk` | Overwrite slot {n}? | ¿Sobrescribir la ranura {n}? | question | 34 |
| `ui.slots.overNote` | The run saved there is lost. | La partida guardada ahí se pierde. | question | 40 |
| `ui.slots.overYes` | Overwrite | Sobrescribir | question | 14 |
| `ui.slots.overNo` | Keep | Conservar | question | 14 |
| `ui.slots.back` | Back | Volver | footer | 12 |
| `ui.slots.hint` | W S or arrows · Enter choose · Esc back | W S o flechas · Enter elegir · Esc volver | footer | 48 |

`{date}`: day, the month's short name and year, then the time, 24-hour (`30 Sep 2026, 21:40`; `30 sep 2026, 21:40`).
Zone names are `zone.<id>.name` (`map/map.md` §6).

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed) |
|---|---|---|---|
| open | wash and sheet fade in, the sheet settles 14 hu | 0.18 | `sfx.ui.open` |
| back | gone at once | — | `sfx.ui.close` |
| focus moves | the frame jumps | — | `sfx.ui.move` |
| portraits | Akeris breathes, cape and streak move, each on its own phase | continuous | — |
| denied | the frame flashes | 0.35 | `sfx.ui.denied` |
| load, start | fade to black | 0.4 | `sfx.ui.confirm` |

## 8. Never

- A won run is never loaded; an empty slot never loads.
- A run is never overwritten without the question, and the question never starts on `Overwrite`.
- Nothing on a card is a number the run did not save; no card shows a run that death wiped.
- No delete button (U43).

## 9. Acceptance

1. At 1920×1080 the layout matches `save-slots.png` within 2 hu: two runs and an empty slot, the focus on
   the last run played, marked `Last played`.
2. Each card shows Akeris with that run's weapon and shield, the zone and its name, the five weapon slots
   in the run's order with their levels, the equipped shield, XP, coins, time played and the save date.
3. Loading a run puts Akeris back with everything it carried, in its zone; that run becomes the last played.
4. A won run is greyed with the `WON` stamp and cannot be loaded; the footer says why
   (`captures/ranurasGanada.png`).
5. With the three slots full, *New game* opens the sheet in **new** mode (`captures/ranurasNueva.png`);
   Enter on a slot asks, focus on `Keep` (`captures/ranurasSobrescribir.png`); `Overwrite` starts a new run there.
6. Esc and *Back* return to the title; Esc in the question closes it.
7. After a death, that slot shows as empty; after the outro, as won.

## 10. Proposals for the operator

**All approved by the operator on 2026-09-30** (U43–U47), as the sandbox does them.

**Decided by the operator before drafting (2026-09-30):** rich cards (Akeris with his weapon and shield,
the zone, the weapons and their levels, XP, coins, time played and date; empty or won as such).

| # | Question | Proposal |
|---|---|---|
| U43 | Can a slot be deleted? | No: death frees it, and *New game* can overwrite any slot with the question. One fewer way to lose a run by mistake |
| U44 | What does a won run do here? | It stays on its card with a `WON` stamp, greyed in **load** mode and not loadable; in **new** mode it can be overwritten like any other |
| U45 | Where does the focus start? | **Load:** on the last run played. **New:** on slot 1 |
| U46 | And the overwrite question? | As *Quit to title*: over a darker wash, focus on `Keep` |
| U47 | Do the portraits move? | Yes, gently, each on its own phase, like the title's Akeris: the same rig, never a still picture that could drift from the game's drawing |
