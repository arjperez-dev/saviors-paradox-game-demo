# Pillars

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Vision statement, §Core loop, §Success criteria, §Risks, §Client
  constraints, §Art direction
- **Read by:** the architect and the planner, to weigh a choice the vision does not settle; the
  translator, to keep `VISION.md` faithful to them. A task cites this file only when a criterion
  depends on a pillar.

Five things the game is. When two ways of building something both satisfy `VISION.md`, the one that
serves these pillars better wins. A pillar never overrides a number, a control or a rule of
`VISION.md` or of another approved reference; it breaks ties.

---

## 1. A drawing that holds still

The game is a pencil drawing on old paper that has come to life. Every stroke is drawn once and
stays exactly as it was drawn; only things that really move, move. Nothing trembles: no line boil, no
per-frame jitter, no screen shake.

- **Serves it:** static seeded strokes, masonry drawn by hand, weight shown by pose and timing,
  hitstop instead of shake.
- **Betrays it:** any effect that wobbles, flickers or shakes the camera to sell an impact; outlined
  tiles; anything that looks crude or childish (`VISION.md` §Risks, the operator's main concern).

## 2. Every fight is read, not mashed

Combat is a duel. Enemies and bosses show what they are about to do, and the player answers with the
right tool: a block, a roll, a jump, a chain throw. Blocking a blow at the last moment is rewarded
with the counter; blocking a projectile at the last moment sends it back at its thrower. Each enemy
may look like another, but none fights like another.

- **Serves it:** readable wind-ups, one clear answer per attack (blockable or not, dodge or block),
  hit feedback that confirms what happened (hitstop, callouts, sparks).
- **Betrays it:** damage the player could not see coming, two enemies with the same behaviour in a
  different skin, attacks that can only be out-traded.

## 3. The chain is the other hand

The chain blades are always there, and they are how Akeris fights at range, crosses the dungeon and
takes bosses apart: throw, pull, snatch, hook, climb, swing, anchor. A new room, enemy or boss is a
new question for the chain.

- **Serves it:** rooms with rings, walls and gaps; enemies with something to snatch; bosses with parts
  to hook and a chain finisher.
- **Betrays it:** content that ignores the chain, or a chain use that exists but is never needed.

## 4. Each descent is new; the spirits remember

Every run rebuilds every zone: nothing is where it was. Death wipes the run and the slot. What
carries over is the story: the spirits remember Akeris, and each run reveals more of who he is.

- **Serves it:** procedural generation from the run's seed, rewards for exploring, spirits whose
  words change with past runs.
- **Betrays it:** hand-placed layouts that repeat, progression that survives death, lore that is the
  same every time.

## 5. Quiet, melancholic, eerie

The dungeon is dark and old, and so is its sound: muted music, processed ancient voices, silence
around the torches. The game is for all ages; it unsettles, it does not shock. See `tone.md`.

- **Serves it:** restraint in colour, sound and text; one warm light; the red streak of the eye.
- **Betrays it:** gore, jokes, loud or triumphant music, bright colour outside the allowed accents
  (`02-art-direction/palette.md`).
