# Palette

- **Status:** approved 2026-09-30 (step 3.6 proposes `wood`, `iron`, `parchmentDark` and the coins' gold)
- **Sources:** `../ART_DIRECTION.md` §2 · the Akeris sandbox and the art direction sandbox (the values below are
  theirs) · `VISION.md` §Art direction, §Client constraints
- **Sheet:** [`palette.png`](palette.png): every colour with its name and value
- **Read by:** every task that picks a colour. A colour not in this file is not allowed; a new one is
  proposed to the operator and added here first.

The game is graphite and ink on old paper. Colour is an exception with a reason: light, the timeline,
or the element of a shield or effect. Alpha values are part of the colour.

---

## 1. Paper and ink

| Name | Value | Used for |
|---|---|---|
| `ink` | `#1a1715` | every outline and stroke; callout outlines; the eye |
| `paper` | `#d4ccbe` | the page; fills of heads and pale shapes |
| `paperLight` | `#efe6d6` | callout fill |
| `graphite` | `ink` at 0.14–0.35 alpha | hatching |
| `grain` | `rgba(60–110, 50–90, 40, ≤ 0.09)` | the paper grain, 0–2 su specks (the sandbox's `buildLayers`; 1–2 before, operator 2026-10-15) |
| `stain` | `rgba(90,70,45, 0.04–0.09)` | the paper stains, radial |
| `vignette` | `rgba(14,11,9,.62)` at the edges | the edge vignette of the paper overlay |

## 2. The dungeon

| Name | Value | Used for |
|---|---|---|
| `stone` | `rgb(200,192,179)`, minus up to 20 per stone and 40 with depth | masonry stones |
| `stoneEdge` | `rgba(246,239,224,.5)` | the light line along a stone's top edge |
| `mortar` | `#35302a` | the gaps between stones |
| `pillar` | `#bdb3a0` | pillars and capitals |
| `hollow` | `#231e19` | deep arches, niches, openings |
| `bone` | `#ddd6c6`, `#e2dccd` | skulls, bones and rubble |
| `depth` | `rgba(14,11,9, 0 → .78)` | the darkness gradient on masonry, from 24 to 300 su below a top edge |
| `pit` | `rgba(14,11,9,0)` → `rgba(10,8,6,.97)` | chasms and pits |
| `farChain` | `rgba(14,11,9,.9)` | foreground hanging chains |

## 3. Light

| Name | Value | Used for |
|---|---|---|
| `torchlight` | `rgba(255,160,70,.3)` → transparent, radius 210 su | the halo of every torch |
| `flame` | `#e8872e` outer, `#ffd978` inner | torch flames, fireballs; *(step 3.6)* the altar candles and the potion's amber liquid |
| `shadow` | `rgba(10,8,6,.28)` at contact, fading with height | the contact shadow under the feet |

There is one warm light: torchlight. No other light source is coloured.

## 4. The timelines

| Name | Values | Used for |
|---|---|---|
| `streakRed` | `#6e0a10` wide pass, `#d8141d` core, glow `rgba(200,0,20,.8)`; eye glow `rgba(120,0,10,.7)` | the Savior and Future Akeris; the counter's aura (`../fx/counter/counter.md`); *(step 3.7)* the health bar of the Savior and of Future Akeris (`06-ui/hud/hud.md`) |
| `streakPurple` | `#3a1768` wide pass, `#8a4fe0` core, glow `rgba(140,70,230,.85)`; eye glow `rgba(90,30,160,.7)` | Corrupted Akeris only, and the intro's silhouette; *(step 3.7)* his health bar, with `paperLight` stripes (`06-ui/hud/hud.md`) |

Red and purple are never used for anything that is not a timeline. The health bar is one: it is the streak of whoever owns it. Nothing is blood-red.

## 5. Characters and gear

| Name | Value | Used for |
|---|---|---|
| `cape` | `#3d3934`, hatched `rgba(8,6,5,.5)` | Akeris's cape |
| `blade` | `#e4e1d9` | the sacred sword's blade |
| `hookBlade` | `#d2cdc2`, inner edge `rgba(245,240,228,.8)` | the chain blades |
| `leather` | `#b9ad95` | grips and straps |
| `straw` | `#bfb39b` body, `#c9bea7` head, `#8f8472` club | the sandboxes' training dummy only |
| `rock` | `#a39a8a` | thrown rocks |
| `wood` *(step 3.6)* | `#6e5f4d`, grain in `ink` at .45 | spear shaft, flail and hammer handles, scroll rods |
| `iron` *(step 3.6)* | `#5a554e`, hatched `rgba(8,6,5,.35–.4)` | spear socket and butt, flail ball, hammer head |
| `parchmentDark` *(step 3.6)* | `#ddd3bf` | the cursed scroll's paper |

## 6. Accents: shields and elements

| Name | Values | Used for |
|---|---|---|
| `sacred` | face `#dcd5c3`, gold `rgba(150,120,50,.85–.95)`; effects `rgba(196,160,72,1)` (`#c4a048`) | the sacred shield; its block sparks and reflect ring; *(step 3.6)* the coins |
| `ice` | face `#c3dbe4`, facets `rgba(60,110,140,.6)`, highlight `rgba(255,255,255,.8)`; effects `rgba(70,140,175,1)` | the ice shield; its sparks; the freeze shell (`../fx/freeze/freeze.md`); ice attacks and their frost (`../fx/elements/elements.md`) |
| `fire` | iron `#5d4637`, emblem `#e0782c` and `#ffd166`; effects `rgba(224,120,44,1)`, embers `rgba(232,135,46,.75)` | the fire shield; fire attacks; burning (`../fx/burn/burn.md`) |
| `inkSmoke` | `ink` at .72–.88 | the counter's speed lines and ink smoke (`../fx/`) |
| `poison` *(step 3.14, approved 2026-10-03)* | liquid `#7a8638`, deep `#4d5527`, drips `#a6b04c`, glow `rgba(150,170,60,.55)` | a bile yellow-green: the poison pools of zone 4 and their faint glow, the drips on a poisoned body, the HUD chip *Envenenado* (`04-zones/zone-4-rotting-canopy/biome.md` §A.3); the Giant Spider's venom and the Spore Pod will take it (their steps) |

Slow, levitation and stun get their accents with the enemies and bosses that cause them
(steps 3.10–3.15); until then they are drawn in graphite (the zone 4 webs are `paperLight`).
