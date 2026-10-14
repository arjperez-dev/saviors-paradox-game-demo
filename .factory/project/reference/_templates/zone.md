<!--
Template: zone (biome). One folder per zone: 04-zones/zone-N-<biome>/.

Files:
  biome.md       part A of this template; always
  layout.md      part B; always
  hazards.md     part C; always
  boss-room.md   part D; always
  sandbox.html   a playable slice of the biome, built from the Akeris sandbox, with Akeris in it; always
  sheet.png      the biome sheet exported from the sandbox: tiles, props, layers, hazards; always

The enemies and the boss of the zone have their own contracts under 03-characters/ and are only
listed here. Rules: every number has a unit; gameplay numbers come from VISION.md or are marked
"the game decides"; every list is closed. Delete these comments.
-->

# Zone <N> — <Biome name>

- **Status:** draft · review · approved <YYYY-MM-DD>
- **Sandbox:** [`sandbox.html`](sandbox.html) · **Sheet:** [`sheet.png`](sheet.png)
- **Sources:** `VISION.md` §<sections> · `01-story/zones-narrative.md` §<zone> ·
  `02-art-direction/ART_DIRECTION.md` §<sections>

---

## Part A — `biome.md`

### A.1 Identity

<Two or three sentences: what this place is, what it feels like, what the player must understand the
moment they arrive.>

### A.2 Layers, back to front

| Layer | Contents | Parallax factor | Palette and hatching |
|---|---|---|---|
| far background | | | |
| far wall | | | |
| play layer | | 1 | |
| foreground | | | |

### A.3 Tiles and masonry

| Tile kind | Size (tiles) | How it is drawn | Variants |
|---|---|---|---|
| <solid, platform, drifting platform, ledge…> | | never as an outlined tile | |

### A.4 Props and light

| Prop | Where it appears | Light it casts | Moves? |
|---|---|---|---|
| | | | only real motion; nothing trembles |

### A.5 Ambient effects and sound

| Effect or sound | Where | Id |
|---|---|---|
| <dust, fog, music cue, ambience loop> | | `07-audio/…` or `02-art-direction/fx/…` |

### A.6 Enemies and boss

| Enemy | Contract |
|---|---|
| <name> | `03-characters/enemies/zone-N/<name>/contract.md` |
| **boss:** <name> | `03-characters/bosses/<name>/contract.md` |

### A.7 Never

- <The likely mistakes, stated so they can be checked.>

---

## Part B — `layout.md`

### B.1 Size and shape

| Measure | Value | Source |
|---|---|---|
| zone size (rooms or tiles) | | `VISION.md` §<n> |
| room size (tiles) | | |
| number of rooms | | |

### B.2 How it is generated

<The algorithm in steps: from which seed, which room kinds exist and how many of each, how rooms
connect, what guarantees the path to the boss exists, what varies between runs and what never
does. Deterministic: the same seed gives the same zone.>

### B.3 Room kinds

| Kind | Size (tiles) | Contents | How many per zone |
|---|---|---|---|
| start | | | 1 |
| <combat, traversal, rest, secret…> | | | |
| boss | | Part D | 1 |

---

## Part C — `hazards.md`

| Hazard | Where | Telegraph (s) | Effect on the player | Look | Sound |
|---|---|---|---|---|---|
| <abyss, falling rubble…> | | | copied from `VISION.md` or "the game decides" | | |

---

## Part D — `boss-room.md`

- **Size (tiles):** <w × h>
- **Entry:** <how the room seals, what the player sees first, the cinematic if any>
- **Arena:** <platforms, hazards, what changes between phases>
- **Exit:** <what opens after the boss falls>

---

## Acceptance

What the operator checks in the game, side by side with the sandbox.

1. <The layers of A.2 appear in order and scroll at their parallax factors.>
2. <Two runs with the same seed produce the same zone; two seeds produce different ones.>
3. <…>
