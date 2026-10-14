# Potion

- **Status:** approved 2026-09-30 (step 3.6)
- **Kind:** satchel
- **Images:** [`icon.png`](icon.png) (full) · [`icon-empty.png`](icon-empty.png) (an empty place in the quick inventory)
- **In his hands:** `03-characters/akeris/animations.md` §5.2 (drinking), [`sheet-drink.png`](../../03-characters/akeris/sprites/sheet-drink.png)
- **Sources:** `VISION.md` §Mechanics (Potions) · `00-game/controls.md` G8, G9 · `03-characters/akeris/mechanics.md` P3 · [`../items.md`](../items.md) I12

## 1. What it is

A small round flask he carries at the hip. He carries **3**, refilled on entering each zone
(`VISION.md`); hold F to drink one (never while hanging).

## 2. Look

A round flask of glass (`paperLight` `#efe6d6`, outline `ink` 1.7) with a short neck and a leather
stopper (`leather`); the **liquid is amber**: the torch flame's outer `#e8872e` with a band of its
inner `#ffd978` (I12: light in a bottle, no new colour), and a white glint on the glass. While he
drinks, the liquid drops from full to empty.

## 3. What it does

Heals; how much, and how long drinking takes, are the game's (`akeris/mechanics.md`). Releasing F
before the sip cancels it without spending the potion (P3). Potions are not found on altars.

## 4. Icons, sound and text

[`icon.png`](icon.png), [`icon-empty.png`](icon-empty.png): the flask upright. `item.potion.name`:
Potion / Poción. Sound: `sfx.akeris.drink`.

## 5. Acceptance

1. The quick inventory shows 3 flasks; each drink empties one; a new zone fills them.
2. The flask he drinks from is amber, as `icon.png`.
