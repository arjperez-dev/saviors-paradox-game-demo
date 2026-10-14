# cinematics

## What it is

The intro, the descent and the outro, and skipping them.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/cinematic_player` | implements | `lib/features/cinematics/application/cinematic_director.dart` |
| `state/cinematic_state` | owns | `lib/features/cinematics/application/cinematic_director.dart` |
| `ports/soundscape` | consumes | — |
| `events/player_command` | consumes | — |

## Roots

`lib/features/cinematics/`, `test/features/cinematics/`

## References

- `.factory/project/reference/01-story/cinematics/intro.md`
- `.factory/project/reference/01-story/cinematics/outro.md`
- `.factory/project/reference/01-story/cinematics/intro-sheet.png`
- `.factory/project/reference/01-story/cinematics/outro-sheet.png`
- `.factory/project/reference/01-story/cinematics/sandbox/sandbox.html`
- `.factory/project/reference/01-story/cinematics/sandbox/captures/`
- `.factory/project/reference/03-characters/future-akeris/sprites/intro-short-circuit.png`
- `.factory/project/reference/03-characters/future-akeris/sprites/outro-behind.png`
- `.factory/project/reference/03-characters/future-akeris/sprites/outro-charge.png`
- `.factory/project/reference/03-characters/corrupted-akeris/sprites/intro-dream.png`

## Not here

- When each one plays: `home`.
