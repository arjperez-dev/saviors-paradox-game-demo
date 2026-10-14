<!--
Template: character contract. Used for Akeris, the other characters, every enemy and every boss.

Files, in 03-characters/<name>/, 03-characters/enemies/zone-N/<name>/ or 03-characters/bosses/<name>/:
  contract.md          this template, filled in; always
  animations.md        the "Animations" part, moved out when it passes ~150 lines
  mechanics.md         the "Mechanics" part, moved out when it passes ~100 lines
  phases.md            bosses only: the "Phases" part
  sprites/sheet.png    the pose sheet exported from the sandbox (key P); always
  sprites/<pose>.png   single poses and frames, transparent, one per pose a task may need
  sprites/sheet-<animation>.png  frame sheets of its animations and effects (#hoja-<name>)
  sprites/<callout>.<en|es>.png  its own callouts (a roar, a screech), transparent, if it has any
  weapons/<weapon>.md  one per weapon or shield it carries: how it is held, drawn, swung, sheathed
  weapons/<weapon>.png the weapon alone, transparent; always, beside its .md
  weapons/<weapon>-sheet.png  how this character carries, draws, swings and sheathes it
                       The weapon as an item (stats, pickup, icon) is in 05-items/ and links here.
  Every PNG is exported from the sandbox, never drawn by hand, and exported again when it changes.
  sandbox/sandbox.html the playable look, built from the Akeris sandbox; always
  sandbox/<scenario>.png  headless screenshots of its #scenarios, for review

Rules for filling it in:
  - Every number has a unit: su for drawing, seconds for time, world units only where the game fixes it.
  - Every gameplay number is copied from VISION.md or marked "the game decides"; never invented here.
  - Every list is closed: what is not listed does not exist.
  - Delete these comments and every section marked "(bosses only)" that does not apply.
-->

# <Name> — character contract

- **Status:** draft · review · approved <YYYY-MM-DD>
- **Kind:** player · character · enemy (zone N) · boss (zone N)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §<sections> · `02-art-direction/ART_DIRECTION.md` §<sections>
- **Built on:** <the rig it reuses — "Akeris's skeleton and poses", or "its own">

## 1. Identity

<Two or three sentences: who it is, what it does in the game, and what a player must read from it at
a glance — its threat, its weak point, its mood.>

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| standing height | | Akeris = 192 |
| width at the widest point | | |
| head | | |
| <limb, weapon, cape…> | | |

**Silhouette test:** <what makes it recognisable filled in solid black, at 26 % of the screen height>.

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| outline | ink `#1a1715` | | |
| <part> | | | <slope, gap, alpha> |

Only the colours `02-art-direction/` allows. <The accent this character is allowed, if any, and why.>

## 4. Animations

A closed list. The game logic chooses the state; this table says how each state is drawn.

| Animation | Entered from | Duration (s) | Loops | Exits to | Key poses |
|---|---|---|---|---|---|
| idle | | | yes | | |
| <walk / run> | | the gait follows the distance moved | yes | | |
| <attack…> | | the logic's; default <n> | no | | |
| hurt | | | no | | |
| death | | | no | — | ends in ink smoke |

**Blending:** <crossfade time between states, which transitions cut without blending, and why>.

**Timing rule:** a timed animation is stretched to the duration the game logic gives it; the times
above are the shape and the default, never a gameplay number.

### <animation name>

<Only for animations that need more than a row: the key poses in order, with the time of each as a
fraction of the duration, joint angles or positions in su, and what the sheet shows.>

## 5. Cape, weapons and gear

| Item | Where it sits | How it moves | When it changes | Detail |
|---|---|---|---|---|
| <cape> | | state-driven, never free physics | | here |
| <weapon> | | | | `weapons/<weapon>.md` |

## 6. Effects

| Effect | Trigger (game event) | Look | Duration (s) |
|---|---|---|---|
| <trail, spark, smoke, callout…> | `<event>` | | |

Effects that belong to every character (ink smoke, callouts) are defined once in
`02-art-direction/fx/` and only referenced here.

## 7. Sounds

| Sound id | Trigger (game event or animation frame) | Defined in |
|---|---|---|
| `<sfx.id>` | | `07-audio/sfx.md` |

## 8. Mechanics

What the character does, as the game must implement it. Every number is copied from `VISION.md` with
its section, or marked **the game decides**.

| Property | Value | Source |
|---|---|---|
| health | | `VISION.md` §<n> |
| damage | | |
| speed (world units/s) | | |
| hitbox (world units) | | |

**Behaviour:** <for an enemy: what it senses, how it chooses, its attack pattern with telegraph
times, what interrupts it. For the player: which mechanic each animation serves.>

## 9. Phases (bosses only)

| Phase | Enters when | Changes | New animations |
|---|---|---|---|
| 1 | the fight starts | | |
| 2 | health ≤ <n> % | | |

## 10. Never

- <What must not be drawn or done — the likely mistakes, stated so they can be checked.>
- Nothing trembles: no line boil, no jitter, no shake.

## 11. Acceptance

What the operator checks in the game, side by side with the sandbox. Each line is one observation.

1. <Standing still, it matches the idle pose of `sprites/sheet.png`.>
2. <Each animation of §4 plays in the listed order and blends as listed.>
3. <…>
