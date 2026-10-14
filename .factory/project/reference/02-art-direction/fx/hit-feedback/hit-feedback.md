# Hit feedback

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Mechanics (Hit feedback), §Art direction · `../../ART_DIRECTION.md` §2 (version
  1 §10–§11) · the Akeris and art direction sandboxes (`spark`, `burst`, `spawnDust`, `drawTrail`, `hitPlayer`)
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png): a slash, a chain strike, the three shields blocking, a burn
- **Read by:** every task that shows a hit, a block or a landing.

**No screen shake anywhere.** Impact is sold by the following, and only by them.

---

## 1. The pieces

| Piece | Rule |
|---|---|
| **Hitstop** | the game holds still 0.05–0.06 s when a hit lands or is blocked; 0.07 s on a reflect, 0.09 s when a counter starts |
| **Callout** | a hand-lettered word at the hit (`../callouts/callouts.md`) |
| **Sparks** | 7–16 radial strokes, 2 wide, that fly out 14–50 and fade within 0.18–0.28 s; ink, or the shield's accent on a block |
| **Dust puffs** | seeded circles that grow 2.4× and fade within 0.45–0.75 s, filled `rgba(212,204,190,.9)`, outlined `ink` at .6 |
| **Blade trail** | only during a strike's active frames: a band between the blade's tip and its middle, sampled from the real tip path over 12 steps, `rgba(70,66,60)` fading from .28, with the tip line at .5 |
| **Contact shadow** | an ellipse under the feet, `shadow`, shrinking and fading as the body rises (gone at 300 above the floor) |

Particles may move randomly; their shapes are seeded per particle, so none flickers.

## 2. When each one plays

| Event | Hitstop (s) | Sparks | Callout | Other |
|---|---|---|---|---|
| Akeris's melee hit lands | 0.06 | 7, ink | `slash` (the thrust: `thud`) | the target recoils; the trail is already on |
| Akeris's chain strike lands | 0.05 | 7, ink | `slash` | — |
| a chain hooks a ring / bites a wall | — | a few, ink | `chain` / `clack` | chips of stone at the wall |
| blocked, sacred shield | 0.05 | 9, `sacred` | `clang` | the `blockHit` push |
| blocked, ice shield | 0.05 | 11–12, `ice` | `crish` | against a melee hit, the attacker is frozen 1.5 s (`../freeze/freeze.md`) |
| blocked, fire shield | 0.05 | 12, `fire`, longer | `fwoom` | against a melee hit, the attacker burns 1.5 s (`../burn/burn.md`); only this shield blocks fire |
| a shield's last use is spent | — | 16, long, in its colour | `crack` | shards; Akeris is staggered (`hurt`) |
| **perfect block, melee, sacred shield** | 0.09 | 16, ink, long | `counter` | the counter (`../counter/counter.md`); with the ice or fire shield a perfect block is drawn as their plain block |
| **perfect block, projectile** | 0.07 | 12, shield colour | `reflect` | the projectile flies back (`../reflect/reflect.md`) |
| a reflected projectile hits its thrower | 0.05 | 12, ink (fire: `fire`; ice: `ice`) | `thud` | it damages the thrower, which recoils; reflected with the ice shield it also freezes it 0.5 s, with the fire shield it burns it 0.5 s |
| Akeris is hit | 0.06 | 7, ink (fire: 12, `fire`; ice: 12, `ice`) | `thud` (fire: `burn`; ice: `frost`) | `hurt` pose and knockback. A fire attack blocked with any shield but the fire one, or an ice attack with any but the ice one, is a hit (`../elements/elements.md`) |
| fast descent lands | 0.05 | — | `thud`, larger (50) | a big dust puff on each side |
| an enemy is defeated | — | — | — | ink smoke (`../ink-smoke/ink-smoke.md`) |

How each shield is drawn when raised is Akeris's (`../../../03-characters/akeris/animations.md` §6).
Which attacks a shield stops and how many uses it has are the game's (`VISION.md` §Mechanics). Only
the fire shield blocks fire attacks; the ice shield will block ice attacks when the game has any.
