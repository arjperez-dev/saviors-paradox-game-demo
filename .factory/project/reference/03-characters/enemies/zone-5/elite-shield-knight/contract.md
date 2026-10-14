# Elite Shield Knight — character contract

- **Status:** approved 2026-10-12 (operator: «Me encantaron»; step 3.15; the proposal EK1–EK9 approved by the operator on 2026-10-12, built as approved)
- **Kind:** enemy (zone 5, the Dragon Battlements); the garrison of the tower rooms
- **Sandbox:** the zone 5 sandbox, [`../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`](../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html):
  in the `gatehouse` and `guardroom` towers the garrison plan gives it (*Ir a… caballero*; the address `#s<seed>-caballero` also works) ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 5: *Elite Shield Knight*) · `03-characters/enemies/zone-1/shield-knight/contract.md`
  (K1–K9 still hold except where this contract changes them) · `00-game/controls.md` §Combat (the roll; G7; G16) ·
  `03-characters/akeris/weapons/hook-blades.md` §6 (the chain does not immobilize; each own reaction to the chain at most once every 5 s) ·
  `02-art-direction/palette/palette.md` · `04-zones/zone-5-dragon-battlements/biome.md` (the three hollows) · the operator's approval of
  EK1–EK9 and of the garrison R1–R5 (2026-10-12; EK6 «me gusta que castigue detrás del escudo»)
- **Built on:** Akeris's skeleton, poses and crossfade at 1.18× (`ART_DIRECTION.md` §5) and the zone 1 knight's iron pieces, with its
  own helm crest, tabard and tower shield
- **Code name:** `eliteKnight` · **Español:** caballero con escudo de élite

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

The guard of the walls Akeris's people raised: the most complete duelist of the demo. Taller and darker than the zone 1 knight —
iron blackened with soot, a closed helm with an iron crest, the people's tabard with the three hollows — behind a tower shield
whose painted **dragon eye** follows Akeris. It does not wait to be read: it raises its shield against a jump, answers a turtle
with its shield, turns on whoever rolls behind it, and closes distance with a thrust. Every attack has its warning, and the roll
gets through every one of them.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| standing height | ≈ 227 (crest top ≈ 240) | Akeris = 192; his rig at 1.18× |
| tower shield | ≈ 64 × 116 | covers from the knee to the chin: also when Akeris crouches |
| sword | ≈ 125 | the zone 1 knight's iron sword |
| high guard | the shield raised over the helm, top ≈ 300 | towers are 400–420 su high: never reaches the vault |

**Silhouette test:** a black squared helm with a fin crest, a tall rectangular shield in front, a long blade over it. Never the zone 1
knight (heater shield, no crest, stone-pale), never Akeris (no round head, no cape).

## 3. Palette and strokes

| Part | Colour | Hatching |
|---|---|---|
| outline | `ink` | Akeris's widths × 1.18 |
| helm, crest, plate, faulds, leg and arm pieces, pauldron | `iron` `#5a554e` | soot: `rgba(8,6,5,.42)`, gap 2.4–2.6 (denser than the zone 1 knight's) |
| light edges | `rgba(210,205,194,.65)` | — |
| tabard | `parchmentDark` `#ddd3bf` | `ink` at .3; **the three hollows** in `#16120f` (as the banners) |
| tower shield face | `stone` minus 24, `rgb(176,168,155)` | `ink` at .13, heavier on its lower part |
| shield rim and bands, rivets | `iron` 4.6 under `ink` 2; `ink` rivets | — |
| dragon eye | `flame` `#e8872e` iris, `#ffd978` centre, a slit pupil in `ink`, three scales over it | — |
| sword | `iron`, `ink` grip with `leather` wrap | as the zone 1 knight |

No new colour. **Static:** every stroke has its fixed seed (the same pose drawn twice is identical, pixel for pixel); only the
breathing moves (≈ 0.02° per frame).

## 4. Animations

| Animation | Entered from | Duration (s) | Exits to | Key poses (`sprites/`) |
|---|---|---|---|---|
| guard / walk | spawn, every state's end | — | any attack, turn | `guard`, `walk` |
| high guard | Akeris in the air in front within 260 su | rises in 0.15, falls in 0.25 | guard | `high` |
| combo | Akeris within 225 su | 0.5 warning · cut at 0.57 · 0.25 second warning · rising cut at 1.03 · recover to 1.73 | guard | `wind`, `cut`, `riseTel`, `rise` |
| thrust | Akeris at 230–420 su | 0.45 warning · lunge 200 su (≈ 0.18) · hold 0.22 · recover 0.5 | guard | `thrustTel`, `thrust` |
| bash | Akeris 1 s behind his raised shield within 200 su | 0.4 warning · charge 160 su · recover 0.6 | guard | `bashTel`, `bash` |
| turn / spin | Akeris behind it 0.35 s (counted from the end of his roll) | turn: crossfade 0.16; spin: 0.4 warning · cut · recover 0.63 | guard | `spinTel`, `spin` |
| blocked | a blow on its shield | 0.24 | guard | `blocked` |
| yank | the chain's first pull on the shield | 0.8 (open) | guard | `yank` |
| aside | the hammer on the shield | 0.5 (open) | guard | `aside` |
| snatched | the chain's second pull | 0.6 | guard (shieldless) | `snatched` → `bGuard` |
| stagger | the sacred just block (the counter) | 1.3 | guard | `stagger`, graphite stars |
| stun | Akeris's fast descent beside it | 0.8 | guard | `stagger`, graphite stars |
| hurt | a blow that lands while in guard | 0.25 | guard | `hurt` |
| frozen / burning | the ice / fire just block (G16) | 1.5 | guard | the pose held under ice; flames |
| dying | its last health | 2.4 | — | the shield falls first (`dying`), then it fills with ink and dissolves (`sheet-death.png`) |

## 5. Weapons and gear

| Item | How it moves | When it changes |
|---|---|---|
| sword | one-handed over the shield; two-handed once the shield is gone | never sheathed |
| tower shield | on the back forearm; the eye's slit pupil follows Akeris (±5 su); raised over the helm in the high guard; pulled aside by the chain or the hammer | torn away by a second chain pull: flies toward Akeris, lands, lies flat 1.2 s and dissolves in ink; at death it falls first |

Neither is an item: Akeris cannot pick them up.

## 6. Effects

| Effect | When | Look |
|---|---|---|
| shield block | a blow on its shield | ink sparks at the rim, `CLANG!` |
| chain on the shield | yank / snatch | ink sparks, `¡Cadena!` |
| stars | stagger, stun | three graphite stars above the helm |
| frozen | ice just block | pale `ice` shell |
| burning | fire just block | three small flames; 1 health every 0.5 s |
| health marks | Akeris in its tower | 14 ink marks with a `paperLight` rim, drawn above the tower's darkness |
| ink smoke | death | it fills with ink from the top, holes open, puffs rise |

## 7. Sounds

All `sfx.eliteKnight.*` (`07-audio/sfx/sfx.md`, *Enemies of zone 5*; WAV in `07-audio/sfx/enemies/`), plus the existing
`sfx.hit.clang` (a blow on the shield, the bash), `sfx.hit.blade` / `sfx.hit.blunt` (a blow that lands) and `sfx.fx.inkSmoke` (death).

| Id | When |
|---|---|
| `step` | each foot contact while it walks |
| `raise` | every attack starts: the warning |
| `swing` | each cut of the combo |
| `rise` | the combo's second warning (the blade turns, a step) |
| `thrust` | the thrust leaves |
| `bash` | the bash leaves |
| `guardUp` | the high guard rises |
| `yank` | the chain pulls the shield aside (softer: the hammer) |
| `snatch` | the chain tears the shield away |
| `shieldDrop` | the loose shield hits the floor |
| `spin` | the spinning cut |
| `stun` | the fast descent stuns it |

## 8. Mechanics

| # | Rule (approved 2026-10-12; numbers: the game decides) |
|---|---|
| R1–R5 | **Where:** the garrison of the tower rooms (`z5Garrison`, shared with the fire mace brute): each `gatehouse` and `guardroom` has one, knight or brute, never two; always on the main path, 60 % on branches; the brute 65 % in the gatehouse, the knight 65 % in the guardroom; x 1600 / 800 (mirrored when the room is flipped). Never in open rooms, shafts, dead ends or the boss room. Seeds 1–3: 3, 4 and 1 knights. |
| EK1 | **Look:** §1–§3. |
| EK2 | **High guard:** if Akeris jumps in front within 260 su it raises its shield in 0.15 s and stops the blow to the helm (`CLANG!`). Before it is up, a jumping blow to the helm lands; the chain's overhead arc lands unless the high guard is up. |
| EK3 | **The shield resists the chain:** a ranged chain strike on the shield from the front pulls it **aside 0.8 s** (open; its own reaction to the chain, at most once every 5 s; in between the chain only clangs). The next reaction, **≥ 5 s later, tears the shield away**. **The hammer** on the shield pulls it aside 0.5 s (not a chain reaction; the hammer's next combo blow lands). On an open or shieldless knight the chain hurts (1) without interrupting it. |
| EK4 | **Two-cut combo:** an overhead cut (0.5 s warning: the sword behind the helm) and a **rising cut** with its own 0.25 s warning (the blade turns, a step of 46 su); 2 each. Any shield stops both; the sacred just block on either opens the counter (stagger 1.3 s; the counter's blows take 1 each, up to 3); rolling dodges both. |
| EK5 | **Thrust:** Akeris at 230–420 su → 0.45 s warning (the sword back at the shoulder), a 200 su lunge with the point: 2. Any shield stops it; rolling dodges it. |
| EK6 | **Shield bash** against a blocker: Akeris 1 s behind his raised shield and within 200 su → 0.4 s warning (the shoulder down behind the shield), a 160 su charge: **1**, pushes him and **lowers his shield 0.6 s** (he cannot raise it). **No shield stops it; rolling dodges it.** |
| EK7 | **Turn:** it turns in 0.35 s, counted from the end of Akeris's roll. If Akeris is still behind it and close (≤ 220 su) when the 0.35 s end: the **spinning cut** (0.4 s warning, 200 su to both sides, 2); any shield stops it, rolling dodges it. Farther, it just turns. A blow in its back lands. |
| EK8 | **Shieldless:** two-handed, faster (raise 0.38 s, pause 0.4 s); keeps the combo, the thrust and the spin, no bash, no high guard; every blow lands from any side. |
| EK9 | **Endurance:** 14 health; the fast descent within 180 su stuns it 0.8 s (no damage); no contact damage (Akeris passes through it); walks at 130 su/s to ≈ 175 su; never leaves its tower; the ice / fire just block freezes / burns it (G16; frozen, blows take double). Pause between attacks 0.8–1 s (0.25 after a blow it blocked). |
| — | **Defeat:** the shield falls first, then ink smoke; defeated, it never comes back. |

## 9. Never

- An attack without its warning, seen and heard.
- An attack the roll does not dodge.
- Being held still by the chain (its reaction, the shield pull, at most once every 5 s).
- Blocking from behind, with its shield aside (combo cuts, recoveries, yank, aside, stagger, stun, frozen) or shieldless.
- Leaving its tower, entering the stone, or reaching into the vault.
- Blood, trembling lines, or any colour beyond §3.

## 10. Acceptance

Tested in the sandbox (2026-10-12; scripts in the session scratchpad `ek/`):

1. It walks to ≈ 194 su of Akeris in guard.
2. Combo standing: 4 (both cuts land); with the shield 0 (2 blocks); sacred just block on the first or the second cut: the counter (14 → 11); ice: frozen 1.5 s; fire: burning 1.5 s (14 → 11); rolled through both cuts: 0.
3. Thrust: 2 (it lunges ≈ 192 su); blocked 0; rolled 0; just block: the counter.
4. Bash against a held shield: 1, Akeris cannot raise his shield while it is lowered (0 frames); rolled: 0.
5. Jumping at its helm: the high guard rises (`guardUp`) and the blow clangs; from the front on the floor, 2 blows, 2 clangs; in its back the blow lands.
6. Behind it at 150 su: the spinning cut (2); blocked 0; rolled 0. Behind at 600 su: it turns at 0.35 s. Rolling under it: it turns 0.34 s after the roll ends.
7. Chain: first pull → aside; 1 s later → clang, no damage; 5 s later → torn away, the loose shield falls and dissolves. On it open, the chain takes 1; on a shieldless warning, 1 and the warning goes on; the overhead arc takes 1.
8. Hammer on the shield: aside, no damage; the hammer's combo then lands (1).
9. Fast descent beside it: stunned 0.8 s, no damage, `stun`.
10. Shieldless: raise 0.38 s, combo 4, a front blow lands, never a bash.
11. Death: stun → dying with the shield falling → ink → dead; it stays dead. Sounds: `shieldDrop`, `inkSmoke`.
12. **Random player** (40 runs × 40 s per seed, seeds 1–3, in its towers, sword, chain blades, hammer and spear, each shield): no errors; never inside the stone, never out of its tower, never stuck in a state; **no damage while rolling (0)**. Per seed: combos 259 / 279 / 252, thrusts 141 / 150 / 163, bashes 28 / 34 / 55 (22 / 21 / 37 landed), spins 110 / 84 / 86, high guards 333 / 334 / 298, yanks 10 / 10 / 10, snatches 9 / 9 / 10, stuns 87 / 82 / 108. Damage taken ≈ 15 per run.
13. **Against the zone 1 knight, with the sword** (seed 1, 40 runs): a duelist bot (blocks or just-blocks the warnings, rolls the bash, strikes when it is open or turned) beats the zone 1 knight 40/40 in 9.4 s on average taking 0.7 per run; the elite 34/40 in 18.7 s taking 4.6. The random player beats the zone 1 knight 3/40 (3.1 per run) and the elite 0/40 (15.1 per run). With the duelist and every weapon (seeds 1–3): 33–34/40, 14–16 s; the chain blades are the fastest (6–8 s), the hammer the slowest (18–20 s).
14. The garrison, seeds 1–3: 3 / 4 / 1 knights; never in a room with a drakeling or a gargoyle; never two of the garrison in a room; every main-path tower garrisoned.

## 11. Exports

- [`sprites/sheet.png`](sprites/sheet.png): the 24 poses, and each alone (`sprites/<pose>.png`); [`sprites/shield.png`](sprites/shield.png): the tower shield and the sword
- [`sheet-combo.png`](sprites/sheet-combo.png), [`sheet-thrust.png`](sprites/sheet-thrust.png), [`sheet-bash.png`](sprites/sheet-bash.png), [`sheet-spin.png`](sprites/sheet-spin.png), [`sheet-guard.png`](sprites/sheet-guard.png), [`sheet-chain.png`](sprites/sheet-chain.png), [`sheet-bare.png`](sprites/sheet-bare.png), [`sheet-death.png`](sprites/sheet-death.png)
- [`captures/`](captures/) (25): guard, the tower, both cuts and their warnings, the thrust and its warning, rolling through it, the bash and its warning, the shield, the high guard, the back, the spinning cut, the chain pulling and tearing the shield, the hammer, the counter, ice, fire, stunned, shieldless, the shield falling and the ink smoke
- The sandbox exports it all with `ekExportAll()` and the sounds with `ekExportSfx()`.

## 12. Chain balance (step 3.17, *approved* 2026-10-13)

HB1 flagged it (the hook blades won in 41 % of the other weapons' time). **HB2, the long bash:** after two chain hits in a row from range
(> 200 su, no 5 s pause) it answers, at most once every 5 s: 0.55 s warning (`hbTel`: lower than EK6's, the shoulder behind the shield,
one foot back; `sfx.eliteKnight.charge`, `¡BRUUM!`), then it runs 900 su/s up to 480 su: **1** and Akeris's shield lowered 0.6 s, as EK6
(no shield stops it; **rolling dodges it**). Shieldless: the running thrust (`bHbTel`, `bHbRun`), 2, any shield stops it. Arriving with
Akeris within reach: its combo; otherwise 0.7 s open. Its chain reaction never cuts it. **HB3:** its shield already stopped the frontal
chain (a clang between its 5 s reactions); unchanged. Frames: `sprites/sheet-lunge.png`, `sheet-lunge-bare.png`. Measured after: 43 %
(still under 60 %; see `../../../akeris/weapons/hook-blades-balance.md`).
