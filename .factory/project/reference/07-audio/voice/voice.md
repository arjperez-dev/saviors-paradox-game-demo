# Voices

- **Status:** approved 2026-10-01
- **Sources:** `VISION.md` §Client constraints («spirit voices are processed sounds imitating an
  ancient language») · `01-story/dialogue/rules.md` · `06-ui/dialogue/dialogue.md` §7 · the operator's
  decision of 2026-09-30 (whispered invented syllables)
- **Made in:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html): talk to the spirit by the door (H)
- **Read by:** the task that plays the spirits' dialogue; the tester

Only the spirits have a voice. **Akeris never speaks** (`03-characters/akeris/contract.md`), and the
bosses do not either (`01-story/characters.md`).

---

## Voice — the spirits

- **Who:** every spirit (`01-story/characters.md`; their look comes in `03-characters/spirits/`).
- **Language:** invented, never a readable real one. **Whispered syllables with echo**: a breathy
  onset (s, sh, h, k, t, f, n, th) and a whispered vowel (a, e, i, o, u), 24 fixed syllables in
  `voice.spirit.syllable` (`spirits/spirit-syllable-1…24.wav`), each through a small stone room and an
  echo of 0.19 s.
- **When:** the text is the subtitle (`rules.md` §3). As a line is written (40 characters a second,
  `dialogue.md`), **one syllable sounds at the first letter of each word**, at most one every 0.11 s.
  The syllable is chosen by the line and the letter, so the same line always sounds the same.
  When Enter completes a line at once, the rest of it is silent; the next line starts its own voice.
- **Pitch:** each spirit has a fixed rate (its tone), and each syllable moves it by ±3.6 %. Zone 1:
  `suspendedSanctuaryWarning` 0.90, `suspendedSanctuaryLore` 1.08. The spirits of the other zones get
  theirs in their zone's step (between 0.85 and 1.15, no two alike in a zone). Zone 2 *(step 3.12)*:
  `echoCavernsWarning` 0.86, `echoCavernsLore` 1.14. Zone 3 *(step 3.13)*: `sunkenGraveyardWarning` 0.93,
  `sunkenGraveyardLore` 1.11. Zone 4 *(step 3.14)*: `rottingCanopyWarning` 0.90, `rottingCanopyLore` 1.09. Zone 5 *(step 3.15)*:
  `dragonBattlementsWarning` 0.88, `dragonBattlementsLore` 1.06.
- **Barks:** `voice.spirit.sigh` (`spirits/spirit-sigh.wav`), a whispered exhale when a dialogue opens,
  at the spirit's rate, with `sfx.ui.dialogueOpen`.
- **Lines:** by translator key in `01-story/dialogue/`; never written here.

| Id | Trigger | Length (s) | Variations | Volume | At once | Priority | File |
|---|---|---|---|---|---|---|---|
| `voice.spirit.syllable` | the first letter of each word as it is written (see above) | 0.9 (tail) | 24 | 0.5 | 3 | normal | `spirits/spirit-syllable-1…24.wav` |
| `voice.spirit.sigh` | a dialogue opens | 1.6 | 1 | 0.45 | 1 | normal | `spirits/spirit-sigh.wav` |

The voice plays on the sound-effect bus, so the settings' effect volume governs it. Files are 44.1 kHz,
16-bit, mono, peak −1 dBFS.

## Never

- Real words in any language, or syllables that spell one.
- A voice for Akeris or a boss.
- A syllable per letter (it becomes a buzz) or a voice that keeps going after the line is complete.

## Acceptance

1. Writing a line plays one syllable per word, never two closer than 0.11 s.
2. The same line, heard twice, sounds the same.
3. Each spirit keeps its own tone; two spirits of a zone never share one.
4. Enter on a half-written line stops its voice at once.
