# The Skeleton — boss contract

- **Status:** approved 2026-10-02 (step 3.13)
- **Kind:** boss (zone 3, the Sunken Graveyard)
- **Sandbox:** the zone 3 sandbox, [`../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`](../../../04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html):
  *Ir a… jefe*, then walk in: the doors seal and it wakes. `N` makes it start its next attack when it is waiting ·
  **Pose sheet:** [`sprites/sheet.png`](sprites/sheet.png)
- **Sources:** `VISION.md` §Bosses (Skeleton: «unblockable air slashes at range (dodge by jumping or behind tombstones,
  which break); blockable bone throws (open a counter); bony hands from the ground; reassembles once after its first
  "death" unless its skull is snatched with the chain»), §Abilities (Skeleton: Air Slash, Reassemble) ·
  `01-story/zones-narrative.md` (zone 3: «the oldest of the dead, who stands up once more after falling»; the mark of the
  three hollows, «like the sword's guard») · `01-story/dialogue/zone-3.md` (the warning spirit: «the bones in the lowest crypt
  still hold a sword», «put a stone between you») · [`../../../04-zones/zone-3-sunken-graveyard/boss-room.md`](../../../04-zones/zone-3-sunken-graveyard/boss-room.md)
  (the lowest crypt: the bier, two hanging coffins, six tombstones) · `04-zones/zone-3-sunken-graveyard/hazards.md` (Z34:
  tombstones stop projectiles and break; how many hits its air slash takes is this contract's) · `00-game/controls.md` (G7,
  G16) · the Giant Bat's contract (the boss bar, the choice) · the operator's decisions of 2026-10-02 (the proposal; the
  reassembly lasts **1.2 s**, the bones gathering from **0.7 s**; **snatching the skull does not defeat it**: it takes health,
  and a second later a guttural roar throws Akeris away, he drops the skull, it flies back and phase 2 begins); then: **every attack faster** (shorter telegraphs and recoveries, less wait between attacks, faster slashes and bones, faster walk), and finally **halfway** between the first numbers and the fast ones
- **Built on:** Akeris's skeleton at 1.35×, drawn as bones
- **Code name:** `skeleton` · **Español:** el esqueleto

Every gameplay number is the sandbox's and is marked **the game decides**. Proposals SK1–SK16 (§13) approved by the operator on 2026-10-02 as the sandbox does them.

**Change to `VISION.md` (operator, 2026-10-02):** where it says it «reassembles once after its first "death" unless its skull
is snatched with the chain», it always reassembles; snatching the skull takes health from its second life and ends with the
guttural roar.

## 1. Identity

The oldest of the dead, lying on its bier in the lowest crypt with its sword between its hands. A tall skeleton in the
remains of old armour — a rusted breastplate shard, a pauldron — a royal cloak gone to rags and an iron circlet. Its long
sword's guard has **the three hollows**, the mark on every tombstone of the zone, «like the sword's guard»: one who came down
before. When the room seals it sits up, takes the sword and its eye sockets light; in its second life they burn red. A player
reads: the sword high, I duck; the sword low, I jump; when it plants it, I get off the floor; when it falls, its skull is my
chance — but it will stand up again.

## 2. Silhouette and proportions

| Measure | Value (su) | Notes |
|---|---|---|
| height | ≈ 260 (Akeris's skeleton at 1.35×, upright) | Akeris = 192 |
| sword | ≈ 255: a 162 blade, a 44 guard with the three hollows, a 36 grip, a pommel | held in both hands; always carried |
| high slash | a crescent from 145 to 205 su above the floor | over a crouched Akeris (138) and over a tombstone (150) |
| low slash | a crescent from 12 to 72 su above the floor | under a jump; a tombstone stops it |
| bones | three ribs thrown at 130 su (the chest); in an arc to a hanging coffin | stopped by the shield and by tombstones |
| hands | rise 150 su out of the floor | the coffins hang 250 su up |

**Silhouette test:** a tall bony figure with a crown of iron spikes, a cloak and a sword as long as Akeris; never the skeleton
archer (no bow, twice its size, a crown) and never the gravedigger (no hat, no flesh).

## 3. Palette and strokes

| Part | Colour | Stroke width (su) | Hatching |
|---|---|---|---|
| bones | `#ddd6c6` inside an `ink` line | 3–3.6 + 1.8 | — |
| skull | `#ddd6c6`; sockets `#120e0b` with a pale glow (red `#9e1218` in phase 2; off while asleep) | 2.2 | `ink` at .14 |
| circlet, breastplate shard, pauldron, the guard | `IRON` `#5a554e` | 1.8 / 4.2 | `ink` at .3 |
| cloak | `#2a2622` with an old iron edge | 2 | `ink` at .42 |
| sword | blade `#8f877b`, grip `WOOD`, the three hollows `#120e0b` | 1.8 / 5 | — |
| the air slash | four crescents of `ink` and pale paper, a dashed trail | 4.6 → 1 | — |
| the floor cracks | `ink` cracks and a dashed ring that closes | 1.6 | — |

No new colour (the red is the Giant Bat's rage red).

## 4. Animations

| Animation | Entered from | Duration (s) | Loops | Exits to | Look |
|---|---|---|---|---|---|
| asleep | the room | — | yes | wake | `lie`: on its bier, the sword along its body, sockets dark |
| wake | 1.0 s after the doors seal | 2.2 | no | guard | sits up, rises with the sword (the roar pose), the sockets light, it steps down from the bier (`sheet-wake.png`) |
| guard | wake, any end | — | yes | slash, bones, hands, heavy | `guard`: the sword held low in front; keeps ≈ 460 su (walks 145 su/s; 195 in phase 2) |
| slash, high | guard | 0.5 + 0.33 | no | guard | `slash-high-wind`: the sword raised high behind its head (the telegraph, the blade humming) → `slash-high`: the crescent leaves at head height (`sheet-slash-high.png`) |
| slash, low | guard | 0.5 + 0.33 | no | guard | `slash-low-wind`: crouched, the sword low behind → `slash-low`: the crescent leaves along the floor (`sheet-slash-low.png`) |
| slash pair (phase 2) | guard | 0.38 + 0.3 + 0.33 | no | guard | a high crescent and, 0.35 s later, a low one (`sheet-phase2.png`) |
| bones | guard; Akeris on a coffin too long | 0.38 + 0.33 | no | guard | `bones-wind`: it tears a rib off → `bones`: three thrown in a fan (in an arc toward a coffin) (`sheet-bones.png`, `sheet-coffin.png`) |
| hands | guard | 0.33 + 0.75 open + 0.3 | no | guard | `plant-wind`: the sword raised point down → `plant`: driven into the floor; it stays planted 0.75 s (the opening) (`sheet-hands.png`) |
| heavy | guard, Akeris within 230 su | 0.43 + 0.08 + 0.34 | no | guard | `heavy-wind` → `heavy`: a two-handed chop (`sheet-heavy.png`) |
| stagger / stun | a sacred just block, its bone just-blocked, the fast descent | 1.2 / 1.0 | no | guard | `hurt`, swaying; graphite stars |
| down (first death) | its first life at 0 | **1.2** | no | rise, held | it falls apart; the skull rolls ≈ 140 su; **at 0.7 s the bones start to gather**; at 1.2 s it stands (`sheet-collapse.png`, `sheet-reassemble.png`) |
| held | the chain snatches the skull | **1.0** | no | skull back | Akeris holds the skull; the headless bones wait (`sheet-skull.png`) |
| roar, skull back | after 1.0 s | 0.4 | no | rise | the guttural roar: Akeris is thrown away and drops the skull, which flies back to the body (`sheet-skull.png`) |
| rise (phase 2) | down, skull back | 0.53 | no | guard | `roar` → guard; the sockets red (`phase-2`) |
| defeat | its second life at 0 | ≈ 0.7 | no | — | it falls apart for good; the skull drops and cracks; the sword lies on the floor; the remains stay (`sheet-defeat.png`) |

## 5. Weapons and gear

The long sword with the three hollows on its guard: always in its hands (on its chest while it sleeps; on the floor when it is
defeated). Not an item. The skull is not an item either: Akeris holds it for a second only.

## 6. Effects

| Effect | Trigger | Look | Duration (s) |
|---|---|---|---|
| the air slash | slash | a crescent of ink and pale paper, four arcs, at 1035 su/s along the room until a wall; a dashed trail | — |
| a stopped slash or bone | a tombstone | the stone cracks (one hit per slash or per throw) | — |
| the bones | bones | three ribs spinning, straight or in an arc; stopped, they bounce and fade | ≤ 2.2 |
| the cracks | hands | three to five cracks with a dashed ring that closes, then two bone hands per crack rise 150 su and sink | 0.6 + 0.3 + 0.35 |
| the gathering | down | the bones draw together toward the body | 0.5 |
| the roar | snatch + 1 s; rise | `GRRAAAH!`, rings from its body | — |
| hit feedback, block sparks, counter, stars | as every enemy | `02-art-direction/fx/` | — |
| in the dark | always | its sockets (red in phase 2), the slashes and the cracks over the darkness | — |

## 7. Sounds

| Sound id | Trigger | Defined in |
|---|---|---|
| `sfx.skeleton.wake` | it sits up: bones fitting, the sword raised, a deep groan | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.step` | each step: bone and old iron | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.slashWind` | the slash's telegraph: the blade hums and rises (also the heavy's, lower) | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.slash` | the air slash flies | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.bones` | it tears its ribs off and throws | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.boneHit` | a bone hits something | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.plant` | the sword into the floor | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.handsWarn` | the floor cracking (the hands' telegraph) | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.hands` | the hands burst out | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.heavy` | the two-handed chop | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.collapse` | the first death: it falls apart, the skull rolls | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.gather` | the bones gather | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.roar` | the guttural roar | `07-audio/sfx/sfx.md` |
| `sfx.skeleton.defeat` | the second death: the fall, the skull cracking, the sword on the stone | `07-audio/sfx/sfx.md` |
| shield sounds, `sfx.zone3.stoneCrack` / `.stoneBreak`, `sfx.ossuaryManyArmed.crack` (the skull snatched), `sfx.bossDoor.*`, `music.skeleton.*` | blocks, tombstones, the snatch, the doors, the music | existing |

## 8. Mechanics

| Property | Value | Source |
|---|---|---|
| health | the game decides (sandbox: 20 in its first life; 10 in its second, 7 if the skull was snatched) | proposal; operator |
| slash, bone, hands and heavy damage | the game decides (sandbox: the HUD's test hit) | — |
| XP and coins | the game decides | `VISION.md` §Assumptions |
| hit radius | 70 su | the sandbox |
| ability | the player chooses Air Slash or Reassemble | `VISION.md` §Abilities |

**Behaviour:**

1. **Asleep, the wake (SK2).** It lies on its bier until the doors seal; 1.0 s later it wakes (2.2 s) and `music.skeleton.fight`
   starts.
2. **The plan (SK3).** It keeps ≈ 460 su. Close (230 su) it chops; otherwise it follows a plan: phase 1 *slash, bones, slash,
   hands*; phase 2 *slash pair, hands, bones, slash pair, hands*. 0.78 s between attacks (0.53 in phase 2).
3. **The air slash (SK4).** **No shield stops it.** The stance tells the height (**0.5 s**; 0.38 in phase 2): **sword high → high slash** (crouch,
   roll, or a tombstone does *not* help: it passes over the stone); **sword low → low slash** (jump, roll, or **a tombstone
   stops it and cracks**). It flies the room to a wall. In phase 2 they come in pairs, high then low.
4. **The bones (SK5).** Three ribs thrown in a fan at the chest; **the shield stops them** and **a sacred just block opens the
   counter** (`VISION.md`; it staggers 1.2 s); tombstones stop them. If Akeris stays on a hanging coffin (2.15 s; 0.85 s in phase
   2), it throws them in an arc up to him. Bones fly at 910 su/s.
5. **The hands (SK6).** It drives the sword into the floor: cracks open under Akeris and at ±170 su (three; five in phase 2),
   with a closing ring; 0.6 s later two bone hands rise from each (they hit and throw him up a little; no shield stops them).
   **The hanging coffins are out of their reach.** It stays planted 0.75 s: the opening.
6. **The heavy chop (SK7).** Within 230 su: 0.43 s telegraph; the shield stops it and a sacred just block opens the counter.
7. **The first death (SK8; operator).** At 0 it falls apart and its skull rolls ≈ 140 su. **It reassembles in 1.2 s**: the
   bones begin to gather at 0.7 s. It cannot be hurt meanwhile.
8. **The skull (SK9; operator).** If the chain reaches the skull while it lies there, Akeris **snatches it**: it **takes 3 from
   its second life** (it will stand with 7 instead of 10), but does **not** defeat it. **One second later** a **guttural roar**
   throws Akeris away (no damage), he drops the skull, it flies back to the body, and phase 2 begins. Any chain stuck in its
   body is released when it falls, so the chain is free for the skull.
9. **Phase 2 (SK10).** Its sockets burn red; it is faster (shorter telegraphs, 165 su/s), slashes in pairs, five hands, and
   throws bones in an arc sooner.
10. **The second death (SK11).** It falls apart for good, the skull cracks, the sword lies on the floor; the remains stay in
    the crypt. The doors open (`sfx.bossDoor.open`), and 2.6 s later the choice: **Air Slash** (an unblockable slash along the
    floor) or **Reassemble** (once per zone, rise at 30 % health on death) (`VISION.md` §Abilities; `captures/eleccion.png`).
11. **The fast descent** beside it stuns it 1.0 s while it fights.

## 9. Never

- Nothing trembles; the strokes never change; the slashes, bones and hands move smoothly.
- A slash, a bone throw, the hands or the chop without its telegraph; a high slash with the sword low, or the reverse.
- A shield that stops the air slash or the hands.
- Defeated by snatching its skull; a reassembly longer than 1.2 s or a skull held longer than 1 s.
- The hands reaching a hanging coffin.
- The doors open before the second death; a third life.

## 10. Acceptance

1. Asleep on its bier; when the doors seal it wakes and stands (`sheet-wake.png`).
2. The high slash hits a standing Akeris, even blocking, and passes over a crouched one (`sheet-slash-high.png`); the low slash
   is jumped, and a tombstone stops it and cracks (`sheet-slash-low.png`).
3. The bones are stopped by the shield; a sacred just block opens the counter (`sheet-bones.png`); on a coffin, they come in an
   arc (`sheet-coffin.png`).
4. The hands hit on the floor and miss on a coffin (`sheet-hands.png`); the heavy chop is blocked and countered (`sheet-heavy.png`).
5. At its first 0 it falls apart and stands again in 1.2 s, the bones gathering from 0.7 s (`sheet-reassemble.png`).
6. Snatching the skull takes 3 from its second life; a second later the roar throws Akeris and phase 2 begins
   (`sheet-skull.png`).
7. Phase 2: red sockets, slash pairs (`sheet-phase2.png`); at its second 0 it is defeated, the doors open and the choice
   appears (`sheet-defeat.png`, `captures/eleccion.png`).
8. Checked with a random player (half with the chain, aiming at the body or the skull): 40 fights of 90 s — the reassembly
   always 1.2 s, the skull held 1.0 s, phase 2 never above 10, never stuck, never out of its room, the room sealed until the
   second death and the choice after it (`skFuzz` in the sandbox).

## 11. HUD

The boss bar at the top centre (`06-ui/hud/hud.md` §3.3), as the Giant Bat's: «The Skeleton» / «El esqueleto», bones along the
bar, a mark at half where it reassembles; in phase 2 the fill darkens. Hidden while it sleeps (`captures/barra.png`).

## 12. Exports

From the zone 3 sandbox (`skExportAll()`, the sounds with `skExportSfx()`): `sprites/sheet.png`, fifteen single poses (`lie`,
`guard`, `slash-high-wind`, `slash-high`, `slash-low-wind`, `slash-low`, `bones-wind`, `bones`, `plant-wind`, `plant`,
`heavy-wind`, `heavy`, `roar`, `hurt`, `phase-2`), `sprites/sheet-collapse.png` and eleven frame sheets (`wake`, `slash-high`,
`slash-low`, `bones`, `hands`, `coffin`, `heavy`, `reassemble`, `skull`, `phase2`, `defeat`), and twenty-six screenshots in
`captures/` (two in the dark, the boss bar and the choice). 24 WAV in `07-audio/sfx/bosses/skeleton-*`.

## 13. Proposals (operator)

| # | Proposal | As the sandbox does it |
|---|---|---|
| SK1 | Look | a tall skeleton (1.35×) in old armour, a royal cloak in rags, an iron circlet; a long sword whose guard has the three hollows |
| SK2 | The wake | asleep on its bier; 1.0 s after the seal it wakes (2.2 s) |
| SK3 | The plan (operator: faster, then halfway) | keeps ≈ 460 su, walks 145 su/s (195); phase 1 slash, bones, slash, hands; phase 2 slash pair, hands, bones, slash pair, hands; 0.78 s between attacks (0.53) |
| SK4 | The air slash | unblockable; sword high → high (crouch), sword low → low (jump, tombstone); 0.5 s telegraph (0.38); 1035 su/s |
| SK5 | The bones | three ribs at the chest, 0.38 s telegraph, 910 su/s; shield; sacred just block opens the counter; in an arc to a coffin after 2.15 s (0.85 in phase 2) |
| SK6 | The hands | sword planted (0.33 s); 3 (5) cracks under and beside Akeris, 0.6 s; the coffins are safe; 0.75 s planted (the opening) |
| SK7 | The heavy chop | within 230 su; 0.43 s telegraph; blocked; countered |
| SK8 | The first death (operator) | falls apart; reassembles in 1.2 s, the bones gathering from 0.7 s |
| SK9 | The skull (operator) | the chain snatches it: −3 to the second life, not defeated; 1 s later the guttural roar throws Akeris, the skull returns, phase 2 |
| SK10 | Phase 2 | half health (10), red sockets, faster, slash pairs, five hands |
| SK11 | The second death | for good: the skull cracks, the sword on the floor, the remains stay; the doors open; the choice |
| SK12 | Abilities | Air Slash, Reassemble (`VISION.md`) |
| SK13 | Health | 20 + 10 |
| SK14 | In the dark | the sockets, the slashes and the cracks show |
| SK15 | Hands' effect | damage and a small knock-up only (they do not hold) |
| SK16 | Sound | wake, step, slash telegraph, slash, bones, bone hit, plant, cracks, hands, heavy, collapse, gather, roar, defeat |
