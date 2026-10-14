# Fire Mace Brute — character contract

- **Status:** approved 2026-10-12 (operator: «Me encantaron»; step 3.15; the proposal FB1–FB9 approved 2026-10-12, built as below)
- **Kind:** enemy (zone 5, the Dragon Battlements); the garrison of the passage towers (`gatehouse`, `guardroom`)
- **Sandbox:** the zone 5 sandbox, [`../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`](../../../../04-zones/zone-5-dragon-battlements/sandbox/sandbox.html):
  *Ir a… bruto* (or `#s2-bruto`); `N` makes the brute of Akeris's room attack (sweep, sweep, smash; from afar, the coals);
  each test scene plays live with `#fb-<name>` (e.g. `#fb-ola`, `#fb-brasasDevuelta`, §10) ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 5: *Fire Mace Brute*) · `../../zone-1/mace-brute/contract.md` (B1–B9 still hold
  unless changed here) · `00-game/controls.md` (the roll; G7: a projectile blocked just before impact flies back; G16) ·
  `03-characters/akeris/weapons/hook-blades.md` §6 (the chain does not immobilize; own reaction at most once every 5 s) ·
  `02-art-direction/fx/elements/elements.md` (fire: only the fire shield) · the operator's approval of FB1–FB9 (2026-10-12), with
  the garrison rules R1–R5 and the operator's rules (nothing trembles; rolling always dodges; no fire left on the floor, DR7)
- **Built on:** Akeris's skeleton at 1.4× and the zone 1 brute's body (`drawBruteFig`), redrawn
- **Code name:** `fireBrute` · **Español:** bruto del mazo de fuego · prefix `fb` in the sandbox

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

The zone 1 brute hardened by fire: a hunched giant of blackened leather with a sackcloth hood charred at the edges and a faint
ember glow deep in its two eye holes. Its mace head is an **iron cage with spikes, full of embers**, with a torchlight halo, that
sheds sparks when it swings. It guards the passage towers of the walls. The fire punishes whoever backs away: close in, it is the
zone 1 brute (sweep, sweep, smash); the smash sends a low tongue of fire along the floor, and from afar it throws coals.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height, hunched | ≈ 260 (the hood ≈ 240) | Akeris = 192; the skeleton at 1.4× |
| mace | ≈ 130 long; cage radius ≈ 25 (spikes ≈ 36) | in guard the cage rests on the floor in front |
| highest point of any pose | ≤ 370 | the tower vaults are at 400–420: the mace never touches them (when a blend would lift it higher, it foreshortens) |
| reach of the sweep | 225 | from its centre |
| where the smash lands | ≈ 260 in front | the cage, from the `smashHit` pose |

**Silhouette test:** the zone 1 brute's mass (hunched, pale hood, ball on a stick) with a glowing ball: never the elite knight
(upright, tower shield) nor Akeris.

## 3. Palette and strokes

| Part | Colour | Stroke (su, before scale) | Hatching |
|---|---|---|---|
| outline, limbs | `ink` | 2.6; limbs 8–9 | — |
| leather body | `wood` blackened | 2.6 | `ink` at .5, gap 2.6; stitches; three burn marks `ink` at .55 |
| hood | `parchmentDark` `#ddd3bf` | 2.6 | `ink` at .4; charred lower and back edges `ink` at .6–.78 |
| eye holes | `#120e0b` with an ember dot `flame` at .6 (doused, .25) | — | — |
| bracers, belt, shoulder plate, cage bars and spikes | `iron` | 1.3–2.4 | — |
| embers in the cage | `flame` `#e8872e`, `#ffd978` cores, coal bits `ink` at .7; doused: `mortar` `#35302a` and `iron` ash | — | — |
| halo | `torchlight` `rgba(255,160,70,·)` | — | — |
| hood on fire (enraged) | `flame` licks with `#ffd978` cores | 1 | — |
| fire wave, coals, sparks, spilled embers | `flame`, `#ffd978`, `torchlight`; the coal outlines `ink` | 1.6 | — |

No new colour. **Static:** every stroke has its seed; the breathing and the stuck tug move slowly; the flame licks of the wave
and of the hood are fixed shapes (they move with the front, they never flicker); the cage's glow changes very slowly (2.2 rad/s).

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| guard | spawn, end of an attack | — | yes | walk, sweep, smash, coals | hunched, the cage resting on the floor in front (`guard`) |
| walk | guard | — | yes | guard | Akeris's gait with the guard's arms (`walk`) |
| turn | Akeris behind it | 0.25 | no | guard | it turns slowly |
| sweep | guard | 0.5 telegraph; hit 0.58; ends 0.95 | no | guard | `sweepWind` → `sweepHit` |
| smash | guard | 0.85 telegraph; hit 0.95 | no | stuck | `smashWind` (the mace high and back) → `smashHit` |
| stuck / pull | smash | 1.1 / 0.35 | no | guard | the cage in the floor, it tugs at the haft |
| coals | guard | 0.6 telegraph; throw at 0.6; ends 1.1 | no | guard | `whirl`: it swings the mace in a flat circle over its head (the cage foreshortens as it passes in front and behind) → `throwHit` |
| reel | the chain (once every 5 s, only in guard) | 0.4 | no | guard | it sways back (half `hurt`) |
| stagger | the sacred just block on the sweep | 1.3; graphite stars | no | guard | `hurt` |
| stun | the fast descent beside it | 1.0; graphite stars | no | guard | `hurt` |
| frozen | the ice just block on the sweep | 1.5 | no | guard | still, an ice tint |
| dead | 0 health | 1.7 | no | — | `hurt` → `down`; the embers spill and go out; ink smoke at 0.9 s; it fades |

## 5. Weapons and gear

The ember cage (`fbCage`): a wooden haft with a binding and an iron ring, an iron cage of four bars with eight spikes, embers
inside. It never leaves its hands. Doused, it is grey ash and smokes.

## 6. Effects

| Effect | When | Look |
|---|---|---|
| sparks | the cage moves fast (> 220 su/s) | small `flame` dots that rise and fade (≤ 90 at once) |
| halo | always (doused: none) | `torchlight` around the cage (r ≈ 120), and a faint one on the body so it reads in the dark tower |
| the slam | the smash lands | dust both ways, six chips, a fixed ink crack, `¡PUM!` |
| the fire wave | the smash lands with the cage lit | a low tongue (≤ 70 su, 150 su long) running both ways from the brute, from 90 to 600 su (800 enraged) at 900 su/s; cut by gaps and walls (and on one side by the fire shield); `¡FUUM!`; it leaves nothing on the floor |
| the coals | the throw | three glowing coals with short trails, in an arc; a patch of light grows on the floor where each will land; on landing they go out in sparks |
| douse | the ice just block | a puff of steam; the cage grey; a thin steam wisp every 0.45 s for 6 s |
| hood on fire | from half health | fixed flame licks along the hood's lower and back edges |
| death | 0 health | ten embers spill from the cage, bounce and go grey; ink smoke at 0.9 s |

Above the darkness: the halo, the embers in the cage, the eye glow, the burning hood, the wave, the coals, the sparks, the spill.

## 7. Sounds

All `sfx.fireBrute.*` (`07-audio/sfx/sfx.md`, *Enemies of zone 5*; WAV in `07-audio/sfx/enemies/fireBrute-*.wav`).

| Id | When |
|---|---|
| `step` | each heavy step (the cage swings and crackles) |
| `sweepWind` | the sweep's telegraph |
| `smashWind` | the smash's telegraph (a rising growl and the fire roaring up) |
| `swing` | the mace starts moving (the smash at rate 0.8) |
| `slam` | the smash lands; ×0.5 when the fast descent stuns it |
| `fireWave` | the fire wave runs |
| `whirl` | the coals' telegraph (three turns of fire); softer when it becomes enraged |
| `throw` | the coals leave |
| `coalHiss` | a coal goes out on the floor |
| `pull` | it pulls the mace free |
| `douse` | the ice douses the cage |
| `die` | defeated (then `sfx.fx.inkSmoke`) |

Existing: `sfx.hit.blade` / `sfx.hit.blunt` when it is hit, the shield sounds, `sfx.fx.reflect`, `sfx.fx.inkSmoke`.

## 8. Mechanics

Numbers are the sandbox's; **the game decides**.

| # | Rule |
|---|---|
| R1–R5 | **Where:** the garrison (`z5Garrison`, shared with the elite knight): each passage tower (`gatehouse` 2×1, `guardroom` 1×1) holds one garrison enemy, never two — always on the main path, 60 % on branches; the brute in the gatehouse 65 %, in the guardroom 35 % (x 1600 / 800 of the template). Never in an open room, a shaft, a dead end or the boss room; never with a drakeling or a gargoyle. Seeds 1–3: 3, 3 and 3 brutes. |
| FB1 | **Look:** §1–§3. |
| FB2 | **Approach:** 90 su/s; stops ≈ 190 su away; turns in 0.25 s; never leaves its room (90 su from its edges) nor walks off a ledge; no contact damage. |
| FB3 | **Rhythm:** sweep, sweep, smash (as zone 1); with the shield raised, the smash; **the coals** when Akeris is 380–800 su away (at most every 2.6 s; it walks toward him in between); a pause of **0.9 s** after each attack. |
| FB4 | **The sweep:** 0.5 s telegraph, 225 su at waist height: **any shield stops it** (iron, not fire; the ice shield spends a use); rolling dodges it. Just block: **sacred** → the counter (stagger 1.3 s; the counter's blows take 1 each); **ice** → frozen 1.5 s and **the cage doused 6 s** (no wave, no coals; `douse`); **fire** → only a block (it does not burn). |
| FB5 | **The smash and the fire wave:** unblockable (0.85 s telegraph), 2; it lands ≈ 260 su in front. When it lands, **a low tongue of fire** (≈ 70 su) runs along the floor **both ways from the brute, from 90 to 600 su at 900 su/s: 2** (once per wave). **Jumping or rolling saves Akeris** (once he has rolled through it, it is behind him); **the fire shield stops it** (one use; that side goes out there). Cut by gaps and walls; **no fire left on the floor** (DR7). The cage stuck 1.1 s + 0.35 s to pull it free: the opening. |
| FB6 | **The coals:** Akeris 380–800 su → 0.6 s telegraph (it swings the mace over its head; the cage flares) → **3 coals in an arc** onto him and ±120 su: **2** (one volley hurts once at most). Their arc never rises above 50 su under the tower vault. **Only the fire shield stops them** (one use each); **its just block returns one** in an arc to the brute's chest (−1; fire does not burn it). **Rolling dodges them.** They go out in sparks on the floor. |
| FB7 | **Enraged** from half health (7 of 14): the hood catches fire at the edges (drawing only), pause 0.6 s, the wave reaches 800 su. |
| FB8 | **Endurance:** 14 marks; every strike takes 1; it does not flinch; fire does not burn it; ice freezes it (the just block). **The chain blades** hurt it at range but cannot pull it; **its own reaction: a 0.4 s reel, at most once every 5 s and only in guard or walking — it never cuts an attack**. The fast descent beside it (≤ 180 su) takes 1 and stuns it 1.0 s. |
| FB9 | **Death:** the embers spill from the cage and go out, then ink smoke; it never comes back. Sounds: §7. |

## 9. Never

- An attack without its telegraph, seen and heard (sweep 0.5 s low and back; smash 0.85 s high and back; coals 0.6 s whirl).
- An attack the roll does not dodge: the sweep, the smash, the wave and the coals are all passed by a roll.
- Fire left on the floor; a wave that crosses a gap or a wall.
- The mace or a coal through the tower vault.
- Being held still by the chain (reaction at most once every 5 s; never during an attack).
- Leaving its room, entering the stone, coming back once defeated.
- A new colour; anything that trembles.

## 10. Acceptance

Tested in the sandbox (2026-10-12), with the deterministic scenes (`fbRunScene`, `#fb-<name>`):

1. `guardia`: from 950 su it walks to him; within 800 su it throws the coals.
2. `barrido`: 2; `barridoEscudo`: 0, blocked; `barridoJusto` (sacred): 0, the counter takes 2, stagger; `barridoHielo`: 0, frozen 1.5 s and doused 6 s (one ice use); `barridoFuego`: 0, only blocked; `barridoRueda`: 0.
3. `espalda`: rolled through the sweep, a strike lands on its back before it turns (it turns at 1.21 s, 0.25 s after the sweep ends).
4. `aplastar` with the shield raised: the smash 2 and the wave 2 (unblockable); `aplastarRueda`: rolled through the smash, 0 (and the wave behind him, 0).
5. `ola` at 470 su: 2; `olaSalto`: 0; `olaRueda`: 0; `olaEscudo` (fire): 0, one use spent. The wave ends at 600 su both ways (800 enraged).
6. `clavado`: jumping the wave behind it, a strike lands while the cage is stuck.
7. `brasas`: 2 (one volley, once); `brasasEscudo` (fire): 0, one use per coal blocked; `brasasDevuelta`: the just block returns a coal, the brute loses 1; `brasasRueda`: 0. Highest coal: 345 su over the floor (vault at 400).
8. `cadena`: two chain throws 0.9 s apart take 2; it reels once; a chain throw during the smash never cuts it.
9. `martillo`: 1, no flinch; `descenso`: 1 and stunned 1.0 s.
10. `enfurecido`: at 7 marks, the hood burns; the wave reaches 800 su.
11. `apagado`: after the ice just block, a smash without a wave.
12. `vencido`, `humo`: the embers spill and go out, ink smoke, gone at 1.7 s; it never comes back.
13. Highest point of any pose ≤ 351 su (≤ 370 su in any blend, capped); the tower vaults are at 400–420 su.
14. A random player (40 runs of 40 s per seed, seeds 1–3, in its towers, with sword, chain blades, hammer and spear and each
    shield): no errors; never inside the stone, never out of its room, never through the vault (highest point 370 su); never stuck
    in a state; **no damage while rolling** (0 in 120 runs; 102 attacks passed rolling); per seed ≈ 205 sweeps, ≈ 113 smashes,
    ≈ 103 waves (≈ 33 jumped, ≈ 14 rolled), ≈ 57 coal volleys, ≈ 18 chain reels (of ≈ 128 chain hits), ≈ 35 fast-descent stuns;
    35–39 of 40 defeated.
15. Against the sword (the same random player, 40 runs of 40 s, seed 1): the fire brute falls in 27.0 s on average (14 marks,
    1.93 s per mark) and deals 16.9 damage per minute; the zone 1 brute in 26.1 s (10 marks, 2.83 s per mark) and 5.2 per
    minute. As long to beat, about three times the damage: the wave and the coals punish whoever keeps away.

## 11. Exports

- [`sprites/sheet.png`](sprites/sheet.png): the 12 poses, and each alone (`sprites/<pose>.png`)
- [`sprites/sheet-sweep.png`](sprites/sheet-sweep.png), [`sheet-smash.png`](sprites/sheet-smash.png), [`sheet-whirl.png`](sprites/sheet-whirl.png), [`sheet-coals.png`](sprites/sheet-coals.png), [`sheet-death.png`](sprites/sheet-death.png)
- [`captures/`](captures/): every scene of §10 (26)
- The sandbox exports it all with `fbExportAll()` and the sounds with `fbExportSfx()` (20 WAV).

## 12. Chain balance (step 3.17, *approved* 2026-10-13)

HB1 flagged it (30 %). **HB2, the charge:** after two chain hits in a row from range (> 200 su, no 5 s pause), at most once every 5 s:
0.6 s warning (`chargeTel`: it crouches, the hood down, the cage dragged back low, pawing; `sfx.fireBrute.charge`, `¡BRUUM!`), then it
runs 680 su/s up to 520 su with the cage in front (`charge`): **2**, no shield stops it, **rolling dodges it**. Arriving within its sweep
reach: its sweep or smash (with their warnings); otherwise 0.9 s open. Its reel never cuts it. The acceptance scene `cadena` (§10.8, two
chain throws 0.9 s apart) now ends in the charge. Frames: `sprites/sheet-charge.png`. Measured after: 34 % (still under 60 %; see
`../../../akeris/weapons/hook-blades-balance.md`).
