# Strangler Vine — character contract

- **Status:** approved 2026-10-05 (SV1–SV12 as the sandbox does them, everywhere)
- **Kind:** enemy (zone 4, the Rotting Canopy); rooted, it never moves
- **Sandbox:** the zone 4 sandbox, [`../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`](../../../../04-zones/zone-4-rotting-canopy/sandbox/sandbox.html):
  the vines live in every room of the zone but the start, the antechamber, the boss room and the way down, whatever the
  room's enemy (*Ir a… hueco*, *nido*, *combate*, *charcos*, *tronco*) · **Pose
  sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 4: *Strangler Vine (traps Akeris; freed with the chain)*) ·
  `04-zones/zone-4-rotting-canopy/biome.md`, `hazards.md` (the grab vines it must never be mistaken for; the torches) ·
  `00-game/controls.md` §3 (the chain blades: slot 2; a click throws), G16 (what each shield does on a just block against a
  melee hit) · the operator's decisions of 2026-10-05 (the proposal and the four recommendations: only on the floor; caught, it
  squeezes; one chain throw frees him; caught, the sword cannot cut it) and, after seeing it, «por todos lados, como las
  arañitas»: in every room, as the spiderlings' nests
- **Built on:** its own shape (no skeleton)
- **Code name:** `stranglerVine` · **Español:** enredadera estranguladora

Every gameplay number is the sandbox's and is marked **the game decides**.

## 1. Identity

A thick stem of living root, thorned, coiled on the floor like a heap of roots, with a closed bud at its tip that bears the
mark of the three hollows inside. Step into its reach and it uncoils, raises its tip, opens the bud and lashes at the waist;
if the lash lands, it wraps Akeris and squeezes. Only the chain cuts him free. A player reads: a coiled root with thorns is
not scenery; the open bud is the warning; caught, switch to the chain.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| coiled | ≈ 60 wide, 30 high | a spiral of thorned stem beside its root |
| raised | ≈ 150 high | leaning back before the lash |
| reach | 180, at Akeris's waist (92 above the floor) | the lash |
| stem | 9 thick, thorns every ≈ 15 | — |
| bud | three petals ≈ 22 long | open: a pale heart with the three hollows |

**Silhouette test:** a thorned stem rising from the floor with a bud at its tip. Never a grab vine (those hang smooth from the
ceiling, no thorns, no bud), never a root of the floor (those lie flat and never coil), never an animal.

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| stem | rotten wood `#857a66` with an ink outline and a pale sheen | 9 (+3 ink) | — |
| thorns | ink | — | — |
| bud | pale fungus `#c9bea7`; its heart bone `#ddd6c6` with three ink hollows | 1.4 | — |
| burnt | `#1f1b18` | 9 | — |
| frozen | the ice shield's blue over the stem at 50 % | — | — |

No new colour: the zone's rotten wood, pale fungus and bone (`biome.md` §A.3), light enough to read on the canopy and on the
dark wood of the hollow root. In the dark only the open bud's heart shows.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| coiled | spawn, recoil, knot, stun | — | yes | rise | a spiral beside its root, breathing a little (`coiled`) |
| rise (the telegraph) | coiled, Akeris within 180 su | 0.8 | no | lash | it uncoils and rises leaning back, the bud opens (`rise`, `sheet-lash.png`) |
| lash | rise | 0.18 (+ 0.12) | no | hold, recoil | it whips out at waist height to its reach (`lash`) |
| hold | the lash lands | up to 3 | no | knot | three coils around Akeris's waist, thorns over him (`hold`, `sheet-trap.png`) |
| recoil | blocked, missed, hit | 0.9 | no | coiled | leaning back, open (`recoil`, `sheet-block.png`) |
| knot | cut by the chain, or it lets go | 1.2 | no | coiled | drooping in a knot, stars (`knot`) |
| stun | the sacred just block | 1.5 | no | coiled | as recoil, stars |
| death | its last health | 1.0 | no | — | it dries and shrinks, fading (`dead`, `sheet-death.png`); burnt: black, a flame |

## 5. Weapons and gear

None: its lash and its coils.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| the coils | hold | three thorned loops around Akeris, the front half drawn over him | the hold |
| squeeze | each second caught | sparks on Akeris, «¡PUM!» | — |
| cut | the chain frees him | «¡CRAC!» at the stem | — |
| stars | knot, stun | graphite stars over the tip | the state's |
| block sparks, callouts | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.stranglerVine.rise` | it uncoils (the telegraph) | `07-audio/sfx/sfx.md` |
| `sfx.stranglerVine.lash` | the lash | `07-audio/sfx/sfx.md` |
| `sfx.stranglerVine.grab` | it catches Akeris | `07-audio/sfx/sfx.md` |
| `sfx.stranglerVine.squeeze` | each squeeze | `07-audio/sfx/sfx.md` |
| `sfx.stranglerVine.cut` | the chain cuts it | `07-audio/sfx/sfx.md` |
| `sfx.stranglerVine.hurt` | it is hit | `07-audio/sfx/sfx.md` |
| `sfx.stranglerVine.die` | its last health (not by fire) | `07-audio/sfx/sfx.md` |
| `sfx.spiderlings.burn`, shield sounds | burnt; blocks | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | 3 | proposal |
| where | on the floor of every room but the start, the antechamber, the boss room and the way down (operator: «por todos lados»), away from doors, pools and spore pods: `hollow` (two), `webs` (one, at the web's edge), `rootEnd`, `webEnd`, `pools` (on the island between the pools), `boughs` (on a sound root), `clearing`, `nest` (under the sacs), `poolEnd` (by the altar), and at the bottom of the `trunk` and the `cascade`; about 39 in a zone of seed 1; many within a torch's fall | operator: only on the floor; everywhere |
| squeeze | 1 a second while caught, the first 1 s after the catch | operator |
| XP and coins | the game decides | `VISION.md` §Assumptions |

**Behaviour:**

1. **Rooted (SV1).** It never moves. It acts only while Akeris is in its room, on its floor (within 120 su of its height).
2. **The lash (SV2).** When Akeris comes within **180 su**, it turns to him, uncoils and rises leaning back, its bud opening,
   for **0.8 s** (the telegraph; it does not turn again) and lashes at his waist out to 180 su.
3. **Dodging (SV3).** **Rolling** passes through the lash; **jumping** passes over it (his feet more than 70 su up). The lash
   that misses leaves it in recoil (0.9 s, open).
4. **Caught (SV4, operator).** A lash that lands **wraps him**: he cannot move, jump, roll, block or use the sword, and loses
   **1 health every second**. Hanging from a grab vine, it cannot reach him.
5. **Freed with the chain (SV5, operator).** **One chain throw** that touches the vine cuts it: he is free and it loses 1.
   With the sword in hand, he switches to the chain blades (2) and throws; **the sword cannot cut it** (operator). If he does
   nothing, it lets go after **3 s** and lies in a knot (1.2 s).
6. **The shield (SV6).** A block stops the lash (a melee hit) and it recoils, open. The just block follows G16: with the
   **sacred** shield it opens the counter (stunned 1.5 s, −1); with the **ice** shield it freezes 1.5 s; with the **fire**
   shield it burns — and fire kills a plant.
7. **Hits (SV7).** It takes **3 hits**, on the raised stem (rising, lashing, in recoil, in a knot, stunned); **coiled, a hit
   glances off** («¡CLAC!»). The chain thrown at it, free, takes 1; the dive on it takes 1.
8. **Fire (SV8).** **A fallen torch** whose flame reaches it (within 60 su), a burning web under it, or the fire shield's just
   block, burn it at once.
9. **In the dark (SV9).** Only the heart of its open bud shows (rising, lashing).
10. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy). A vine is not a room enemy: it lives
    beside whatever enemy the room has.

## 9. Never

- Nothing trembles: it uncoils and whips smoothly; strokes never change.
- It never moves, never hangs from a ceiling (operator), never looks like a grab vine.
- A lash never comes without its full 0.8 s rise, and never turns during it.
- It never catches him while he rolls or jumps over it, nor holds him more than 3 s.
- Caught, he never moves; the sword never hurts it while it holds him.

## 10. Acceptance

1. Coiled it waits (`captures/enroscada.png`); close, it rises and lashes (`sheet-lash.png`).
2. Caught, he cannot move and loses 1 a second; at 3 s it lets go in a knot (`sheet-trap.png`).
3. One chain throw cuts him free and takes 1; the sword does not (`sheet-chain.png`).
4. Rolling passes through the lash and jumping over it (`sheet-dodge.png`).
5. The shield stops it and it recoils; a hit then takes 1 (`sheet-block.png`); the just block: sacred counter, ice freeze, fire
   burns it dead (`sheet-just.png`).
6. Three hits dry it out; a fallen torch burns it (`sheet-death.png`).
7. In the dark only the open bud's heart shows (`captures/oscuridad.png`).

## 11. Exports

From the zone 4 sandbox (`vsExportAll()`, the sounds with `vsExportSfx()`): `sprites/sheet.png`, seven single poses, seven
frame sheets (`lash`, `trap`, `chain`, `dodge`, `block`, `just`, `death`) and seventeen screenshots in `captures/`. Tests: the
16 scenarios `vs*` (`vsAll()`), the list of vines (`vsList()`) and the random player `vsFuzz()` (110 fights of 60 s, in turn in
all eleven kinds of room with vines, without the spiderlings, half with the chain, a third with the ice shield and a third with the
fire shield: never a lash without its full telegraph, never a catch without a lash, never caught while rolling, never moving
while caught, never two squeezes within 1 s, never held more than 3 s, never hurt by the sword while it holds him, never
moving, never back from defeat, never stuck).

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| SV1 | Look | a thorned stem of living root coiled on the floor, a bud with the mark inside; never like a grab vine; no new colour |
| SV2 | The lash | within 180 su: 0.8 s rise (bud opening), a lash at the waist to 180 su |
| SV3 | Dodging | rolling passes through, jumping passes over; a miss leaves it open 0.9 s |
| SV4 | Caught | it squeezes: −1 a second (operator); no moving, jumping, rolling, blocking or sword |
| SV5 | The chain | one throw cuts him free and takes 1 (operator); the sword cannot (operator); it lets go at 3 s |
| SV6 | Shield | a block makes it recoil; just block: sacred counter (stun 1.5 s, −1), ice freeze 1.5 s, fire burns it dead (G16) |
| SV7 | Hits | 3, on the raised stem; coiled, they glance off; the chain and the dive take 1 |
| SV8 | Fire | a fallen torch, a burning web, the fire shield's just block |
| SV9 | Dark | only the open bud's heart |
| SV10 | Place | only on the floor (operator), in every room but the start, the antechamber, the boss room and the way down (operator: «por todos lados»), away from doors, pools and pods; 1–2 per room |
| SV11 | Numbers | 3 health; every number is the sandbox's |
| SV12 | Sound | rise, lash, grab, squeeze, cut, hurt, die; no echo or reverb (the jungle) |
