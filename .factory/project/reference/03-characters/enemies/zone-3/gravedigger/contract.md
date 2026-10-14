# Gravedigger — character contract

- **Status:** approved (step 3.13)
- **Kind:** enemy (zone 3, the Sunken Graveyard); the zone's digger: it makes the open graves the zone is about and travels
  through them
- **Sandbox:** the zone 3 sandbox, [`../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`](../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html):
  *Ir a… combate* (the default enemy); `N` makes it attack · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 3: *Gravedigger (rises from graves)*), §Scope (fog, open graves, breakable
  tombstones as cover) · `01-story/zones-narrative.md` (zone 3: «the gravedigger digs them before they are needed»; the mark
  of the three hollows) · `04-zones/zone-3-sunken-graveyard/hazards.md` (Z33: the open grave; Z34–Z35: the tombstone stops any
  projectile) · `04-zones/zone-3-sunken-graveyard/layout.md` §B.3 (the yard and the ossuary combat rooms) ·
  `00-game/controls.md` (G16: only a melee just block opens the counter) · the operator's decisions of 2026-10-02 (the
  proposal, but faster: it digs a grave in 1 s; the chain snatches the spade; only in the yard; the rising blow cannot be
  blocked)
- **Built on:** Akeris's skeleton at 1.1×, dressed
- **Code name:** `gravedigger` · **Español:** sepulturero

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals GD1–GD14 (§12) approved by the operator as the sandbox does them.

## 1. Identity

The one who digs the graves of those who come down, before they are needed. A tall, stooped dead man in a long coat caked
with mud and a slouched wide-brimmed hat, his face grey and sunken, grey hair hanging behind; an iron spade with the mark of
the three hollows on its blade. The first time he sees Akeris he stops and **measures him** with the spade. A player reads:
he makes holes; where there is a hole he can come out; when the ground swells and a ring closes, get away.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 215 with the hat (Akeris's skeleton at 1.1×, stooped) | Akeris = 192 |
| coat | from the neck to below the knees, the hem ragged | it hides the legs to the shins |
| spade | ≈ 160: a T handle, a 104 shaft and a 42 iron blade | held in both hands; the back hand always on the shaft |
| his grave | 130 wide, 140 deep, a heap of earth beside it | the zone's narrow graves are 140–180 |

**Silhouette test:** a hat and a long coat with a spade; never the ghoul (clothed, upright, no claws while he has the spade)
and never the Skeleton boss (no bones showing, no sword).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| skin (face, hands) | `#aaa491`, a grey of the dead | 2.1 / 1.5 | `ink` at .16 |
| coat and sleeves | `#3b342c`; mud on the hem `rgba(74,63,51,.55)`; buttons `#1d1915` | 2.2 | `ink` at .32 |
| trousers and boots | `#2c2620` / `#1d1915` | 9 / 1.4 | — |
| hat | `#26211c`, a band `#4a3f33` | 2 | paper at .07 |
| hair | `#7d776a` | 1.4 | — |
| spade | shaft `WOOD` `#6e5f4d`, blade `IRON` `#5a554e`, the three hollows `#120e0b` | 6.4 / 2 | `ink` at .22 |
| his grave | the pit `#100d0b`, earth `#4a3f33`, clods `#5a4d3e` | 1.8 | `WOOD` at .18, `ink` at .3 |
| the warning ring | `ink`, dashed, from .4 to .95 alpha, and a cross | 2.2 / 1.8 | — |

No new colour: the earth is the zone's graves'.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| guard | spawn, any end | — | yes | measure, swing, shove, toss, dig, walk | `guard`: stooped, the spade in front with its blade by his feet, breathing slowly; walks 165 su/s |
| measure | the first time he sees Akeris | 0.6 | no | guard | `measure`: upright, the spade standing beside him, blade up; an iron note (`sheet-measure.png`) |
| swing | guard, Akeris within 230 su | 0.3 + 0.32 | no | guard | `swing-wind` → `swing`: the spade over the shoulder (the telegraph), then a sweep at chest height (`sheet-swing.png`) |
| shove | guard, close, every third melee or a grave behind Akeris | 0.26 + 0.34 | no | guard | `shoveW` → `shove`: the spade pulled to the hip, then thrust flat ahead (`sheet-shove.png`) |
| toss | guard, Akeris 400 su or farther | 0.35 + 0.35 | no | guard | `toss-wind` → `toss`: bent low, he scoops earth and flings it (`sheet-toss.png`) |
| dig | guard (to go under) | **1.0** | no | drop | `dig-1` ↔ `dig-2`: the blade into the earth, the earth over the shoulder, twice; clods fly; the grave opens in front of him (`sheet-dig.png`) |
| drop | dig, or a hole within 280 su | 0.3 | no | under | he steps into the grave and sinks |
| under | drop | ≤ 1.4 | no | rise warning | not drawn: **a ridge of loose earth** moves along the floor toward Akeris at 780 su/s, leaving clods behind (`sheet-rise.png`) |
| rise warning (the telegraph) | under | **0.6** | no | rise | the earth swells, clods jump, **a dashed ring closes** where he will come out (`sheet-rise.png`) |
| rise | the warning | 0.22 | no | half | `rise`: he bursts up with the spade straight overhead; earth flies (`sheet-rise.png`) |
| half-buried (the opening) | rise | 0.8 | no | climb, yanked | `half`: up to the waist in his grave, elbows on the edge (`sheet-dodge.png`) |
| climb | half-buried | 0.35 | no | guard | a hop out of the grave to its edge, on Akeris's side |
| hurt | a hit | 0.25 | no | guard | `hurt`; **a hit while he digs stops the dig** and the half-dug grave closes (`sheet-interrupt.png`) |
| stagger / stun | the sacred counter / the fast descent | 1.2 / 1.2 | no | guard | `hurt`, swaying; graphite stars |
| yanked, down | the chain while half-buried | 0.35 + 1.4 | no | guard | pulled out in an arc, he lands **on his back** next to Akeris, stunned (`down`, `sheet-chain.png`) |
| bare | the chain snatched the spade | — | — | — | `bare`: no spade; he fights with **claws** (the ghoul's), walks 200 su/s (`sheet-snatch.png`) |
| death | his last health | 0.5 to fall, then the ink smoke | no | — | he **falls on his back**; **the spade stays planted upright like a cross**, the last thing to fade; his graves fill by themselves (`sheet-death.png`) |

## 5. Weapons and gear

The iron spade (`weapons/spade-sheet.png`): he walks, measures, swings, shoves, scoops and digs with it. **The chain snatches
it** (operator, 2026-10-02): it flies toward Akeris, falls and fades in 2.6 s; it is not an item. Without it he cannot dig or
go under.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| his grave | dig, or the rise where no grave was | a black pit in the floor's section with earth walls, roots and clods, the heap of dug earth beside it; opens over the dig, appears whole when he bursts out | — |
| a grave that fills | his death, a third grave, a cut dig | the pit and the heap shrink | 0.5 |
| the clods | each spadeful, the rise | the zone's debris in earth colour, falling with gravity | 0.8–1 |
| the toss | the toss | five clods in a fan toward the chest (820 su/s, gravity), each with two fading copies; burst into crumbs when they hit | ≤ 1.3 |
| the ridge | under | a hump of earth with cracks and a trail of clods that fades in 0.9 s | — |
| the warning | rise warning | the hump swells, clods hop, a dashed ring (≈ 135 su across the blow's reach) closes with a cross in the middle | 0.6 |
| the spade snatched | the chain | it flies, lands flat and fades | 2.6 |
| hit feedback, block sparks, counter, ink smoke, the grave's hands | as every enemy and as the zone's graves | `02-art-direction/fx/`, `hazards.md` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.gravedigger.step` | each step: a heavy boot in the earth, the coat | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.measure` | he measures Akeris: the spade raised, one hollow iron note, a low grunt | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.dig` | each spadeful | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.burrow` | he goes into a grave; the chain pulls him out | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.rumble` | under the ground, and again at the warning (heard in the fog) | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.rise` | he bursts out | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.swing` | the swing | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.shove` | the shove | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.throw` | the toss | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.dirtHit` | the earth hits Akeris, a shield, a tombstone or the floor; the snatched spade lands | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.snatch` | the chain takes the spade | `07-audio/sfx/sfx.md` |
| `sfx.gravedigger.collapse` | he falls; the spade is driven into the earth | `07-audio/sfx/sfx.md` |
| `sfx.zone3.graveGrab`, `sfx.zone3.stoneCrack`, shield sounds, `sfx.blindGhoul.claw`, hits, `sfx.fx.inkSmoke` | falling into his grave, earth on a tombstone, blocks, the bare claws, hits, death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 6) | proposal |
| swing, shove, claw, toss and rise damage; falling into his grave | the game decides (sandbox: the HUD's test hit; the grave as the zone's) | `hazards.md` Z33 |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 56 su | the sandbox |
| where he stands | **only the yard's combat rooms** (`yard`): the catacombs are stone (operator, 2026-10-02) | `layout.md` §B.3 |

**Behaviour:**

1. **He measures (GD2).** The first time he sees Akeris (within 1200 su) he stops 0.6 s and measures him with the spade. Only
   once.
2. **Close (GD4).** Within 230 su: **the swing** (0.3 s telegraph), and every third melee — or at once if an open grave is
   behind Akeris — **the shove**, which throws Akeris back (620 su/s, ≈ 120 su), **toward his graves**. Both are melee hits: the shield
   stops them and a sacred just block opens the counter (G16). 0.7 s between attacks.
3. **Middle (GD5).** Between 230 and 400 su he walks toward Akeris (165 su/s).
4. **Far: the toss (GD6).** From 400 su, every other choice: he scoops earth (0.35 s) and flings **five clods in a fan** at the
   chest. The shield stops them (no just block sends earth back: it crumbles); **a tombstone** stops them and cracks once per
   toss; rolling goes through. One hit per toss.
5. **Far: under the ground (GD7–GD9).** Every other choice he goes under:
   - through **an open grave within 280 su** (his own or the room's), or he **digs one in 1 s** in front of him (behind him if
     there is no room; he walks up to 500 su to a place he can dig: flat, clear of tombstones, walls and other graves). **He is
     open while he digs**; a hit stops it and the half-dug grave closes.
   - under the ground he **cannot be hurt**; a **ridge of earth** moves toward Akeris (780 su/s), for at most 1.4 s.
   - he comes out of **the open grave nearest to Akeris** (within 220 su), or **opens a new one** at Akeris's feet (or the
     nearest place he can dig). **The warning lasts 0.6 s**: the earth swells and a ring closes.
   - **the blow from below cannot be blocked** (operator): within ≈ 135 su of the grave it hits and throws Akeris away. Rolling
     or stepping out of the ring avoids it.
   - then he stays **half-buried 0.8 s** (the opening: every weapon reaches him) and hops out to the edge.
6. **His graves (GD10).** A grave he digs **is the zone's open grave** (`hazards.md` Z33): stepping on its mouth, the hands
   pull Akeris under and he is back on his last firm ground, hurt. **Two at most**: a third fills the oldest. **When he dies,
   they fill by themselves.** The grave he bursts out of is not a trap while he is in it; the blow throws Akeris clear of
   it before he climbs out. **Akeris's last firm ground is never on one of his graves** (operator, 2026-10-02): when he digs
   or bursts out where Akeris last stood still, that point moves to the nearest flat floor **at least 120 su from the edge of any of
   his graves** (preferably away from him; if there is none, the zone's start), so a fall never puts Akeris back on a grave to
   fall again. And if, coming back from a fall, Akeris were still over one of his graves, he is moved off it, never pulled
   under again. Checked with a random player fighting him: 100 fights of 60 s, 1009 returns, none on a grave and no new fall
   without moving.
7. **The chain (GD11).** Standing, the chain **snatches the spade** (operator): no damage, it flies away and fades; without it
   he never digs or goes under and fights with **claws** (a melee hit, 0.24 s telegraph, reach 160 su), walking faster.
   Half-buried, the chain hurts him and **pulls him out**: he lands on his back next to Akeris, **stunned 1.4 s**. Under the
   ground the chain cannot reach him.
8. **The fast descent** beside him stuns him 1.2 s, as every enemy.
9. **Defeated, he stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles; the strokes never change; the ridge, the clods and the spade move smoothly.
- A rise without its 0.6 s warning, or a blow from below that the shield stops.
- A hurt while he is under the ground.
- More than two of his graves at once; a grave of his that stays after he dies; digging in stone (the catacombs).
- A grave that opens under Akeris without the warning.
- Coming back from a fall onto one of his graves (and falling again).
- Blood: he dissolves into ink; the spade is the last to go.
- He never comes back once defeated.

## 10. Acceptance

1. The first time he sees Akeris he stops and measures him (`sheet-measure.png`), once.
2. The swing and the shove show their telegraph; the shield stops them and a sacred just block counters (`sheet-swing.png`,
   `sheet-block.png`); the shove throws Akeris into a grave behind him, and the hands pull him under (`sheet-shove.png`).
3. The toss flies in a fan at the chest; the shield stops it; crouched behind a tombstone Akeris takes nothing and the stone
   cracks (`sheet-toss.png`, `sheet-toss-cover.png`).
4. He digs a grave in 1 s and goes into it (`sheet-dig.png`); a hit while he digs stops it and the grave closes
   (`sheet-interrupt.png`).
5. Under the ground he cannot be hit; the ridge goes toward Akeris; the warning (0.6 s) shows where he will come out; the blow
   hits through the shield (`sheet-rise.png`, `sheet-unblockable.png`); rolling out of the ring avoids it (`sheet-dodge.png`).
6. Half-buried, every weapon reaches him; the chain pulls him out on his back, stunned (`sheet-chain.png`).
7. Standing, the chain snatches the spade; then he only claws (`sheet-snatch.png`).
8. Walking onto the mouth of his grave, the hands pull Akeris under and he is back on firm ground, hurt (`sheet-grave.png`);
   if that firm ground was where a grave opened afterwards, he comes back beside it and does not fall again
   (`captures/reaparece.png`).
9. At his last health he falls on his back, the spade stays planted upright and fades last, his graves fill
   (`sheet-death.png`); he never comes back.

## 11. Exports

From the zone 3 sandbox (`gdExportAll()`, the sounds with `gdExportSfx()`): `sprites/sheet.png`, thirteen single poses
(`guard`, `measure`, `swing-wind`, `swing`, `shove`, `toss-wind`, `toss`, `dig-1`, `dig-2`, `rise`, `hurt`, `bare`, `down`),
fifteen frame sheets (`measure`, `swing`, `block`, `shove`, `toss`, `toss-cover`, `dig`, `rise`, `unblockable`, `dodge`,
`chain`, `snatch`, `grave`, `interrupt`, `death`), `weapons/spade-sheet.png` and twenty-five screenshots in `captures/` (with
`oscuridad.png`, the warning in the zone's darkness and fog). 22 WAV in `07-audio/sfx/enemies/gravedigger-*`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| GD1 | Look | a tall, stooped dead man: long muddy coat, slouched wide-brimmed hat, grey sunken face, an iron spade with the mark of the three hollows |
| GD2 | He measures | the first time he sees Akeris: 0.6 s, the spade standing beside him |
| GD3 | Pace (operator: faster) | walks 165 su/s (200 without the spade); 0.7 s between attacks |
| GD4 | Close | swing (0.3 s) and shove (0.26 s, throws Akeris ≈ 120 su back, toward his graves); blocked by the shield, countered by a sacred just block |
| GD5 | Middle | walks toward Akeris between 230 and 400 su |
| GD6 | The toss | from 400 su: five clods in a fan at the chest; shield and tombstone stop it; never sent back |
| GD7 | Digging (operator: 1 s) | a grave 130 wide in 1 s, in front of him; open while he digs; a hit stops it |
| GD8 | Under the ground | through a grave within 280 su or one he digs; a ridge of earth at 780 su/s, ≤ 1.4 s; cannot be hurt |
| GD9 | The rise | out of the open grave nearest Akeris (220 su) or a new one at his feet; 0.6 s warning (swelling, a closing ring); the blow (≈ 135 su) **cannot be blocked** (operator); half-buried 0.8 s |
| GD10 | His graves | the zone's open graves (Z33); two at most; they fill when he dies; Akeris's last firm ground never stays on one (operator) |
| GD11 | The chain (operator) | standing, it snatches the spade (then claws); half-buried, it pulls him out, stunned 1.4 s on his back; under the ground it cannot reach him |
| GD12 | Where (operator) | only the yard's combat rooms |
| GD13 | Health | 6 |
| GD14 | Death and sound | falls on his back, the spade planted upright like a cross, the last to fade; step, measure, dig, burrow, rumble, rise, swing, shove, throw, dirt, snatch, collapse |
