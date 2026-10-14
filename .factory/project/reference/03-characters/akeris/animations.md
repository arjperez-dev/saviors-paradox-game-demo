# Akeris — animations

- **Status:** approved 2026-09-30 (step 3.5). Version 1 (§1–§3, and the gear now in `weapons/`) was approved
  2026-09-30.
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Mechanics, §Art direction · `../../00-game/controls.md` (G1–G16) ·
  version 1 moved unchanged from `02-art-direction/ART_DIRECTION.md` version 1 §5–§10 · the callouts
  are keys of `../../02-art-direction/fx/callouts/callouts.md`
- **Read by:** every task that draws or animates Akeris. The sandbox wins on how he looks and moves
  (`../../README.md` §1).

This file is part of Akeris's contract ([`contract.md`](contract.md) §4). How he holds, draws, swings
and sheathes each weapon and shield is in [`weapons/`](weapons/); what each animation serves in the
game is [`mechanics.md`](mechanics.md).

**Scope.** Everything here is how Akeris looks and moves. Controls are `../../00-game/controls.md`;
gameplay numbers (speeds, jump heights, roll time and invulnerability, hitboxes, ranges, cooldowns,
shield uses, how long a drink or a levitation lasts) are the game's. Where a row below reads like a
mechanic, it describes what the sandbox shows so that it can be drawn; `VISION.md` and the game win.
Animation adapts to gameplay, never the reverse: the gait blends with the game's walk and run speeds,
the phase advances with the distance the game moved him, and a timed animation (roll, attacks,
mantle, drink, death) is stretched to the duration the logic gives it. Every function named
(`gaitPose`, `stepCape`…) is in the sandbox's script, whose comments are in Spanish. Numbers are in su
(`../../02-art-direction/ART_DIRECTION.md` §3).

---

## 1. Akeris's rig

### 1.1 Skeleton (`skeleton`)

The segments are the torso (72), thigh (46), shin (46), upper arm (32), forearm (30), and the head
(radius 17, its centre 20 from the neck). The shoulder sits 6 below the neck, along the torso.

A pose is a set of angles in degrees in the facing frame (0 = forward, 90 = down, −90 = up):
`lean hd aU aL sw bU bL fT fS kT kS`. The pose also carries:

| Key | Meaning |
|---|---|
| `hy` | hip height above the feet |
| `hx` | hip offset forward |
| `rot`, `pv` | whole-body rotation, about a pivot `pv` above the feet |
| `cu` | spine curl; the torso is drawn curved backward |
| `sl` | foreshortening of the weapon's length |
| `sh` | shield open: 0 = lowered and edge-on, 1 = facing out |

The `a` arm holds the weapon and is drawn in front; the `b` arm (drawn behind) carries the shield on
its forearm. Each shin ends in a 10-long foot stroke.

**Grounded poses are defined by their feet, not their leg angles.** Each pose gives
`feet: [front x, back x]` plus `hy`, and a two-bone IK (`ik`) solves the knees, so both feet always
land on the floor. Air poses give leg angles directly, and so does `kneel`, whose back knee rests on
the floor with its shin flat behind it. The pose table is `POSE_DEF` in the sandbox; take the values
from there, verbatim.

### 1.2 Locomotion (`gaitPose`)

The feet follow a trajectory: glued to the floor during stance, an arc in swing. IK places the
knees. **The phase advances with the distance travelled** (`q += |vx|·dt / S`), so the feet never
slide.

| Parameter | Walk (r=0) | Run (r=1) | Crouch-walk |
|---|---|---|---|
| stance fraction `st` | 0.60 | 0.38 | 0.62 |
| foot contact x → toe-off x | 34 → −30 | 30 → −60 | 28 → −26 |
| hip height | 86 | 72 | 50 |
| bob | −3·cos 4πq | −6·cos 4π(q − st/2) | −1.5·cos 4πq |
| swing lift / heel kick | 16 / 0 | 26 / 34 | 9 / 0 |
| lean / head | −84 / 2 | −66 / −14 | −44 / −30 |
| free arm swing | ±24 | ±50 | ±10 |

- `r` goes smoothly from 0 at walking speed to 1 at running speed, so walking becomes running
  continuously. In the game, use the game's walk and run speeds; the sandbox's 170 and 440 are
  its own. The sandbox's accelerations are not a target: the game's movement logic decides
  how fast Akeris moves.
- The idle-to-gait weight eases in at a rate of 12/s.
- Idle breathes: lean ±1.3 and arm ±1.2, at 2.2 rad/s.

### 1.3 State changes

**Every posture change crossfades** from a snapshot of the last pose to the new target over the
state's blend time (0.01–0.3 s, listed in §4). Rotation is normalised to ±180° in the snapshot, so a
finished roll never unwinds. Physics runs at a fixed 120 Hz step.

## 2. Cape: state-driven, never free physics (`CAPE_MODES`, `stepCape`)

The operator rejected free verlet cloth as too jerky. The cape is 12 segments of 12, each at a world
angle:

- Each Akeris state names a **cape mode**, and each mode gives a target shape: a base angle, a
  curvature per segment and the amplitude of a slow wave.
- Each segment eases toward its target with a critically damped spring. ω runs from 13 at the neck
  to 5.5 at the tip, so the tip follows late.
- **Angular speed is capped at 420°/s.** Segment *i* aims at segment *i−1* plus the target's relative
  bend, so the cape hangs as one piece.
- The wave: `sin(1.6t − 0.5i) · amp · i/11`.
- Points are clamped above the floor, so the cape rests on it and never pierces it.
- Turning around swings the cape under the body by the shortest angle.

| Mode | base | curve | amp | Mode | base | curve | amp |
|---|---|---|---|---|---|---|---|
| quieto | 108 | 2.5 | 2.5 | caer | 212 | −3 | 3 |
| andar | 128 | 2 | 3.5 | picado | 262 | −1 | 2 |
| correr | 162 | −1 | 4 | aterrizar | 128 | 6 | 1 |
| agachado | 150 | 4 | 2 | atacar | 150 | 2 | 1.5 |
| frenazo | 70 | 5 | 1 | bloquear | 118 | 3 | 1.5 |
| subir | 102 | 3 | 2 | rodar | 150 + roll angle | 14 | 0 |
| escalar | 122 | 3 | 2 | balanceo | 158 | 2 | 3 |
| **flotar** (new) | 238 | −4 | 7 | **tendido** (new) | 176 | 1 | 0.5 |

`flotar` lifts the cape above and behind him while he levitates; `tendido` lays it along the floor
behind him when he lies dead.

**Drawing** (`drawCape`): the segments are smoothed by 2 Chaikin passes and drawn as a band that
widens from 3 to about 37. The end is torn into 5 tongues, with tatters along the lower edge. Four
elliptical holes show the paper through. It is hatched with strokes that travel with the cloth.

## 3. Head, eye and streak

- **Head:** a paper-filled circle.
- **Eye:** a black almond, 15.5 long, tilted 0.28 rad forward, with a soft red glow.
- **Streak:** it leaves the eye and follows the eye's last 20 positions, drifting back 5.2 and up 0.8
  per sample, with a slow wave. It is drawn twice: `#6e0a10` at 4.4 with a blur of 9, then `#d8141d`
  at 2.2. The approved colour is **red**; the sandbox also offers purple (`E`) for the other
  timelines.

## 4. The animations — a closed list

What is not listed does not exist. The game logic chooses the state; this table says how each is
drawn. "Blend" is the crossfade into the state. Durations are the sandbox's and are the shape and
the default: a timed animation is stretched to the time the game gives it. New in step 3.5: **bold**.

| Animation (sandbox state) | Entered from | Blend (s) | Duration (s) | Loops | Exits to | Key poses · cape mode |
|---|---|---|---|---|---|---|
| idle / walk / run (`loco`) | any ground state | 0.1 | the gait follows the distance moved | yes | any | `idle` mixed with `gaitPose` · quieto / andar / correr by speed |
| skid | run, reversing above 300 | 0.07 | until slowed (≤ 0.35) | no | loco | `skid`, dust at the front foot · frenazo |
| crouch / crouch-walk | ground | 0.09 | held | yes | loco | `crouch` mixed with the crouch gait · agachado |
| jump take-off | ground | 0.05 | 0.06 | no | air | `squat` · aterrizar |
| air (rise → apex → fall) | take-off, a ledge, a release | 0.07–0.14 | by vertical speed | — | land | `rise` → `apex` → `fall`: a = smoothstep((vy+650)/550), b = smoothstep((vy−50)/500) · subir / caer |
| **high jump** | take-off with Space held | 0.07 | by vertical speed | — | land | the air blend mixed toward `riseHigh` (knees tucked, arms up) by smoothstep((−vy − 250)/700) while rising fast; a bigger dust puff at take-off · subir |
| land | air | 0.04 | 0.08–0.22 by impact speed | no | loco | `land` → `idle`, dust · aterrizar |
| fast descent | air, S | 0.06 | until the floor | no | land (0.32, big dust, `thud`) | `dive` · picado |
| roll | ground, Shift | 0.06 | 0.46 | no | crouch or land, or **jump** | the `tuck` ball rotating 360·(0.3u + 0.7·smoothstep(1.04u)) about `pv` = 55; unfurls after u = 0.78; dust at both ends. **Space while rolling** (G18): straight into `air` (0.06 blend), keeping the roll's speed; in the air that speed is kept while no opposite key is held · rodar |
| **air roll** (G18) | air, Shift, once per jump | 0.05 | 0.42 | no | air | the `tuck` ball raised 42 so it turns about the middle of the body, one full turn (360·smoothstep(u)); blends into `fall` after u = 0.8; the jump's path continues · rodar · frames [`sprites/sheet-air-roll.png`](sprites/sheet-air-roll.png), roll into jump [`sprites/sheet-roll-jump.png`](sprites/sheet-roll-jump.png) |
| sword combo | ground, click | 0.08 → 0.06 → 0.09 | 0.42 / 0.42 / 0.50 | no | loco, or the next strike (buffered from 0.15–0.17) | `windup`→`slash`, `lowCock`→`upslash`, `thrustCock`→`thrust` (lunge 420); strike segments ease out cubically · atacar |
| **overhead strike** | ground, W + click | 0.12 | 0.54 | no | loco (never chains) | `overCock` (sword straight up) → `overStrike` (ease-out, lands at 0.17) · atacar |
| aerial attack | air, click | 0.07 | 0.38 | no | air | `airWindup` → `airChop` · caer |
| block | ground, right click held | 0.08 | held | yes | loco | `block` with `sh` = 1; the weapon held back, low and ready · bloquear |
| block impact | block | 0.04 | 0.24 | no | block or loco | `blockHit` → `block`, pushed back at 260 · bloquear |
| hurt | any ground state | 0.04 | 0.40 | no | loco | `hurt` → `idle`, knocked back at 300 · caer |
| counter | block, perfect, sacred shield | 0.03 | 1.0 | no | loco | `../../02-art-direction/fx/counter/counter.md` · atacar |
| chain throw (strike) | ground or air, click with the chain blades | 0.05 | ≈ 0.2 | no | loco / air | the arm cocks back (0.06 s), then snaps to the aim; if the back hand throws, the arms swap · atacar |
| **bite** | a strike that hits an enemy | — | 0.3 | no | pull, or the blade returns | no pose of its own: the blade stays in the enemy, its chain taut from the hand |
| **pull** | bite + click | 0.05 | 0.22 flying + 0.42 strike | no | loco / air | `pullFly` (body stretched forward along the chain) while the chain reels him in; on arrival the diagonal slash (`windup`→`slash`) with the hook blade · correr |
| **overhead arc** | click with W, chain blades | 0.05 | ≈ 0.5 | no | loco / air | the arm from behind and above (`ARC_COCK`) over to forward and down (`ARC_REL`); the blade follows a curve over his head (§5.4) · atacar |
| **area spin** | click held ≥ 0.18, chain blades | 0.08 | while held (sandbox cap 1.4) | yes | loco / air | `spin`: the arm up, the blade circling on its chain (§5.5) · atacar |
| swing (ring) | a hook catches a ring | 0.14 | held | yes | air (Space, or a wall) | `swing` rotated by −φ about the gripping hand; legs trail by up to ±32° · balanceo |
| **free hand** (hanging) | swing | continuous | held | yes | swing | the holding arm stays at `swing`; the free arm holds its hook blade, or the shield lowered or raised (§5.6) · balanceo |
| **hanging counter** | free-hand shield, perfect, sacred | — | 1.0 | no | swing | the free hook blade out and back every 0.16 s, afterimages and aura, the swing almost stopped (§5.7) · balanceo |
| wall climb | a hook bites a wall | 0.08–0.1 | 0.5 per stretch | no | wall hang | `wallPose`: feet stepping up the wall by IK, leaning back from the chain · escalar |
| wall hang | wall climb | 0.12 | held | yes | climb, jump, drop | `wallPose(0, −80)` with a slow sway · escalar |
| mantle | a hook over the top edge | 0.1 | 0.62 | no | crouch | hang, then `mantle1` → `crouch` over the edge · escalar |
| weapon swap | wheel or 1–5 | overlay | 0.3 | no | — | an arm overlay on any pose: the hand to the shoulder (sword, spear, hammer) or the hip (hook blades, flail, flask, scroll); the item changes at the midpoint |
| **free-slot weapons** (step 3.6) | click, W + click, click in the air, with the spear, flail or hammer | as the sword | their own | no | carry pose | the sword's combo, overhead and aerial with each weapon's timing and pose variants; spear and hammer carried in their own pose: `weapons/spear.md`, `flail.md`, `hammer.md` |
| **drink** | ground, F held | 0.1 | 1.3 + the swap back | no | loco | swap to the flask (0.3) → `drinkReach` → `drink` (head back, 0.5–1.1) → `drinkReach` (1.3) → swap back to the weapon held before (§5.2) · quieto |
| **levitate** | inside the golem's radius | 0.3 | as long as the golem holds him | yes | air, or anchor | `levitate`: limbs slack, slowly turning (§5.3) · flotar |
| **anchor** | levitate, S + click, chain blades | 0.08 | 0.14 throw + 0.35 pull down | no | land (0.22) | `levitate` → `anchor` (both hands pulling the chain down) · subir |
| **death** | any state, health reaches zero | 0.05 | 1.4 + ink smoke | no | — | `hurt` → `kneel` → `fallen`, then ink smoke (§5.8) · caer → agachado → tendido |

## 5. The animations of step 3.5

### 5.1 Overhead strike and high jump

- **Overhead strike** (`ATK[3]`): `overCock` holds the sword straight up above the head (0–0.12),
  snaps down to `overStrike` (0.12–0.19, ease-out), holds to 0.32 and recovers to `idle` at 0.54. The
  blow lands at 0.17 with the `slash` callout. It never chains into the combo. The blade trail is on
  from 0.12 to 0.36. In the air, W + click is the aerial attack.
- **High jump:** the same take-off (`squat`, 0.06 s), a bigger dust puff, and the air blend pulled
  toward `riseHigh` while he rises fast; at the apex he opens back into `apex` and falls as usual.
  It is Space held (G2, revised 2026-10-01): Space still held at take-off launches the high jump; let go
  while rising below the normal jump's height, the rise is cut to end at that height, and the pose opens
  back to the normal jump's. A tap is exactly the normal jump; holding it all the way, the high jump.

### 5.2 Drinking (`drinkPose`)

| Time (s) | What is drawn |
|---|---|
| 0 → 0.3 | the weapon swap overlay to the hip; the weapon goes away at 0.15 (the sword to its sheath on the back, the hook blades to the belt) and the **flask** is in the front hand |
| 0.3 → 0.5 | `drinkReach` (flask at the hip) → `drink`: the flask up to the face, head tilted back (`hd` −24) |
| 0.5 → 1.1 | he drinks: the head nods ±2 at 9 rad/s; the liquid in the flask drops from full to empty |
| 1.1 → 1.3 | `drink` → `drinkReach`: the empty flask back to the hip |
| 1.3 → 1.6 | the swap overlay back to the weapon held before (the hand to the shoulder for the sword, to the hip for the hook blades) |

If F is released before 1.1 s, the drink is cancelled: the flask goes and the weapon comes back at
once with the swap overlay; nothing is drunk. The flask is the potion's (step 3.6): glass in `paperLight`, a leather stopper and
amber liquid, the torch flame's two colours (`05-items/potion/potion.md`).

### 5.3 Levitation and the anchor

- **Levitate:** he rises 150 over 0.9 s (sandbox values; the golem decides, step 3.11) and floats,
  bobbing ±5 at 1.6 rad/s. The pose is slack: body tilted forward, head dropped (`hd` 28), the
  weapon arm hanging, the other drifting up. It turns slowly, `rot` = 9·sin(0.9t) about `pv` = 100,
  and the arms and the front leg sway (±6, ±5). The cape is in `flotar`. A/D do nothing.
- **Anchor:** S + click throws the next hook blade straight down (0.14 s) to the floor under him; it
  bites with dust, a spark and the `clack` callout; then the chain pulls him down over 0.35 s
  (accelerating, u²) into a 0.22 s land with a big dust puff, and both chains reel in. The pose goes
  from `levitate` to `anchor` in 0.12 s: both hands low on the chain, head down.

### 5.4 Strike, bite, pull and overhead arc

- **Strike:** as version 1 (chain blades, §4 row). If it **hits an enemy, the blade bites**: it stays
  where it hit for 0.3 s with its chain taut, then returns.
- **Pull:** a click while the blade bites. The chain drags him to the enemy in 0.22 s (ease in-out),
  in `pullFly`; on arrival the chain reels back (0.1 s) and he strikes with the hook blade in hand
  (the diagonal slash, hit at 0.1 s after arrival, `slash` callout), and recovers by 0.42 s.
- **Overhead arc:** the front hand throws. The blade flies along a quadratic curve whose control
  point is 330 above the shoulder and 60 ahead, to a point 280 ahead near the floor, in 0.26 s (ease
  in-out), turned along the curve; it bites with dust and returns in 0.22 s.

### 5.5 Area spin

The front hand holds its chain and the blade circles him: a flattened circle (radius 150, vertical
radius 0.55 of it, centred 150 above his feet) at 13 rad/s, growing from 0 to full radius in 0.14 s,
turned along its path. The arm sways ±10 with the blade. On release the blade comes back in 0.15 s.
Each enemy it passes is struck (sandbox: once every 0.25 s) with the `slash` callout.

### 5.6 Hanging from a ring: the free hand (`hangPose`, G12–G15)

- **The holding hand** stays as in `swing` (upper and lower arm at −92) whichever hand it is, so the
  ring stays where it was. The other hand is free.
- **Free hand, hook blade** (always what it holds on catching a ring): the arm forward and down
  (upper 64, lower 26), the blade in the hand.
- **Free hand, shield** (the wheel swaps it): the shield goes to the free forearm, whichever hand
  it is, and the free hook blade goes to the belt. Lowered: arm 100/84, shield edge-on; raised: arm
  25/−55, shield facing out (`sh` 1). It rises and falls with a rate of 24/s.
- **Free throw** (right click with the hook blade): the arm cocks back (−150/−165) in 0.05 s, then
  snaps to the aim in 0.08 s; the blade flies 340 toward the mouse (forward and down if the mouse has
  not moved) in 0.15 s and returns in 0.2 s. The aim is taken in the body's frame (the aim minus the
  swing's rotation).
- **Hit while hanging:** blocked or not, the swing is pushed away from the attacker; he never lets
  go (sandbox; the game decides). The same sparks and callouts as on the ground.
- **Throwing to the next ring** swaps the hands: the new free hand holds its hook blade again.

### 5.7 Hanging counter (G13)

As the ground counter (`../../02-art-direction/fx/counter/counter.md`): hitstop 0.09, 16 ink sparks,
the `counter` callout, the aura, and afterimages every 0.04 s that fade in 0.24 s. The difference:
**the free hand's hook blade** goes out and back every 0.16 s (0.06 out, 0.06 back), with the free
arm's throw gesture on each beat, the heights stepping over the target (−26, 0, +26); the swing is
damped almost to a stop while it lasts (rate 8/s). When it ends, the free hand takes the shield
again.

### 5.8 Death (`deathPose`, `drawHeroDissolving`)

| Time (s) | What is drawn |
|---|---|
| 0 | hitstop 0.08, a spark and the `thud` callout; he is knocked back at 200, slowing at 6/s |
| 0 → 0.18 | `hurt` |
| 0.18 → 0.55 | `hurt` → `kneel`: the front foot planted, the back knee on the floor, head bowed, the sword tip down toward the floor ahead |
| 0.55 → 1.0 | `kneel` → `fallen` (ease in-out): he topples forward and lies face down, the sword arm reaching ahead with the sword flat on the floor; dust at both ends at 1.0 |
| 1.4 → ≈ 3.2 | **ink smoke**, the same method as `../../02-art-direction/fx/ink-smoke/ink-smoke.md`, applied to his whole drawing (body, cape, weapon, streak): it fills with ink in 0.2 s, then 40 seeded holes (radius 17–35 over the lying body, upper ones first) open over 0.45 s each, each with a puff; what remains fades after 1.0 s. Nothing is left behind |

If he dies in the air, he falls under gravity while the poses play. In the sandbox he gets up where
he fell at 3.6 s; in the game, death ends the run (`VISION.md` §Win / lose), and what follows is the
death screen's (`06-ui/death/death.md`).
