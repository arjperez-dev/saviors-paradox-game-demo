---
factory_version: 4.3.0
---

# PR — ui

- **Date:** 2026-10-16
- **Outcome:** `ui: The screens draw their menus, keys and questions in pencil on paper`
- **Decisions:** named the Scrutinise points at FocusGroup's unproven multi-row paths and T064's InkFrame hit-test fix, since those are where a reviewer not present for each task would otherwise have to rediscover the reasoning.
- **Deviations:** none
- **Evidence:**

```text
## Summary

Builds `lib/core/ui/` end to end: the pencil-art primitives (`PencilBox`, `DashedOutline`,
`SheetOutline`, `InkFrame`, `HoldRing`, `PaperSheet`) generated once from a fixed seed and
painted without trembling; the ink theme (`InkLettering`, `InkThemeData`, `InkTheme`) that
scales every screen to its height; the widget kit (`MenuButton`, `KeyCap`, `KeyCapButton`,
`HintFooter`, `ConfirmQuestion`) that draws and answers a menu's buttons, key hints and
safe-answer confirm box; and `FocusGroup<T>`, pure navigation over a screen's rows of
choices. It deliberately wires none of this into a pause menu, map or dialogue screen yet —
those screens are for later waves to build on this kit.

## Tasks

| id | title | type |
|---|---|---|
| T051 | Scale the UI frame to the screen's height | feat |
| T052 | Give the screens one ink theme at the screen's size | feat |
| T053 | Generate a box's pencil outline once from its seed | feat |
| T054 | Dash a closed outline from its first corner | feat |
| T055 | Generate a sheet's pencil border once from its seed | feat |
| T056 | Move the focus through a screen's rows of choices | feat |
| T057 | Draw a paper sheet under a menu | feat |
| T058 | Frame a box in pencil on paper | feat |
| T059 | Draw a key as a small paper cap | feat |
| T060 | Fill a pencil ring with the fraction of a hold | feat |
| T061 | Draw a menu button that answers the mouse | feat |
| T062 | Press a key by clicking the button that carries its cap | feat |
| T063 | Letter a sheet's footer with its key hint | feat |
| T064 | Ask a question with the focus on its safe answer | feat |
| T065 | Test a key cap click reaching a menu through the loop | feat |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- `flutter test`: All tests passed! (454 tests)
- Manual tests: none

## Scrutinise

- `FocusGroup<T>`'s row-and-column navigation (T056) is only exercised by T065's single
  confirm-question layout — one row of two choices; a reviewer should check it against a
  screen with more than one row before trusting its column-keeping across rows of different
  lengths.
- T064 fixed `InkFrame`'s flash painter to override `hitTest`, since without it the flash
  layer always claimed a tap first and blocked any widget placed in `InkFrame.child` — a
  bug every earlier use of `InkFrame` (T058–T063) happened to avoid by wrapping it in its
  own outer `GestureDetector`. Worth checking that no future widget placed inside
  `InkFrame.child` relies on a gesture arena order this fix changed.
```
