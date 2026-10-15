# Art direction

- **Status:** approved 2026-09-30 · 2026-10-15: §3, the scale the architect fixed in `change-02`
- **Sources:** `VISION.md` §Art direction, §Client constraints, §Risks · `../00-game/pillars.md` §1, §5 ·
  `../00-game/tone.md` §2 · the approved Akeris sandbox (2026-09-29, six iterations)
- **Read by:** every task that draws anything. This file holds the rules every drawing obeys and says
  where each part of the look is written down.

Version 2 (step 3.4 of the plan). Version 1, approved 2026-09-29, was one long file; it is now split
into the folders of §4 without changing a rule or a number, and the effects of `fx/` are added. Each
part has its own folder: its `.md` and the PNGs exported from the sandbox beside it.

---

## 1. Authority and scope

- **How things look and move** is decided by the approved sandboxes; these files state their rules
  and numbers so that a session without a browser can use them. Where a file and its sandbox
  disagree on how something looks or moves, the sandbox wins and the file has a defect to fix.
- **Nothing here changes a control or a gameplay number.** Controls are `../00-game/controls.md`;
  speeds, jump, gravity, roll time and invulnerability, hitboxes, ranges, cooldowns, shield uses and
  timing windows are the game's. A sandbox has its own simple physics and its own keys so that its
  drawings can be judged; they are stand-ins, never targets.
- **Animation adapts to gameplay, never the reverse.** A timed animation is stretched to the duration
  the game logic gives it; a drawn crouch fits the game's crouching height without changing the
  hitbox.
- A rule that reads like a mechanic (what a shield stops, what a perfect block does) describes what a
  sandbox shows so that it can be drawn. Where it differs from `VISION.md`, `VISION.md` wins and the
  difference is reported to the operator.

## 2. Hard rules

1. **Nothing on screen trembles.** No line boil, no per-frame jitter, no screen shake. Every stroke
   keeps its hand-drawn irregularity, but that irregularity is generated **once** from a seed fixed to
   the stroke and is the same in every frame. Only real motion moves: characters, cape, chains,
   projectiles, particles, torch flames (a slow sway, not a flicker). A stroke that disappears
   disappears whole, or is eaten by a shape that grows (`fx/ink-smoke/ink-smoke.md`); it never flickers out.
2. **Pencil on old paper.** Ink lines, graphite hatching, a paper texture over everything. The only
   colours are those of `palette/palette.md`: warm torchlight, the red eye streak (purple for the corrupted
   timeline), and the ice-blue, fire and gold accents of the shields and their effects.
3. **The dungeon is masonry,** never outlined tiles (`dungeon/dungeon.md`).
4. **Determinism holds.** Stroke seeds come from stable ids (entity id, part index, tile-run index),
   never from time or an unseeded random generator. Animation advances with `dt` only. Particles may
   move randomly, but their **shapes** are seeded per particle, so none of them flickers.
5. **Dark and refined, not crude.** Stick figures with round heads, drawn with care: proportions,
   weight and silhouette read as eerie, never childish (`VISION.md` §Risks).
6. **Death is ink.** No blood and no gore. Defeated enemies dissolve into ink smoke
   (`fx/ink-smoke/ink-smoke.md`); nothing is left behind.

## 3. Units and scale

The sandboxes work in **sandbox units (su)**: Akeris standing is **192 su** tall and the view is
600 su tall at zoom 1. Every number in these files is in su unless it says otherwise. To use one in
the game, multiply it by **k = Akeris's standing height in world units ÷ 192**; that applies to
lengths, stroke widths, offsets and speeds alike.

- **On-screen size:** Akeris is **≈ 26 % of the screen height** (192 su in a 750 su view, the
  sandbox's "medio" zoom). The architect fixed how the game reaches it (architect `change-02`, operator 2026-10-15): **k = 1** — one su is one
  world unit, so a tile of 32 su is 32 world units — and the camera's view is **750 world units tall**,
  its width following the screen's aspect with no letterbox (about 1333 at 16:9). Akeris is 25.6 %.
- **Crouching and rolling:** in the sandbox the crouch pose's head top is ≈ 136 su and the roll ball
  has a radius of 55 su. If the game's crouching height is lower, the drawn crouch and roll are
  lowered to fit it; they keep their character (the head up, the kneeling back leg, the curled
  ball), and the hitbox does not grow.

## 4. Where each part lives

```text
02-art-direction/
├── ART_DIRECTION.md          this file
├── palette/                  palette.md · palette.png (every colour, swatched)
├── strokes/                  strokes.md · strokes.png (the primitives, the widths, the lettering)
├── dungeon/                  dungeon.md · dungeon.png (the sandbox's test room, not zone 1)
├── fx/
│   ├── hit-feedback/         hit-feedback.md · sprites/sheet.png
│   ├── callouts/             callouts.md · sprites/sheet.png and one transparent PNG per callout and language
│   ├── counter/              counter.md · sprites/sheet.png (sacred sword), sheet-blades.png (chain blades)
│   ├── reflect/              reflect.md · sprites/sheet.png (a rock), sheet-fire.png (a fireball)
│   ├── freeze/               freeze.md · sprites/sheet.png (the ice shield's block)
│   ├── burn/                 burn.md · sprites/sheet.png (the fire shield's block)
│   ├── elements/             elements.md · sprites/sheet.png (fire and ice against each shield), sheet-ice.png
│   └── ink-smoke/            ink-smoke.md · sprites/sheet.png
└── sandbox/                  sandbox.html · a screenshot per scenario
```

| Part | File | What its PNGs show |
|---|---|---|
| colours | [`palette/palette.md`](palette/palette.md) | `palette.png`: each colour with its name and value, over hatching so its alpha shows |
| the static stroke, widths, lettering | [`strokes/strokes.md`](strokes/strokes.md) | `strokes.png` |
| the dungeon: layers, camera, masonry, torches | [`dungeon/dungeon.md`](dungeon/dungeon.md) | `dungeon.png`: the sandbox's test room with Akeris for scale, **not zone 1's design**; each zone's own sandbox adds its biome (`04-zones/`) |
| hit feedback: hitstop, sparks, dust, blade trail, contact shadow, blocks | [`fx/hit-feedback/hit-feedback.md`](fx/hit-feedback/hit-feedback.md) | `sprites/sheet.png`: a slash, a chain strike, the three shields blocking, a burn |
| callouts | [`fx/callouts/callouts.md`](fx/callouts/callouts.md) | `sprites/sheet.png`, and `sprites/<key>.<en\|es>.png`: each callout alone, transparent, at twice its game size |
| the counter | [`fx/counter/counter.md`](fx/counter/counter.md) | `sprites/sheet.png`, `sprites/sheet-blades.png`: six frames with their times |
| reflecting a projectile | [`fx/reflect/reflect.md`](fx/reflect/reflect.md) | `sprites/sheet.png` (sacred), `sheet-ice-shield.png` (freezes), `sheet-fire-shield.png` (burns), `sheet-fire.png` (a fireball): from the block to the hit on the thrower |
| freeze | [`fx/freeze/freeze.md`](fx/freeze/freeze.md) | `sprites/sheet.png`: the ice shield blocks, the attacker freezes, the ice breaks |
| burn | [`fx/burn/burn.md`](fx/burn/burn.md) | `sprites/sheet.png`: the fire shield blocks, the attacker burns and loses health |
| fire and ice attacks | [`fx/elements/elements.md`](fx/elements/elements.md) | `sprites/sheet.png`: a fireball and an ice shard against each shield; `sprites/sheet-ice.png`: an ice shard reflected |
| ink smoke | [`fx/ink-smoke/ink-smoke.md`](fx/ink-smoke/ink-smoke.md) | `sprites/sheet.png`: six frames over 1.6 s |
| Akeris: rig, gait, state changes, cape, eye and streak, gear, chain blades, shields | [`../03-characters/akeris/animations.md`](../03-characters/akeris/animations.md) | his `sprites/` and `weapons/` (step 3.5) |

A frame sheet is six crops of the sandbox with the time of each, left to right, top to bottom. It is
exported from the sandbox, never drawn by hand; when the sandbox changes, the sheet is exported again.

**Sandboxes:**

- **Akeris** — [`../03-characters/akeris/sandbox/sandbox.html`](../03-characters/akeris/sandbox/sandbox.html),
  approved 2026-09-29.
- **Art direction** — [`sandbox/sandbox.html`](sandbox/sandbox.html): the Akeris sandbox plus a
  training dummy with ten health marks over its head. It swings a club (`M`), throws a rock, a
  fireball or an ice shard (`G`, `H`, `I`), takes damage from Akeris's hits, from the counter and from its own projectiles
  reflected back at it, freezes when the ice shield blocks its club and burns when the fire shield
  does, and dissolves into ink smoke when its marks run out (or with `V`). `L` switches
  the callouts between English and Spanish and `O` shows their sheet. The dummy and its marks are
  sandbox tools, not an enemy or a HUD of the game.
  - Scenarios, screenshotted beside it: `#humo`, `#humo2`, `#contra`, `#contra2`, `#bloqueo3`,
    `#devolver`, `#devolver2`, `#devolver3`, `#congelar`, `#congelar2`, `#quemar`, `#hielo`, `#devolverHielo`, `#onomatopeyas`; and the element
    matrix `#fuegoSagrado`, `#fuegoHielo`, `#fuegoFuego`, `#hieloSagrado`, `#hieloFuego`, `#hieloHielo`. `#name@seconds` freezes a scenario at
    another instant.
  - Exports: `#hoja-contra`, `#hoja-contra2`, `#hoja-devolver`, `#hoja-devolver2`, `#hoja-humo`,
    `#hoja-congelar`, `#hoja-quemar`, `#hoja-devolverHielo`, `#hoja-devolverFuego`, `#hoja-hielo`,
    `#hoja-elementos`, `#hoja-golpes` (the frame sheets), `#paleta`, `#trazos`, `#sala`, and `#exportar-onomatopeyas`
    (the callout PNGs, written into the page).

## 5. Other characters

Enemies and bosses use the same primitives and the same static-stroke rule. Humanoid enemies (the
mace brute, the knights, the many-armed) reuse Akeris's skeleton, poses and crossfade, with their own
head and no cape. Each has its own contract in `03-characters/`.

## 6. Decisions

| # | Question | Decided (operator, 2026-09-30) |
|---|---|---|
| A1 | How are stroke widths chosen for enemies and bosses larger than Akeris? | scaled by their size ratio, capped at 1.6× (`strokes/strokes.md` §2) |
| A2 | Which hand-lettered font does the game bundle for callouts? | *Patrick Hand* (SIL Open Font License), bundled with the game (`strokes/strokes.md` §3) |
| A3 | The Spanish counter callout: *¡CONTRA!* or *¡CONTRAATAQUE!*? | *¡CONTRA!*: short enough to read in the 0.1 s it takes to land (`fx/callouts/callouts.md`) |
| A4 | The reflect callout: *WHOOSH! / ¡FIUU!*? | yes (`fx/callouts/callouts.md`) |
| A5 | The English slash callout: *SLASH!*? | yes; the Spanish stays *¡ZAS!* (`fx/callouts/callouts.md`) |
