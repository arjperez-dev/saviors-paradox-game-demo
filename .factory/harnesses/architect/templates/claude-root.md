# <Game title>

## Stack

- <language or tool> <version>
- <language or tool> <version>

## Commands

| Command | Value |
|---|---|
| `install_command` | `<command>` |
| `test_command` | `<command>` |
| `lint_command` | `<command>` |
| `run_command` | `<command>` |
| `build_command` | `<command>` |

## Paths

| Path | Value |
|---|---|
| `source_root` | `<path>` |
| `test_root` | `<path>` |
| `contracts_root` | `<path>` |

## Modules

| Module | Kind | Roots |
|---|---|---|
| <module> | <feature \| shared> | `<source_root>/<path>/`, `<test_root>/<path>/` |
| integration | integration | `<test_root>/integration/` |

## Rules

- <a global rule every task must respect> (`<08-engineering/ path>`)
