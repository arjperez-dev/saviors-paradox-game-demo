# Outro

- **Status:** approved 2026-10-14 (the operator approved the outro as built) · **rewritten by the operator 2026-10-14, second version** (the Dragon's death made
  melancholic, a mistake rather than a victory; distorted clocks from the moment it vanishes; the walk to the way down;
  the fog; black and a great blow; Future Akeris behind him; his cards; a longer short circuit of his hatred and pain
  under the corrupted clock; the corrupted charge of his sword; «I have to do it»; the massive tick; «To be
  continued»). It replaces the 2026-09-30 script and the first 2026-10-14 version (no teleport, no zone 6)
- **Sandbox:** played in the zone 5 sandbox, in the real Dragon room
  (`../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`, «Final (tras el dragón)»); *approved* 2026-10-14 (operator: «me encantó todo»)
- **Sources:** `VISION.md` §Win / lose conditions, §Content scope (Cinematics), §Non-goals ·
  `../premise.md` §4 · `../characters.md` §2 · `intro.md` (shots 3, 6 and 7: the short circuits, the clock in the sky,
  Future Akeris's look) · `../../04-zones/zone-5-dragon-battlements/boss-room.md` ·
  `../../03-characters/bosses/dragon/contract.md` (its defeat)
- **Read by:** the task that builds the outro, and whoever draws or scores it.

## The mood

Killing the Dragon must feel **like a mistake, not a won phase**: melancholy first, then dread. No fanfare, no victory
sting. From the moment the Dragon vanishes a **distorted clock** ticks in the background (*the room's clock*: slow,
warped, detuned, slightly irregular) and it never stops until the final cut — under the ability choice, the walk, the
fog, the cards and the short circuit. The short circuit has **its own clock** (*the corrupted clock*: huge, metallic,
painful and powerful); the two are different sounds and must be heard as two: different pitch and tempo, the corrupted
one landing between the room clock's ticks, the room clock ducked (not stopped) under it.

## Before the outro: the Dragon's death (in the fight, before the ability choice)

The Dragon's defeat (its contract) is kept but slowed and made sad: the fight music does not end on a hit; it drains into
a lone, low line. The Dragon sinks, its last breath goes out toward Akeris, its eye dims slowly; Akeris lowers his
sword. Then it dissolves into ink smoke as before — and as the last of it goes, **the room clock starts**. Then the
ability choice (as now), with the room clock still ticking under it.

## The outro (from taking the ability)

The player has no control from shot 1 on. No voice: images, sound and four cards; the first three are Future Akeris's
thoughts and nothing names him. Static pencil stroke: no line boil. The fog moves smoothly as a function of time (the
same instant gives the same picture). Flashes only in the short circuit and at Future Akeris's arrival. Durations are
defaults in seconds; the game logic runs them from `dt`.

| # | Shot | Duration (s) | Picture | Sound | Text |
|---|---|---|---|---|---|
| 1 | Walking out | 5 | The gates of the two gate towers open. Akeris walks slowly toward the way down, head low; the camera follows | the room clock; slow footsteps; wind | — |
| 2 | The fog | 4 | Fog rises from the floor and fills the room; the light goes grey and heavy; the scene grows tense | the room clock, heavier; a low drone that swells; the footsteps slow and stop | — |
| 3 | The blow | 1.5 | **Black.** | **a great, deep blow** in the background; the room clock keeps on under it | — |
| 4 | The one behind | 2.5 | Back in the fog: **Future Akeris** stands right behind Akeris (fully torn cape, curved battered sword, very dirty, the battered broken red streak, as in the intro). Akeris does not see him | the room clock; a held, harsh breath | — |
| 5 | Card | 4 | Black. | the room clock, faint | `cinematic.outro.card1` |
| 6 | His world | 8 | A long short circuit, as in the intro but more cuts (8–10): the weight of his hatred and pain at having destroyed everything — the erased world, broken towers falling, ash; him on his knees among it, hands to his head; his broken sword in the ash; the clock in the sky **fully corrupted** (cracked, black, red and purple), ticking with pain and power; the last cut on the clock | the corrupted clock, painful and huge, between the room clock's ticks; static between the cuts | — |
| 7 | Card | 3 | Black. | the room clock alone again | `cinematic.outro.card2` |
| 8 | The charge | 4 | Back in the fog: Future Akeris raises his sword; it fills with a grim, corrupted light (black and purple with a red heart), thick with hatred, growing | the room clock quickening; a rising, grinding charge | — |
| 9 | Card | 2 | Black. | the charge held, the room clock | `cinematic.outro.card3` |
| 10 | The strike | 1.5 | The sword comes down; an instant before it touches Akeris, **a massive clock tick** — cut to black on that frame | **the massive tick**; then everything stops, the room clock too | — |
| 11 | Card | 8 | Black. | silence | `cinematic.outro.card4` |
| | **Total** | **43.5** | | | |

Then the home screen (`06-ui/title/title.md`): the run's slot is kept, marked won, and can no longer be continued (S6).

## Texts

| Key | English | Español |
|---|---|---|
| `cinematic.outro.card1` | Did I ever really believe I would save the world? | ¿De verdad en algún momento creí que yo salvaría el mundo? |
| `cinematic.outro.card2` | I have to stop all of it. | Tengo que detener todo. |
| `cinematic.outro.card3` | I have to do it. | Tengo que hacerlo. |
| `cinematic.outro.card4` | To be continued… | Continuará… |

## Never

- The strike never lands: the massive tick cuts it an instant before (`VISION.md` §Non-goals: no fight with him).
  What the tick does is not shown.
- No text names Future Akeris or says he is Akeris (`../premise.md` §4).
- No blood; no victory music or sting after the Dragon.
- No line boil; flashes only in shots 4 and 6.

## Decisions

| # | Question | Decided |
|---|---|---|
| S6 | What happens to the save slot after the outro? | it is kept, marked as won, and can no longer be continued; the home screen offers a new game (operator, 2026-09-30) |
| S7 | Can the outro be skipped? | yes, always, from the first time, with the same key as the intro: holding Enter or Esc for 5 s (S4) (operator, 2026-09-30). (D): a control, moved into `VISION.md` in step 5.1 |
| S8 | What does the outro tell? | the operator's second 2026-10-14 script above; it plays in the Dragon room after the ability choice (CI3, operator 2026-10-13) |
