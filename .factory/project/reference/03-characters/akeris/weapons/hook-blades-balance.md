# Akeris — the hook blades' balance, enemy by enemy (HB1–HB4)

- **Status:** approved 2026-10-13 (step 3.17). The operator keeps everything as built («Lo de las embestidas me gusta») and **accepts that the
  blades stay strong for now**; §5 (P1–P3) is not applied. Later, in the game, they may be rebalanced or **turned into the weakest
  weapon** (the least damage), used above all to climb and move, for their defined utility moves (snatching shields, knocking down
  the enemies already defined) and to anchor to the floor (operator, 2026-10-13). HB2, as built, does not reach the 60 % target (§4).
- **Sandboxes:** the zone 5 sandbox (zones 1–3 and 5 enemies; block «Paso 3.17 — el equilibrio de las espadas gancho», prefix `hb`) and the
  zone 4 sandbox (zone 4 enemies; the same block, only the HB3 fix). Zones 1–3 sandboxes keep the old weapon (by decision).
- **Rules it keeps:** [`hook-blades.md`](hook-blades.md) §6 (C1–C3) and §7 (HB1–HB4).

## 1. How it was measured (HB1)

A **duelist bot with the same logic for every weapon** (only the weapon and its reach change): it walks to its weapon's reach (the hook
blades keep 190–300 su and strike at the enemy's centre, never clicking during the bite, so never pulling), learns each enemy's hit timings
in a first pass (4 runs per weapon without dodging) and then, in the duel, **just-blocks (60 %) or rolls** each learned attack 0.02–0.24 s
before it lands (always rolls what proved unblockable), learns which enemy states its blows bounce off and waits them out; it jumps at
flyers and strikes low enemies from above. The two knights use the duelist already used for them (`ek/fz_ek_duel.js`: when each attack
lands, whether it is blockable, when it is open). **20 runs per weapon and enemy**, seed 1, 60 s at most (a run not won counts 60 s), 999
health (the damage taken is counted). Zones 1–3 and 5 enemies in the zone 5 sandbox, zone 4 enemies in the zone 4 sandbox. Script:
`scratchpad/hb/core.js` + `run.mjs`. Time = mean time to kill (s); *blades ÷ others* = the hook blades' time over the mean of the other
four weapons; **< 60 %** flags the enemy.

## 2. Before (main, 6377ae0)

| Zone | Enemy | sword | hook blades | spear | flail | hammer | damage taken per run (sword / blades / spear / flail / hammer) | blades ÷ others |
|---|---|---|---|---|---|---|---|---|
| 1 | shield knight | 6.41 | 5.16 | 7.31 | 6.76 | 8.13 | 0.1 / 0 / 0.7 / 0.2 / 0.8 | 72 % |
| 1 | rune sentinel | 7.49 | 8.71 | 9.4 | 9.63 | 10.59 | 0.1 / 2.6 / 0.6 / 2 / 1.4 | 94 % |
| 1 | wandering eye | 11.02 | 7.97 | 59.77 (1/20) | 10.19 | 13.93 | 0 / 0 / 0.2 / 0 / 2 | 34 % **< 60** |
| 1 | mace brute | 8.58 | 6.97 | 10.46 | 8.63 | 9.76 | 0.2 / 0 / 0.2 / 0.2 / 0.3 | 74 % |
| 2 | small bats | 1.76 | 2.9 | 1.62 | 1.88 | 1.95 | 0 / 0 / 0 / 0 / 0 | 161 % |
| 2 | blind ghoul | 57.37 (1/20) | 57.21 (1/20) | 57.06 (1/20) | 60 (0/20) | 60 (0/20) | 0 / 0 / 0 / 0.2 / 0 | 98 % |
| 2 | ceiling crawler | 8.47 | 7.11 | 8.41 | 11.13 | 13.9 | 4 / 1.4 / 4 / 4.7 / 5.6 | 68 % |
| 2 | many-armed | 60 (0/20) | 60 (0/20) | 60 (0/20) | 60 (0/20) | 60 (0/20) | 0.2 / 0 / 0 / 0 / 0 | 100 % |
| 3 | skeleton archer | 3.81 | 3.18 | 3.61 | 6.91 | 9.39 | 0 / 0 / 0 / 1.7 / 4.3 | 54 % **< 60** |
| 3 | gravedigger | 7.18 | 4.66 | 7.52 | 11.65 | 10.48 | 4.6 / 0 / 2 / 6.3 / 5.5 | 51 % **< 60** |
| 3 | wraith | 7.1 | 2.77 | 5.79 | 9.12 | 5.46 | 0.4 / 0 / 0.2 / 0.7 / 0.3 | 40 % **< 60** |
| 3 | ossuary many-armed | 33.25 (13/20) | 32.9 (12/20) | 43.42 (12/20) | 55.06 (3/20) | 50.08 (6/20) | 6.7 / 5 / 5.5 / 4.2 / 8.2 | 72 % |
| 4 | mantis | 5.11 | 1.74 | 3.85 | 4.8 | 5.6 | 1.1 / 0 / 0.8 / 0.6 / 1.1 | 36 % **< 60** |
| 4 | strangler vine | 16.28 (16/20) | 13.47 (16/20) | 13.9 (16/20) | 23.48 (16/20) | 41.21 (15/20) | 8.8 / 8.8 / 9 / 9 / 11 | 57 % **< 60** |
| 4 | spore pod | 54.36 (3/20) | 43.76 (8/20) | 53.55 (4/20) | 52.35 (3/20) | 52.64 (3/20) | 40.95 / 31.4 / 40.5 / 38.8 / 38.35 | 82 % |
| 4 | spiderlings | 5.7 (19/20) | 22.79 (13/20) | 8.36 (18/20) | 5.92 (19/20) | 5.81 (19/20) | 0.3 / 0.25 / 0.3 / 0.3 / 0.3 | 353 % |
| 5 | drakeling | 8.71 | 1.44 | 5.8 | 4.27 | 4.18 | 0.85 / 0 / 2.85 / 2.6 / 2.95 | 25 % **< 60** |
| 5 | gargoyle | 8.14 | 2.37 | 6.88 | 7.33 | 3.51 | 4.65 / 0 / 4.2 / 4.5 / 3 | 37 % **< 60** |
| 5 | elite shield knight | 17.55 | 7.96 | 18.69 | 17.06 | 23.52 | 0.8 / 1.5 / 1.5 / 1 / 4.8 | 41 % **< 60** |
| 5 | fire mace brute | 14.75 | 4.81 | 16.98 | 13.62 | 19.24 | 4 / 0.8 / 3.3 / 2.3 / 4 | 30 % **< 60** |

Not conclusive (the bot, not the weapon): the **many-armed** (zone 2) and the **blind ghoul** are almost never won by any weapon (the grab;
the ghoul's stealth kill is not used); the **spore pod** and the **strangler vine** runs are dominated by the poison and the hold (they
also explain the damage taken while rolling there: poison ticks, not attacks); the **spiderlings** are a swarm the chain aims badly at.

**Flagged (< 60 %):** wandering eye, skeleton archer, gravedigger, wraith, mantis, strangler vine, drakeling — light, swarm, ranged or
special (report and propose, §5) — and the **heavies**: **elite shield knight, fire mace brute, gargoyle** (stone: «too heavy» for the
chain) → HB2. The zone 1 knight (72 %) and mace brute (74 %) are not flagged: nothing changes for them but HB3.

## 3. What was built (HB2, HB3)

| # | Enemy | The lunge (HB2) | Frames · sound |
|---|---|---|---|
| HB2a | elite shield knight | **the long bash**: 0.55 s warning (lower than EK6's: the shoulder behind the shield, one foot back; `¡BRUUM!`), then it runs 900 su/s up to 480 su: **1** and lowers Akeris's shield 0.6 s (as EK6; **no shield stops it**). Shieldless: **the running thrust**, 2, any shield stops it. If Akeris is still within reach when it arrives: its combo (with its warnings); otherwise 0.7 s open | `sprites/sheet-lunge.png`, `sheet-lunge-bare.png`, `hbTel.png`, `hbRun.png`, `bHbTel.png`, `bHbRun.png` · `sfx.eliteKnight.charge` |
| HB2b | fire mace brute | **the charge**: 0.6 s warning (it crouches, the hood down, the cage dragged back low, pawing; a bellow; `¡BRUUM!`), then it runs 680 su/s up to 520 su with the cage in front like a ram: **2**, **no shield stops it**. Within its sweep reach when it arrives: its sweep or smash; otherwise 0.9 s open | `sprites/sheet-charge.png`, `chargeTel.png`, `charge.png` · `sfx.fireBrute.charge` |
| HB2c | gargoyle | on the floor, **the pounce**: 0.5 s warning (crouched, wings up and back, claws raised; a stone screech; `¡GRRAAAH!`), a low leap at 860 su/s up to 460 su (only where its body fits on the floor): **2**, no shield stops it; lands beside Akeris → its claw (0.4 s warning), else 0.6 s open. In the air: **its usual dive, at once** (the 0.6 s shadow warning over Akeris) | `sprites/sheet-pounce.png`, `pounceTel.png`, `pounce.png` · `sfx.gargoyle.pounce` |
| HB2 | all three | after **two chain hits in a row from range** (> 200 su, beyond the spear; no 5 s pause; any other blow breaks the row); **at most once every 5 s**; never while Akeris is in his counter, dying or falling; its own chain reaction (reel, cringe) never cuts it; **the roll always dodges it** | — |
| HB3 | both shield knights | a frontal chain strike on the raised shield: `¡CLANG!`, no damage (between its 5 s reactions); it lands from above (the overhead arc), from behind, and once the shield is gone. **Fixed:** in the zone 4 and 5 sandboxes the C1–C2 rule passed the arc to the zone 1 knight as a weak chain and its shield stopped it; now it lands | — |

## 4. After (HB2 built as approved)

| Zone | Enemy | sword | hook blades | spear | flail | hammer | damage taken per run (sword / blades / spear / flail / hammer) | blades ÷ others |
|---|---|---|---|---|---|---|---|---|
| 1 | shield knight | 6.64 | 5.44 | 8.37 | 7.27 | 9.09 | 0 / 0 / 0.7 / 0.2 / 0.3 | 69 % |
| 5 | gargoyle | 8.14 | 2.36 | 6.88 | 7.41 | 3.48 | 4.65 / 0 / 4.2 / 4.4 / 3 | 36 % **< 60** |
| 5 | fire mace brute | 14.75 | 5.44 | 16.98 | 13.54 | 19.24 | 4 / 0.2 / 3.3 / 2.3 / 4 | 34 % **< 60** |
| 5 | elite shield knight | 17.84 | 8.04 | 18.68 | 17.18 | 21.57 | 0.8 / 0.5 / 2 / 0.9 / 3.1 | 43 % **< 60** |

(Only these four enemies' code changed; the rest of the table stays as §2.) Lunges per 20 hook-blade duels: elite knight 16 (16 rolled),
fire brute 17 (16 rolled, 1 hit), gargoyle 19 (dives). With the cooldown at 2.5 s or even 1 s (sandbox experiment, 6 runs) the times
barely move (fire brute 5.2 → 5.8 s, elite knight 8.2 → 9.6 s, gargoyle 2.2 s).

**Result: the target (no enemy under 60 %) is not reached.** A competent player rolls every lunge (0.5 s lost each), and the hook blades
strike about three times a second from range: one lunge every 5 s cannot double the time to kill. The blades stay a good weapon (never
the slowest).

## 5. Proposals (for the operator; not built)

| # | Proposal | Estimate |
|---|---|---|
| P1 | **Heavies shrug the chain**: iron and stone (elite knight, fire brute, gargoyle) take ½ from each ranged chain strike (two strikes, one mark); the pull's blow and the arc as now | ≈ doubles the blades' time: fire brute ≈ 64 %, elite knight ≈ 80 %, gargoyle ≈ 65 % |
| P2 | **The gargoyle turns to stone** as its chain reaction (1 s, nothing hurts it; once every 5 s) instead of cringing | gargoyle ≈ 55–60 % |
| P3 | **The fire brute guards with the cage**: in guard, a frontal chain strike clangs off the swinging cage 1 time in 2 | ≈ 60 % |
| P4 | Light / ranged / special flagged (eye, archer, gravedigger, wraith, mantis, vine, drakeling): leave as they are — the blades are the intended answer to flyers and archers, and the wraith and gravedigger are built around the chain's reactions; at most, the mantis and drakeling **sidestep a second chain strike in a row** (a hop, once every 5 s) | — |
