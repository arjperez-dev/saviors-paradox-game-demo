# Audio

- **Status:** approved 2026-10-01 (the index; each piece has its own status in `../README.md`)
- **Mock:** [`sandbox/sandbox.html`](sandbox/sandbox.html), the interface sandbox with all its sound,
  plus the *Mesa de sonido* under it
- **Sources:** `VISION.md` §Scope, §Client constraints · `00-game/tone.md` §3 · `_templates/sound.md`
- **Read by:** any task that plays a sound or music; the tester, to find a sound's acceptance list

Everything here was **made within the project**, as `VISION.md` asks: each sound effect is a seeded
recipe and each piece of music a written score, synthesised in the sandbox with Web Audio and
exported to WAV. Nothing was recorded or downloaded. The same id and variation always sound the same.

---

## 1. The pieces

| Piece | What it fixes |
|---|---|
| [`music/music.md`](music/music.md) | the cues (title, zone 1, the Golem's calm and fight, the two cinematics), their light versions, and the director: which cue plays in which state, with which fades |
| [`sfx/sfx.md`](sfx/sfx.md) | the closed list of 72 sound effects of the common game, zone 1 and the boss rooms, their triggers, volumes, variations and the mixing rules |
| [`voice/voice.md`](voice/voice.md) | the spirits' whispered invented language: when a syllable sounds, each spirit's tone |
| [`sandbox/sandbox.html`](sandbox/sandbox.html) | where all of it is made and heard in play |

## 2. The folders

```
07-audio/
├── audio.md                 this index
├── music/                   music.md; one folder per cue family
│   ├── title/               title.wav
│   ├── zone-1/              zone1.wav, zone1-lite.wav
│   ├── zone-2/              zone2.wav, zone2-lite.wav
│   ├── zone-3/              zone3.wav, zone3-lite.wav
│   ├── zone-4/              zone4.wav, zone4-lite.wav
│   ├── zone-5/              zone5.wav, zone5-lite.wav
│   ├── golem/               golem-calm(-lite).wav, golem-fight(-lite).wav
│   ├── giant-bat/           giantBat-calm(-lite).wav, giantBat-fight(-lite).wav
│   ├── skeleton/            skeleton-calm(-lite).wav, skeleton-fight(-lite).wav
│   ├── giant-spider/        giantSpider-calm(-lite).wav, giantSpider-fight(-lite).wav
│   ├── dragon/              dragon-calm(-lite).wav, dragon-fight(-lite).wav
│   └── cinematics/          intro.wav, descent.wav, outro.wav
├── sfx/                     sfx.md; one folder per family
│   ├── akeris/              his body: steps, jumps, rolls, hurt, drink, death…
│   ├── weapons/             the five weapons' strikes and the chain
│   ├── shields/             blocks, the just block, breaking, restoring
│   ├── combat/              hits, reflect, freeze, burn, ink smoke, fire and ice
│   ├── items/               pickup, altar, scrolls, curses, XP and coins
│   ├── ui/                  menus, map, dialogue sheet, death, settings
│   ├── ambience/            each zone's air under its music
│   ├── zone-1/              the zone 1 hazards (step 3.9)
│   └── boss-room/           the boss doors sealing and opening, every zone
├── voice/                   voice.md
│   └── spirits/             the 24 syllables and the sigh
└── sandbox/                 sandbox.html and captures/
```

The game mirrors this under `assets/audio/` (`music/<family>/`, `sfx/<family>/`, `voice/spirits/`).
Each later step adds its own folder: `music/zone-<N>/`, `music/<boss>/`, and the enemies' sounds in
`sfx/enemies/<enemy>/` and the bosses' in `sfx/bosses/<boss>/`, with their rows in `sfx/sfx.md`.

## 3. Files

WAV, 44.1 kHz, 16-bit, normalised to −1 dBFS: effects and voice mono, music stereo. File names are the
id without its prefix, dots turned into hyphens, and `-1…n` for variations (`sfx.akeris.step` →
`sfx/akeris/akeris-step-1.wav`). The music weighs about 80 MB; effects 6.8 MB; voice 2.1 MB.
Which format the game ships (WAV, OGG or MP3) is the architect's choice; these are the masters.
The WAV files are stored with **Git LFS** (`*.wav` in `.gitattributes`, operator 2026-10-01): run
`git lfs install` once per clone.

**Exporting again:** open the sandbox with `#exportar-audio=sfx`, `#exportar-audio=voice` or
`#exportar-audio=<music id>`; the files appear in `<pre id="export">` with their path, as the PNGs of
the other sandboxes. A re-export may differ by one 16-bit step (Chrome's float rounding).

## 4. The sandbox

The interface sandbox (`06-ui/sandbox/`) unchanged, with the sound block added: a key or a click
switches the sound on. Akeris, the dummy, the altars, the scrolls, the HUD, the pause menu, the map,
the spirit, the title, the slots, the settings, death and loading all sound as the game will. Under
the game, the **Mesa de sonido** plays every effect and its variations, every cue, and a stand-in
boss room (*Entrar*, *Despierta*, *Vencido*) until step 3.11. The music is composed when the sound is
switched on (a few seconds; the board says *Componiendo la música…*).

## 5. Decisions (A1–A8)

The operator approved A1–A8 as proposed (2026-10-01).

| # | Question | Decision (as the sandbox does it) |
|---|---|---|
| A1 | Pause and map in a boss room | the light version of the boss cue that is sounding |
| A2 | After the boss dies | the fight fades out in 2 s, 2 s of silence, then the zone's light cue until the zone ends |
| A3 | The fight's entry | on the calm's next beat (at most 1 s), with the calm fading in 1 s |
| A4 | Dialogue | the music ducks −6 dB and the ambience drops to 0.35 while a dialogue is open |
| A5 | The spirits' voice | one whispered syllable per word, at most one every 0.11 s; each spirit a fixed tone (zone 1: warning 0.90, lore 1.08) and a sigh on opening |
| A6 | A just block | its own bright ting (`sfx.shield.just`) over the shield's block, the counter or the reflect |
| A7 | Zone ambience | each zone has a quiet looped air under its music; zone 1's, the immense cavern, came with its biome (step 3.9) |
| A8 | Loudness | effects and music with a square volume curve; 24 effects at once at most, cut by priority |

## 6. Never

- Anything recorded or taken from outside the project (`VISION.md`).
- A sound or cue not listed in these files.
- A victory fanfare, a beep, gore, or a voice for Akeris (`00-game/tone.md`).
