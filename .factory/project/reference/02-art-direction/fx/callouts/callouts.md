# Callouts

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Mechanics (Counter, Hit feedback) · `../../../00-game/tone.md` §1 · the FX
  sandbox (`CALL`, `popText`, key `O`; screenshot [`onomatopeyas.png`](../../sandbox/onomatopeyas.png))
- **Sprites:** [`sprites/sheet.png`](sprites/sheet.png) · one transparent PNG per callout and language, `sprites/<key>.en.png` and `sprites/<key>.es.png` (§3)
- **Read by:** every task that shows a callout; the `localization` feature for the texts.

A callout is a hand-lettered onomatopoeia or word at a hit. Callouts are the only place the game
shouts (`../../../00-game/tone.md` §1). They are player-visible text, so each one is a translator key
with an English and a Spanish text; neither is a translation of the other, each is the sound in its
own language.

---

## 1. The list

A closed list: a callout not here does not exist.

| Key | English | Español | When (`../hit-feedback/hit-feedback.md` §2) |
|---|---|---|---|
| `callout.slash` | SLASH! | ¡ZAS! | a slash or a chain strike lands |
| `callout.thud` | THUD! | ¡PUM! | a thrust lands; Akeris is hit; the fast descent lands; a reflected projectile hits its thrower |
| `callout.chain` | CHAIN! | ¡CADENA! | a chain hooks a ring |
| `callout.clack` | CLACK! | ¡CLAC! | a chain bites a wall |
| `callout.clang` | CLANG! | ¡CLANG! | the sacred shield blocks |
| `callout.crish` | CRISH! | ¡CRIS! | the ice shield blocks |
| `callout.fwoom` | FWOOM! | ¡FUUM! | the fire shield blocks |
| `callout.crack` | CRACK! | ¡CRAC! | a shield's last use is spent |
| `callout.burn` | FWAAH! | ¡FUAAH! | Akeris is hit by fire |
| `callout.frost` | BRRR! | ¡BRRR! | Akeris is hit by ice (`../elements/elements.md`) |
| `callout.counter` | COUNTER! | ¡CONTRA! | a counter starts (`../counter/counter.md`) |
| `callout.reflect` | WHOOSH! | ¡FIUU! | a projectile is reflected (`../reflect/reflect.md`) |

Enemies' and bosses' own callouts (a screech, a roar) are added here with their contracts.

## 2. How a callout is drawn

- Hand lettering (`../../strokes/strokes.md` §3), filled `paperLight`, outlined `ink` 6 wide, round-joined.
- **Size:** 44 by default; 40 on a block, 30–34 for the chain's; 50 for the fast descent; **60** for
  `counter`.
- **Life:** 0.9 s (1.1 s for `counter`). It scales from 1.5 to 1 over the first 10 % of its life,
  drifts up 14, and fades after 60 %.
- **Tilt:** a fixed tilt of up to ±0.125 rad, chosen once when it appears; it never wobbles.
- **Place:** above the hit, 70–90 above the point of contact; the counter's above Akeris's head.
- At most one callout per hit. A second hit on the same frame shows only the larger.

## 3. Sprites

Each callout is exported from the art direction sandbox (`#exportar-onomatopeyas`) as its own PNG with
a transparent background, at twice its game size (88 px for the default 44, 120 px for `counter`),
named `<key>.<language>.png`: `counter.en.png`, `counter.es.png`… These are the reference for the
lettering; the game draws its callouts with its own font (`../../strokes/strokes.md` §3) and holds
them against these PNGs. `sprites/sheet.png` shows all of them side by side.
