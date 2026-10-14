# audio

## What it is

The `Soundscape` facade over music, sound effects and spirit voices.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/soundscape` | implements | `lib/features/audio/infrastructure/soloud_soundscape.dart` |
| `events/sound_effect_cued` | consumes | — |
| `state/settings_state` | consumes | — |
| `events/zone_entered` | consumes | — |
| `events/boss_woke` | consumes | — |
| `events/boss_defeated` | consumes | — |
| `events/pause_opened` | consumes | — |
| `events/pause_closed` | consumes | — |
| `events/spirit_whispered` | consumes | — |
| `events/run_ended` | consumes | — |

## Roots

`lib/features/audio/`, `test/features/audio/`, `assets/audio/`

## References

- `.factory/project/reference/07-audio/audio.md`
- `.factory/project/reference/07-audio/music/`
- `.factory/project/reference/07-audio/sfx/`
- `.factory/project/reference/07-audio/voice/`
- `.factory/project/reference/07-audio/sandbox/sandbox.html`

## Not here

- Which sound a game event makes: the feature that cues it.
