# Loading screen

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: Esc, *Quit to title*, *Quit*) ·
  **Image:** [`loading.png`](loading.png) (1920×1080)
- **Sources:** operator, 2026-09-30 (a loading screen between the pause menu and the title, so leaving
  does not feel abrupt) · `VISION.md` §Session shape (autosave on quitting) · `01-story/cinematics/intro.md`
  (the black cards) · `05-items/altar/altar.md` (the hourglass seal) · `06-ui/pause-menu/pause-menu.md` ·
  `06-ui/title/title.md` · `06-ui/save-slots/save-slots.md` · `06-ui/death/death.md`

## 1. Purpose

A calm moment between a run and the title, while the game saves or loads: the player sees that the run
is being kept, and the change of screen does not jump.

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| **Quit to title** confirmed in the pause menu, after its 0.4 s fade to black (saving, then loading) · *Continue* or a slot loaded on the title (loading) · *New game* or *Title screen* on the death screen (loading) | the save and the load are done, and at least **1.8 s** have passed | yes: nothing runs and no input is read | black; nothing behind it shows |

It does not show for a new game from the title: the intro takes that place (`intro.md`).

## 3. Layout

1920×1080 frame (**hu**); everything is centred and only the black grows on wider screens.

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| background | whole screen | — | black (`#0a0806`, the intro cards'), with a faint lighter centre | — |
| hourglass | centre | centred at (960, 470); 132 wide, 192 tall | **the hourglass seal of the Time Chamber** (altars, coins), drawn in `paperLight` pencil on the black: two plates, two posts, two glass bulbs with a glint. Its sand runs from the upper bulb to the lower one in 1.6 s (the upper level drops, a mound grows below, a thin stream and a few grains fall), then it **turns over** in 0.4 s and runs again | — |
| status | under it | centred, y 652, 38 px | `Saving the run…` (only when quitting, until the save is written), then `Loading…` | what is happening |
| slot | under the status | centred, y 700, 26 px, faint | `Slot 2`, when a run is saved or loaded | the run's slot |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| appearing | the hourglass and the text fade in | 0.3 s |
| saving | `Saving the run…` | quitting, until the save is written (sandbox: 0.9 s) |
| loading | `Loading…` | until the next screen is ready, at least 1.8 s from the start |
| going | the hourglass and the text fade out | the last 0.25 s |
| to the title | the title comes out of black (its own 0.6 s) | quit, death → title |
| to the game | the black lifts off the game | 0.4 s, a run loaded or started after death |

## 5. Navigation

None. Every key and click is ignored while it shows (Esc, M, H, movement…); it cannot be skipped.

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.loading.saving` | Saving the run… | Guardando la partida… | status | 30 |
| `ui.loading.loading` | Loading… | Cargando… | status | 30 |
| `ui.loading.slot` | Slot {n} | Ranura {n} | under the status | 12 |

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed; `07-audio/` fixes them in step 3.8) |
|---|---|---|---|
| sand | runs down; the hourglass turns over | 1.6 + 0.4, repeating | — (silence: the zone music has faded out with the pause's fade) |
| appear, go | fade | 0.3, 0.25 | — |
| into the game | the black lifts | 0.4 | the zone music starts |

Nothing trembles: the hourglass is one seeded drawing; only the sand and its turn move, as real motion.

## 8. Never

- No skipping it, and nothing the player presses during it acts afterwards.
- Never shorter than 1.8 s, even when saving and loading are instant: a flash of black reads as a glitch.
- No tips, no progress bar and no numbers: the hourglass is the progress.
- No colour but black and `paperLight`.

## 9. Acceptance

1. At 1920×1080 the layout matches `loading.png` within 2 hu (saving), and `captures/cargaCargando.png`
   (loading); English fits (`captures/cargaEn.png`).
2. *Quit to title* fades to black, shows the hourglass with `Saving the run…` and `Slot N`, then
   `Loading…`, and the title comes out of black; the slot holds the run as it was when quitting.
3. Loading a run from the title and leaving the death screen pass through it; the game appears as the
   black lifts.
4. It lasts at least 1.8 s; keys and clicks during it do nothing.

## 10. Proposals for the operator

**All approved by the operator on 2026-09-30** (U56–U58), as the sandbox does them.

**Asked by the operator (2026-09-30):** a loading screen between the pause menu and the title.

| # | Question | Proposal |
|---|---|---|
| U56 | What does it show? | The Time Chamber's hourglass in pencil on black, its sand running and turning over; `Saving the run…`, then `Loading…`, and the slot |
| U57 | Only after the pause? | Also when a run is loaded from the title and when leaving the death screen, so every passage between a run and the title feels the same (not after the intro, which is its own passage) |
| U58 | How long? | At least 1.8 s, and as long as saving and loading take; it cannot be skipped |
