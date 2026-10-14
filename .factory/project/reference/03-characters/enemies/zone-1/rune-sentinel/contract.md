# Rune Sentinel — character contract

- **Status:** approved 2026-10-01 (R1–R8 approved as the sandbox does them)
- **Kind:** enemy (zone 1, the Suspended Sanctuary)
- **Sandbox:** the zone 1 sandbox, [`../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`](../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html):
  *Ir a… combate*, then *Enemigo* until it reads *centinela rúnico*; `N` makes it charge ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 1 enemies: *small rolling rock that charges*), §Mechanics
  (block, counter, fast descent, hit feedback) · `02-art-direction/ART_DIRECTION.md` §5 ·
  `00-game/controls.md` (G16) · `00-game/pillars.md` (combat is a duel) · `00-game/glossary.md` §7 ·
  the operator's decisions of 2026-10-01 (it is low; its charge is jumped or blocked)
- **Built on:** its own shape (a rock; no skeleton)
- **Code name:** `runeSentinel` · **Español:** centinela rúnico

Every gameplay number is the sandbox's and is marked **the game decides**. The proposals R1–R8 (§12)
were approved by the operator on 2026-10-01.

## 1. Identity

A stone of the sanctuary that remembers its duty: a rough boulder, knee-high to Akeris, with the
sanctuary's hourglass carved on its face. Asleep, it is one more stone on the floor. Awake, the carving
fills with ink, it rocks back, and it charges in a straight line. At a glance a player reads a small
rock that is not quite still: get over it, stop it, or strike low.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | 60 (radius 30, ±10 %) | Akeris's knee is at 46 su; Akeris = 192 |
| width | ≈ 60 | a rounded twelve-sided stone |
| carving | an hourglass ≈ 25 su | rotates with the stone while it rolls |

**Silhouette test:** filled black, a small round stone on the floor. It is told from the dungeon's
loose stones by its size, its contact shadow and, once awake, the black hourglass.

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| outline | `ink` | 2.4 | — |
| stone | `rock` `#a39a8a` (the thrown rocks') | — | `ink` at .3 on its lower half, gap 3.6 |
| light | `stoneEdge` family, a soft highlight at its upper left | — | — |
| cracks | `ink` at .55–.6 | 1.1–1.2 | — |
| carving, asleep | `ink` at .35 | 1.1 | — |
| carving, awake | `ink`, its two halves filled | 2.6 | — |

No new colour; no glow: the carving fills with ink, it never lights up.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Key poses (`sprites/`) |
|---|---|---|---|---|---|
| asleep | spawn | — | yes (still) | wake | `sleep` |
| wake | Akeris within sight | 0.45: the carving fills with ink | no | watch | `sleep` → `awake` |
| watch | wake, recover | — | yes | wind | `awake`, leaning 2 su toward Akeris |
| wind (the telegraph) | watch, after its pause | 0.6: rolls back 28 su | no | charge | `wind` |
| charge | wind | until a wall, the edge of its island or 900 su | yes (rolling) | dizzy, bounce, topple | `roll-1`, `roll-2`, dust behind |
| dizzy | the charge stops or hits Akeris | 0.9, wobbling; graphite stars | no | watch | `dizzy` |
| bounce | its charge hits a shield | 0.5, rolling back | no | dizzy | — |
| topple | a just block with the sacred shield | 1.6, sent back and rocking hard; graphite stars | no | watch | `dizzy` |
| stun | Akeris's fast descent beside it | 1.2; graphite stars | no | watch | `dizzy` |
| hurt | a hit that lands | 0.25, a 10 su knock | no | watch | — |
| frozen, burning | `fx/freeze`, `fx/burn` | the effect's | — | dizzy | — |
| death | its last health | the ink smoke's | no | — | `fx/ink-smoke` |

**Rolling rule:** while it moves its rotation is the distance moved divided by its radius: it never
slides. **Timing rule:** a timed animation stretches to the game's duration.

## 5. Weapons and gear

None. It is the weapon.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| dust trail | while charging, every 0.06 s | dust puffs behind it (`fx/hit-feedback`) | 0.5 |
| crash | the charge stops on a wall or edge | dust and `THUD!` | — |
| stars | dizzy, stun, topple | three graphite stars on a thin ring above it (as the knight's) | the state's |
| hit feedback, freeze, burn, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.runeSentinel.wake` | wake | `07-audio/sfx/sfx.md` |
| `sfx.runeSentinel.windup` | the wind starts: the telegraph | `07-audio/sfx/sfx.md` |
| `sfx.runeSentinel.roll` | loops while it charges | `07-audio/sfx/sfx.md` |
| `sfx.runeSentinel.crash` | the charge stops on a wall or edge; the fast descent stuns it (×0.6) | `07-audio/sfx/sfx.md` |
| `sfx.hit.blunt`, `sfx.hit.blade` | its charge on a shield; hits that land | `07-audio/sfx/sfx.md` (existing) |
| `sfx.fx.inkSmoke` | death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 10 marks) | — |
| damage of the charge | the game decides (sandbox: the HUD's test hit) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| sight | the game decides (sandbox: 720 su across, 200 up or down) | — |
| charge speed | the game decides (sandbox: 760 su/s, at most 900 su) | — |
| hit radius | 46 su around its body | the sandbox |

**Behaviour:**

1. **Asleep, then awake (R2).** It sleeps until Akeris comes within sight, wakes (0.45 s) and never
   sleeps again. It turns to face Akeris at once.
2. **The charge (R3).** After its pause (1.1 s) it rocks back (0.6 s: the telegraph, seen and heard)
   and rolls straight at where Akeris was, until a wall, the edge of its island or 900 su. It never
   falls into the abyss and never leaves its room. Then it is dizzy (0.9 s).
3. **Answering the charge (R4):** it passes under a jump; a roll passes through it (the roll's
   invulnerability); the shield stops it (it bounces back and is dizzy); a **just block with the sacred
   shield** sends it back, toppled for 1.6 s, and opens the counter; with the ice or fire shield the
   just block freezes or burns it (G16). If it reaches Akeris standing, it hits him and stops.
4. **It is low (R5).** Only strikes that come down to it land: the diagonal slash at the sword's
   length, the overhead strike (with every weapon), the hammer and the flail in their whole combo, the
   chain blades aimed at it and their overhead arc. The thrust, the strikes at chest height and the
   spear's flatter combo pass over it: with the spear, only its overhead strike reaches it.
5. **Hits.** Every hit that reaches it lands, from any side; a hit interrupts its wind but not its
   charge.
6. **Stun (R6).** Akeris's fast descent within 150 su stuns it 1.2 s.
7. **No contact damage** except its charge; Akeris can stand over it. **Defeated, it stays
   defeated** for the rest of the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles: its rolling and wobbling are smooth; no line boil.
- No glow, no colour: the carving fills with ink.
- It never slides: it rolls exactly as far as it turns.
- It never charges without rocking back first, and never falls into the abyss.
- It never comes back once defeated.

## 10. Acceptance

1. Asleep, it matches `sleep` of `sprites/sheet.png`; awake, `awake`.
2. It wakes when Akeris comes near and charges as `sprites/sheet-attack.png`, with the windup sound first.
3. Jumping over the charge leaves Akeris unhurt (`sheet-jump.png`).
4. The shield stops it (`sheet-block.png`); the just block with the sacred shield topples it and opens the counter (`sheet-counter.png`).
5. The diagonal slash and the overhead strike land; the thrust passes over it (`sheet-low.png`).
6. The fast descent beside it stuns it (`sheet-stun.png`).
7. At its last health it dissolves (`sheet-death.png`), drops XP and coins, and never comes back.
8. Each sound of §7 plays at its trigger; the roll loops only while it charges.

## 11. Exports

From the zone 1 sandbox (`snExportAll()`, the sounds with `snExportSfx()`): `sprites/sheet.png`, six
single poses, seven frame sheets and eleven screenshots in `captures/`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| R1 | Look | a knee-high stone (60 su) with the sanctuary's hourglass carved on it; asleep a grey carving, awake filled with ink; no glow, no new colour |
| R2 | Waking | asleep until Akeris comes within sight; wakes in 0.45 s and never sleeps again |
| R3 | The charge | rocks back 0.6 s (the telegraph) and rolls straight at 760 su/s until a wall, the edge or 900 su; dizzy 0.9 s; pause 1.1 s |
| R4 | Answers | jumped over or rolled through; the shield stops it (bounce, dizzy); the just block with the sacred shield topples it 1.6 s and opens the counter; ice and fire as G16 |
| R5 | Low | hit radius 46 su: the diagonal at the sword's length, the overhead strike, the hammer, the flail and the chain reach it; the thrust, chest-high strikes and the spear's combo pass over (the spear reaches it only from above) |
| R6 | Stun | the fast descent within 150 su stuns it 1.2 s |
| R7 | Hits | every hit that reaches it lands; a hit interrupts its wind, not its charge |
| R8 | Sound | wake, windup (the telegraph), a rolling loop, the crash |
