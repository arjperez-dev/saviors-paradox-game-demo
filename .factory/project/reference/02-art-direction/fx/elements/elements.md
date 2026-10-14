# Fire and ice attacks

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Mechanics (Shields: the fire shield blocks fire attacks) · the operator,
  2026-09-30 (`../../../00-game/controls.md` §5 G16): only the fire shield blocks fire attacks without
  Akeris taking damage, and only the ice shield blocks ice attacks; ice attacks are defined now · the
  art direction sandbox (`spawnShot`, `hitPlayer`, `drawIceShard`; frame sheets below)
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png): a fireball and an ice shard against each of
  the three shields · [`sprites/sheet-ice.png`](sprites/sheet-ice.png): an ice shard reflected by the
  ice shield
- **Read by:** every task that draws an enemy's fire or ice attack, or Akeris blocking one.

Some attacks are **fire** and some are **ice**; every other attack is **plain**. Which enemies and
bosses have fire or ice attacks is written in their own contracts (the dragon and the drakeling have
fire in `VISION.md`); this file says how they look and how each shield meets them.

---

## 1. Which shield stops what

| Attack | Sacred shield | Ice shield | Fire shield |
|---|---|---|---|
| plain | stops it | stops it | stops it |
| **fire** | does not stop it: Akeris takes the hit | does not stop it: Akeris takes the hit | **stops it**, no damage |
| **ice** | does not stop it: Akeris takes the hit | **stops it**, no damage | does not stop it: Akeris takes the hit |

A shield that does not stop an attack is drawn as no block at all: the `hurt` pose, the knockback,
and the element's callout (`burn` for fire, `frost` for ice). A shield that stops it is drawn as its
block (`../hit-feedback/hit-feedback.md` §2). A perfect block with the shield that stops it reflects
the projectile (`../reflect/reflect.md`).

Shield uses are the game's (`VISION.md` §Mechanics: the fire shield lasts 4 dragon blasts, the ice
shield 10 hits).

## 2. How they look

| Attack | Look | While it flies |
|---|---|---|
| fireball | a `flame` circle (radius 12) with a `flame (inner)` core (6.5), outlined in `ink` 1.6, in a `torchlight` glow of radius 46 | embers: small fire-coloured puffs left behind, about 15 a second |
| **ice shard** | an elongated crystal 46 long and 14 wide, flying point first: `ice` fill, outlined in the ice facet colour 1.7, a facet line along it and a crossing one, and a white highlight near the point | frost: small pale-ice puffs (`rgba(195,219,228,.8)`) left behind, about 15 a second, falling slightly |

Both are seeded once per projectile; neither flickers. A breath or a wave of fire or ice (the
dragon's breath) is drawn with the same colours and particles, in its own boss contract.

## 3. When Akeris is hit by one

| Attack | Sparks | Callout | Akeris |
|---|---|---|---|
| fire | 12, `fire` | `burn` | `hurt` pose and knockback |
| ice | 12, `ice` effects | `frost` | `hurt` pose and knockback |

Whether Akeris himself burns or freezes after such a hit is the game's; if he does, he is drawn with
the same flames or shell as an enemy (`../burn/burn.md`, `../freeze/freeze.md`), at his own size.
