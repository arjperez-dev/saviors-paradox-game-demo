# Scrolls

- **Status:** approved 2026-09-30 (step 3.6)
- **Kind:** scroll, read at once
- **Images:** [`icon-health.png`](icon-health.png) · [`icon-power.png`](icon-power.png) ·
  [`icon-cursed.png`](icon-cursed.png) · [`sheet-read.png`](sheet-read.png) (reading) ·
  [`sheet-cursed.png`](sheet-cursed.png) (the cursed scroll, its curse, the tenth kill and rage, death by a hit)
- **Sandbox:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html): three altars; scenarios `#leer`, `#maldito`, `#maldito2`, `#malditoMuerte`
- **Sources:** `VISION.md` §Mechanics (Scrolls), §Win / lose conditions · [`../items.md`](../items.md) I4–I7

## 1. What they are

Three per zone (`VISION.md`), each on an altar:

| Scroll | Seal and sign | Effect (`VISION.md`; amounts the game's) |
|---|---|---|
| health | amber wax (`flame`), a drop of light | raises maximum health and refills it (I5) |
| attack and ability | iron wax, two crossed blades | raises the damage of weapons and abilities (I5) |
| cursed | black ink wax that drips, a skull; ink stains, a darker parchment | the **cursed challenge**: kill 10 enemies without taking damage; any damage kills Akeris; success gives **rage** (an attack boost) for 3 min, ending early on a zone change |

## 2. Look

Rolled: a parchment 48 × 16 su (`paperLight`; the cursed one `parchmentDark` `#ddd3bf`), hatched
in graphite, with a rolled end and a wooden rod (`wood`) at each side, a band (`leather`; ink on the
cursed one) and the round wax seal with its sign. Open: a sheet up to 70 × 46 su between the rods,
with four lines of hand-drawn runes in ink and the sign at the top.

## 3. Reading (I4)

Picked up with G, a scroll is read at once, standing still (sandbox times; the game decides):

| Time (s) | What is drawn |
|---|---|
| 0 → 0.3 | the weapon swap to the hip: the weapon goes away, the rolled scroll comes out of the satchel into his front hand |
| 0.3 → 0.55 | both hands come up in front of his chest (head down 14); the scroll unrolls |
| 0.55 → 0.95 | he reads |
| 0.95 → 1.3 | the runes lift off the paper as ink motes and fly into his chest (dark and larger for the cursed one) |
| 1.3 → 1.5 | the effect applies; the empty paper crumbles into ink puffs |
| 1.5 → 1.8 | the swap back to the weapon he held |

## 4. The curse and rage

- **While cursed** (I7): a ring of 16 static ink thorns on the floor around his feet (62 × 13 su,
  `ink`, seeded once, following him) and, in the HUD, `item.curse.progress` with the count. Every
  enemy killed counts one. Any damage kills him at once, and the run is lost.
- **Curses add up** (D-I7): a shield repair started during the curse adds its 10 kills to the
  same count (4/10 becomes 4/20), and the other way round; the rewards all come at the end. The HUD
  lists what the count will give (`furia + reparar el escudo de hielo`). Scenario `#sumar`.
- **The last kill** (the tenth, or the total when curses add up) ends it: the ring breaks into ink puffs. After the scroll, **rage** starts: his
  eye streak burns 1.8× wider for its 3 min (I6); the HUD shows the time left.
- The shield repair's curse looks and works the same (`../shields/ice-shield/ice-shield.md` §5).

## 5. Sounds and text

`sfx.scroll.open`, `sfx.scroll.ink`, `sfx.scroll.crumble`, `sfx.curse.start`, `sfx.curse.tick`,
`sfx.curse.end`. Keys: `item.scroll.health.name`, `item.scroll.power.name`,
`item.scroll.cursed.name`, `item.curse.progress` (`../items.md` §9).

## 6. Never

- The cursed scroll never uses red or purple: its mark is ink.
- The runes are never readable words: they are hand-drawn marks, seeded once.

## 7. Acceptance

1. G on a scroll plays `sheet-read.png`; its effect applies when the paper crumbles.
2. The cursed scroll starts the ring and the counter; ten kills end it and start rage (the wider streak).
3. A hit during the curse kills Akeris, as in the last frame of `sheet-cursed.png`.
