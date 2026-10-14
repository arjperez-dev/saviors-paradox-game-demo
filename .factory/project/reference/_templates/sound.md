<!--
Template: sound. Three files in 07-audio/, each a closed list:
  music.md   one "Music cue" entry per piece of music
  sfx.md     one row per sound effect in the table below, grouped by who makes it
  voice.md   one "Voice" entry per speaking character or spirit

A sound that is not listed does not exist. Every trigger is a game event or an animation frame from
a character contract, never a keypress. Asset paths are under assets/audio/. Delete these comments.
-->

# <Music | Sound effects | Voices>

- **Status:** draft · review · approved <YYYY-MM-DD>
- **Sources:** `VISION.md` §<sections> · `00-game/` tone

## Sound effects

| Id | Trigger | Description | Length (s) | Variations | Volume (0–1) | Priority | Asset |
|---|---|---|---|---|---|---|---|
| `sfx.<owner>.<action>` | `<event>` or `<character> §4 <animation> at <fraction>` | <what it sounds like, in words> | | <n, picked by seed> | | <what cuts what> | `assets/audio/sfx/<file>` |

**Mixing rules:** <how many sounds of one id may overlap, what ducks what, what is never cut>.

## Music cue — `<music.id>`

- **Plays:** <where and when: zone, room kind, boss phase, menu>
- **Starts / stops:** <the event that starts it, how it fades in and out, in seconds>
- **Loops:** <yes, from <s> to <s> · no>
- **Mood and instruments:** <in words>
- **Layers:** <stems that enter or leave with game state, and the event that drives each>
- **Asset:** `assets/audio/music/<file>`

## Voice — `<character>`

- **Who:** <character, with its contract path>
- **Language:** <spoken or invented; how it is processed>
- **Lines:** by translator key, in `01-story/dialogue/`; never written here.
- **Barks:** <short non-verbal sounds and their triggers, as sfx ids>

## Never

- <The likely mistakes, stated so they can be checked.>

## Acceptance

1. <Each trigger plays its sound once, at the listed volume, with no clipping.>
2. <…>
