# ui

## What it is

The interface kit: `PaperSheet`, `InkFrame`, `KeyCap`, `KeyCapButton`, `HoldRing`, `MenuButton`, `FocusGroup`, `ConfirmQuestion`, `HintFooter` and `InkTheme`, the reusable widgets every screen is built from, drawn with `core/rendering` and lettered through `core/localization`, holding no game rule. Sizes are in hu through `UiScale`; what is clickable shows the hand cursor; a `KeyCapButton` hands its key's press and release to `core/input`'s active context; a `HoldRing` shows the fraction its owner gives it; `InkTheme` takes the palette, the strokes and the Patrick Hand family from `core/rendering`.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/ui_scale` | implements | `lib/core/ui/presentation/screen_ui_scale.dart` |
| `kernel/screen_vec2` | consumes | — |
| `kernel/ui_vec2` | consumes | — |

## Roots

`lib/core/ui/`, `test/core/ui/`

## References

- `.factory/project/reference/06-ui/ui.md`
- `.factory/project/reference/06-ui/pause-menu/pause-menu.md`
- `.factory/project/reference/06-ui/map/map.md`
- `.factory/project/reference/06-ui/dialogue/dialogue.md`
- `.factory/project/reference/06-ui/title/title.md`
- `.factory/project/reference/06-ui/save-slots/save-slots.md`
- `.factory/project/reference/06-ui/settings/settings.md`
- `.factory/project/reference/06-ui/death/death.md`
- `.factory/project/reference/01-story/cinematics/intro.md`
- `.factory/project/reference/01-story/cinematics/outro.md`
- `.factory/project/reference/01-story/cinematics/sandbox/sandbox.html`
- `.factory/project/reference/02-art-direction/palette/palette.md`
- `.factory/project/reference/02-art-direction/strokes/strokes.md`

## Not here

- Any screen: each belongs to its feature's `presentation/`.
- What a key does: `core/input`.
- How long a hold lasts: the feature that asks for it.
- The font files: `core/rendering`, under `assets/fonts/`.
