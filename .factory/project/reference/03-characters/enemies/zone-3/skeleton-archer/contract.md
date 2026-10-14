# Skeleton Archer — character contract

- **Status:** approved (step 3.13)
- **Kind:** enemy (zone 3, the Sunken Graveyard); the zone's ranged enemy, the one the tombstones are for
- **Sandbox:** the zone 3 sandbox, [`../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`](../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html):
  *Ir a… combate* (the default enemy); `N` makes it attack · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 3: *Skeleton Archer*), §Scope (fog, open graves, breakable tombstones as
  cover) · `04-zones/zone-3-sunken-graveyard/hazards.md` (Z33–Z35: the tombstone stops any projectile; crouched it covers
  Akeris whole, standing only up to the chest) · `00-game/controls.md` (G7, G16: a just block sends a projectile back; only a
  melee just block opens the counter) · `01-story/zones-narrative.md` (the mark of the three hollows) · the operator's
  decisions of 2026-10-02 (the proposal as it stands; the shield does not stop the volley; the chain does **not** snatch the
  bow)
- **Built on:** Akeris's skeleton at 1×, drawn as bones
- **Code name:** `skeletonArcher` (in the sandbox, `archer`) · **Español:** arquero esqueleto

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals SA1–SA12 (§12) wait for the operator.

## 1. Identity

One of those who came down for the clock and stayed in the graveyard: a skeleton in a torn hood and a ragged cape, a bow of
bone with a string of ink, a quiver of black arrows on its back and, on its brow, the mark of the three hollows that every
tombstone bears. It keeps its distance, likes high ground and steps back when Akeris comes near. A player reads: it shoots
at me from afar; get behind a stone or raise the shield; when it aims at the sky, move.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 190 (Akeris's skeleton at 1×, a little stooped) | Akeris = 192 |
| bow | ≈ 116 tip to tip, held in the front hand | bone limbs, a bound grip |
| arrow | ≈ 64 shaft, an iron head, two dark feathers | the same arrow flies, sticks and falls |
| shot height | leaves the bow ≈ 154 above its floor; aims at the top of Akeris's chest (26 below the top of his head) | standing, it passes over a tombstone (150); crouched behind one, it hits the stone |

**Silhouette test:** a thin figure of bones under a dark hood, a bow in front; never the Skeleton boss (no sword, smaller,
always a bow) and never a wraith (it has legs and a shadow).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| bones | `#ddd6c6` (the zone's skulls) inside an `ink` line | 2.4–3 + 1.8 | — |
| skull | `#ddd6c6`; black sockets `#120e0b`; teeth in `ink`; three tiny hollows on the brow | 2 / 0.9 | `ink` at .14 |
| hood and cape | `#3f3a33` (the many-armed's shroud) | 1.8 | `ink` at .4 |
| quiver | `WOOD` `#6e5f4d`; fletchings `#2a2622` | 1.8 / 0.9 | `ink` at .4 |
| bow | `#ddd6c6` limbs inside a 6.2 `ink` line; the string `ink` 1.1 | — | — |
| arrow | `ink` shaft 1.8, `IRON` head, `#2a2622` feathers | — | — |
| the aim line | `ink`, dashed, from .12 to .57 alpha as it draws | 1 → 2.2 | — |
| the volley's mark | `ink`, a dashed ring that closes, a soft shadow and a cross | 2.6 / 2.4 | — |

No new colour.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| guard | spawn, any end | — | yes | aim, volley, bash, hop | `guard`: the arrow nocked, swaying slightly; it faces Akeris and walks (110 su/s) to its spot |
| aim (the telegraph) | guard | 0.7 | no | loose | `draw` → `aim`: the bow arm straight, the string pulled back to the chest; the wood creaks; a fine dashed line toward Akeris that darkens; it follows him and locks 0.15 s before it lets go (`sheet-shot.png`) |
| loose | aim, volley | 0.35 | no | guard | `loose`: the string snaps back, the hand flies open |
| volley (the telegraph) | guard | 0.8 | no | loose | `volley`: the bow raised to the sky (−62°), the string drawn (`sheet-volley.png`) |
| bash | guard, Akeris within 170 su and no room to hop | 0.3 + 0.4 | no | guard | `bash`: the bow raised and swung down like a club (`sheet-bash.png`) |
| hop | guard (too close, or climbing to its spot); the chain | 0.5 (pulled: 0.35) | no | guard, stun | `hop`: knees tucked, a parabola to the chosen floor (`sheet-hop.png`) |
| hurt | a hit | 0.3 | no | guard | `hurt`: thrown back; **a hit while it draws cancels the shot** (`sheet-interrupt.png`) |
| stagger / stun | the sacred counter / its arrow sent back, the chain, the fast descent | 1.3 / 1.2 | no | guard | `hurt`, swaying; graphite stars |
| death | its last health | ≈ 0.45 to fall, then the ink smoke | no | — | it **falls apart**: each bone drops where it stood into a heap, the skull rolls, the bow falls; then the ink (`sheet-death.png`) |

## 5. Weapons and gear

The bone bow and its black arrows (`weapons/bow-sheet.png`). Not items: **the chain never snatches the bow** (operator,
2026-10-02), and it never drops it until it dies.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| the shot | loose | a black arrow along the locked line at 900 su/s, two fading copies behind it, up to 1300 su | — |
| the arrow sent back | a just block | flies back along the same line at 1300 su/s, with speed lines | — |
| the volley | loose (from the sky) | three arrows fly up out of sight; three dashed rings appear on the floor around Akeris (±110 su) and close until each arrow drops almost straight down (0.85, 0.93, 1.01 s after it lets go) | ≈ 1 |
| a stuck arrow | it hits the ground or a wall | stays stuck, then fades | 1.6 |
| a stopped arrow | the shield, a tombstone, a hit | bounces and falls, spinning, and fades | 0.8 |
| hit feedback, block sparks, reflect ring, counter, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.skeletonArcher.step` | each step: bones that rattle | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.draw` | the aim and the volley: the bone creaks and the string tightens (the telegraph you hear in the fog) | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.release` | it lets go | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.arrow` | the shot whistles | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.arrowHit` | an arrow sticks, hits stone or its thrower | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.volley` | the volley: three strings and three rising whistles | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.rain` | each volley arrow starts to fall | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.bash` | the bow swing | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.hop` | a hop; the chain pulls it | `07-audio/sfx/sfx.md` |
| `sfx.skeletonArcher.collapse` | it falls apart: bones cascading, the skull rolling | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.fx.reflect`, `sfx.zone3.stoneCrack` / `.stoneBreak`, hits, `sfx.fx.inkSmoke` | blocks, a just block, an arrow on a tombstone, hits, death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 4) | proposal |
| shot, volley and bash damage | the game decides (sandbox: the HUD's test hit) | — |
| its arrow sent back | the game decides (sandbox: 2) and a stun of 1.2 s; with the ice / fire shield it freezes / burns it 0.5 s instead | G7, G16 |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 50 su | the sandbox |

**Behaviour:**

1. **Its spot (SA2).** Every 0.6 s it looks for where to stand in its room: about **680 su** from Akeris (never closer
   than 450), on its own side of him, **as high as it can** (a raised floor counts for a lot), without wandering too far
   from home (900 su). It walks there (110 su/s) and **hops** up a step (≤ 220 su), down a drop (≤ 420 su) or over an open
   grave (it never lands in one).
2. **Too close (SA3).** Within 250 su it **hops back** about 260 su (it waits 1.8 s before hopping again). If there is no
   floor behind it (a wall, a grave), it uses **the bash** within 170 su: a swing of the bow (0.3 s telegraph). It is a melee
   hit: the shield stops it and a sacred just block opens the counter (G16).
3. **The shot (SA4).** It draws for **0.7 s** (the creak and the fine dashed line), follows Akeris and locks 0.15 s before it
   lets go; the arrow flies straight at 900 su/s at **the top of his chest**. Answers:
   - **the shield** stops it (the ice shield spends a use);
   - **a just block** sends it back along the same line, and it hurts and stuns the archer;
   - **a tombstone** stops it: standing next to one does not help (the arrow passes over it), but **crouched behind it**
     Akeris is covered and the arrow cracks the stone (`hazards.md`);
   - **rolling** goes through it; **jumping** or stepping out of the line dodges it.
4. **The volley (SA5).** It aims at the sky for **0.8 s** and lets three arrows fly up. On the floor around Akeris three
   **marks** appear (where he stands and ±110 su) and close until the arrows fall almost straight down on them, one after
   another. **Neither the shield nor a tombstone stops what falls from above** (operator, 2026-10-02): Akeris has to move
   (or roll through). An arrow that lands on a tombstone still cracks it.
5. **Which one (SA6).** It uses the volley when Akeris is **covered** (crouched behind a tombstone in the line, or the
   shield raised), when it has **no line** (a wall or a raised floor in between) and every third attack; otherwise the shot.
   0.35 s after letting go, it waits 1.1 s before the next attack.
6. **Interrupted (SA7).** Any hit while it draws **cancels the shot** (it is thrown back 0.3 s and waits at least 0.5 s).
7. **The chain (SA8).** The chain hurts it like any weapon and **pulls it off its spot**: it flies to the floor next to
   Akeris (≈ 130 su from him) and lies **stunned 1.2 s**. It **never snatches the bow** (operator, 2026-10-02).
8. **The fast descent** beside it stuns it 1.2 s, as every enemy.
9. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles; the strokes never change; the arrows, the marks and the bones move smoothly.
- A shot without its 0.7 s draw, or a volley without its marks on the floor.
- A shield that stops the volley; an arrow that goes through a tombstone.
- The chain taking its bow.
- Blood: it falls apart into bones, then ink.
- It never comes back once defeated.

## 10. Acceptance

1. In guard it keeps ≈ 680 su from Akeris and prefers a raised floor; within 250 su it hops back (`sheet-hop.png`).
2. The shot plays as `sheet-shot.png`: 0.7 s of draw with the creak and the dashed line, the arrow at the top of the chest.
3. The shield stops the arrow (`sheet-block.png`); a just block sends it back and the archer is hurt and stunned
   (`sheet-reflect.png`); rolling goes through.
4. Crouched behind a tombstone, the arrow cracks the stone and Akeris takes nothing (`sheet-tomb.png`); standing beside
   it, the arrow passes over the stone.
5. The volley shows its three marks before the arrows fall (`sheet-volley.png`); standing still hurts, moving out of the
   marks does not (`sheet-dodge.png`); neither the shield nor a tombstone helps against it.
6. With Akeris covered, it chooses the volley (`captures/cobertura.png`).
7. A hit while it draws cancels the shot (`sheet-interrupt.png`); the chain pulls it down stunned (`sheet-chain.png`); the
   bash is stopped by the shield and countered by a just block (`sheet-bash.png`).
8. At its last health it falls apart into a heap of bones and dissolves (`sheet-death.png`), and never comes back.

## 11. Exports

From the zone 3 sandbox (`arExportAll()`, the sounds with `arExportSfx()`): `sprites/sheet.png`, eight single poses
(`guard`, `draw`, `aim`, `loose`, `volley`, `bash`, `hop`, `hurt`), eleven frame sheets (`shot`, `block`, `reflect`, `tomb`,
`volley`, `dodge`, `hop`, `bash`, `chain`, `interrupt`, `death`), `weapons/bow-sheet.png` and nineteen screenshots in
`captures/` (with `oscuridad.png`, in the zone's darkness and fog). 20 WAV in `07-audio/sfx/enemies/skeletonArcher-*`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| SA1 | Look | a skeleton in a torn hood and cape, a bone bow with an ink string, a quiver of black arrows, the mark of the three hollows on its brow |
| SA2 | Its spot | ≈ 680 su from Akeris, on its side, as high as it can, within 900 su of home; walks 110 su/s, hops steps, drops and graves |
| SA3 | Too close | hops back ≈ 260 su within 250 su (every 1.8 s at most); cornered, the bash (melee, counterable) |
| SA4 | The shot | 0.7 s of draw with the creak and a dashed line, locks 0.15 s before; 900 su/s at the top of the chest; shield, just block (sent back: 2 and a 1.2 s stun), tombstone (crouched), roll, jump |
| SA5 | The volley | 0.8 s at the sky; three marks (±110 su) that close; the arrows fall 0.85–1.01 s after it lets go; neither shield nor tombstone stops them (operator) |
| SA6 | Which one | the volley when Akeris is covered or out of line, and every third attack; otherwise the shot; 1.1 s between attacks |
| SA7 | Interrupted | any hit while drawing cancels the shot |
| SA8 | The chain | hurts it and pulls it next to Akeris, stunned 1.2 s; never snatches the bow (operator) |
| SA9 | Shot height | from ≈ 154 su to the top of his chest: over a tombstone if Akeris stands, into it if he crouches behind it (Z35) |
| SA10 | Health | 4 |
| SA11 | Death | it falls apart into a heap of bones, the skull rolls, then the ink smoke |
| SA12 | Sound | step (bones), the creak of the draw, release, the whistle, the hit, the volley, the falling arrows, the bash, the hop, the collapse; with the catacombs' stone in the crypts |
