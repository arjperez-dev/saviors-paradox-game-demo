---
factory_version: 4.3.0
---

# PR — tooling

- **Date:** 2026-10-14
- **Outcome:** `tooling: Stand up the Flutter stack, its lint rules, a fullscreen Flame window and the Windows runner`
- **Decisions:** Named the feature's deliberate scope limit in the Summary — no game system wired
  yet — and picked the renamed Windows resource strings and the empty composition root as the two
  points to scrutinise, since both are easy to mistake for a gap rather than a planned boundary.
- **Deviations:** none
- **Evidence:**

```text
tooling: Stand up the Flutter stack, its lint rules, a fullscreen Flame window and the Windows runner

## Summary

This feature stands up the project's tooling: a pinned `saviors_paradox` package with the kernel's
contract tests running under `flutter test`, `flutter_lints` plus coding-standards.md's strict modes
enforced through `analysis_options.yaml`, an entry point that opens a fullscreen `FlameGame<World>`
through `window_manager`, and a generated Windows runner renamed to Savior's Paradox. It deliberately
wires no game system yet — the game loop, rendering and input are left to later waves.

## Tasks

| id | title | type |
|---|---|---|
| T001 | Run the kernel's tests on the declared stack | build |
| T002 | Configure the Dart analysis options | build |
| T003 | Boot the game in a fullscreen Flame window | build |
| T004 | Generate the Windows runner | build |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- `flutter test`: All tests passed! (35 tests)
- Manual tests: none

## Scrutinise

- `windows/` is generated output, renamed in two places only (the window title and the `Runner.rc`
  `FileDescription`/`ProductName` strings) while `InternalName`, `OriginalFilename` and `BINARY_NAME`
  were deliberately left on `saviors_paradox` — worth a close look that no other generated string
  needs the same rename.
- `lib/core/app/bootstrap.dart` and `saviors_paradox_game.dart` are the composition root's first
  files, holding no system yet; the empty `FlameGame<World>` is a placeholder a reviewer should
  expect later waves to fill, not a gap in this feature.
```
