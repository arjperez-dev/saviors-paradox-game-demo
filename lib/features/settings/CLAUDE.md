# settings

## What it is

Music volume, sound-effect volume and language, saved for the computer, and their screen.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/settings_state` | owns | `lib/features/settings/application/current_settings.dart` |
| `events/player_command` | consumes | — |

## Roots

`lib/features/settings/`, `test/features/settings/`

## References

- `.factory/project/reference/06-ui/settings/`
- `.factory/project/reference/06-ui/sandbox/sandbox.html`

## Not here

- Applying the volume: `audio`.
- Translating: `localization`.
