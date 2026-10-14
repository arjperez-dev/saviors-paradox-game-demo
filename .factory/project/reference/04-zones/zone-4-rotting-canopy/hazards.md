# Zone 4 — Rotting Canopy: hazards

- **Status:** approved 2026-10-06 (the torch in the hand, Z49); approved 2026-10-03 before that (step 3.14)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → charcos, ramas, telas, cortina, hueco*;
  *Volver a poner telas, antorchas y raíces*; *Escudo: de fuego (X)* and *Bola de fuego (O)* to burn webs) ·
  **Captures:** [`veneno`](sandbox/captures/veneno.png), [`liana`](sandbox/captures/liana.png),
  [`lianaSiguiente`](sandbox/captures/lianaSiguiente.png), [`tela`](sandbox/captures/tela.png),
  [`antorcha`](sandbox/captures/antorcha.png), [`cortina`](sandbox/captures/cortina.png),
  [`raiz`](sandbox/captures/raiz.png), [`raizCae`](sandbox/captures/raizCae.png),
  [`antorchaMano`](sandbox/captures/antorchaMano.png), [`antorchaTela`](sandbox/captures/antorchaTela.png),
  [`antorchaDeja`](sandbox/captures/antorchaDeja.png)
- **Sources:** `VISION.md` §Scope (poison pools, vines to swing over poison, torches that burn webs, roots),
  §Bosses (floor webs slow and are burned by the fire shield), §Mechanics (status effects: slow, poison) ·
  `01-story/dialogue/zone-4.md` («Mind the pools», «Keep away from the white threads», «Fire does not care for
  webs») · `00-game/controls.md` §3.1 (hanging from a ring, whose mechanic the vine follows) · `05-items/scrolls/`
  (the curse) · the operator's answers (2026-10-03) · the operator's decision of 2026-10-06: «se permiten agarrar las
  antorchas con la mano así Akeris las puede usar para quemar siempre que sea necesario»; they are not thrown
- **Read by:** the tasks that build the hazards; the tester; the contracts of the zone 4 enemies and of the Giant Spider

The list is closed: the zone 4 hazards are the poison pools, the floor webs and curtains, the rotten roots; the
vines and the torches are the zone's aids, listed here because they belong to the same mechanics. The spores and
the darkness are the biome, not hazards (`biome.md` §A.4).

| Hazard | Where | Telegraph (s) | Effect on the player | Look | Sound |
|---|---|---|---|---|---|
| **poison pool** | `pools` (two, 600 su), `boughs` (three, under the roots), `clearing` (240 su), `poolEnd` (200 su); `layout.md` §B.3 | none: always visible (the poison glows faintly, spores rise over it) | **can be waded** (operator, 2026-10-03): the bottom is 64 su below the edge, the poison covers Akeris to the knees, he moves at **60 %** and climbs out with a jump. Inside and for **2 s** after he is **poisoned**: he loses **1** health every second, the first 0.5 s after stepping in (sandbox numbers; **the game decides**). The HUD shows the chip *Envenenado*. With a curse active, the first bite kills him. Better to jump a short one or cross a long one by the vines | `sheet.png`: pool; `veneno.png` | `sfx.zone4.wade` on stepping in, `sfx.zone4.poison` on each bite |
| **floor web** | `webs` (620 su), `hollow` (500 su), `nest` (340 su) | none: always visible | walking or running in it, Akeris goes at **40 %** and for **0.5 s** after (the HUD chip *Lento*). The **fire shield**, equipped, burns the web as soon as he touches it; a fallen **torch** or any fire projectile burns it too. It burns from where it caught to both ends in **0.6 s** and **does not come back** in the run | `tela.png`, `antorcha.png` | `sfx.zone4.webStick` on stepping in, `sfx.zone4.webBurn` |
| **web curtain** | `webEnd`: it closes the dead end, floor to ceiling | — | **solid**: it stops Akeris. It burns as the floor web (fire shield touching it, a torch, fire) and, burnt, never comes back. Behind it waits what the dead end holds (an altar, the lore spirit or a lookout) | `cortina.png` | `sfx.zone4.webBurn` |
| **rotten root** | `boughs` (two of its four roots) | **0.8**: standing on it, it creaks, sags and cracks | it snaps and falls (into the poison below); Akeris falls with it. **6 s** later a new root grows down slowly (1.2 s) into its place and is solid again (it waits if Akeris is in the way). Never the only way: the pools below can be waded and the other roots hold | `sheet.png`: rotten root; `raiz.png`, `raizCae.png` | `sfx.zone4.rootCreak`, `sfx.zone4.rootSnap` |

## The aids

| Aid | Where | How it works |
|---|---|---|
| **vine** (proposal Z44, operator 2026-10-03: «con las manos, no con las espadas, pero que siga la misma mecánica: saltas y tienes que hacer clic para que Akeris se agarre») | `pools`: two over each pool, 280 su apart, hanging 360 su from a ceiling 640 su above the floor | **jump and left click** with Akeris's shoulder within **120 su** of a vine: he grabs it **with his hand**, with **any weapon** equipped, and swings as from a ring (`controls.md` §3.1): **A / D** swing, **Space** lets go with the swing's speed, **S** drops, **left click** grabs the next vine if his free hand is within 150 su of it (hand over hand, forward only). His free hand holds the **shield** (right click blocks; the just block opens the hanging counter as on a ring); with the hook blades, its hook blade, as on a ring (the wheel swaps). The weapon goes to the back (the sword sheathed; the spear and the hammer across the back). He cannot drink or strike with the weapon while hanging. The pendulum length is where he grabbed (90 su to the vine's length); let go, the vine keeps swinging and slows down. A wall stops the swing and drops him |
| **torch** (proposal Z45) | 1–4 per room (`tc`), planted in the floor; in `webs`, `hollow` and `webEnd` beside the web | a **weapon blow** or the **chain** knocks it over **toward where it is hit**; it falls in about 0.45 s, lies on the floor and keeps burning (its light goes with the flame). If its flame lands within 70 su of a floor web, or 90 su of a curtain, it sets it alight. It never stands up again in the run. **In the hand (Z49):** **G** next to a planted or fallen torch (90 su from a planted one, 115 from the middle of a fallen one; an altar in reach comes first) takes it in the free hand: it lights 400 su as planted and its flame rides above Akeris's head. **It burns the web or curtain Akeris touches** (as the fire shield) and **whatever its flame touches**: spiderlings, mantises, spore pods, the raised stem of a strangler vine, a spore cloud. **While he carries it he cannot raise the shield** (the shield is put away); he can roll, jump, strike, use the chain and swing on a vine. **G** again lays it down in front of him, lying and burning (it lights the web or curtain its flame lands on). **A hit makes him drop it** (it falls burning where he is), and so does being caught by a strangler vine, falling into a pool or taking an item from an altar. It is never thrown (operator) |

**Last firm ground:** as zones 1–3; a pool's bottom never counts as firm ground.

## Proposals for the operator (Z43–Z46)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z43 | The poison pool | wades to the knees at 60 %; poisoned inside and 2 s after, −1 a second (the first at 0.5 s); the chip *Envenenado*; jump short ones, vine over long ones |
| Z44 | The vine | jump + click, the hand (any weapon); the ring's swing: A/D, Space, S, click to the next; the free hand holds the shield |
| Z45 | Webs and torches | floor webs slow to 40 %; curtains are solid; fire shield, torches and fire burn them in 0.6 s, for the run; a blow or the chain knocks a torch toward the hit |
| Z46 | The rotten root | creaks 0.8 s, snaps, falls; regrows after 6 s in 1.2 s; never the only way |
| Z49 | The torch in the hand (operator, 2026-10-06) | G takes it and lays it down; it burns what Akeris touches and what its flame touches; no shield while carried; a hit drops it; never thrown |

## Never

- A pool that kills outright (except with the curse), or that Akeris cannot climb out of with a jump.
- A vine that needs the hook blades, or that catches Akeris without a click.
- A web or curtain that comes back once burnt, or a curtain in front of the main path.
- A rotten root that is the only way across.
- A torch that falls by itself.
- A torch carried with the shield raised, or thrown.

## Acceptance

1. In a pool Akeris moves at 60 % and is poisoned: −1 health a second inside and for 2 s after, the chip shows; with a curse, the first bite kills.
2. Jumping and clicking near a vine, with any weapon, Akeris grabs it; A/D swing; click grabs the next; Space lets go keeping the speed.
3. In a floor web Akeris moves at 40 % and for 0.5 s after; the fire shield burns it on touching it.
4. A blow or the chain knocks a torch toward the hit; fallen, it sets alight the web or curtain its flame touches; burnt, they never come back in the run.
5. A curtain stops Akeris until it burns.
6. A rotten root creaks 0.8 s under Akeris and falls; it grows back after 6 s.
7. G takes a torch (`antorchaMano.png`); carried, the web Akeris walks into burns (`antorchaTela.png`); the shield cannot be raised; G lays it down burning (`antorchaDeja.png`); a hit drops it. Tested with `ztFuzz()` (24 runs of 40 s in every room with torches: 2026-10-06, without failures).
