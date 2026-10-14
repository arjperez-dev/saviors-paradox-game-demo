# Music

- **Status:** approved 2026-10-01
- **Sources:** `VISION.md` §Scope (one track per zone; menu and boss tracks soft), §Client constraints
  (composed within the project) · `00-game/tone.md` §3 · `01-story/cinematics/` · `06-ui/title/`,
  `pause-menu/`, `map/`, `dialogue/`, `death/`, `loading/` · the operator's decisions of 2026-09-30 (§1)
- **Made in:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html): every cue is a score written there
  (`MUSIC` in the sound block) and synthesised with a seed. The sandbox plays it where the game would;
  the *Mesa de sonido* plays each cue and tries the boss room.
- **Read by:** any task that plays music or changes it with the game state; the tester

---

## 1. What the operator decided (2026-09-30)

- **Cues:** one for the title screen (melancholic, sad), **one per zone that sounds like its zone**,
  and **each boss room has two**: a soft one before the fight and a fight one. The pause menu and the map
  play **a light version of the music that is sounding**, never a new piece.
- **Instruments:** everything that can be made: choir, piano, percussion (big drums, taiko, timpani),
  strings and violin, flute, harp, celesta, horns, organ. The operator asked for **big drums and choir**
  in the zones.
- **Made here:** synthesised in the sandbox and exported to WAV; nothing comes from outside.

Every cue stays muted and sad: no major-key victory, no fanfare (`00-game/tone.md`). A fight is tense,
never triumphant.

## 2. The cues

| Id | Plays | Loop | Length (s) | Key, tempo | Files (`music/…`) |
|---|---|---|---|---|---|
| `music.title` | title, save slots, settings | yes | 58.2 (16 bars) | D minor, 66 bpm | `title/title.wav` |
| `music.zone1` | zone 1 in play | yes | 80.0 (24 bars) | E Dorian, 72 bpm | `zone-1/zone1.wav`, `zone1-lite.wav` |
| `music.zone2` | zone 2 in play | yes | 64.0 (24 bars) | B minor with the Phrygian C and F♯ major, 90 bpm | `zone-2/zone2.wav`, `zone2-lite.wav` |
| `music.zone3` | zone 3 in play | yes | 60.0 (24 bars) | D minor (lament bass, Neapolitan E♭, tritones), 96 bpm | `zone-3/zone3.wav`, `zone3-lite.wav` |
| `music.zone4` | zone 4 in play | yes | 57.6 (24 bars) | A minor with the rotting B♭, 100 bpm | `zone-4/zone4.wav`, `zone4-lite.wav` |
| `music.zone5` | zone 5 in play | yes | 53.3 (24 bars) | F minor with the Neapolitan G♭, 108 bpm | `zone-5/zone5.wav`, `zone5-lite.wav` |
| `music.golem.calm` | the Golem's room before the fight | yes | 32.0 (8 bars) | C minor, 60 bpm | `golem/golem-calm.wav`, `golem-calm-lite.wav` |
| `music.golem.fight` | the Golem's fight | yes | 68.6 (32 bars) | C minor with the Phrygian D♭, 112 bpm | `golem/golem-fight.wav`, `golem-fight-lite.wav` |
| `music.giantBat.calm` | the Giant Bat's room before the fight | yes | 32.0 (8 bars) | F♯ minor with the Phrygian G, 60 bpm | `giant-bat/giantBat-calm.wav`, `giantBat-calm-lite.wav` |
| `music.giantBat.fight` | the Giant Bat's fight | yes | 60.0 (32 bars) | F♯ minor with the Phrygian G, 128 bpm | `giant-bat/giantBat-fight.wav`, `giantBat-fight-lite.wav` |
| `music.skeleton.calm` | the Skeleton's room before the fight | yes | 32.0 (8 bars) | G minor with the Phrygian A♭, 60 bpm | `skeleton/skeleton-calm.wav`, `skeleton-calm-lite.wav` |
| `music.skeleton.fight` | the Skeleton's fight | yes | 73.8 (32 bars) | G minor with the Phrygian A♭, 104 bpm in triplets | `skeleton/skeleton-fight.wav`, `skeleton-fight-lite.wav` |
| `music.giantSpider.calm` | the Giant Spider's room before the fight | yes | 32.0 (8 bars) | E Phrygian, 60 bpm | `giant-spider/giantSpider-calm.wav`, `giantSpider-calm-lite.wav` |
| `music.giantSpider.fight` | the Giant Spider's fight | yes | 58.2 (32 bars) | E Phrygian, 132 bpm | `giant-spider/giantSpider-fight.wav`, `giantSpider-fight-lite.wav` |
| `music.dragon.calm` | the Dragon's room before the fight | yes | 32.0 (8 bars) | B♭ Phrygian, 60 bpm | `dragon/dragon-calm.wav`, `dragon-calm-lite.wav` |
| `music.dragon.fight` | the Dragon's fight | yes | 64.0 (32 bars) | B♭ minor, 120 bpm | `dragon/dragon-fight.wav`, `dragon-fight-lite.wav` |
| `music.intro` | the intro cinematic | no | 45.0 | — | `cinematics/intro.wav` |
| `music.descent` | *New game* on the title screen: the descent (approved 2026-10-14) | no | 4.6 | — | `cinematics/descent.wav` |
| `music.outro` | the outro cinematic (43.5 s; `music.title` comes in at 39.5 s) | no | 39.5 | — | `cinematics/outro.wav` |
| `music.dragon.fall` | the Dragon's death, before the ability choice | no | 9.0 | — | `dragon/dragon-fall.wav` |

The operator asked that the cues of zones 2–5 and their bosses be **more energetic than zone 1's and
sound like their biome** (2026-10-01); all of them are done, each in its own folder (`zone-<N>/`,
`<boss>/`). The Dragon's fight is the one exception to «muted»: the operator asked for it **epic and
melancholic**, because a mythical creature is being killed; it is still never triumphant.

### `music.title` — the title screen

- **Mood:** melancholic, sad, quiet. The dungeon's mouth at dusk.
- **Instruments:** piano (a falling melody over broken chords), low strings and cello, a soft choir on
  «oo» from bar 9, a flute in the last four bars; one deep, soft drum at bar 9.
- **Form:** two eight-bar phrases (Dm Bb F C Dm Gm Bb A, then the same higher, with choir).
- **Starts / stops:** from black in 0.6 s with the title (U41); fades in 0.4 s with any fade to black.
  The settings' music volume changes it live, so it is heard.

### `music.zone1` — Suspended Sanctuary

- **Mood:** high, airy and sacred: ruins that float because the stones forgot how to fall
  (`01-story/zones-narrative.md`).
- **Instruments:** harp arpeggios and flute (the air), celesta notes picked by seed (stones that do not
  fall), high strings; from bar 9 the choir on «ah» (the sanctuary), the big drums on beats 1, 3½ and 4
  (the weight that forgot to fall), cello and a violin melody; bars 17–24 add low piano and a shaker;
  timpani rolls close bars 16 and 24.
- **Form:** A (bars 1–8, harp and flute, a drum every other bar), B (9–16, choir, drums, violin),
  C (17–24, everything, the flute back).
- **Light version** (`zone1-lite.wav`): harp, celesta, high strings, flute and violin, without choir,
  drums or lows, slightly darker (low-pass 5 kHz).

### `music.zone2` — Echo Caverns

- **Mood:** caves that keep every sound ever made in them (`01-story/zones-narrative.md`): dripping
  water, the dark, and every note coming back. Faster and more driven than zone 1.
- **Instruments:** water drops (a sine that jumps up and leaves a tuned note, B minor pentatonic, two or
  three a bar placed by seed, each with two echoes); pizzicato strings in eighth notes from bar 1; a low
  string drone; high strings held; **every melody has its echo**: it sounds again a beat and a half
  later (a dotted eighth), quieter, on the other side of the stereo.
- **Form:** A (bars 1–8: drops, pizzicato, the cello melody low, a loose taiko), B (9–16: choir on «o»,
  taiko in eighth notes, big drums on 1 and 3, tom fills every four bars, the violin melody),
  C (17–24: choir on «a», the horn, a shaker, the violin above); timpani rolls close bars 16 and 24.
- **Light version** (`zone2-lite.wav`): the drops, the high strings and the melodies with their echoes,
  without drums, choir or lows (low-pass 5 kHz), about 4.5 dB under the full one.

### `music.zone3` — Sunken Graveyard

- **Mood:** dark and sinister, something wrong in it: the graves of everyone who came down, dug before
  they are needed, and dead who do not stay still (`01-story/zones-narrative.md`). The operator asked
  for it darker and more ghastly once, and approved it then.
- **Instruments:** an **out-of-tune music box** (celesta doubled almost a semitone sharp) with the A
  melody, back at bars 23–24; a deep **tolling bell** (every other bar, then every bar) and from bar 9 a
  **second bell a tritone away**; **bones** knocking in limping eighth notes; **the gravedigger's
  shovel** on beat 4, then on 2 and 4; walking pizzicato in eighth notes; **the abyss**: an organ pedal
  on D and its tritone A♭ all through; a high tremolo with a minor second on top; a low choir murmur on
  D and E♭ in A; **groans**, low strings that swell and drag down a minor third every four bars;
  **ghost gusts** that suck in towards bars 9, 17 and the loop.
- **Form:** A (bars 1–8: music box, bell, bones, murmur), B (9–16: the dead sing the *Dies irae*, the
  plainchant, in a low choir in two octaves; organ, taiko and big drums), C (17–24: the violin low,
  choir on «oo», the second bell, tom fills, the music box again); timpani rolls close bars 16 and 24.
  The A chord at bars 5 and 23 has a flat fifth.
- **Light version** (`zone3-lite.wav`): the music box, the bells, the violin and the tremolo, without
  drums, choir or lows.

### `music.zone4` — Rotting Canopy

- **Mood:** an underground jungle: the roots of the world above, grown down into the dark and rotting
  as the days run out; someone waits at the bottom, holding the clock, counting
  (`01-story/zones-narrative.md`).
- **Instruments:** hand drums (low, mid and slap); a **marimba in groups of three sixteenths** that
  cross the four-beat bar; a **reed flute**, breathy, with the A melody; **the jungle**: cicadas that swell
  every four bars, frogs and bird calls placed by seed; **a wooden clock that counts faster and faster**
  (every two beats in A, every beat in B, every eighth note in C); a low string drone and high strings;
  the B♭ that rots the harmony at bars 15 and 22.
- **Form:** A (bars 1–8: drums, marimba, the flute, the jungle), B (9–16: choir hits on «o», big drums
  and taiko, shaker, the violin melody), C (17–24: the horn, choir on «a», shaker in sixteenths);
  timpani rolls close bars 16 and 24.
- **Light version** (`zone4-lite.wav`): the flute, the violin, the horn, the marimba, the high strings,
  the cicadas and the birds; without drums, choir or lows.

### `music.zone5` — Dragon Battlements

- **Mood:** walls Akeris's people built not to keep things out but to keep something from coming up;
  someone watches from the walls (`01-story/zones-narrative.md`). A march of the watch: grave, never
  triumphant.
- **Instruments:** low strings in a marching rhythm (dotted eighth and sixteenth); a **military snare**
  (loose rolls in A, the full march from B with a roll every four bars); big drums and taiko; **the side
  wind** between the merlons, gusts that rise, whistle and go; **the bell of the watch** every four
  bars; embers crackling in C; **the call of the one watching from the walls**: a lone, distant trumpet
  at bars 2, 6, 14 and 22, coming back in echo on the other side.
- **Form:** A (bars 1–8: the march, the wind, the choir humming on «o», the call), B (9–16: the full
  march, choir hits, the horn melody over the cello), C (17–24: the trumpet melody, choir on «a»,
  tremolo, timpani on the downbeats, embers); timpani rolls close bars 16 and 24.
- **Light version** (`zone5-lite.wav`): the call and its echo, the horn, the trumpet, the high strings,
  the wind and the bell; without drums, choir or lows.

### `music.golem.calm` — before the fight

- **Mood:** held breath. Something huge is asleep.
- **Instruments:** an organ drone on C, low choir on «oo» (Cm, Ab, G), a soft heartbeat on the big drum
  every bar, stone grinding, a low piano note at bars 1 and 5, a timpani roll into the loop.
- **Light version:** the drone and the choir.

### `music.golem.fight` — the fight

- **Mood:** tense and heavy, never triumphant.
- **Instruments:** taiko ostinato and big drums, low strings in eighth-note ostinato, choir hits on «ah»,
  horns with the melody (bars 9–24; an octave up from 17), tremolo violins and legato choir in the climax
  (17–24), a quieter breakdown (25–28) that builds back; tom fills every eight bars; low piano clusters.
- **Light version:** the drone, the low strings held and the choir; no drums.

### `music.giantBat.calm` — before the fight

- **Mood:** it hangs from the ceiling in the dark; only its eyes show (`VISION.md` §Bosses).
- **Instruments:** an organ drone on F♯, low choir on «oo», **its echolocation**: pairs of high clicks,
  as if feeling its way, each coming back three times on the other side; two wing flutters that swell
  and fold away (bars 3 and 7), a drop now and then, a low piano note at bars 1 and 5, a timpani roll
  into the loop.
- **Light version:** the drone and the choir.

### `music.giantBat.fight` — the fight

- **Mood:** fast and fluttering, tense, never triumphant; faster than the Golem's.
- **Instruments:** strings in **sixteenth notes that flutter** over the root, taiko and big drums,
  choir hits on the off-beats (bars 1–16), **the clicks with their echo** all through, a wing flutter
  every four bars; the horn with the melody and its echo (bars 9–24; an octave up from 17), tremolo
  violins and legato choir in the climax (17–24); a breath (25–28) with only flutters, clicks and choir
  that builds back; tom fills every eight bars.
- **Light version:** the drone, the low strings held and the choir; no drums.

### `music.skeleton.calm` — before the fight

- **Mood:** the oldest of the dead, lying down; as dark as its zone.
- **Instruments:** the abyss (an organ on G and its tritone D♭), low choir on «oo», a very low voice
  singing the *Dies irae* slowed right down, the tolling bell every other bar, **its bones trembling**
  at bars 3 and 7 (knocks that crowd together and stop, as if it were about to stand), a fragment of the
  out-of-tune music box, a timpani roll into the loop.
- **Light version:** the drone and the choir.

### `music.skeleton.fight` — the fight

- **Mood:** a dance of death in triplets; tense and dark, never triumphant.
- **Instruments:** strings galloping in triplets, a **bone xylophone** with limping arpeggios (bars 1–8
  and 17–24, an octave up), taiko at a gallop and big drums, choir hits (bars 1–16), **the *Dies irae*
  in the horns** (bars 9–16; an octave up in the climax, 17–24, with tremolo violins, legato choir and
  the second bell a tritone away); the tolling bell every other bar; ghost gusts before each section.
- **It falls and reassembles** (bars 25–28): the music stops, the bones scatter, the out-of-tune music
  box plays the theme; then the bones gather faster and faster and the gallop comes back.
- **Light version:** the drone, the low strings held and the choir; no drums.

### `music.giantSpider.calm` — before the fight

- **Mood:** it weaves in the roots and waits, hanging; the jungle has gone quiet.
- **Instruments:** an organ drone on E, low choir on «oo», **threads of the web plucked** (very high,
  harp-like notes that tighten and slacken a little), **legs running** twice (eight dry taps in an
  instant), the zone's wooden clock slowed to every two beats, the last cicada falling silent at the
  start, a low piano note at bars 1 and 5, a timpani roll into the loop.
- **Light version:** the drone and the choir.

### `music.giantSpider.fight` — the fight

- **Mood:** eight legs, fast and crawling; tense, never triumphant.
- **Instruments:** strings in sixteenth notes that **crawl a semitone** above and below the root; the
  zone's marimba in groups of three over them; hand drums, taiko and big drums; legs running and
  threads plucked; **the venom**, low strings that swell and drag down, every eight bars; choir hits
  (bars 1–16); the horn with the melody (bars 9–24; an octave up from 17), tremolo violins and legato
  choir in the climax; tom fills every eight bars.
- **It hangs from its thread** (bars 25–28): only the clock, the threads, the legs and the choir; then
  it comes down again.
- **Light version:** the drone, the low strings held and the choir; no drums.

### `music.dragon.calm` — before the fight

- **Mood:** the last guard sleeps high on the walls; it forgot why it guards, not how.
- **Instruments:** **its breathing** (low air that goes in and out every two bars), embers, the zone's
  side wind, a very low organ drone, low choir on «oo», an ancient horn in long notes, and at bar 5,
  far away, **the call of the one watching** (zone 5's motif) with its echo; a timpani roll into the loop.
- **Light version:** the drone and the choir.

### `music.dragon.fight` — the fight

- **Mood:** **epic and melancholic** (operator, 2026-10-01): a dragon, the threshold boss, and they are
  killing it, the last of something that will not come back. The biggest fight, never triumphant.
- **Harmony:** a sad epic in B♭ minor: B♭m B♭m G♭ G♭ D♭ A♭ E♭m F; the F major leaves each phrase hanging.
- **Melody:** long and breathing, rising to G♭ and falling slowly. Bars 9–16: the horns, with choir on
  «o» and high strings held under them. Bars 17–24, **the climax**: violins, trumpet, horns and the full
  choir on «a» sing it together, with the organ; the drums go to half time to sound broader, timpani on
  every bar.
- **The lament** (bars 25–28): all the drums fall away; piano and cello play the melody alone over the
  choir on «oo» while the dragon breathes; the distant call of the one watching. Bars 29–32: a timpani
  roll and everything grows back into the loop.
- **The dragon in the music:** a roar with a flare of fire at the start and at the climax, a quake
  before each section, its wings (wind), embers.
- **Section A** (bars 1–8): low strings in eighth notes, taiko, big drums, the battlements' snare, brass
  stabs and choir hits.
- **Light version:** the drone, the low strings held and the choir; no drums.

### `music.intro` and `music.outro` — the cinematics

The intro (`01-story/cinematics/intro.md`, the operator's second 2026-10-13 script; this part *approved*
2026-10-14) is scored to its ten shots, 45 s: in the ruins (0–6 s) the fire's low breath and crackle, the wind, and
a lone low melody (a cello-like string: D3 F3 E3 C3 D3); going into the dream (6–9 s) the melody stretches far into
the reverb (A2, F3, a soft organ D2) as the fire's sound fades; the short circuits (9–14 s): a band of static at
each gap and each cut with its own sound — blades clashing, a shield struck, a streak whooshing, a hand on a ledge
(scrape and breath), a roar, the cape in the wind, the five bosses (a low organ chord and a drum) — over a faint
breathing; the Time Chamber (14–20 s): heavy steps on each of the torn Akeris's footfalls, a held low note (D2,
A2) cut by the one blow (18 s), then silence; the clock taken (21.2 s): the deep tick and a low note that bends down
(D2 to A1); the end of the world (24–32 s): a rising rumble, the hand striking (27.4 s), the crack of the bolt
(27.6 s) and a long roar that thins into nothing by 31.9 s; Future Akeris (32–37 s): static at each cut and a
heartbeat, a snap when the card appears (34.15 s); the waking: a sharp breath (37.15 s) and the embers; black
(40–41 s): silence; the run to the temple (41–45 s): running steps on each footfall, his stop (42.85 s), the air
of the dungeon's mouth. The times it shares with the picture are listed in the score (`marks`) and checked by the
cinematic's sandbox. Then `music.title` starts, as the home screen shows.
`music.descent` (*New game*, approved 2026-10-14): footsteps on stone fading into the dark, one per footfall
(0.6 s and every 0.48 s), over a low organ D2; 4.6 s. Both are rendered with a convolution reverb whose impulse
response is seeded, so a re-export gives the same WAV (at most one least-significant bit apart in a few samples);
the other cues keep their comb reverb.
The outro (`01-story/cinematics/outro.md`, the operator's second 2026-10-14 script; this part *approved* 2026-10-14):
killing the Dragon must feel like a mistake. **`music.dragon.fall`** (9 s): when the Dragon falls, the fight does not
end on a hit; the game fades it out (3 s) and a lone, low cello line goes down (D3, C3, A2, D2) over a faint organ D2;
no victory chord. Under everything from the moment its ink is gone runs **the room clock** and, in the short circuit,
**the corrupted clock** (`../sfx/sfx.md` §Cinematics: the game schedules them, so the room clock does not restart when
the ability is chosen and the corrupted one always lands between two room ticks). **`music.outro`** (39.5 s, from
taking the ability) is the bed: walking out (0–5 s) a cold wind; the fog (5–9 s) a low organ (D1, A1) and a dark
noise that swell and are cut dead by the black at 9 s (the great blow is `sfx.outro.blow`); the one behind (10.5–13 s)
a held, harsh breath; the cards: silence (the room clock); his world (17–25 s) everything through **interference** (operator,
2026-10-14): a band of static at each gap of the nine cuts, and the low, dissonant D2–E♭2–A♭1 and its sub crushed to a few
levels, band-limited, with short dropouts and a stutter on each cut, over tape hiss and a bending radio whine; the charge (28–34.9 s) a grinding detuned sawtooth cluster that
rises, is held through the third card and rises to its peak as the sword comes down, and with it **something being
destroyed** (operator, 2026-10-14): stone and metal cracking, falling debris, tearing, ever closer together as the charge
grows, over a crumbling low rumble; in its last 0.42 s (`swell10`, 34.48 s) the grind shoots up in pitch and filter
with the massive tick's own reverse swell, and flows with no gap into the hit (`sfx.clock.massive`, 34.9 s), where it
stops. The last card lasts 8 s (35.5–43.5 s): the tick's bass tail dies away under it, and from 39.5 s (`title11`, where
`music.outro` ends) the game brings `music.title` in under the tail (fade-in 4 s; D minor like the bass), so the tail
hands over to the title music with no gap and no jump; the home screen then lifts from black in 1.2 s. The times it shares
with the picture are its `marks`, checked by the zone 5 sandbox (`otTests()`). Both cues are rendered with the seeded
convolution reverb.

## 3. The music director: which cue, when

| Game state | Music |
|---|---|
| title, save slots, settings | `music.title` |
| a fade to black (start, load, exit, quit from the pause) | the cue fades out in 0.4 s |
| loading screen | silence (`06-ui/loading/`) |
| intro cinematic | `music.intro`; skipping it cuts it in 0.4 s |
| *New game* on the title screen | `music.title` fades out (0.4 s) and `music.descent` plays the descent; then zone 1 |
| in play | the zone's cue, from 0.4 s after the black lifts |
| pause menu or map open | the **light version**, crossfaded in 0.4 s **at the same point**; back to the full one on closing |
| dialogue open | the music ducks −6 dB (`../sfx/sfx.md` §3) |
| entering the boss room | the zone cue fades out (0.8 s); the boss's `calm` fades in (1 s) |
| the boss wakes | the `fight` starts on the calm's next beat; the calm fades out in 1 s |
| paused in the boss room | the light version of the boss cue that is sounding |
| boss defeated | the fight fades out in 2 s, 2 s of silence, then the zone's **light** cue until the zone ends |
| the Dragon defeated (zone 5, approved 2026-10-14) | the fight fades out in 3 s into `music.dragon.fall`; the room clock (`sfx.clock.room`) from when its ink is gone; taking its ability starts `music.outro` |
| Akeris dies | the cue fades out over the death (3.25 s); the death sheet plays `sfx.ui.runOver`, no music |
| next zone | the cue fades out with the fade to black (0.6 s); the next zone's starts as the black lifts |

The full and the light files of a cue have the same length and start together, muted on one side,
so the crossfade never jumps. Every loop is rendered so its end runs into its start with the reverb
tail already there: it loops with no seam.

## 4. Files

44.1 kHz, 16-bit, stereo WAV, peak −1 dBFS; the light file shares the full file's gain, so neither
jumps in loudness at the crossfade. Exported from the sandbox with `#exportar-audio=<cue id>`
(`<pre id="export">`, like the PNGs of the other sandboxes). A re-export may differ from the committed
file by one step of 16 bits (Chrome's float rounding); it sounds the same.

## 5. Never

- A triumphant cue: no major-key cadence after a boss, no fanfare.
- A new piece in the pause menu or the map: it is the same cue, light.
- Music under the loading screen or the death sheet.
- A cue that restarts from the beginning when the pause closes.

## 6. Acceptance

1. Each state in §3 plays the cue in that row, with the fades in that row.
2. Opening and closing the pause or the map crossfades in 0.4 s and the music keeps its place.
3. A loop runs for ten minutes with no click at its seam.
4. The boss's fight starts on a beat of the calm, never in the middle of one.
5. The settings' music volume at 0 silences all music and no sound effect.
