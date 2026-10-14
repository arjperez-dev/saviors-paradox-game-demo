# How a spirit talks

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Mechanics (Spirits), §Session shape (Progression) · `00-game/controls.md`
  §4 · `premise.md` · `characters.md` §4
- **Read by:** the `narrative` feature (what a conversation says and in what order), `06-ui/` (the
  dialogue box), `07-audio/voice.md` (the voice). A task that builds spirit dialogue cites this file
  and the `zone-N.md` whose lines it loads.

Marks: **(D)** is an operator decision of 2026-09-30 that settles something `VISION.md` leaves open;
the translator moves it into `VISION.md` in plan step 5.1.

---

## 1. A conversation

Akeris walks up to a spirit and presses H; Enter advances each line (`00-game/controls.md`). Enter
moves to the next line at once, without waiting for the voice to finish **(D)**. The spirit says, in
order:

1. **A greeting**, chosen by memory (§2).
2. **Its next fragment**, if it has one left for this run (§3). A fragment is 1 to 3 lines.
3. Nothing else: the conversation ends after the last line.

**Closing early (D).** Lines Akeris hears for the first time cannot be closed: the player follows
the story, and only Enter speeds it up. Esc closes a conversation only while it replays fragments
already heard (*Hear it again*, §3).

Every line is shown as a subtitle while the spirit's processed voice plays (`07-audio/voice.md`). The
voice never says the words; it is the same ancient language in both languages.

## 2. Memory

What a spirit remembers survives death (`VISION.md` §Session shape); it only changes what it says.

| The spirit remembers | Greeting |
|---|---|
| it never spoke to Akeris before, in any run | `greetingFirst` |
| it spoke to Akeris in an earlier run | `greetingAgain` |
| it already spoke to Akeris in this run | `sameRun` (one line, no greeting, no fragment); if all three fragments are heard, it then offers the choice of §4 again |

Per spirit, memory needs: whether it has ever spoken, the run it last spoke in, and how many fragments
Akeris has heard. How that is stored is the `narrative` feature's choice (`SpiritMemory`).

## 3. Fragments (D)

Each spirit has **three fragments**, told in order: 1, 2, 3.

- **One new fragment per spirit per run.** The first conversation of a run tells the next fragment
  Akeris has not heard; later conversations in the same run get `sameRun`. Hearing everything a zone
  holds takes three runs; this is what "each run reveals more" means in `00-game/pillars.md` §4.
- **When all three are heard,** the first conversation of a run says `allHeard` and offers a choice
  (§4). *Hear it again* tells fragments 1, 2 and 3 in a row; *Go on* ends the conversation. This is
  `VISION.md`'s "offering to replay or skip".
- A new fragment is never cut (§1). If the run ends before its last line, it counts as not heard.

## 4. Choices

The only choice in any conversation is the one of `allHeard`. It is a menu, chosen with the mouse or
W / S / arrows + Enter (`00-game/controls.md` §4). Its labels are shared by every spirit:

| Key | English | Español |
|---|---|---|
| `dialogue.choice.replay` | Hear it again | Escucharlo otra vez |
| `dialogue.choice.leave` | Go on | Seguir |

Akeris never speaks (`premise.md` §5): the labels are what the player does, not what Akeris says.

## 5. Keys

A line's key is `spirit.<spiritId>.<part>.<n>`:

- `<spiritId>` is the spirit's code name (`characters.md` §4), e.g. `suspendedSanctuaryLore`;
- `<part>` is `greetingFirst`, `greetingAgain`, `sameRun`, `allHeard`, `fragment1`, `fragment2` or
  `fragment3`;
- `<n>` is the line's number within the part, from 1.

The `localization` feature may turn these into its own identifiers; the strings in `zone-N.md` are
the ones shown. Neither language is a literal translation of the other (`00-game/tone.md` §1).

## 6. Writing a line

- At most **90 characters** in English and **110** in Spanish, so a line fits the dialogue box without
  shrinking the text (`06-ui/` may tighten this).
- Short sentences, plain words, a little archaic; no names; no exclamation marks.
- Held against `premise.md` §4: a line that says what the demo never says is a defect.
- A hint about a boss says what to do, never a number (damage, time, hits).
- A hint never contradicts `00-game/controls.md`: a projectile blocked at the last moment flies back; only a melee hit opens a counter.

## 7. Decisions

| # | Question | Decided (operator, 2026-09-30) |
|---|---|---|
| S2 | Can a conversation be closed before its last line? With which key? | not while it tells lines heard for the first time: the player follows the story, and Enter moves to the next line at once. A replay (*Hear it again*) closes with Esc. (D): a control, moved into `VISION.md` in step 5.1 |
| S3 | What does a spirit heard in full say when spoken to again in the same run, after *Go on*? | its `sameRun` line, and then it offers *Hear it again* / *Go on* once more |
