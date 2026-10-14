# Akeris — character contract

- **Status:** approved 2026-09-30 (step 3.6 adds the spear, the flail and the hammer, and the potion's real flask)
- **Kind:** player
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Mechanics, §Art direction, §Win / lose conditions ·
  `02-art-direction/ART_DIRECTION.md` §2–§4 · `00-game/controls.md` · `01-story/characters.md` §1
- **Built on:** his own rig, the one every humanoid enemy reuses (`VISION.md` §Art direction)
- **Parts:** [`animations.md`](animations.md) (§4 of this template) · [`mechanics.md`](mechanics.md)
  (§8) · [`weapons/`](weapons/) (§5)

## 1. Identity

Akeris, the Savior: the player and the only playable character. He never speaks; everything he
feels is pose and timing (`01-story/characters.md` §1). At a glance a player reads a thin ink figure
with a paper head, one black almond eye trailing a **red streak**, and a **torn dark cape with
holes**: determined, quiet, a little eerie — never heroic, never cute.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| standing height | 192 | 26 % of the screen height (`VISION.md`) |
| crouching / rolling height | 138 / 112 in the sandbox | drawn lowered to fit the game's crouching height |
| head | radius 17, centre 20 from the neck | a paper-filled circle |
| torso · thigh · shin | 72 · 46 · 46 | hip height standing 84 |
| upper arm · forearm | 32 · 30 | the shoulder 6 below the neck |
| foot | a 10-long stroke | |
| cape | 12 segments of 12 (144), 3 → 37 wide | torn end in 5 tongues, 4 holes |
| sacred sword · hook blade | 114 blade · 40 + a hook of radius 13 | `weapons/` |
| shield | about 44–50 across | on the back forearm |

**Silhouette test:** filled in solid black at 26 % of the screen height, he is a stick figure with a
round head and a long ragged cape trailing behind, a long straight blade in front; the eye streak is
the only colour and reads even at that size.

## 3. Palette and strokes

| Part | Colour (`02-art-direction/palette/palette.md`) | Stroke width (su) | Hatching |
|---|---|---|---|
| outline, limbs | `ink` `#1a1715` | torso 3.1, head 3, front arm and legs 2.9, foot 2.7, back arm 2.6 | — |
| head | fill `paper` `#d4ccbe` | 3 | — |
| eye | `ink`, glow `rgba(120,0,10,.7)` blur 5 | — | — |
| streak | `streakRed wide` `#6e0a10` at 4.4 (blur 9) under `streakRed` `#d8141d` at 2.2 | — | — |
| cape | `cape` `#3d3934`, outline `ink` 1.8 | 1.8 | strokes that travel with the cloth, `rgba(8,6,5,.5)` 1 wide |
| cape holes | `paper` | 1.1 | — |
| weapons, shields | their own (`weapons/*.md`) | 1.4–2.2 | |

Only the colours `02-art-direction/` allows. His accent is the **red** streak; purple is the other
timelines' (Future and Corrupted Akeris), never his.

## 4. Animations

[`animations.md`](animations.md): the rig, the gait, the cape, the eye, and **the closed list of his
animations (§4)** with how each blends, how long it lasts and its key poses; §5 details the ones
added in this step (overhead strike, high jump, drink, levitate and anchor, bite and pull, overhead
arc, area spin, the free hand while hanging, the hanging counter, death).

**Timing rule:** a timed animation is stretched to the duration the game logic gives it; the times
there are the shape and the default, never a gameplay number.

**Frame sheets** (`sprites/`, exported from the sandbox, six frames each):

| Sheet | Shows |
|---|---|
| [`sheet-drink.png`](sprites/sheet-drink.png) | the weapon away, the flask up, drinking, the weapon back |
| [`sheet-levitate.png`](sprites/sheet-levitate.png) | rising and floating; the anchor thrown, biting, pulling him down |
| [`sheet-death.png`](sprites/sheet-death.png) | the blow, kneeling, falling, lying, the ink, only smoke |
| [`sheet-overhead.png`](sprites/sheet-overhead.png) | the overhead strike |
| [`sheet-high-jump.png`](sprites/sheet-high-jump.png) | the high jump |
| [`sheet-arc.png`](sprites/sheet-arc.png) | the chain's overhead arc |
| [`sheet-spin.png`](sprites/sheet-spin.png) | the area spin |
| [`sheet-pull.png`](sprites/sheet-pull.png) | strike, bite, pull, strike on arrival |
| [`sheet-swap.png`](sprites/sheet-swap.png) | sword → hook blades → sword |
| [`sheet-hang.png`](sprites/sheet-hang.png) | the free hand: its blade, the shield raised, the free throw |
| [`sheet-hang-counter.png`](sprites/sheet-hang-counter.png) | the counter while hanging |
| [`sheet-spear.png`](sprites/sheet-spear.png), [`sheet-flail.png`](sprites/sheet-flail.png), [`sheet-hammer.png`](sprites/sheet-hammer.png) | step 3.6: each weapon's combo, overhead strike and aerial attack |
| [`sheet-swap-slots.png`](sprites/sheet-swap-slots.png) | step 3.6: the wheel through the slots (hip, shoulder, hip) |
| [`sheet-roll-jump.png`](sprites/sheet-roll-jump.png), [`sheet-air-roll.png`](sprites/sheet-air-roll.png) | G18: jumping out of a roll; the air roll |
| [`sheet-jump-ring.png`](sprites/sheet-jump-ring.png) | G19: a ring caught in mid-jump, aiming |
| [`sheet-wall-to-wall.png`](sprites/sheet-wall-to-wall.png) | G20: jumping off one wall and hooking the one across |

The ground counter's sheets are the effect's: `02-art-direction/fx/counter/sprites/`.

**Single poses** (`sprites/<pose>.png`, transparent, 2×): `idle`, `walk`, `run`, `crouch`,
`crouch-walk`, `skid`, `squat`, `rise`, `rise-high`, `apex`, `fall`, `land`, `dive`, `roll`,
`windup`, `slash`, `low-cock`, `upslash`, `thrust-cock`, `thrust`, `overhead-cock`,
`overhead-strike`, `air-windup`, `air-chop`, `block`, `block-hit`, `hurt`, `throw-cock`,
`throw-release`, `arc-cock`, `arc-release`, `spin`, `pull`, `swing`, `wall-climb`, `mantle`,
`hang-blade`, `hang-shield`, `hang-throw`, `drink-reach`, `drink`, `levitate`, `anchor`, `kneel`,
`fallen`; step 3.6 adds `air-stab`, `hammer-cock`, `hammer-slam`, `spear-carry`, `hammer-carry`, `flail-carry`.
The pose sheet has **fifteen** rows: the last three are the spear, the flail and the hammer (`P`, page 3).

## 5. Cape, weapons and gear

| Item | Where it sits | How it moves | When it changes | Detail |
|---|---|---|---|---|
| cape | from the neck, behind | state-driven, never free physics | every state names a cape mode | `animations.md` §2 |
| sacred sword | front hand; sheathed on the back otherwise | with the front hand | weapon swap (0.3 s, hand to the shoulder) | [`weapons/sacred-sword.md`](weapons/sacred-sword.md) |
| hook blades | one in each hand; at the belt otherwise | thrown on their chains, alternating hands | weapon swap (0.3 s, hand to the hip) | [`weapons/hook-blades.md`](weapons/hook-blades.md) |
| sacred / ice / fire shield | strapped to the back forearm; to the free forearm while hanging | lowered edge-on ↔ raised facing out | only in the pause menu's inventory | [`weapons/sacred-shield.md`](weapons/sacred-shield.md), [`ice-shield.md`](weapons/ice-shield.md), [`fire-shield.md`](weapons/fire-shield.md) |
| spear, flail, hammer | the front hand when equipped; **not drawn** otherwise (`05-items/items.md` I1) | with the front hand; the flail's ball on its chain | weapon swap (spear and hammer at the shoulder, flail at the hip) | [`weapons/spear.md`](weapons/spear.md), [`flail.md`](weapons/flail.md), [`hammer.md`](weapons/hammer.md) |
| potion flask | at the hip, in the front hand while drinking | with the front hand | drinking | `animations.md` §5.2; its look is [`05-items/potion/potion.md`](../../05-items/potion/potion.md): amber liquid |

## 6. Effects

| Effect | Trigger (game event) | Look | Duration (s) |
|---|---|---|---|
| dust puffs | take-off, landing, roll, skid, fast-descent impact, anchor, falling dead | `02-art-direction/fx/hit-feedback/hit-feedback.md` | 0.45–0.75 |
| blade trail | a sword strike, the counter | same | while it strikes |
| sparks | a hit, a block, a hook catching | same; the shield's colour on a block | 0.18–0.28 |
| contact shadow | always; fades with height | an ellipse under him, `shadow` | — |
| callouts | `slash`, `thud`, `chain`, `clack`, `clang`, `crish`, `fwoom`, `crack`, `burn`, `frost`, `counter`, `reflect` | `02-art-direction/fx/callouts/callouts.md` | 0.9 (counter 1.1) |
| counter: afterimages and aura | a perfect block with the sacred shield, on the ground or hanging | `02-art-direction/fx/counter/counter.md` | 1.0 |
| reflect | a perfect block against a projectile | `02-art-direction/fx/reflect/reflect.md` | — |
| ink smoke | death | `02-art-direction/fx/ink-smoke/ink-smoke.md`, on his whole drawing (`animations.md` §5.8) | ≈ 1.8 |

He has no callout of his own: all are the shared list.

## 7. Sounds

Defined in `07-audio/sfx.md` (step 3.8). The triggers are closed; the ids are this step's proposal
and step 3.8 may rename them.

| Sound id (proposed) | Trigger |
|---|---|
| `sfx.akeris.step` | each foot contact while walking or running (the gait's stance start) |
| `sfx.akeris.jump`, `sfx.akeris.land` | take-off (high jump the same, stronger); landing |
| `sfx.akeris.dive` | the fast descent hitting the floor |
| `sfx.akeris.roll` | a roll starts |
| `sfx.akeris.swing` | each sword strike, at its snap |
| `sfx.spear.swing`, `sfx.flail.swing`, `sfx.flail.chain`, `sfx.hammer.swing`, `sfx.hammer.slam` | step 3.6: the free-slot weapons' strikes; the flail's chain while the ball swings; the hammer hitting the floor |
| `sfx.chain.throw`, `sfx.chain.hook`, `sfx.chain.bite`, `sfx.chain.back` | a hook blade leaves the hand; catches a ring; bites a wall, an enemy or the floor; is reeled back |
| `sfx.chain.spin` | the area spin, looped while it lasts |
| `sfx.akeris.swap` | the weapon swap's midpoint |
| `sfx.shield.sacred`, `sfx.shield.ice`, `sfx.shield.fire`, `sfx.shield.break` | a block with each shield; the last use spent |
| `sfx.akeris.counter` | a counter starts |
| `sfx.akeris.hurt` | he is hit |
| `sfx.akeris.drink` | the drink's sip (0.5 s) |
| `sfx.akeris.levitate`, `sfx.akeris.anchor` | levitation starts; the anchor bites |
| `sfx.akeris.death` | death; then the ink smoke's own sound |

He never speaks: no voice lines, no grunts that sound like words.

## 8. Mechanics

[`mechanics.md`](mechanics.md): the numbers `VISION.md` gives (all others are the game's), which
mechanic each animation serves, the operator's decisions **P1–P8** (§3), and the rules the tester
checks.

## 10. Never

- Nothing trembles: no line boil, no jitter, no shake. Each stroke is seeded once.
- No blood and no gore; death is ink, and nothing of him is left behind.
- No mouth, nose or second eye; no face but the almond eye.
- The streak is never purple on him, and never any colour but red.
- The cape is never free cloth physics, never pierces the floor, and never whips.
- The sacred sword never hooks, climbs or swings; the chain is always the hook blades'.
- Blocking is always a shield; a weapon never blocks.
- No gem holes on the sword in the demo.
- A foot never slides on the floor while he walks or runs.
- A weapon never passes through the floor while he stands or kneels.

## 11. Acceptance

What the operator checks in the game, side by side with the sandbox. Each line is one observation.

1. Standing still, he matches `sprites/idle.png` and the idle cell of `sprites/sheet.png`, and
   breathes slowly.
2. Walking blends into running as he speeds up, and the feet stay planted on the floor.
3. Every animation of `animations.md` §4 plays when its input or event happens, blends in as listed,
   and matches its row of `sprites/sheet.png` and, where there is one, its frame sheet.
4. A jump with Space alone always reaches the same height; with W it goes higher, tucked.
5. W + click with the sword is the overhead strike and does not chain into the combo.
6. Holding F puts the weapon away, drinks from the flask with the head tilted back, and gives back
   the weapon held before; releasing F early cancels (P3).
7. Inside the golem's radius he floats helpless and turning; with the chain blades, S + click drives
   a blade into the floor and pulls him down.
8. When he dies he kneels, falls on his face, fills with ink and comes apart into smoke, as in
   `sprites/sheet-death.png`; nothing remains.
9. Hanging from a ring, the free hand holds its hook blade; the wheel gives it the shield; right
   click throws the blade or raises the shield; a perfect block with the sacred shield plays the
   hanging counter without letting go (`sprites/sheet-hang.png`, `sheet-hang-counter.png`).
10. The chain blades alternate hands on every throw; the pull, the arc and the spin look like their
    frame sheets.
11. The cape follows each state's shape, the tip trailing, and rests on the floor without piercing it.
12. The eye streak is red, trails behind the eye, and never jitters.
