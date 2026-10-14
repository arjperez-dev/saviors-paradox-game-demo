# Ossuary Many-Armed — character contract

- **Status:** approved (step 3.13)
- **Kind:** enemy (zone 3, the Sunken Graveyard); the ossuary's variant of zone 2's Many-Armed, with mechanics of its own
- **Sandbox:** the zone 3 sandbox, [`../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`](../../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html):
  *Ir a… osario* (the default enemy, in the ossuary's combat room); `N` makes it attack · **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Content scope (zone 3: *Ossuary Many-Armed (variant with different mechanics)*) ·
  `03-characters/enemies/zone-2/many-armed/contract.md` (approved: the family's body, the chain that tears off arms) ·
  `04-zones/zone-3-sunken-graveyard/layout.md` §B.3 (`ossuary`: a chapel of bones, two heaps of skulls) · `00-game/controls.md`
  (G7: a just block sends a projectile back; G16: only a melee just block opens the counter) · the operator's decisions of
  2026-10-02 (the proposal; it rebuilds arms from the heaps of skulls; the cage is escaped by hitting it; no bone lamp)
- **Built on:** Akeris's skeleton at 1.25×, the body of zone 2's Many-Armed
- **Code name:** `ossuaryManyArmed` (in the sandbox, `ossuary`) · **Español:** el de muchos brazos del osario

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals OM1–OM12 (§12) approved by the operator as the sandbox does them.

## 1. Identity

Of the same family as zone 2's: hooded, eyes and mouth sewn shut. But its six extra arms are **bare bone**, lashed with wire
and rags, ending in hands of bone, with no swords; its shroud is sewn with small bones and it wears a necklace of little
skulls. The ossuary is its larder: **its bones come and go**. A player reads: it throws its arms at me and they come back;
up close it cages me; if I tear its arms off, it rebuilds them from the skulls — stop it.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 235 (Akeris's skeleton at 1.25×, stooped) | Akeris = 192; zone 2's is 1.2× |
| bone arms | 34 + 32, a hand of four 16-su finger bones | white bone in an `ink` line, wire at the elbow |
| thrown arm | flies at **150 su** above the floor | a crouched Akeris (138) is under it |
| the cage | bars from its body around Akeris, 125 su in front of it | one bar per arm it has |

**Silhouette test:** a hooded, stooped shape with a fan of white bones; never zone 2's (no swords, bone arms) and never the
Skeleton (it wears a shroud and has a face).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| skin, face, own arms | `GH_SKIN` `#bab29f` (zone 2's) | 2.2–5.4 | `ink` at .2 |
| shroud and hood | `#3f3a33` (zone 2's) with small bones sewn on | 2 | `ink` at .42 |
| bone arms, cage bars, the thrown arm | `#ddd6c6` (the zone's bone) inside an `ink` line; wire `#5a554e` | 3 / 2.6 / 1.2 | — |
| necklace | the zone's skulls at .45 | — | — |

No new colour.

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| guard | spawn, any end | — | yes | throw, cage, smash, rebuild | `guard`: six bone arms hanging, swaying a little; walks 100 su/s to keep ≈ 320 su |
| throw | guard, Akeris 210–720 su | 0.5 + 0.3 | no | guard | `throw-wind`: one bone arm drawn back, every bone rattling (the telegraph) → `throw`: flung; the arm spins out and back (`sheet-throw.png`) |
| cage | guard, Akeris within 210 su and 4+ arms | 0.6 | no | caging, open | `cage-wind`: every arm wide (the telegraph) → shut (`sheet-cage.png`) |
| caging | the cage shuts on Akeris | ≤ 3.0 | no | stagger, guard | `cage`: the bars around Akeris; it squeezes every 0.8 s |
| open | the cage shuts on nothing | 0.8 | no | guard | arms closed on air: the opening |
| smash | guard, close and fewer than 4 arms | 0.35 + 0.07 + 0.38 | no | guard | `smash`: two bone arms raised and brought down (`sheet-smash.png`) |
| rebuild | guard, 3 arms or fewer and a heap left | 1.2 | no | guard | `rebuild`: bent over a heap of skulls, its arms in it; bones gather; a new arm (`sheet-rebuild.png`) |
| hurt | a hit | 0.25 | no | guard | `hurt`; **a hit while it rebuilds stops it** (the heap stays) |
| stagger / stun | escaping the cage, its arm sent back, the sacred counter / the fast descent | 1.2 / 1.2 | no | guard | `hurt`, swaying; graphite stars |
| death | its last health | ≈ 0.85, then the ink smoke | no | — | it falls apart into bones; its bone arms drop; the hood falls last (`sheet-death.png`, `sheet-collapse.png`) |

## 5. Weapons and gear

None but its bone arms. A thrown arm caught by the chain breaks and is gone; it is not an item.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| the thrown arm | throw | a bone arm spinning at 150 su, with two fading copies, out ≈ 600 su and back; a wall turns it back early | 1.3 |
| sent back | a just block | flies straight at it and hits it | — |
| caught | the chain | it breaks: bone crumbs, `crack!`, the pieces fall and fade | 0.8 |
| the cage | caging | bone bars curving from its body around Akeris; each hit, `crack!` and bone crumbs | — |
| a used heap | rebuild | the heap of skulls is gone; a few loose bones stay on the floor | — |
| hit feedback, block sparks, reflect ring, counter, stars, ink smoke | as every enemy | `02-art-direction/fx/` | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.ossuaryManyArmed.step` | each heavy step, the small bones on its shroud | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.rattle` | every bone rattling: the throw's telegraph (and the smash's) | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.spin` | the thrown arm spinning out and back | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.catch` | the arm back in place | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.cageOpen` | the cage's telegraph: every arm opening | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.cageShut` | the cage slamming shut | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.crack` | a hit on the cage; an arm torn off or caught; its arm hitting Akeris | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.rebuild` | bones gathering into a new arm | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.smash` | the bone smash | `07-audio/sfx/sfx.md` |
| `sfx.ossuaryManyArmed.collapse` | its last health: bones cascading, the hood falling | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.fx.reflect`, `sfx.akeris.hurt`, hits, `sfx.fx.inkSmoke` | blocks, the arm sent back, the squeeze, hits, death | `07-audio/sfx/sfx.md` (existing) |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 8, as zone 2's) | proposal |
| thrown arm, squeeze and smash damage | the game decides (sandbox: the HUD's test hit; the squeeze 1) | — |
| its arm sent back | the game decides (sandbox: 1) and a stagger | G7 |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 64 su | the sandbox |
| where | **only the ossuary rooms** | operator |

**Behaviour:**

1. **Distance (OM2).** It walks (100 su/s) to keep about 320 su from Akeris.
2. **The thrown arm (OM3).** From 210 to 720 su, with an arm to spare and none in the air: it draws one bone arm back
   (**0.5 s**, every bone rattling) and flings it. The arm spins **150 su above the floor**, out ≈ 600 su and back to it:
   **two passes**, each hits once. Answers:
   - **crouching** passes under it; **rolling** goes through it; a jump may not clear it;
   - **the shield** stops a pass **if Akeris faces where it comes from** — the way back comes from behind him if he is inside
     its range;
   - **a just block** sends it straight back: it hits it (1) and staggers it (G7);
   - **the chain catches it in the air**: the arm breaks and **it is lost for good** (the chain touching it anywhere on its
     flight is enough).
   While the arm flies it has one arm fewer; it does not throw another until that one is back or gone.
3. **The cage (OM4; operator: escaped by hitting).** Within 210 su, with 4 arms or more: it opens every arm (**0.6 s**) and
   shuts them on Akeris (125 su in front of it). **Rolling** out escapes it; **a sacred just block** bursts it and opens the
   counter (G16); the plain shield does not stop it. Caught, Akeris stays inside (he can still swing): it **squeezes every
   0.8 s** (1 of damage); **three hits** on the bars break it and it **staggers 1.2 s** (the opening). Inside the cage the
   blows go to the bars, not its body. It lets go by itself after **3.0 s** at most, throwing him out.
4. **Rebuild (OM5; operator).** With **3 arms or fewer** it walks to the nearest **heap of skulls** in its room, sinks its
   arms into it for **1.2 s** (open) and comes back with **one new arm**. A hit stops it (the heap stays for another try).
   **Each heap serves once** and does not come back; the ossuary has two.
5. **Fewer than 4 (OM6).** Instead of the cage, close in, **the bone smash**: two arms raised and brought down (0.35 s
   telegraph); the shield stops it and a sacred just block opens the counter. With no extra arm left it still throws nothing
   and fights with the smash.
6. **The chain (OM7).** Each chain blade that reaches its body **tears off an arm** (no damage), as zone 2's; it also catches
   the thrown arm.
7. **The fast descent** beside it stuns it 1.2 s, as every enemy.
8. **Defeated, it stays defeated** for the run (operator, 2026-10-01; every enemy).

## 9. Never

- Nothing trembles; the strokes never change; the bones and the cage move smoothly.
- A throw without its rattle, a cage without its 0.6 s of open arms.
- A cage that holds Akeris forever, or kills him outright (that is zone 2's).
- Swords, waves or the mill: those are zone 2's.
- Rebuilding from a heap it already used, or more arms than six.
- A bone lamp brought down by the chain (operator).
- It never comes back once defeated.

## 10. Acceptance

1. The throw: 0.5 s of rattle, the arm spins out and back, two passes (`sheet-throw.png`); crouched it passes over; the
   shield stops a pass only facing it (`sheet-dodge.png`); a just block sends it back and staggers it (`sheet-reflect.png`).
2. The chain catches the flying arm and it is lost (`sheet-chain-arm.png`); on the body, the chain tears an arm off (`sheet-chain.png`).
3. The cage: 0.6 s of open arms, shut, a squeeze every 0.8 s (`sheet-cage.png`); three hits break it and it staggers, rolling
   escapes it (`sheet-cage-escape.png`); a sacred just block bursts it (`sheet-cage-counter.png`).
4. With fewer than 4 arms, the smash instead (`sheet-smash.png`).
5. With 3 or fewer it rebuilds an arm at a heap (1.2 s); the heap is gone after (`sheet-rebuild.png`); a hit stops it.
6. At its last health it falls apart into bones, the hood last (`sheet-collapse.png`, `sheet-death.png`).
7. Checked with a random player (half the fights with the chain): 80 fights of 60 s — the cage always lets go within 3.0 s
   of play, Akeris never leaves the cage without breaking it, the arm always returns or breaks, never more than six arms or a
   heap used twice, never stuck, never out of its room (`osFuzz` in the sandbox).

## 11. Exports

From the zone 3 sandbox (`osExportAll()`, the sounds with `osExportSfx()`): `sprites/sheet.png`, eight single poses (`guard`,
`throw-wind`, `throw`, `cage-wind`, `cage`, `smash`, `rebuild`, `hurt`), `sprites/sheet-death.png` and eleven frame sheets
(`throw`, `dodge`, `reflect`, `chain-arm`, `cage`, `cage-escape`, `cage-counter`, `smash`, `rebuild`, `chain`, `collapse`), and
eighteen screenshots in `captures/` (with `oscuridad.png`, in the ossuary's darkness). 18 WAV in
`07-audio/sfx/enemies/ossuaryManyArmed-*`.

## 12. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| OM1 | Look | zone 2's family (hood, sewn eyes and mouth) with six bare bone arms lashed with wire, bone hands, no swords; small bones sewn on the shroud, a necklace of skulls |
| OM2 | Distance | keeps ≈ 320 su, walks 100 su/s |
| OM3 | The thrown arm | 0.5 s rattle; spins at 150 su, out ≈ 600 su and back; two passes; crouch or roll; the shield facing it; a just block sends it back; the chain catches it and it is lost |
| OM4 | The cage (operator) | within 210 su with 4+ arms; 0.6 s open; roll out or sacred just block; caught: squeeze every 0.8 s, three hits break it (stagger 1.2 s), lets go after 3.0 s |
| OM5 | Rebuild (operator) | with 3 arms or fewer, at a heap of skulls, 1.2 s open, one arm; each heap once |
| OM6 | Fewer than 4 | the bone smash instead of the cage (blocked, countered) |
| OM7 | The chain | tears off an arm; catches the thrown arm |
| OM8 | Health | 8 |
| OM9 | Where (operator) | only the ossuary rooms |
| OM10 | No lamp (operator) | the bone lamp is not brought down |
| OM11 | Death | falls apart into bones, the hood last |
| OM12 | Sound | step, rattle, spin, catch, cage open and shut, crack, rebuild, smash, collapse; with the catacombs' stone |
