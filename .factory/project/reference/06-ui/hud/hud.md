# HUD

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: the items hall with the HUD) ·
  **Image:** [`hud.png`](hud.png) (the HUD over the game at 1920×1080) and
  [`hud-layer.png`](hud-layer.png) (the HUD alone, transparent, 1920×1080)
- **Sources:** `VISION.md` §Mechanics (weapons, shields, potions, abilities, scrolls, XP, coins, map) ·
  `05-items/items.md` §4 (the quick inventory), I6, I7, I8, I11, D-I5, D-I7 ·
  `02-art-direction/ART_DIRECTION.md` (static stroke) · `02-art-direction/palette/palette.md`
- **Asked by the operator (2026-09-30):** Akeris's face at the top left, joined to the health bar;
  XP and coins under the bar; the inventory of weapons, shields, potions and abilities at the bottom
  left, out of the player's way.

## 1. Purpose

What Akeris has and how he is, at a glance, while playing: his health, his XP and coins, what lasts
on him (a curse, rage), and the quick inventory. It never covers the middle of the screen, where he
fights.

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| a zone starts (after the zone's title card) | the pause menu, the map (M), a dialogue, a cinematic, death | no | the game, under nothing but the screen's paper overlay |

It is drawn **over** the paper overlay (grain and vignette), so it stays readable in dark rooms.

## 3. Layout

A 1920×1080 reference frame (**hu**), scaled by `screen height ÷ 1080`. The top-left and bottom-left
groups anchor to their corner; on wider screens they keep their distance to the left edge. Safe
margin: 36 hu. Numbers are what the sandbox draws (`HUD_L` in `sandbox.html`).

### 3.1 Top left: face, health, XP and coins

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| portrait | top-left | circle, centre (110, 110), radius 74; a thin outer ring at 80 | Akeris's head in a dark niche lit by torchlight: the paper head (radius 44), the black almond eye looking right, the neck and the torn cape at the shoulders | Akeris: health, dead |
| eye streak | portrait | from the eye (≈ 122, 98) back to the left, past the medallion's edge (28, 86), 10 wide under a 5 core | **his red streak trails behind him, to the left, and waves as in the game**; **its length follows his health**: whole at full health, shorter with every point lost, 15 % of its length at the last point, gone when he dies (the same wave as `drawStreak`: 4 rad/s, growing toward the tail, up to 3.4 hu); the eye looks toward the bar | rage: 1.5× wider |
| health bar | joined to the portrait | starts at x 176, centre y 96, 30 tall; **44 hu per health point** (10 → 440, 12 → 528), a pointed end 8 long | the filled part, a tick for every point, the lost part (§4) | health, max health |
| health numbers | after the bar | x = bar end + 24, y 96, 28 px | `9/12` | health, max health |
| XP | under the bar | mote icon at (202, 146), text from x 224, 30 px | `2350 XP` | XP |
| coins | after XP | 34 hu after the XP text | coin icon and `14` | coins |
| attack | after coins | 34 hu after the coins | a small sacred-sword icon and `+1`; **only when the attack scroll has raised it** | attack bonus |
| gains | under XP or coins | starts at y 190 and rises 14 while it fades, 24 px | `+150`; gains within 0.5 s add up | XP, coins picked up |
| lasting states | under the portrait | from (36, 194), chips 40 tall, 10 apart | curse: a ring of ink thorns and `4/10`; rage: a short red streak and `Rage 2:40`. The golem's levitation and the other bosses' states join this row when they are designed | curse (D-I7), rage (I6) |

### 3.2 Bottom left: the quick inventory

Two rows of five boxes of **84 hu**, 10 apart, aligned in columns. Total: 460 × 184 hu.

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| weapon slots 1–5 | bottom-left | row y 960–1044; box *i* at x = 36 + *i* · 94 | the weapon's icon (`05-items/weapons/<item>/icon.png`), the slot number at the top left, **three level marks** at the bottom right (filled = its level; the demo stops at 3, I11) | the five slots, the weapon in hand, weapon levels |
| the weapon in hand | its slot | raised 8, frame 3.6 wide with an inner line | — | weapon in hand |
| empty slot | its slot | dashed frame, faint number | nothing | — |
| shield | over slot 1 | row y 860–944 | the **equipped** shield's icon and its uses `6/10`; broken: `icon-broken.png` and `Broken` (D-I5, I8). The sacred shield shows no count | equipped shield, uses |
| potions | over slot 2 | row y 860–944 | three flasks, empty ones drawn empty, and the key `F` | potions carried |
| abilities | over slots 3–5 | row y 860–944 | the keys `Q`, `E`, `R`; empty: dashed box and a dashed ring; equipped: its icon; recharging: an ink wash that drains downward and the whole seconds left | the 3 equipped abilities, cooldowns |

### 3.3 Reserved (designed in their own pieces)

| Element | Where | Piece |
|---|---|---|
| circular minimap | top-right | `06-ui/map/map.md` §3.2 (approved 2026-09-30; `hud.png`, `hud-layer.png` and the `captures/hud*.png` are exported again with it, nothing else changes) |
| boss health | top-centre, above the curse notice | the golem, step 3.11 |
| the curse notice | top-centre, y 150–208, 36 px, 3 s | this piece, §4 |
| take prompt | over the altar, in the world | this piece, §4 |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| damage | the portrait's streak shortens with the shown health; the bar drops at once; the lost part stays **pale** for 0.45 s, then drains at 8 points/s | he takes damage |
| heal | the bar fills at 10 points/s | he drinks a potion; the health scroll |
| max health up | the bar grows 44 hu per point | the health scroll (`05-items/scrolls/`) |
| low health | at **30 % or less**: an ink crack across the portrait's head and a pale inner ring on the medallion | health ≤ 30 % of max |
| dead | the eye closes into a line, no streak; the notice `The run is lost` | death |
| rage | the portrait's streak burns 1.5× wider; the rage chip counts down | rage (I6) |
| curse | the full notice at the top centre for 3 s (`Curse: 4/10 — any damage kills you`), then only the chip | a curse starts or adds up (D-I7) |
| weapon swap | the new slot rises 8 hu in 0.18 s | 1–5, the wheel, a weapon taken |
| ability not ready | its frame flashes for 0.35 s; nothing else | Q, E or R on an empty or recharging slot |
| **Akeris behind a group** | that group fades to **30 %** (6/s) and comes back when he leaves | his body overlaps the group's rectangle |
| near an altar | the take prompt: a key cap `G` and `Take: <item>` | `05-items/items.md` §2 |

## 5. Navigation

The HUD takes no input. The controls it shows are `VISION.md`'s: 1–5 and the wheel pick a weapon,
F drinks, Q/E/R trigger the abilities, G takes an item (G17, (D)). The equipped shield is changed only
in the pause menu.

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.hud.health` | {hp}/{max} | {hp}/{max} | after the bar | 7 |
| `ui.hud.xp` | {n} XP | {n} XP | under the bar | 10 |
| `ui.hud.attack` | +{n} | +{n} | after the coins | 3 |
| `ui.hud.curse` | {n}/{total} | {n}/{total} | curse chip | 7 |
| `ui.hud.rage` | Rage {time} | Furia {time} | rage chip | 12 |
| `ui.hud.empty` | Empty | Vacía | an empty ability, for screen readers | 8 |
| `ui.hud.death` | The run is lost | La partida se pierde | death notice | 24 |
| `item.curse.progress` | Curse: {n}/{total} — any damage kills you | Maldición: {n}/{total}. Cualquier daño te mata | curse notice (`05-items/items.md` §9) | 48 |
| `item.shield.broken` | Broken | Roto | shield box | 8 |
| `ui.prompt.take` | Take | Tomar | take prompt, followed by the item's name key | 8 + name |

Numbers are formatted by the game; coins and XP have no thousands separator in the demo.

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed; `07-audio/` fixes them in step 3.8) |
|---|---|---|---|
| lost health | pale, then drains | 0.45 + 8 points/s | — (the hit has its own) |
| heal | fills | 10 points/s | — (the potion has its own) |
| gains | rise 14 hu and fade | 1 | — (`sfx.xp.absorb`, `sfx.coin.take`) |
| weapon slot | rises 8 hu | 0.18 | `sfx.ui.slot` |
| ability not ready | frame flashes | 0.35 | `sfx.ui.denied` |
| group behind Akeris | fades to 30 % | 6/s | — |
| curse notice | shows, fades in its last 0.5 s | 3 | — (`sfx.curse.start`) |
| low health | nothing moves: the crack is drawn | — | `sfx.ui.lowHealth` (once, on crossing 30 %) |

Nothing trembles: no shake, no pulse, no flicker. Only values move, and the portrait's streak waves as Akeris's does in the game.

## 8. Never

- Nothing in the middle of the screen, except the curse notice for 3 s and the death notice.
- No stroke is redrawn differently from one frame to the next; every box and ring has its seed.
- No colour outside `palette.md`; red is Akeris's streak and nothing else (see U1).
- No hard-coded text: every string is a key of §6.
- The HUD never shows the shields that are not equipped: that is the pause menu's full inventory.
- No HUD element moves Akeris's camera or reacts to the camera.

## 9. Acceptance

1. At 1920×1080 the layout matches `hud.png` and `hud-layer.png`, element by element, within 2 hu.
2. At any 16:9 or wider resolution the top-left group keeps its distance to the top-left corner and
   the quick inventory to the bottom-left corner; nothing overlaps.
3. A hit leaves the lost part pale for 0.45 s, then it drains (`captures/hudHerido.png`).
4. At 30 % health or less the portrait shows the crack; at zero the eye is closed.
5. The health scroll lengthens the bar by 44 hu per point.
6. XP and coins picked up show their gain under the number (`captures/hudBotin.png`).
7. A curse shows the notice for 3 s, then the chip; rage shows its countdown (`captures/hudMaldito.png`).
8. The equipped special shield shows its uses, and its broken icon and `Broken` when broken
   (`captures/hudRoto.png`).
9. An empty weapon slot and an empty ability are dashed (`captures/hudInicio.png`); an ability
   recharging shows its ink wash and seconds (`hud.png`).
10. When Akeris's body overlaps a group, that group fades to 30 %, and comes back when he leaves.
11. Near an altar the prompt shows G and the item's name (`captures/hudRecoger.png`).

## 10. Proposals for the operator

| # | Question | Proposal |
|---|---|---|
| U1 | What does the health bar look like? | **Decided by the operator (2026-09-30): the bar is his streak.** The Savior's is red (`streakRed`: the dark red fill with the bright core); **Corrupted Akeris**'s is purple with white stripes, like his streak (`streakPurple` with `paperLight` stripes at .62, 3 wide, every 17 hu); **Future Akeris**'s is the same red, **battered and defective**: the bright core in pieces, some dead and some jumped up or down, dark cuts across the fill, ink bruises, scratches, cracks and bites out of the edges. **His streak is defective too, on the portrait and on the character** (operator, 2026-09-30): it breaks into pieces with gaps, some pieces are shifted up or down, and some lose the bright core. The defect is fixed along the streak by a seed (`DEFECT`, seed 4242): it waves with the streak and never flickers. It belongs to `03-characters/future-akeris/` when he is made. The ink bar is dropped. `palette.md` adds "the health bar" to the uses of `streakRed` and `streakPurple`. Neither Corrupted nor Future Akeris is played in the demo; their bars are the reference for when they are (`captures/hudCorrupto.png`, `captures/hudFuturo.png`; B in the sandbox) |
| U2 | How is the face drawn? | His head as the game draws it, larger, in a dark niche lit by torchlight, with the cape at the shoulders; no other expression. A crack at low health, the eye closed when dead |
| U3 | Is max health shown? | By the bar's length (44 hu per point) and the `9/12` after it |
| U4 | Is the attack shown? | Only when a scroll has raised it: sword icon and `+1` after the coins. Every stat is in the pause menu |
| U5 | What if Akeris walks behind the HUD? | The group he overlaps fades to 30 % |
| U6 | Weapon levels? | Three marks per slot (the demo's cap) |
| U7 | Abilities before any boss? | The three boxes are dashed with their keys; each boss's ability draws its own icon in its step (3.11–3.15). The sandbox uses a stand-in (the golem's Stone Orbit, 8 s) |
| U8 | Where do the curse and rage go? | A row of chips under the portrait; the bosses' states (levitation, poison, slow, stun, freeze) join it |
