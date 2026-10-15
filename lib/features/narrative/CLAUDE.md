# narrative

## What it is

The spirits: dialogue, one new fragment per spirit and run, and their memory across deaths. It implements `core/input`'s `InputContext` in `presentation/`: Enter or a left click anywhere advances, W/S or the arrows move between the two choices, Esc closes only a replay (`.factory/project/reference/06-ui/dialogue/dialogue.md` §5; `.factory/project/reference/08-engineering/design-patterns.md` §5).

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `events/dialogue_opened` | emits | `lib/features/narrative/application/step_dialogue.dart` |
| `events/dialogue_closed` | emits | `lib/features/narrative/application/step_dialogue.dart` |
| `events/spirit_whispered` | emits | `lib/features/narrative/application/step_dialogue.dart` |
| `state/zone_state` | consumes | — |
| `state/akeris_state` | consumes | — |
| `events/run_started` | consumes | — |
| `events/player_command` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/narrative/`, `test/features/narrative/`

## References

- `.factory/project/reference/01-story/premise.md`
- `.factory/project/reference/01-story/characters.md`
- `.factory/project/reference/01-story/zones-narrative.md`
- `.factory/project/reference/01-story/dialogue/rules.md`
- `.factory/project/reference/01-story/dialogue/zone-1.md`
- `.factory/project/reference/01-story/dialogue/zone-2.md`
- `.factory/project/reference/01-story/dialogue/zone-3.md`
- `.factory/project/reference/01-story/dialogue/zone-4.md`
- `.factory/project/reference/01-story/dialogue/zone-5.md`
- `.factory/project/reference/06-ui/dialogue/`
- `.factory/project/reference/07-audio/voice/`

## Not here

- The cinematics: `cinematics`.
- The whisper's sound: `audio`.
