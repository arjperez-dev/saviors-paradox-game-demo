# Savior's Paradox

## Stack

- Flutter 3.47.7 (Windows desktop)
- Dart 3.13.5
- Flame 1.38.2
- flutter_soloud 5.2.1
- window_manager 0.5.2
- path_provider 2.1.6
- mocktail 1.0.5
- flame_test 2.3.1
- flutter_lints 6.0.0

## Commands

| Command | Value |
|---|---|
| `install_command` | `flutter pub get --enforce-lockfile` |
| `test_command` | `flutter test` |
| `format_command` | `dart format lib test` |
| `lint_command` | `dart format --output=none --set-exit-if-changed lib test && flutter analyze --fatal-infos` |
| `run_command` | `flutter run -d windows` |
| `build_command` | `flutter build windows --release` |

## Paths

| Path | Value |
|---|---|
| `source_root` | `lib` |
| `test_root` | `test` |
| `contracts_root` | `lib/core/contracts` |

## Modules

| Module | Kind | Roots |
|---|---|---|
| loop | shared | `lib/core/loop/`, `test/core/loop/` |
| rendering | shared | `lib/core/rendering/`, `test/core/rendering/`, `assets/images/`, `assets/fonts/` |
| input | shared | `lib/core/input/`, `test/core/input/` |
| localization | shared | `lib/core/localization/`, `test/core/localization/` |
| ui | shared | `lib/core/ui/`, `test/core/ui/` |
| dungeon | feature | `lib/features/dungeon/`, `test/features/dungeon/` |
| combat | feature | `lib/features/combat/`, `test/features/combat/` |
| chain | feature | `lib/features/chain/`, `test/features/chain/` |
| akeris | feature | `lib/features/akeris/`, `test/features/akeris/` |
| hazards | feature | `lib/features/hazards/`, `test/features/hazards/` |
| enemies | feature | `lib/features/enemies/`, `test/features/enemies/` |
| bosses | feature | `lib/features/bosses/`, `test/features/bosses/` |
| arsenal | feature | `lib/features/arsenal/`, `test/features/arsenal/` |
| inventory | feature | `lib/features/inventory/`, `test/features/inventory/` |
| abilities | feature | `lib/features/abilities/`, `test/features/abilities/` |
| run | feature | `lib/features/run/`, `test/features/run/` |
| narrative | feature | `lib/features/narrative/`, `test/features/narrative/` |
| save | feature | `lib/features/save/`, `test/features/save/` |
| settings | feature | `lib/features/settings/`, `test/features/settings/` |
| audio | feature | `lib/features/audio/`, `test/features/audio/`, `assets/audio/` |
| hud | feature | `lib/features/hud/`, `test/features/hud/` |
| map | feature | `lib/features/map/`, `test/features/map/` |
| pause | feature | `lib/features/pause/`, `test/features/pause/` |
| cinematics | feature | `lib/features/cinematics/`, `test/features/cinematics/` |
| home | feature | `lib/features/home/`, `test/features/home/` |
| integration | integration | `test/integration/` |

## Rules

- A feature never imports another feature; features meet only through `lib/core/contracts/`. (`.factory/project/reference/08-engineering/architecture.md` §2.2)
- `lib/core/` imports no feature and holds no game rule. (`.factory/project/reference/08-engineering/architecture.md` §1, §2.2)
- `domain/` and `application/` import no Flutter, Flame, `dart:io` or `dart:ui`; `domain/` imports no `dart:async`. (`.factory/project/reference/08-engineering/architecture.md` §3)
- `infrastructure/` and `presentation/` never import each other. (`.factory/project/reference/08-engineering/architecture.md` §3)
- No code outside `lib/core/loop/` reads a clock; logic receives `dt` as `Seconds`; a widget's own animation changes no game state. (`.factory/project/reference/08-engineering/coding-standards.md` §8)
- Every random choice comes from a `Seed` passed in; never `Random()` unseeded. (`.factory/project/reference/08-engineering/coding-standards.md` §8)
- Every player-visible string goes through the translator by key. (`.factory/project/reference/08-engineering/coding-standards.md` §8)
- Tile ↔ world conversion only through `TileCoord`; one tile is 32 world units and y grows downward. (`.factory/project/reference/08-engineering/coding-standards.md` §8)
- Nothing trembles: a stroke's geometry is generated once from its fixed seed, never per frame. (`.factory/project/reference/08-engineering/coding-standards.md` §8)
- No singleton, static mutable state, service locator, or class that knows every feature. (`.factory/project/reference/08-engineering/design-patterns.md` §14)
- Nothing in the per-frame path of a hot loop allocates; short-lived objects come from a pool. (`.factory/project/reference/08-engineering/architecture.md` §6)
- `test/` mirrors `lib/`, one test file per production file; test doubles are `mocktail`. (`.factory/project/reference/08-engineering/testing.md` §2, §4)
