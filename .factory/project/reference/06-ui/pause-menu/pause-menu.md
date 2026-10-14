# Pause menu (full inventory and stats)

- **Status:** approved 2026-09-30
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) (playable: Esc in the items hall) ·
  **Image:** [`pause-menu.png`](pause-menu.png) (the menu over the paused game at 1920×1080)
- **Sources:** `VISION.md` §Mechanics (Weapons, Shields, Potions, Abilities, XP and upgrades, Coins, Pause),
  §Session shape (Saving) · `00-game/controls.md` §4 (Esc, G10) · `05-items/items.md` §4–§7 (D-I3, D-I4,
  D-I5, D-I7, I8, I11, I15) · `06-ui/hud/hud.md` · `02-art-direction/ART_DIRECTION.md` (static stroke) ·
  `02-art-direction/palette/palette.md`

## 1. Purpose

Everything Akeris carries and what he is, with the game stopped: his numbers, the full inventory, and
the only place where XP is spent (weapon and shield upgrades, shield uses and repair) where the
equipped shield is changed, and where the weapons are put in the slots the player wants. From here the player also saves by hand and quits to the title.

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| Esc while playing (`VISION.md` §Pause) | Esc (when nothing inside is open), *Resume*, or *Quit* confirmed | **yes**: nothing moves, no timer runs (cooldowns, rage and the curse wait) | the game, frozen, under an ink wash; **the HUD is hidden** |

It does not open during death, a zone change, a dialogue, a cinematic or the map (they have their own
input). It does open during a curse; the curse is shown with what it will give.

## 3. Layout

A 1920×1080 reference frame (**hu**), scaled by `screen height ÷ 1080`; the sheet is **centred**, and on
wider screens only the wash grows. Numbers are what the sandbox draws (`PM` in `sandbox.html`).

| Element | Anchor | Position and size (hu) | Contents | Data source |
|---|---|---|---|---|
| wash | whole screen | — | `vignette` ink (`rgba(14,11,9,.62)`) over the frozen game | — |
| sheet | centre | x 120–1800, y 60–1020 | a paper sheet (`paper`, a soft darker edge), a 3.2 ink border and a faint inner line, all seeded; a soft shadow under it | — |
| title | sheet, top left | (170, 116), 64 px | `Paused` | — |
| where | sheet, top right | right edge 1750, y 120, 32 px | `Zone 1 · Slot 2` | zone, save slot |
| rules | sheet | y 167 and y 917 across; x 631 and x 1311 down (y 200–900) | pencil lines between the header, the three columns and the footer | — |
| **Akeris** | column 1 | label (170, 214); figure standing on a floor line at y 566, x ≈ 392, 1.22× the game's size | Akeris as the game draws him (the same rig, cape and streak), **alive**: he breathes as in the game's idle, his cape sways and his streak waves, on the menu's own clock (the game's is stopped). He holds **the weapon of the selected weapon box**; on opening, always the one he had in hand. The equipped shield is on his forearm (broken if it is) | weapon in hand, selected weapon, equipped shield, streak colour |
| stats | column 1 | six rows from y 616, 48 apart; icon at x 186, name at x 216, value right-aligned at x 596, 30 px | health `9/12` (a short streak), attack `+1` or `0` (sword), experience (mote), coins (coin), potions `2/3` (flask), zone (a door) | health, max health, attack bonus, XP, coins, potions, zone |
| weapons | column 2 | label (680, 214); five boxes of **108**, 14 apart, from (680, 240) | as the quick inventory: icon, slot number, three level marks; empty slots dashed; `In hand` under the one held | the five slots, levels, weapon in hand |
| shields | column 2 | label (680, 404); three boxes from (680, 430): sacred, ice, fire, always in that order | icon, uses `6/10` or `Broken` (broken icon, `05-items`), three level marks; `Equipped` under the equipped one; **a shield not found yet is a dashed empty box** | shields carried, uses, levels, equipped |
| abilities | column 2 | label (680, 594); three boxes from (680, 620) | `Q`, `E`, `R` as in the HUD: icon, recharge wash and seconds; empty dashed | the 3 equipped abilities, cooldowns |
| potions | column 2 | label (1046, 594); one box at (1046, 620) | the three flasks, empty ones drawn empty, and `F` | potions |
| on him | column 2 | label (680, 786), rows from y 826 | only while they last: the curse (thorn ring, `Curse: 4/10 — any damage kills you`, and under it what it gives: `When it is fulfilled: rage, Fire Shield`) and rage (`Rage 2:40`) | curse (D-I7), rage |
| detail | column 3 | x 1350–1750 | the **selected** box, large: a 170 box with the icon at (1350, 214); beside it the level marks and 1–3 status lines (28 px: `Level 1/3`, `In hand` / `Equipped`, `Uses 6/10` / `Broken` / `Repairing: 4/20` / `Never breaks`); the name (1350, 424), 40 px; a short description from y 472, 26 px, up to 4 lines | selected box |
| actions | column 3 | buttons 400 × 60 from y 636, 74 apart (at most three) | in this order, only those that apply: for a weapon `Change slot`, `Upgrade · 1000 XP`; for a shield `Equip`, `Restore uses · 400 XP` **or** `Repair · 1500 XP and a curse`, `Upgrade · 1000 XP`; a button without enough XP is drawn faint | §5.2 |
| note | column 3 | 12 under the last button, 24 px, up to 3 lines | `You need 650 more XP`; for a repair, the curse warning (`Kill 10 enemies…`, or `It adds to your curse: 4/20…`); at the top level, `The highest level in the demo`; while a weapon is carried to another slot, how to place it | — |
| footer | sheet, bottom | buttons 56 tall at y 944 from x 170, 22 apart; hint right-aligned at 1750, y 973, 24 px | `Resume` (with an `Esc` key cap), `Save`, `Quit to title`; the hint `W A S D or arrows · Enter choose · Esc back` | — |
| saved | sheet, top centre | a box centred at x 960, y 92–144, 32 px | `Saved in slot 2` for 2.2 s | save |
| quit | centre, over a darker wash on the sheet | box (560, 380) 800 × 290; buttons (640, 572) and (980, 572), 300 × 64 | `Quit to the title screen?` · `The run is saved where you stand.` · `Quit` / `Stay` (focus starts on `Stay`) | — |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| opening | the wash and the sheet fade in and the sheet settles 14 hu down | Esc; 0.18 s |
| focused | the box or button takes the thick ink frame with an inner line (the HUD's weapon in hand) | keyboard focus |
| hovered | the box's paper brightens; the focus does not move | the mouse over it |
| selected | the detail column shows it; it stays while the focus is on its buttons | focus on a box, or a click |
| not enough XP | the button is faint and the note says how much is missing; Enter or a click flashes its frame (0.35 s) and spends nothing | cost > XP |
| done | the box flashes its frame (0.4 s); the XP, marks, uses or `Equipped` change at once | an action |
| nothing to do | Enter on a box without actions flashes its frame | empty slot, not-found shield, ability, potions, top level |
| weapon previewed | selecting another weapon box: Akeris puts his weapon away and draws that one, as the game's weapon swap (the hand to the shoulder or the hip, 0.3 s). It is only a preview: the weapon in hand does not change. Selecting a shield, an ability or the potions keeps the last weapon shown; reopening the menu starts again with the weapon in hand | focus on a weapon box |
| changing slot | the carried weapon is drawn in the slot it would go to, raised 12 hu with the focus frame; the weapon that was there (or nothing) is drawn in the slot it leaves: the row shows the result before it is placed. The note explains the keys | `Change slot`, or a weapon dragged with the mouse |
| broken shield | its box is greyed, with the broken icon and `Broken`; the detail offers `Repair` | uses = 0 (D-I5) |
| repairing | the detail says `Repairing: n/total`; no `Repair` or `Restore` button | its curse runs (D-I4, D-I7) |
| during a curse | `On him` shows it and its rewards; `Repair` on another shield warns that it adds 10 | curse active |
| saved | the `Saved in slot N` note for 2.2 s | Save |
| quit asked | the dialogue over a darker sheet; only its two buttons answer | Quit to title |

## 5. Navigation and actions

### 5.1 Input

| Input (as `VISION.md` and `controls.md` name it) | Effect |
|---|---|
| Esc (playing) | opens the menu |
| W / S / A / D or the arrows | move the focus: along a row, and between the rows weapons → shields → abilities and potions → footer, keeping the column. Right from the last box of a row goes to the detail's buttons; left from a button returns to its box |
| Enter (on a box) | goes to its first button; if it has none, the frame flashes |
| Enter (on a button) | does it |
| Esc (in the menu) | back: from a button to its box; closes the quit dialogue; otherwise closes the menu (G10) |
| mouse: point | hover only |
| mouse: click | on a box, selects it; on a button, does it |
| mouse: drag a weapon | carries it to another slot (it swaps with the weapon there); dropped outside the row, it goes back |
| A / D or the arrows (changing slot) | choose the slot; Enter places the weapon there, Esc leaves everything as it was |
| the wheel, 1–5, Q/E/R, F, G, M | nothing while paused |

**Spending XP takes two steps** (Enter on the box, Enter on the button; or a click on the box, then on
the button), so nothing is spent by moving around. There is no further confirmation.

### 5.2 What each box offers

| Box | Buttons (in order, only those that apply) |
|---|---|
| a weapon | `Change slot`: any weapon, the sacred sword and the chain blades too, to any of the five slots; if one is there, they swap places (U17). `Upgrade · cost` until level 3: 1→2 **1000 XP**, 2→3 **3000 XP** (`VISION.md`); **every level raises the weapon's damage** (D-I8, `05-items/items.md` §5); the level marks fill at once |
| a shield carried | `Equip` if it is not the equipped one; for the ice or fire shield, `Restore uses · cost` if some uses are spent, or `Repair · cost and a curse` if it is broken (D-I3, D-I4, I15; not while it is being repaired); `Upgrade · cost` until level 3 (U10) |
| a shield not found, an empty slot | nothing: its name says `Not found yet` or `Free slot` and where it may be found |
| an ability | nothing: its name, its key, `Ready` or `Recharging: n s` and what it does. Abilities are swapped only after a boss (`VISION.md`), in that screen |
| potions | nothing: `2/3` and how they are drunk |
| Resume | closes the menu |
| Save | saves the run in **its own slot** without leaving it (`VISION.md` §Saving) and shows `Saved in slot N` |
| Quit to title | asks; `Quit` autosaves (`VISION.md`: autosave on quitting, keeping the position and everything carried) and goes to the title screen through the loading screen (`06-ui/loading/loading.md`, step 3.7); `Stay` closes the question |

`Repair` starts the curse at once, but nothing can hurt Akeris until the menu closes.

## 6. Text

| Key | English text | Español | Where | Max length |
|---|---|---|---|---|
| `ui.pause.title` | Paused | Pausa | title | 12 |
| `ui.pause.where` | Zone {zone} · Slot {slot} | Zona {zone} · Ranura {slot} | header, right | 24 |
| `ui.pause.akeris` | Akeris | Akeris | column 1 label | 12 |
| `ui.pause.weapons` | Weapons | Armas | label | 14 |
| `ui.pause.shields` | Shields | Escudos | label | 14 |
| `ui.pause.abilities` | Abilities | Habilidades | label | 14 |
| `ui.pause.potions` | Potions | Pociones | label | 14 |
| `ui.pause.states` | On him | Sobre él | label | 14 |
| `ui.pause.stat.health` | Health | Vida | stats | 14 |
| `ui.pause.stat.attack` | Attack | Ataque | stats | 14 |
| `ui.pause.stat.xp` | Experience | Experiencia | stats | 14 |
| `ui.pause.stat.coins` | Coins | Monedas | stats | 14 |
| `ui.pause.stat.potions` | Potions | Pociones | stats | 14 |
| `ui.pause.stat.zone` | Zone | Zona | stats | 14 |
| `ui.pause.level` | Level {n}/{max} | Nivel {n}/{max} | detail | 14 |
| `ui.pause.inHand` | In hand | En la mano | under a weapon; detail | 14 |
| `ui.pause.equipped` | Equipped | Equipado | under a shield; detail | 14 |
| `ui.pause.uses` | Uses {n}/{max} | Usos {n}/{max} | detail | 14 |
| `ui.pause.unbreakable` | Never breaks | No se rompe | detail, sacred shield | 16 |
| `ui.pause.repairing` | Repairing: {n}/{total} | Reparando: {n}/{total} | detail | 20 |
| `ui.pause.upgrade` | Upgrade · {cost} XP | Mejorar · {cost} XP | button | 26 |
| `ui.pause.equip` | Equip | Equipar | button | 26 |
| `ui.pause.move` | Change slot | Cambiar de ranura | button | 26 |
| `ui.pause.moveHint` | A/D or arrows choose the slot · Enter places it · Esc cancels. The weapon there swaps places. | A/D o flechas eligen la ranura · Enter la deja · Esc cancela. Si hay otra arma, se cambian de sitio. | note | 110 |
| `ui.pause.restore` | Restore uses · {cost} XP | Recuperar usos · {cost} XP | button (replaces `item.shield.restore` here) | 26 |
| `ui.pause.repair` | Repair · {cost} XP and a curse | Reparar · {cost} XP y una maldición | button (replaces `item.shield.repair` here) | 34 |
| `ui.pause.needXp` | You need {n} more XP | Te faltan {n} XP | note | 60 |
| `ui.pause.repairWarn` | Kill {n} enemies. Any damage before then kills you. | Mata a {n} enemigos. Cualquier daño antes te mata. | note | 60 |
| `ui.pause.repairAdds` | It adds to your curse: {n}/{total}. Any damage kills you. | Se suma a tu maldición: {n}/{total}. Cualquier daño te mata. | note | 64 |
| `ui.pause.maxLevel` | The highest level in the demo | El nivel más alto de la demo | note | 60 |
| `ui.pause.emptySlot` | Free slot | Ranura libre | detail name | 20 |
| `ui.pause.emptySlotDesc` | A spear, a flail or a hammer may lie on an altar in any zone. | En cualquier zona puede haber una lanza, un mayal o un martillo sobre un altar. | detail | 110 |
| `ui.pause.notFound` | Not found yet | Aún no lo tienes | detail name | 20 |
| `ui.pause.notFoundDesc` | It lies on an altar, in some zone, once per run. | Está sobre un altar, en alguna zona, una vez por partida. | detail | 110 |
| `ui.pause.noAbility` | Empty | Vacía | detail name | 20 |
| `ui.pause.noAbilityDesc` | Each boss leaves one of its two abilities. After a boss you may swap one. | Cada jefe deja una de sus dos habilidades. Tras un jefe puedes cambiar una. | detail | 110 |
| `ui.pause.ready` | Ready | Lista | detail, ability | 20 |
| `ui.pause.recharging` | Recharging: {n} s | Recargando: {n} s | detail, ability | 20 |
| `ui.pause.rewards` | When it is fulfilled: {list} | Al cumplirla: {list} | on him, under the curse | 60 |
| `ui.pause.reward.rage` | rage | furia | in `{list}`; a repair uses the shield's name key | 12 |
| `ui.pause.resume` | Resume | Continuar | footer | 16 |
| `ui.pause.save` | Save | Guardar | footer | 16 |
| `ui.pause.quit` | Quit to title | Salir al inicio | footer | 18 |
| `ui.pause.saved` | Saved in slot {n} | Guardado en la ranura {n} | saved note | 28 |
| `ui.pause.quitAsk` | Quit to the title screen? | ¿Salir a la pantalla de inicio? | quit dialogue | 34 |
| `ui.pause.quitNote` | The run is saved where you stand. | La partida se guarda donde estás. | quit dialogue | 40 |
| `ui.pause.quitYes` | Quit | Salir | quit dialogue | 12 |
| `ui.pause.quitNo` | Stay | Seguir | quit dialogue | 12 |
| `ui.pause.hint` | W A S D or arrows · Enter choose · Esc back | W A S D o flechas · Enter elegir · Esc volver | footer, right | 48 |
| `item.sword.desc` | Dormant and weak. Three empty holes wait along the blade. | Dormida y débil. Tres huecos vacíos esperan en la hoja. | detail | 110 |
| `item.chainBlades.desc` | Two hook blades, each on its own chain. Always with you. | Dos hojas con gancho, cada una con su cadena. Siempre contigo. | detail | 110 |
| `item.spear.desc` | The longest reach, and a lunge. | El mayor alcance, y una embestida. | detail | 110 |
| `item.flail.desc` | The ball strikes all along its path. | La bola golpea en todo su recorrido. | detail | 110 |
| `item.hammer.desc` | The slowest, and it throws them back. | El más lento, y los echa atrás. | detail | 110 |
| `item.sacredShield.desc` | A perfect block opens the counter. | El bloqueo justo abre el contraataque. | detail | 110 |
| `item.iceShield.desc` | A perfect block freezes the attacker. Blocks ice. | El bloqueo justo congela al atacante. Para el hielo. | detail | 110 |
| `item.fireShield.desc` | A perfect block burns the attacker. Blocks fire. | El bloqueo justo quema al atacante. Para el fuego. | detail | 110 |
| `item.potion.desc` | Hold F to drink. They fill again in every zone. | Mantén F para beber. Se rellenan en cada zona. | detail | 110 |

Also used: the item names (`item.<id>.name`, `05-items/items.md` §9), `item.shield.broken`,
`item.curse.progress` and `ui.hud.rage` (`hud.md` §6). Each ability's `ability.<id>.name` and
`ability.<id>.desc` come with its boss (steps 3.11–3.15); the sandbox's stand-in is the golem's Stone
Orbit. The descriptions follow `00-game/tone.md`: short, plain, no numbers.

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id (proposed; `07-audio/` fixes them in step 3.8) |
|---|---|---|---|
| open | wash and sheet fade in; the sheet settles 14 hu | 0.18 | `sfx.ui.open` |
| close | gone at once | — | `sfx.ui.close` |
| focus moves | the frame jumps to the new box | — | `sfx.ui.move` |
| Akeris | breathes (the game's idle breath), the cape sways, the streak waves | continuous | — |
| Akeris's weapon | put away and drawn, as the game's swap | 0.3 | `sfx.akeris.swap` (the game's) |
| weapon carried | raised 12 hu in the slot it would go to | — | `sfx.ui.move` |
| action done | the box's frame flashes | 0.4 | `sfx.ui.upgrade`, `sfx.ui.equip`, `sfx.shield.restore`, `sfx.curse.start` (a repair) |
| denied | the frame flashes | 0.35 | `sfx.ui.denied` |
| saved | the note shows, fades in its last 0.4 s | 2.2 | `sfx.ui.save` |
| quit | fade to black, then the loading screen (`06-ui/loading/`), then the title screen | 0.4 | `sfx.ui.confirm` |

Nothing trembles: every box, rule and letter has its seed; nothing pulses or shakes. Only Akeris moves,
as he does standing still in the game: breath, cape and streak are real motion, never a redrawn stroke.
The ability's recharge wash waits, as every game timer does.

## 8. Never

- The game never runs behind the menu: no damage, no timers, no enemy moves while it is open.
- XP is never spent by moving the focus or by one Enter on a box.
- Changing a weapon's slot never changes the weapon in hand, its level, or anything but the order.
- The equipped shield is changed nowhere else (`VISION.md`); the HUD never offers it.
- No ability swap here; no settings here (they are on the title screen, `VISION.md`).
- A shield not found yet shows no name or picture.
- No colour outside `palette.md`; no hard-coded text; no stroke redrawn differently between frames.

## 9. Acceptance

1. At 1920×1080 the layout matches `pause-menu.png` within 2 hu; on wider screens the sheet stays
   centred at the same size and nothing overlaps.
2. Esc pauses: Akeris, the dummy, the cooldowns and rage stop, and the HUD is hidden; Esc again resumes
   exactly where it was.
3. W/A/S/D and the arrows move the focus as in §5.1 and never move Akeris; the mouse selects with a
   click and does not change the selection by hovering.
4. `Upgrade` raises a weapon a level for 1000 XP (1→2) and 3000 XP (2→3); at level 3 there is no button
   and the note says so (`captures/pausaMejorar.png` shows the faint button and `You need 650 more XP`).
5. `Equip` changes the equipped shield and Akeris's forearm in the figure (`captures/pausaEscudo.png`).
6. `Restore uses` refills a worn special shield for XP per missing use; `Repair` on a broken one takes
   XP and starts the curse, and during another curse it adds 10 (`captures/pausaRoto.png`,
   `captures/pausaMaldito.png`).
7. A new run shows two weapons, the sacred shield, dashed abilities and full potions
   (`captures/pausaInicio.png`).
8. An ability shows its key, its recharge and what it does (`captures/pausaHabilidad.png`).
9. `Change slot` carries a weapon along the row; Enter or a drop places it and swaps it with the one there; Esc or a drop outside leaves the order as it was. After closing, keys 1–5, the wheel and the quick inventory follow the new order (`captures/pausaRanura.png`).
10. Akeris breathes and his streak waves while the menu is open; selecting a weapon box makes him draw that weapon (0.3 s); reopening the menu shows the weapon in hand first (`captures/pausaMejorar.png`: the chain blades selected).
11. `Save` writes the run to its slot and shows `Saved in slot N` (`captures/pausaGuardar.png`); `Quit to
   title` asks, with the focus on `Stay` (`captures/pausaSalir.png`).

## 10. Proposals for the operator

**All approved by the operator on 2026-09-30** (U9–U17), as the sandbox does them.

| # | Question | Proposal |
|---|---|---|
| U9 | Tabs, or one screen? | **One screen**: Akeris and his numbers, the full inventory, and the selected box with its actions; Resume, Save and Quit at the bottom. The demo has little to show and every piece fits |
| U10 | Do the shields have levels? (`VISION.md`: open question) | **Three levels, like the weapons**, with the same marks; what a level does and its cost are the game's (sandbox: 1000 and 3000 XP) |
| U11 | How is XP spent without mistakes? | Two steps (box, then its button); no extra "are you sure?". A button without enough XP stays visible, faint, with how much is missing |
| U12 | What does Save do? | Saves in the run's own slot, stays in the menu and says `Saved in slot N`. No slot picker (that belongs to the title screen) |
| U13 | And Quit? | It asks, focus on `Stay`; quitting autosaves as `VISION.md` says |
| U14 | Are unfound shields shown? | As dashed boxes with no name or picture: the player knows two more exist, not what they look like |
| U15 | Where is Akeris drawn? | Standing, as in the game, breathing, with his cape and streak moving (operator, 2026-09-30); he holds the selected weapon, starting with the one in hand, and wears the equipped shield |
| U16 | Mouse or keyboard selection? | Both: the keyboard moves a focus; the mouse hovers (paper brightens) and selects with a click, so the detail does not jump while the mouse travels to a button |
| U17 | Can the weapons change slot? (asked by the operator, 2026-09-30) | **Yes**, all of them, the sacred sword and the chain blades too, to any of the five slots, swapping with the weapon there. The order is what keys 1–5, the wheel and the quick inventory use. A new weapon still goes to the first free slot (I2) |
