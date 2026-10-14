# Dialogue

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: H next to the spirit by the items hall's
  door) · **Image:** [`dialogue.png`](dialogue.png) (a conversation over the paused game at 1920×1080)
- **Sources:** `VISION.md` §Mechanics (Spirits) · `00-game/controls.md` §4 (H, Enter, G10) ·
  `01-story/dialogue/rules.md` (what a spirit says, in what order, S2, S3) · `01-story/dialogue/zone-1.md`
  (the lines the sandbox loads) · `01-story/characters.md` §4 (anonymous spirits, no speaker name) ·
  `00-game/tone.md` · `06-ui/hud/hud.md` · `06-ui/pause-menu/pause-menu.md` (the sheet) · `06-ui/map/map.md` (the spirit mark) ·
  `02-art-direction/ART_DIRECTION.md` (static stroke) · `02-art-direction/palette/palette.md`
- **Asked by the operator (2026-09-30):** a **sheet of paper at the bottom**, centred, with no name and no
  portrait; **the game stops** while a spirit talks and the HUD hides; each line is **written by hand**,
  left to right: Enter on a line half written completes it, Enter on a complete line moves to the next.

## 1. Purpose

What a spirit says, one line at a time, while Akeris stands and listens. The player reads it at their
own pace; the spirit's processed voice plays under it (`07-audio/voice.md`). Akeris never answers: the
only choice in the game, *Hear it again* or *Go on*, is what the player does (`rules.md` §4).

## 2. When it shows

| Piece | Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|---|
| talk prompt | Akeris on the ground, standing or walking, within **220 su** of a spirit, and no altar in reach (the take prompt wins) | he leaves, or the dialogue opens | no | the world, over the spirit's head |
| dialogue | H with the talk prompt shown (`VISION.md`) | Enter or a click after the last line; *Go on*; Esc only while replaying (§5) | **yes**: nothing moves, no timer runs | the game, frozen, under a light ink wash; **the HUD is hidden** |

When it opens, Akeris stops where he is, turns to the spirit and stands in his idle pose until it
closes. The dialogue does not open during death, a zone change, the map, the pause menu or a cinematic;
while it is open, M, Esc (§5), Q / E / R, F, the wheel, 1–5 and every action key do nothing.

## 3. Layout

A 1920×1080 reference frame (**hu**), scaled by `screen height ÷ 1080`, as the HUD; the sheet stays
centred, on wider screens only the wash grows. Numbers are what the sandbox draws (`DL` in
`sandbox.html`).

### 3.1 The dialogue

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| wash | whole screen | — | `vignette` ink at 22 % over the frozen game, darkening to 42 % at the bottom from y 600: the spirit and Akeris stay in view | — |
| sheet | bottom centre | x 260–1660, y 826–1026 (1400 × 200); 54 hu from the bottom | the pause menu's paper (`pause-menu.md` §3): `paper`, a soft light in the middle, a 3.2 ink border and a faint inner line 12 in | — |
| line | sheet | from x 320, first row at y 884, second at y 938; **40 px**, `ink`; wraps at **1280 hu** (880 while the choice is shown) | the current line, written by hand (§4) | `spirit.<spiritId>.<part>.<n>` |
| progress | sheet, bottom left | dots of radius 4.5 from x 325, 20 apart, y 994 | one per line of this conversation: filled up to the current one | the conversation |
| Enter key | sheet, bottom right | right edge 1620, y 976–1012 | the key cap `Enter`: at 55 % while the line is being written, whole when it is complete; hidden while choosing | — |
| close | left of Enter | the key cap `Esc` and `Close`, 26 px | **only while replaying** (*Hear it again*), the only time Esc closes | replay |
| choice | sheet, right | x 1250–1620; *Hear it again* at y 846–898, *Go on* at y 910–962 | the two buttons of `rules.md` §4, once the line that asks is complete; the focused one has the thick frame | heard in full |

No speaker name, no portrait, no box pointing at the spirit (`characters.md` §4): the spirit is the only
one in the scene that speaks.

**Line length.** At 40 px a row holds about 80 characters of the hand font; `rules.md` §6 allows 90 in
English and 110 in Spanish, so every line fits in **two rows** and never shrinks. The longest zone 1
line (77 characters) fits in one. A line that needs a third row is a defect of the line, not of the box.

### 3.2 In the world

| Element | Anchor | Position and size (su of the world) | Contents | Data source |
|---|---|---|---|---|
| `…` | over the spirit's head, 42 above its centre | three ink dots of radius 3.2, 11 apart | the spirit has something new to say in this run (`rules.md` §3); the same meaning as on the map (`map.md` §3.4) | spirit memory, run |
| talk prompt | over the spirit, 74 above its head | as the take prompt (`hud.md` §3.3): a paper box, the key cap `H` and `Talk`, 17 px at the sandbox's scale | — | near a spirit |

The spirit in the sandbox is a **stand-in** (a paper wisp, as the map's mark, fainter than the living
and with no streak); its look is designed in `03-characters/spirits/`.

## 4. States

| State | What changes | Trigger |
|---|---|---|
| writing | the line appears left to right at **40 characters a second**; each letter fades in over the next 3 and then stays fixed; Enter at 55 % | a new line |
| complete | the whole line; Enter whole | the last letter settles, or Enter / a click while writing |
| next line | the sheet stays; the old line goes at once and the next starts writing; one more dot filled | Enter / a click on a complete line |
| new lines | Esc does not close: the Enter key's frame flashes (0.35 s), nothing else | Esc during lines heard for the first time (`rules.md` S2) |
| choosing | the line that asks wraps at 880; the two buttons show; *Go on* has the focus; Enter hidden | `allHeard` (first conversation of a run) or `sameRun` (S3) with all three fragments heard, once the line is complete |
| replaying | fragments 1, 2 and 3 in a row (9 lines); `Esc Close` shows | *Hear it again* |
| closed | everything goes at once; the game resumes where it stopped | after the last line, *Go on*, or Esc while replaying |

What the spirit says and in which order is `rules.md`: the greeting (`greetingFirst` or
`greetingAgain`), then its next fragment; `sameRun` if it already spoke in this run; `allHeard` and the
choice when the three fragments are heard. A fragment counts as heard once its last line is shown.

## 5. Navigation

| Input (as `VISION.md` and `controls.md` name it) | Effect |
|---|---|
| H (talk prompt shown) | opens the dialogue (`VISION.md`) |
| Enter, or a left click anywhere | the line half written: completes it · complete: the next line, at once (`rules.md` §1) · after the last line: closes |
| W / S or the arrows up / down (choosing) | move the focus between *Hear it again* and *Go on* (G10) |
| Enter (choosing) | does the focused button |
| mouse (choosing) | pointing a button focuses it; a click does it; a click elsewhere does nothing |
| Esc | while replaying: closes · choosing: *Go on* · lines heard for the first time: nothing (the Enter key flashes) |
| everything else | nothing while the dialogue is open |

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.prompt.talk` | Talk | Hablar | talk prompt | 12 |
| `ui.dialogue.close` | Close | Cerrar | next to `Esc`, while replaying | 12 |
| `dialogue.choice.replay` | Hear it again | Escucharlo otra vez | choice (`rules.md` §4) | 22 |
| `dialogue.choice.leave` | Go on | Seguir | choice (`rules.md` §4) | 22 |
| `spirit.<spiritId>.<part>.<n>` | the lines of `01-story/dialogue/zone-N.md` | | the line | 90 / 110 (`rules.md` §6) |

The key caps `H`, `Enter` and `Esc` are keys, not texts.

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed; `07-audio/` fixes them in step 3.8) |
|---|---|---|---|
| opens | the wash and the sheet fade in; the sheet settles 14 hu | 0.18 | `sfx.ui.dialogueOpen` (a sheet laid down) |
| a line | written left to right, 40 characters a second; letters settle and stay | length ÷ 40 | the spirit's voice for that line (`07-audio/voice.md`); it stops when the next line starts |
| next line | at once | — | `sfx.ui.dialogueNext` (a soft page) |
| focus moves | the frame jumps to the other button | — | `sfx.ui.move` |
| choice made | — | — | `sfx.ui.confirm` |
| Esc refused | the Enter key's frame flashes | 0.35 | `sfx.ui.denied` |
| closes | gone at once | — | `sfx.ui.close` |
| the spirit | floats 4 su up and down (1.1 rad/s), its tail sways; it keeps floating while it talks, with the dialogue's clock | — | — |

Nothing trembles: the sheet, the buttons and the spirit have their seeds; a letter, once written, never
moves or changes. No pulse, no blink: the `…` and the prompt are drawn, they do not flash.

## 8. Never

- No speaker name, title or portrait (`characters.md` §4); Akeris never speaks.
- A line heard for the first time is never closed or skipped as a whole: Enter only speeds it up.
- No choice other than *Hear it again* / *Go on*; no dialogue tree.
- The text never shrinks to fit: a line longer than two rows is a defect of the line.
- The game never runs behind the dialogue: no damage, no timers, no enemy moves while it is open.
- The voice never says the words (`rules.md` §1); the subtitle is the only readable text.
- No colour outside `palette.md`; no hard-coded text.

## 9. Acceptance

1. At 1920×1080 the dialogue matches `dialogue.png`, element by element, within 2 hu; on wider screens the
   sheet stays centred and only the wash grows.
2. Near a spirit, on the ground and with no altar in reach, the prompt `H Talk` shows over it
   (`captures/dialogoHablar.png`); a spirit with something new for this run shows `…`.
3. H opens the dialogue: Akeris stops facing the spirit, the HUD hides and everything pauses (the dummy,
   cooldowns, rage, the curse); closing it resumes the game exactly where it was.
4. Each line is written at 40 characters a second (`captures/dialogoEscribiendo.png`); Enter or a click
   completes it, and on a complete line moves to the next at once.
5. The first conversation of a run says the greeting and the next fragment (`dialogue.png`: the warning
   spirit's first time); a later one in the same run says `sameRun` (`captures/dialogoMisma.png`); in a
   later run, `greetingAgain` and the next fragment (`captures/dialogoHistoria.png`).
6. Esc does nothing during lines heard for the first time except flash the Enter key; it never opens the
   pause menu while the dialogue is open.
7. With all three fragments heard, the line that asks wraps beside *Hear it again* / *Go on*, with the
   focus on *Go on* (`captures/dialogoEleccion.png`); W/S or the arrows move the focus, Enter or a click
   chooses, Esc is *Go on*.
8. *Hear it again* tells fragments 1, 2 and 3 in a row with `Esc Close` shown (`captures/dialogoRepetir.png`);
   Esc closes it at any line.
9. English and Spanish lines both fit in two rows at 40 px (`captures/dialogoEn.png`).

## 10. Proposals for the operator

Decided before drafting (operator, 2026-09-30): the sheet at the bottom with no portrait; the game
stops; each line written by hand, Enter completes it and then moves on. **All approved by the operator on
2026-09-30** (U28–U36), as the sandbox does them:

| # | Question | Proposal |
|---|---|---|
| U28 | How far does the talk prompt reach? | **220 su** from the spirit, on the ground, standing or walking; when an altar is also in reach, the take prompt wins |
| U29 | Does Akeris move when it opens? | No: he stops where he is, turns to the spirit and stands idle; the spirit keeps floating while it talks |
| U30 | How fast is a line written? | **40 characters a second** (a 90-character line in about 2 s); each letter fades in over the next 3 and stays |
| U31 | Is there a progress mark? | Yes: one dot per line of the conversation at the bottom left, filled up to the current one |
| U32 | Where is the choice and which one has the focus? | Inside the sheet, on the right, stacked (W/S); the focus starts on **Go on**, so pressing Enter through a conversation never starts a nine-line replay by accident |
| U33 | What does Esc do at the choice? | *Go on* (G10: Esc goes back or closes) |
| U34 | What does Esc do during new lines? | Nothing, as `rules.md` S2 says; the Enter key flashes to say which key moves on |
| U35 | Does the mouse advance? | Yes: a left click anywhere does what Enter does; at the choice only the buttons answer |
| U36 | Does the spirit show `…` in the world? | Yes, over its head, with the same meaning as the map's mark: something new to say in this run |

The sandbox's spirit floats by the items hall's door, as the warning spirit stands before the boss door
(`characters.md` §4). The «Espíritu» button switches between the warning and the lore spirit of zone 1;
«Partida nueva» simulates a death (the spirits remember) and «Olvidar» wipes the spirit's memory. The
spirit only appears in live play and in the `dialogo*` scenarios, so the approved HUD, pause and map
captures export identical.
