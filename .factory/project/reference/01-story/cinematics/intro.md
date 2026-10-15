# Intro

- **Status:** approved 2026-10-14 (the operator approved the animation of the second 2026-10-13 version) · **rewritten by the operator 2026-10-13, second version** (Akeris asleep alone by a
  fire in the ruins; the dream, blurred like a flashback; short circuits of the Akeris who will be corrupted fighting
  through the dungeon; the Time Chamber, the Time Guardian killed (a silhouette); the clock taken, the purple streak;
  the giant clock in the sky and the bolt that destroys the world; a short circuit of Future Akeris and the card; the
  waking; black; the run to the temple). It replaces the 2026-09-30 script and the first 2026-10-13 version
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) plays this script (the second 2026-10-13 version: ten
  shots, 45 s) shot by shot with `music.intro`, and *New game*'s descent with `music.descent` (the animation is
  *approved* 2026-10-14, operator: «haz hecho algo impresionante») · storyboard [`intro-sheet.png`](intro-sheet.png) (the ten shots and the descent) · captures
  `sandbox/captures/intro-<n>-<name>.png` (one per shot, the in-betweens, the home screen, the descent) · the dream
  Akeris after the take: `../../03-characters/corrupted-akeris/sprites/intro-dream.png` · Future Akeris of the short
  circuit: `../../03-characters/future-akeris/sprites/intro-short-circuit.png`. It also proposes the skip control's
  hint, `cinematic.skip` (`Hold to skip` / `Mantén para saltar`)
- **Sources:** `VISION.md` §Content scope (Cinematics), §Vision statement · `../premise.md` §4 ·
  `../characters.md` §1–3, §6 · `../../00-game/glossary.md` (Time Clock, Time Chamber, Time Guardian) ·
  `../../02-art-direction/ART_DIRECTION.md` · `../../00-game/tone.md` · `../../06-ui/title/title.md`
- **Read by:** the task that builds the intro, and whoever draws or scores it (`03-characters/`,
  `07-audio/`, `06-ui/`).

## When it plays

**When the game opens, before the home screen.** Its last shot is Akeris running up to the mouth of the dungeon and
stopping where the home screen shows him; then the home screen's options fade in over the same drawing
(`06-ui/title/title.md`). It can be skipped (S4); skipping lands on the home screen.

**The descent is no longer part of the intro:** choosing *New game* on the home screen plays *the descent* — Akeris,
from where he stands, walks into the arch and goes down the stair into the dark (about 4 s, footsteps fading) — and
zone 1 starts. *Continue* and *Load* skip it.

## The story it tells

Akeris, the last of his race, lives alone in the ruins of a half-destroyed medieval world. He sleeps by a fire and
dreams: an Akeris like him fights his way down the dungeon, kills the Time Guardian, takes the clock and is corrupted;
a giant clock appears over the world and its bolt destroys everything; a battered Akeris tells him to save the world.
He wakes, and runs to the temple. *The Temple of Time* is what the card calls the dungeon. No voice: images, sound and
one card.

## Look

- **Waking world** (shots 1, 8, 10): the game's static pencil stroke. Medieval ruins: broken walls, fallen columns, a
  roofless hall, weeds; the sky low and grey. Melancholy: Akeris small and alone, the fire the only warm light.
- **The dream** (shots 2–7): blurred like a flashback. Soft focus, a faded, washed-out paper, a heavy vignette, edges
  that dissolve into white; the blur and the wash are the same for the same frame (nothing boils).
- **The short circuits** (shots 3, 7): very short frames (0.2–0.6 s) cut hard, with a white flash and a band of
  scratched static between them, like a memory that jumps. Each frame is a still drawing; only the cuts jump. This is
  the one place where the picture flashes.
- **The tremble** (shot 6): the whole picture shakes as one piece; no stroke wobbles on its own.

---

| # | Shot | Duration (s) | Picture | Sound | Text |
|---|---|---|---|---|---|
| 1 | Alone in the ruins | 6 | Night in the ruins of a hall: broken walls, a fallen column, no roof, a few stars. Akeris asleep on the ground by a small fire, curled under his cape, his sword beside him. No one else. The camera eases in slowly | the fire crackling, wind, a lone low melody | — |
| 2 | Into the dream | 3 | The fire's glow swells and washes the picture to white; the dream fades up, blurred: a stair going down into the dark, seen as from far away | the melody stretches, distant | — |
| 3 | Short circuits | 5 | Flashes of the dungeon as a memory, 6–8 cuts: two blades crossing in sparks; a shield struck; a red streak running in the dark; a hand on a ledge; a great shadow roaring; the torn cape in the wind; the five bosses as shapes only. Never a whole room | sword clangs, a roar, breathing — each cut with its own sound, broken by static | — |
| 4 | The Time Chamber | 6 | Still blurred. An Akeris all torn — cape in rags, cuts, bent over his sword, red streak — reaches a vast round chamber. The Time Guardian, only a tall black silhouette, stands before the clock. One strike; the silhouette falls and breaks away | heavy steps, a held note, one blow, silence | — |
| 5 | The clock taken | 4 | He takes the clock from its stand. From the eye outward his streak turns **purple**; his look changes: the cape darkens, his back straightens, his outline goes harder | the deep tick; the note bends lower | — |
| 6 | The end of the world | 8 | The picture trembles. Three shots: (a) the horizon of the ruined world — hills, broken towers — and a **giant clock** forming in the sky above it; (b) its hand strikes and a **bolt of time** (a pencil-white crack, straight down) falls; (c) from where it hits, the world is erased outward: strokes of towers, hills and trees vanish whole, until only white paper is left | rising rumble, a crack, a long roar that thins into nothing | — |
| 7 | The one who came back | 5 | A short circuit: flashes of **Future Akeris** — fully torn cape, curved battered sword, very dirty, his red streak **battered** (frayed, broken into pieces). He looks out at us. Out of nowhere, over his last frame, the card | static, a heartbeat | `cinematic.intro.card` |
| 8 | The waking | 3 | Back to the ruins: Akeris sits up with a start by the fire, which is almost out; his red streak lights. He looks around at the empty ruins | a sharp breath, the fire's embers | — |
| 9 | Black | 1 | Black. | silence | — |
| 10 | To the temple | 4 | The home screen's scene: Akeris runs in from the left and stops where the home screen shows him, before the broken arch; the title draws itself in pencil over the arch; the options fade in | running steps, his stop, the home screen's ambience | the title |
| | **Total** | **45** | | | |

## Texts

| Key | English | Español |
|---|---|---|
| `cinematic.intro.card` | Akeris, you have to save the world. Enter the Temple of Time. | Akeris, tienes que salvar el mundo. Entra al templo del tiempo. |

The keys `cinematic.intro.card1` and `card2` of the 2026-09-30 script are retired. The title *Savior's Paradox* is the
game's logo, the same in both languages (`06-ui/title/title.md`).

## Never

- No text names any Akeris of the dream, the Guardian, or says who used the clock (`../premise.md` §4): all of it stays
  images, and Akeris wakes thinking it a dream.
- The Time Guardian is only a silhouette: no face, no detail, no name.
- No line boil. Flashes only between the short-circuit frames; the shake only in shot 6, as one piece.
- No blood: wounds are torn cloth and cuts in the stroke.

## Decisions

| # | Question | Decided |
|---|---|---|
| S4 | Can the intro be skipped? With which key? | yes, holding Enter or Esc for 5 s (operator, 2026-09-30). (D): a control, moved into `VISION.md` in step 5.1. Also a *Skip* button with an `Esc` key cap, bottom right, labelled with `cinematic.skip`; holding a click on it for 5 s skips as the keys do, and the ring fills on it (operator, 2026-10-15; `06-ui/ui.md` §3) |
| S5 | Does the intro play again after a death? | no (operator, 2026-09-30). After a death the run starts at zone 1 directly. With the 2026-10-13 version the intro plays when the game opens, and a new game plays the descent |
| S6 | What does the intro tell? | the operator's 2026-10-13 script above (second version) |
