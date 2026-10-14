# Settings

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: I, then *Settings*) ·
  **Image:** [`settings.png`](settings.png) (1920×1080)
- **Sources:** `VISION.md` §Client constraints (settings: music volume, sound-effect volume, language; text
  in English and Spanish, selectable in the settings on the home screen), §Non-goals (no other settings) ·
  `00-game/controls.md` (no rebinding) · `06-ui/title/title.md` · `06-ui/pause-menu/pause-menu.md` (the sheet)

## 1. Purpose

The three settings the game has, and nothing more: how loud the music is, how loud the sound effects are,
and the language of every text.

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| *Settings* on the title | *Back* or Esc (to the title, focus on *Settings*) | there is no run behind it | the title scene under a wash |

Only on the title (`VISION.md`); the pause menu has no settings (`pause-menu.md` §8).

## 3. Layout

1920×1080 frame (**hu**), the sheet centred; numbers as the sandbox draws them (`ST`).

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| wash | whole screen | — | `vignette` ink over the title scene | — |
| sheet | centre | x 540–1380, y 230–820 | the pause menu's paper sheet | — |
| title | sheet, top left | (590, 300), 60 px; a rule at y 352 | `Settings` | — |
| rows | sheet | three rows 760 × 80 from (580, 372), 108 apart; label at x 610, 32 px | `Music`, `Sound effects`, `Language`; the focused row takes the thick ink frame | — |
| volume | rows 1–2 | a pencil line from x 900, 360 long, with 11 ticks (longer at 0, 5 and 10); an ink stroke from 0 to the value; a paper knob (r 13); the value at x 1304, 32 px | `0`–`10` | settings |
| language | row 3 | two boxes 180 × 52 at x 900 and 1096 | `English`, `Español` — each in its own language; the chosen one darker with a tick | settings |
| footer | sheet, bottom | `Back` with an `Esc` key cap at (590, 728); a rule above; hint right-aligned at 1330, 24 px | `W S choose · A D change · Esc back` | — |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| opening | the wash and the sheet fade in, the sheet settles 14 hu | 0.18 s |
| focused | the row takes the thick ink frame; on opening, *Music* | keyboard focus |
| hovered | the row's paper brightens | the mouse over it |
| changed | the knob and the value move at once; the volume is heard at once (in the game) | A / D, a click or a drag |
| at an end | the row's frame flashes | A at 0, D at 10 (0.35 s) |
| language | every text on screen changes at once, the sheet included | A / D or Enter on *Language*, a click on a box |

## 5. Navigation and actions

| Input | Effect |
|---|---|
| W / S or the up / down arrows | move the focus: Music, Sound effects, Language, *Back* |
| A / D or the left / right arrows | a volume down or up one step; on *Language*, the other language |
| Enter | on *Language*, the other language; on *Back*, back |
| mouse | a click on a line sets the volume there, and dragging moves it; a click on a language box chooses it |
| Esc, *Back* | back to the title |

**Every change applies and is saved at once**; there is no *Apply* or *Cancel*. Settings live outside the
runs: they are kept on this computer, a death never touches them, and they hold for every slot (U50).

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.settings.title` | Settings | Ajustes | title | 16 |
| `ui.settings.music` | Music | Música | row | 16 |
| `ui.settings.sfx` | Sound effects | Efectos | row | 16 |
| `ui.settings.language` | Language | Idioma | row | 16 |
| `ui.settings.english` | English | English | language box (never translated) | 10 |
| `ui.settings.spanish` | Español | Español | language box (never translated) | 10 |
| `ui.slots.back` | Back | Volver | footer | 12 |
| `ui.settings.hint` | W S choose · A D change · Esc back | W S elegir · A D cambiar · Esc volver | footer | 48 |

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed) |
|---|---|---|---|
| open | wash and sheet fade in, the sheet settles | 0.18 | `sfx.ui.open` |
| focus moves | the frame jumps | — | `sfx.ui.move` |
| sound-effect volume changed | the knob jumps to the step | — | `sfx.ui.slider`, at the new volume, so it is heard |
| music volume changed | the knob jumps to the step | — | the title music itself, at the new volume |
| at an end | the frame flashes | 0.35 | `sfx.ui.denied` |

## 8. Never

- No setting other than these three (`VISION.md` §Non-goals): no key rebinding, no resolution, no window
  mode (fullscreen, detected automatically: `VISION.md` §Target platform).
- No *Apply* step, no confirmation, and no way to lose a change by leaving with Esc.
- The language names are never translated: each is written in its own language.
- No settings inside a run: they are on the title only.

## 9. Acceptance

1. At 1920×1080 the layout matches `settings.png` within 2 hu: music 7, sound effects 8, Spanish chosen,
   the focus on *Music*.
2. A / D move a volume one step between 0 and 10; the ends flash; a click or a drag sets it.
3. Changing the language changes every text at once (`captures/ajustesEn.png`); the boxes keep their own
   languages.
4. Leaving and opening again shows the same values; after a death and a new run they are unchanged.
5. Esc and *Back* return to the title with the focus on *Settings*.

## 10. Proposals for the operator

**All approved by the operator on 2026-09-30** (U48–U51), as the sandbox does them.

| # | Question | Proposal |
|---|---|---|
| U48 | How fine are the volumes? | **11 steps, 0–10**, by the keys or the mouse; music starts at 7 and sound effects at 8 (the game may tune them) |
| U49 | How is the language chosen? | Two boxes side by side, each name in its own language, so a player lost in the other language finds theirs |
| U50 | When is a change kept? | At once, with no *Apply*; settings belong to the computer, not to a run or a slot, and death never touches them |
| U51 | Is the change heard? | Yes: the music plays at the new volume while it moves, and each sound-effect step plays a short tick at its new volume |
