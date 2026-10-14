# Mace Brute — character contract

- **Status:** approved 2026-10-01 (B1–B9 approved as the sandbox does them)
- **Kind:** enemy (zone 1, the Suspended Sanctuary)
- **Sandbox:** the zone 1 sandbox, [`../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`](../../../../04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html):
  *Ir a… combate*, then *Enemigo* until it reads *bruto del mazo*; `N` makes it attack ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 1 enemies: *Mace Brute — unblockable overhead smash,
  blockable sweep*), §Mechanics (block, perfect block and counter, roll, fast descent, hit feedback) ·
  `02-art-direction/ART_DIRECTION.md` §5 (humanoid enemies reuse Akeris's skeleton, poses and
  crossfade, with their own head and no cape) · the operator's decisions of 2026-10-01 (a defeated
  enemy never comes back; the longer roll with its brief invulnerability)
- **Built on:** Akeris's skeleton at 1.35×
- **Code name:** `maceBrute` · **Español:** bruto del mazo

Every gameplay number is the sandbox's and is marked **the game decides**. The proposals B1–B9 (§12)
were approved by the operator on 2026-10-01.

## 1. Identity

One of the sanctuary's guards gone heavy: a hunched giant in stitched leather with a sackcloth hood
(two black holes, nothing visible inside), iron bracers, an iron belt and a spiked iron mace that
drags on the floor. It walks slowly and hits hard. At a glance a player reads: slow, huge, two
very different swings. The low swing backwards means *shield*; the mace going up over the hood
means *get out of there*.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height, hunched | ≈ 250 | Akeris = 192; the skeleton at 1.35× |
| body | a wide hunched trunk with a hump | the hood sits low, in front of the chest |
| mace | ≈ 150 long; spiked head radius ≈ 24 (spikes ≈ 34) | in guard its head rests on the floor in front |
| reach of the sweep | 215 | from its centre |
| where the smash lands | ≈ 250 in front | the mace head, from the `smash` pose |

**Silhouette test:** a hunched mass with a pale hood and a ball on a stick; it can never be read as
the knight (upright, shield, sword) nor as Akeris (thin, cape).

## 3. Palette and strokes

| Part | Colour | Stroke width (su, before scale) | Hatching |
|---|---|---|---|
| outline, limbs | `ink` | 2.6; limbs 8–9 | — |
| leather body | `wood` (the hafts') | 2.6 | `ink` at .32, gap 4; four stitch lines |
| hood | `paper` | 2.6 | `ink` at .34, gap 3.6; a seam; the eye holes `#120e0b` |
| bracers, belt, shoulder plate, mace head | `iron` (the knight's) | 1.8–2.2 | `ink` at .4 on the head |
| mace haft | `wood`, the binding `#b9ad95` | as Akeris's weapons | — |
| the crack where the mace lands | `ink` | 1.6 | fades in 0.5 s |

No new colour: everything is from the knight's and the weapons' palette.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| guard | spawn, end of an attack | — | yes | walk, sweep, smash | hunched, the mace head on the floor in front; slow breathing |
| walk | guard | — | yes | guard | Akeris's gait with the guard's arms; heavy steps |
| sweep (the telegraph) | guard | 0.50 | no | sweep hit | the mace goes back and low behind it (`sweep-wind`) |
| sweep hit | sweep | 0.08 → 0.95 | no | guard | swings level at waist height (`sweep`), then back to guard |
| smash (the telegraph) | guard | 0.85 | no | smash hit | both hands lift the mace high over the hood, leaning back (`smash-wind`) |
| smash hit | smash | 0.10 | no | stuck | the mace comes down in front and sticks in the floor (`smash`) |
| stuck (open) | smash hit | 1.10 | no | pull | the mace stays in the floor; it tugs at the haft |
| pull | stuck | 0.35 | no | guard | pulls the mace free |
| stagger | a just block of the sweep (counter) | 1.30; graphite stars | no | guard | `hurt` |
| stun | the fast descent beside it | 1.20; graphite stars | no | guard | `hurt` |
| death | its last health | the ink smoke's | no | — | `fx/ink-smoke` |

It does not flinch when hit (B6): it is too heavy; hits only take health.

## 5. Weapons and gear

The spiked mace (`brMace` in the sandbox): a wooden haft with a binding at the grip and an iron ring
under the head, and an iron ball with eight spikes and a pale edge light. It never leaves its hands.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| slam | the smash lands | dust both ways, six grey chips, a fixed ink crack, `¡PUM!` and hitstop 0.07 | 0.5–0.6 |
| stars | stagger, stun | three graphite stars on a ring above it (as the other enemies') | the state's |
| hit feedback, block, counter, freeze, burn, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.maceBrute.step` | each step | `07-audio/sfx/sfx.md` |
| `sfx.maceBrute.sweepWind` | the sweep starts: its telegraph | `07-audio/sfx/sfx.md` |
| `sfx.maceBrute.smashWind` | the smash starts: its telegraph | `07-audio/sfx/sfx.md` |
| `sfx.maceBrute.swing` | the mace starts moving (the smash at rate 0.8) | `07-audio/sfx/sfx.md` |
| `sfx.maceBrute.slam` | the smash lands; ×0.5 when the fast descent stuns it | `07-audio/sfx/sfx.md` |
| `sfx.maceBrute.pull` | it pulls the mace free | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.akeris.hurt`, counter | the sweep on a shield; on Akeris; the just block | `07-audio/sfx/sfx.md` (existing) |
| `sfx.fx.inkSmoke` | death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 10 marks) | — |
| damage of the sweep and the smash | the game decides (sandbox: the HUD's test hit) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| sight | the game decides (sandbox: 900 su across, 260 up or down) | — |
| walk | the game decides (sandbox: 80 su/s; it stops ≈ 170 su away) | — |
| hit radius | 70 su, along its body from 50 to 290 su high | the sandbox |

**Behaviour:**

1. **Approach (B2).** It walks slowly toward Akeris and stops about 170 su away. It turns slowly
   (0.25 s). It never leaves its room or walks off a ledge. No contact damage.
2. **The rhythm (B3).** Sweep, sweep, smash, again; a pause of 1.0 s after each attack. If Akeris
   holds the shield up, its next attack is the smash.
3. **The sweep (B4)** reaches 215 su in front at waist height: **any shield stops it** (Akeris is
   pushed back); **the just block with the sacred shield opens the counter** and the brute staggers
   1.3 s. The roll's invulnerability passes through it; stepping back out of its reach dodges it.
4. **The smash (B5)** cannot be blocked: everything in front of it, from its body to about 50 su past
   where the mace lands, is hit, shield or not. **Dodge it by stepping back** (beyond ≈ 300 su) or
   **rolling through** it (the roll's invulnerability; Akeris ends behind it). Akeris hanging from the
   chain is not hit.
5. **Open (B5).** After the smash the mace stays in the floor for 1.1 s, then 0.35 s to pull it free:
   about 1.5 s in which it does not attack. That, and its back, are the openings.
6. **Reaching it (B6).** Every strike reaches it (it is tall and wide). It does not flinch. The fast
   descent beside it stuns it 1.2 s.
7. **Defeated, it stays defeated** for the rest of the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles: breathing and tugging move smoothly; nothing boils.
- It never attacks without its telegraph, and the two telegraphs never look alike: low and back
  means the sweep, high over the hood means the smash.
- The smash is never stopped by a shield; the sweep is always stopped by one.
- It never comes back once defeated.

## 10. Acceptance

1. In guard it matches `guard` of `sprites/sheet.png`; it walks with the heavy step sound.
2. The sweep plays as `sprites/sheet-sweep.png`, with its telegraph sound first.
3. The shield stops the sweep; the just block with the sacred shield opens the counter (`sheet-block.png`).
4. The smash plays as `sprites/sheet-smash.png`; with the shield up Akeris is still hit (`sheet-unblockable.png`).
5. Rolling through the smash leaves Akeris unhurt behind it (`sheet-roll.png`).
6. While the mace is stuck, strikes land and it does not attack (`sheet-stuck.png`).
7. The fast descent beside it stuns it (`sheet-stun.png`).
8. At its last health it dissolves (`sheet-death.png`), drops XP and coins, and never comes back.

## 11. Exports

From the zone 1 sandbox (`brExportAll()`, the sounds with `brExportSfx()`): `sprites/sheet.png`,
seven single poses, eight frame sheets and twelve screenshots in `captures/`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| B1 | Look | a hunched giant on Akeris's skeleton at 1.35×: stitched leather, a sackcloth hood with two black holes, iron bracers and belt, a spiked iron mace that drags; no new colour |
| B2 | Approach | slow (80 su/s), stops ≈ 170 su away, turns in 0.25 s |
| B3 | Rhythm | sweep, sweep, smash; the smash at once if Akeris holds the shield up; 1.0 s pause after each |
| B4 | The sweep | telegraph 0.5 s (the mace back and low), reach 215 su at waist height; any shield stops it; the sacred just block opens the counter (stagger 1.3 s) |
| B5 | The smash | telegraph 0.85 s (the mace high over the hood), lands ≈ 250 su in front; unblockable; dodge back beyond ≈ 300 su or roll through; the mace stays stuck 1.1 s + 0.35 s to pull it free |
| B6 | Being hit | every strike reaches it; it does not flinch; the fast descent stuns it 1.2 s |
| B7 | Hit radius | 70 su, along its body from 50 to 290 su high |
| B8 | Sound | heavy steps, the two telegraphs (different), the swing, the slam, the pull |
| B9 | Health | 10 marks in the sandbox, as the other enemies (the game decides) |
