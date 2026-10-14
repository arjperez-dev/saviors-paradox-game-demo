# Wraith — character contract

- **Status:** approved (step 3.13)
- **Kind:** enemy (zone 3, the Sunken Graveyard); the zone's ambusher: intangible until it attacks
- **Sandbox:** the zone 3 sandbox, [`../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`](../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html):
  *Ir a… combate* (the default enemy); `N` makes it attack · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 3: *Wraith (passes through walls; vulnerable only while attacking)*) ·
  `01-story/zones-narrative.md` (zone 3: the dungeon does not let its dead stay still; the mark of the three hollows) ·
  `04-zones/zone-3-sunken-graveyard/hazards.md` (Z34: the tombstones) · `00-game/controls.md` (G16: only a melee just block
  opens the counter) · `08-engineering/design-patterns.md` (the Wraith's passes through walls) · the operator's decisions of
  2026-10-02 (the proposal; it attacks from inside a wall with its arms, which are solid; the charge **stops in front of**
  Akeris, never passes through him; in both combat rooms)
- **Built on:** its own shape (no legs, no skeleton): a shroud, two long arms and a mask
- **Code name:** `wraith` · **Español:** espectro

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals WR1–WR12 (§12) approved by the operator as the sandbox does them.

## 1. Identity

One of the dead the dungeon will not let rest: a tall, torn shroud of ink with no legs and **no shadow**, two long arms of
shadow with long pale fingers, and for a face **a mask of bone whose eyes are the mark of the three hollows** — the mark of
every tombstone, worn as a face. It is dark and angular, the opposite of the spirits (cream, round, two eyes), so the two are
never confused. A player reads: my blade goes through it; wait until it turns solid, then hit; where its mask peeks out of a
stone, keep away.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 225 with the hood; floats 22 above the floor | Akeris = 192 |
| shroud | from the shoulders to rags that never touch the floor | no legs, no shadow |
| arms | ≈ 72–94 long, four fingers of ≈ 28 | out of its hiding place: up to ≈ 230 |
| mask | 34 × 46, three hollows in a row for eyes | the only thing seen in the dark |

**Silhouette test:** a hooded dark shape with a pale mask and no feet; never a spirit (pale, round, two eyes), never the
gravedigger (hat, coat, spade) and never the Skeleton (bones).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| shroud and hood | `rgba(30,26,23)`: translucent veiled (≈ .42), opaque solid (≈ .92); hidden, .16 | 2 | paper at .06 |
| arms | `ink` around `rgba(70,64,58)` | 5.6 / 2.6 | — |
| fingers | `ink` around `#b9b2a3` | 2.4 / 1 | — |
| mask | `#e4dccb`; the hollows and the scream `#120e0b`; a fine crack | 1.8 | `ink` at .12 |
| the charge's line | `ink`, dashed, .15 → .7, and a mark where it will stop | 1.2 → 2.4 | — |

No new colour.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| veiled (drift) | spawn, hide | — | yes | rush, charge, hide | `veiled` / `drift`: translucent, swaying as it drifts (150 su/s) through walls, floors and tombstones toward Akeris |
| hide | after an attack | 1.0–1.6 | — | drift, from hiding | only the **mask** shows: on the face of a wall, on a tombstone or peeking out of the floor (`sheet-hide.png`, `sheet-floor.png`) |
| rush | drift, Akeris within 300 su | ≤ 0.5 | no | claw | veiled, fast (640 su/s) to 115 su of Akeris |
| claw | rush | 0.45 + 0.07 + 0.6 | no | hide | `claw-wind` (solid: the telegraph, a cold breath) → `claw`: both hands rake → 0.6 s still solid (`sheet-claw.png`) |
| charge | drift, Akeris 300–820 su on its floor, no wall between | 0.5 + ≤ 1.0 + 0.5 | no | hide | `charge-wind`: it draws back 46 su and screams; a dashed line marks where it will stop → `dash` (solid, 920 su/s) → **stops 100 su in front of Akeris** and strikes (`strike`) (`sheet-charge.png`) |
| from hiding | hide, Akeris within 230 su of its face | 0.45 + 0.07 + 0.5 | no | hide | its **arms come out** of the wall, the tombstone or the floor toward Akeris; they are solid (`sheet-hide.png`) |
| hurt | a hit while solid | 0.22 | no | hide | thrown back; a hit on the arms out of hiding: it pulls them back in (`sheet-hide-hit.png`) |
| recoil | the shield stops the claw or the charge; it hits a wall while charging | 0.8 | no | hide | thrown back, still solid (the opening) (`sheet-block.png`, `sheet-charge-block.png`) |
| stun | a sacred just block, the chain, the fast descent | 1.5 | no | hide | `stun`, swaying; graphite stars |
| yank | the chain while solid | 0.35 | no | stun | pulled out of wherever it is, to 120 su of Akeris (`sheet-chain.png`) |
| death | its last health | 0.5, then the ink | no | — | the shroud collapses into a heap; the mask falls and **splits in three** along its hollows; the pieces are the last to fade (`sheet-shatter.png`, `sheet-death.png`) |

## 5. Weapons and gear

None: its arms. The mask is not an item.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| a blade through it | any hit while veiled | ink opens in six puffs and closes; a dashed ripple around it | 0.4–0.6 |
| turning solid | claw, charge, from hiding | it darkens from the edges; the mask sharpens | 0.15 |
| the charge's line | charge (telegraph) | a dashed line at chest height and a mark where it will stop | 0.5 |
| hit feedback, block sparks, counter, stars, ink smoke | as every enemy | `02-art-direction/fx/` | — |
| in the dark | always | the mask over the darkness; when it turns solid, its shape and arms too | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.wraith.whisper` | veiled, within 900 su, every 2.6 s: what you hear before you see it in the fog | `07-audio/sfx/sfx.md` |
| `sfx.wraith.breath` | the cold breath: it is about to turn solid (claw, from hiding) — the telegraph | `07-audio/sfx/sfx.md` |
| `sfx.wraith.solid` | it turns solid | `07-audio/sfx/sfx.md` |
| `sfx.wraith.whiff` | a weapon goes through it | `07-audio/sfx/sfx.md` |
| `sfx.wraith.scream` | the charge's telegraph | `07-audio/sfx/sfx.md` |
| `sfx.wraith.claw` | the claw and the arms from hiding | `07-audio/sfx/sfx.md` |
| `sfx.wraith.dash` | the charge runs and stops | `07-audio/sfx/sfx.md` |
| `sfx.wraith.stun` | stunned; pulled by the chain | `07-audio/sfx/sfx.md` |
| `sfx.wraith.shatter` | its last health: the shroud falls, the mask breaks in three | `07-audio/sfx/sfx.md` |
| shield sounds, hits, `sfx.fx.inkSmoke` | blocks, hits, death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 3; its windows are short) | proposal |
| claw, charge and from-hiding damage | the game decides (sandbox: the HUD's test hit) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 48 su (out of hiding: its arms) | the sandbox |
| where | both combat rooms, the yard and the ossuary (operator) | `layout.md` §B.3 |

**Behaviour:**

1. **Veiled, intangible (WR2).** It drifts toward Akeris through walls, floors and tombstones, never leaving its room. Every
   weapon and the chain **go through it** (the ink opens and closes, `sfx.wraith.whiff`): nothing hurts it.
2. **Solid only while it attacks (WR3)** — the telegraph, the blow and the moment after: then every weapon reaches it.
3. **The claw (WR4).** Within 300 su it rushes veiled to 115 su of Akeris, turns solid (**0.45 s**, the cold breath) and
   rakes; then it stays solid **0.6 s**. The shield stops it (it recoils, still solid, 0.8 s); a sacred just block stuns it
   1.5 s and opens the counter.
4. **The charge (WR5; operator: it stops in front).** From 300 to 820 su, on Akeris's floor and with no wall between, it draws
   back and screams (**0.5 s**; a dashed line marks where it will stop), runs solid at 920 su/s and **stops 100 su in front of
   Akeris** — wherever he is by then: if he walks into it or jumps over it, it stops at once — and strikes. **It never
   passes through him.** The shield stops it (recoil); a just block stuns it; a wall in its way stops it (recoil).
5. **Hiding (WR6; operator: from inside, with its arms).** After each attack it hides 1.0–1.6 s in **the solid thing nearest
   Akeris**: a wall of its room at his height or a whole tombstone (the combat rooms have passages on both sides, so in the
   yard it is usually a tombstone). With none at hand it hides **in the floor**. Only the mask shows. If Akeris comes within
   230 su of that face, **its arms come out** (0.45 s telegraph, the cold breath): they are solid, the shield stops them, a
   sacred just block stuns it and pulls it out, and a hit on the arms hurts it and it pulls them back in. Crouching behind a
   tombstone against the archer is not always safe.
6. **The chain (WR7).** Veiled, the chain goes through it. Solid — attacking, or its arms out — the chain hurts it and
   **pulls it out** of wherever it is, to 120 su of Akeris, **stunned 1.5 s**.
7. **The fast descent** beside it stuns it while it is solid.
8. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles; the strokes never change; the shroud sways and the arms move smoothly.
- Hurt while veiled; solid without attacking.
- An attack without its telegraph (the breath, the scream and the line).
- A charge that passes through Akeris.
- Leaving its room; a shadow; legs.
- Blood: it falls apart into ink; the mask breaks.
- It never comes back once defeated.

## 10. Acceptance

1. Veiled, a blade goes through it and it takes nothing (`sheet-veiled.png`); the chain too (`sheet-chain.png`, below).
2. The claw shows its 0.45 s solid telegraph, rakes and stays solid 0.6 s; it can be hit then (`sheet-claw.png`, `sheet-hit.png`).
3. The shield stops it and it recoils solid; a sacred just block stuns it (`sheet-block.png`).
4. The charge draws back and screams with its line, runs and stops in front of Akeris, never through him
   (`sheet-charge.png`); the shield stops it (`sheet-charge-block.png`).
5. Hidden, only the mask shows; when Akeris comes near, the arms come out of the tombstone, the wall or the floor; they can be
   blocked and hit (`sheet-hide.png`, `sheet-hide-hit.png`, `sheet-floor.png`).
6. Solid, the chain pulls it out stunned (`sheet-chain.png`).
7. At its last health the shroud collapses and the mask splits in three (`sheet-shatter.png`, `sheet-death.png`).
8. Checked with a random player: 60 fights of 60 s — never hurt while veiled, never out of its room, never stuck, the charge
   never crossed Akeris (`wrFuzz` in the sandbox).

## 11. Exports

From the zone 3 sandbox (`wrExportAll()`, the sounds with `wrExportSfx()`): `sprites/sheet.png`, eight single poses (`veiled`,
`drift`, `claw-wind`, `claw`, `charge-wind`, `dash`, `strike`, `stun`), `sprites/sheet-death.png` and eleven frame sheets
(`veiled`, `claw`, `block`, `hit`, `charge`, `charge-block`, `hide`, `hide-hit`, `floor`, `chain`, `shatter`), and eighteen
screenshots in `captures/` (with `oscuridad.png` and `oscuridadZarpazo.png`, in the zone's darkness and fog). 17 WAV in
`07-audio/sfx/enemies/wraith-*`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| WR1 | Look | a tall torn shroud of ink, no legs, no shadow; long shadow arms with pale fingers; a bone mask with the three hollows for eyes |
| WR2 | Veiled | intangible: through walls, floors and tombstones; weapons and the chain go through it (the ink opens and closes) |
| WR3 | Solid | only while it attacks (telegraph, blow and the moment after) |
| WR4 | The claw | within 300 su: rushes, 0.45 s solid telegraph, rakes, 0.6 s solid after |
| WR5 | The charge (operator) | 300–820 su: 0.5 s back and scream with a line; runs solid at 920 su/s; stops 100 su in front of Akeris, never through him |
| WR6 | Hiding (operator) | in the solid thing nearest Akeris (a wall, a tombstone; otherwise the floor); only the mask; its arms come out within 230 su and are solid |
| WR7 | The chain | through it while veiled; solid, it pulls it out, stunned 1.5 s |
| WR8 | Defence | the shield stops everything (recoil, still solid); the sacred just block stuns it 1.5 s and counters |
| WR9 | Where (operator) | both combat rooms |
| WR10 | Health | 3 |
| WR11 | In the dark | the mask always shows; its shape and arms when it turns solid |
| WR12 | Death and sound | the shroud collapses, the mask splits in three; whisper, breath, solid, whiff, scream, claw, dash, stun, shatter |
