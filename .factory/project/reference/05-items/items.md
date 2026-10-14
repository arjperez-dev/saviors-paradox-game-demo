# Items

- **Status:** approved 2026-09-30 (step 3.6)
- **Sources:** `VISION.md` §Core loop, §Mechanics (Weapons, Shields, Potions, Scrolls, XP and upgrades,
  Coins), §Win / lose conditions, §Content scope · `00-game/controls.md` · `00-game/glossary.md` §3 ·
  operator decisions of 2026-09-30 (§6)
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html): the Akeris sandbox with a hall of eight
  altars · icon sheet [`sandbox/icons.png`](sandbox/icons.png)
- **Read by:** every task that makes an item exist in the game: pickup, inventory, upgrades, drops,
  potions, scrolls, shield uses and repair, and the icons the UI draws.

What the player picks up, carries and uses. **How Akeris holds, draws and swings a weapon or shield is
animation, and lives in `03-characters/akeris/weapons/`**; the files here link to it. Every
gameplay number is `VISION.md`'s or "the game decides"; the sandbox's numbers are stand-ins.

---

## 1. The closed list

| Item | Kind | How he gets it | File |
|---|---|---|---|
| sacred sword | weapon, slot 1 | always carried | [`weapons/sacred-sword/`](weapons/sacred-sword/sacred-sword.md) |
| chain blades | weapon, slot 2 | always carried | [`weapons/chain-blades/`](weapons/chain-blades/chain-blades.md) |
| spear, flail, hammer | weapon, free slots 3–5 | on an altar, any zone, once per run | [`weapons/spear/`](weapons/spear/spear.md), [`flail/`](weapons/flail/flail.md), [`hammer/`](weapons/hammer/hammer.md) |
| sacred shield | shield | always carried | [`shields/sacred-shield/`](shields/sacred-shield/sacred-shield.md) |
| ice shield, fire shield | shield | on an altar, any zone, once per run | [`shields/ice-shield/`](shields/ice-shield/ice-shield.md), [`fire-shield/`](shields/fire-shield/fire-shield.md) |
| potion | satchel, 3 | carried; refilled on entering each zone | [`potion/`](potion/potion.md) |
| scroll: health, attack and ability, cursed | read at once | on an altar, 3 per zone | [`scrolls/`](scrolls/scrolls.md) |
| XP, coins | currency | dropped by enemies | [`drops/`](drops/drops.md) |
| the altar | where items lie | placed by the zone | [`altar/`](altar/altar.md) |

There is nothing else: no keys, no armour, no food, no shop items (the shop is locked in the demo).

## 2. Picking up

- Weapons, shields and scrolls lie on **stone altars**, in rooms off the main path (operator,
  2026-09-30). Each floats slowly over the slab between two lit candles
  ([`altar/altar.md`](altar/altar.md)).
- Near an altar (sandbox: within 80 su of its centre), on the ground, a prompt shows the key **G** and
  the item's name (`ui.prompt.take`, drawn by `06-ui/`). **G picks it up** (operator, 2026-09-30; a new
  control, marked (D) for step 5.1).
- **The pickup** (0.5 s, sandbox): he turns to the altar, his **back hand** (the shield hand, which is
  free) reaches to it (0.2), the item flies into the hand (0.1) and vanishes into the inventory, the
  candles go out with a thread of smoke, and he straightens (0.2). Frames:
  [`altar/sheet-pickup.png`](altar/sheet-pickup.png).
- **XP and coins** are never picked with G: XP flies to him by itself; coins are taken by walking over
  them ([`drops/drops.md`](drops/drops.md)).

## 3. What happens to each kind

| Kind | On pickup | Proposal |
|---|---|---|
| weapon | goes to the first free slot (3–5) and **is drawn at once** with the weapon swap | I2 |
| shield | is stored; the equipped shield is still changed only in the pause menu's full inventory (`VISION.md`) | I3 |
| scroll | **is read at once**: he puts his weapon away, opens it with both hands, the ink of its runes rises into him, the paper crumbles into ink, the weapon comes back ([`scrolls/scrolls.md`](scrolls/scrolls.md)) | I4 |

## 4. Inventories

- **Quick inventory** (on screen): the 5 weapon slots, the potions, the three abilities
  (`00-game/glossary.md`). It also shows the equipped shield and its uses (proposal I8). The wheel and
  1–5 pick a weapon **among those carried**; an empty slot is skipped.
- **Full inventory** (pause menu): equipment, XP upgrades, stats, the equipped shield, and **the shield
  repair** (§6). Its layout is `06-ui/`.
- **Icons:** every item has a transparent icon, 96 × 96 su, exported from the sandbox
  (`<item>/icon.png`; see each file). A broken shield has its own broken icon, used in both
  inventories (operator, 2026-09-30).

## 5. Upgrades, levels and death

- Weapons have 7 levels, the demo stops at 3; level 1→2 costs 1000 XP and 2→3 costs 3000 XP
  (`VISION.md`). The sacred shield and the special shields are upgraded with XP too; their levels and
  costs are an open question of `VISION.md`.
- **Each level a weapon goes up raises its damage** (operator, 2026-09-30, D-I8; important). How much
  is the game's; the level is what makes a weapon hit harder, not a new drawing.
- **A level does not change the drawing** in the demo; the UI shows it (proposal I11).
- **Death** loses everything: coins, found weapons and shields, scrolls' effects, XP and the save
  slot (`VISION.md`). The sandbox shows it: after the death animation, the hall is full again and the
  inventory empty.

## 6. Operator decisions of 2026-09-30

Taken before this step was drafted. Those marked **(D)** change or add to `VISION.md`; the translator
moves them in plan step 5.1.

| # | Decision | Changes `VISION.md` |
|---|---|---|
| D-I1 | The spear, the flail and the hammer can appear in **any zone**, by the run's seed | no, settles it |
| D-I2 | Akeris starts each run with the sacred shield only. The ice and fire shields are **found on an altar**, any zone, **once per run** | yes (D): §Mechanics, Shields |
| D-I3 | **The special shields are not refilled on entering a zone.** Their uses are bought back with **XP** in the full inventory, at any time | yes (D): §Mechanics, Shields; §Core loop ("special shields refill") |
| D-I4 | A **broken** shield is repaired with **more XP and a curse**: kill 10 enemies; any damage during it kills Akeris, as the cursed challenge; it is whole again when the tenth dies | yes (D): new mechanic |
| D-I5 | A broken shield **looks broken** in the quick inventory and in the full inventory | yes (D) |
| D-I6 | Weapons, shields and scrolls lie on **stone altars** off the main path and are picked up with **G**. XP and coins drop from enemies and are collected by passing | yes (D): §Mechanics, §Input (new key G) |
| D-I7 | **Curses add up.** Repairing a broken shield while the cursed scroll's challenge runs adds its 10 kills to the same count (for example 4/10 becomes 4/20). The same holds in any order: reading the cursed scroll during a repair, or repairing the second shield. All the rewards (rage, the repaired shields) come together when the total is reached; any damage before that kills Akeris, as always. A shield already being repaired cannot be repaired again | yes (D): new mechanic |
| D-I8 | **Upgrading a weapon raises its damage**, at every level (operator, 2026-09-30, marked important). How much each level adds is the game's | yes (D): §Mechanics, XP and upgrades |

## 7. Operator decisions: the approved proposals

Proposed in this step and **approved by the operator on 2026-09-30**, as the sandbox does them (I7 was
replaced by D-I7). Those that add to or change `VISION.md` are (D) for step 5.1: I2, I4, I5, I6, I7
(D-I7), I8, I9 and I15.

| # | Question | Proposal |
|---|---|---|
| I1 | Where are the free-slot weapons he is not holding? | **Not drawn.** Only the equipped weapon is in hand; the sword is always on his back and the hook blades at his belt (as approved); the others live in the quick inventory. A spear on the back beside the sword would bury the silhouette |
| I2 | What happens when he takes a weapon? | it goes to the first free slot and he draws it at once. The slots can never overflow: there are three free-slot weapons, each found once per run, and three free slots |
| I3 | And a shield? | it is stored; he equips it in the pause menu as `VISION.md` says. The prompt says so (`ui.prompt.stored`) |
| I4 | Are scrolls carried or read? | **read at once** on pickup (≈ 1.8 s, standing still). A hit interrupts the reading and the scroll goes back to its altar, unread (not in the sandbox). The satchel then holds only potions: `00-game/glossary.md` changes ("satchel: potions") |
| I5 | What do the health and the attack-and-ability scrolls do? | health: **raises maximum health and refills it**; attack and ability: **raises the damage of weapons and abilities**. How much is the game's |
| I6 | How does rage look? | his eye streak **burns wider** (1.8×) while it lasts; nothing else changes colour. The HUD shows the time left |
| I7 | How does a curse look, and can two run at once? | a **ring of static ink thorns** on the floor around his feet, following him, and the counter in the HUD. Two curses add up (D-I7, which replaces what this proposal said). A curse survives a zone change |
| I8 | What does a broken shield do? | it stays strapped to his forearm, **drawn broken**, and **cannot block** until repaired or changed in the pause menu. The quick inventory shows the equipped shield with its uses, or broken |
| I9 | How do XP and coins drop? | XP: **pale ink motes** rise from the enemy's ink smoke and fly into his chest by themselves. Coins: pop out, spin, bounce and **lie flat**; taken by walking over them (a pull of 90 su) |
| I10 | How is a taken altar shown? | its two candles go out with a thread of smoke; the empty altar stays, readable from afar |
| I11 | Does a weapon's level show on it? | no, not in the demo; the UI shows the level |
| I12 | What colour is the potion? | **amber**: the torch flame's two colours, light in a bottle. No new colour |
| I13 | How do the three weapons differ? | spear: the longest reach and lunge. Flail: the ball hits along its path, the overhead smashes the floor. Hammer: the slowest, more knockback, the overhead slams the floor with dust and `thud` even on a miss. Damage is the game's |
| I14 | How are they carried and drawn? | spear upright in guard, hammer on the shoulder, flail at his side; spear and hammer drawn over the shoulder, the flail from the hip |
| I15 | Shield costs? | recovering uses costs XP per missing use; repairing a broken shield costs more, plus the curse. The numbers are the game's (sandbox: 100 per use, 1500 broken) |
| I16 | New colours? | **`wood`** `#6e5f4d` (shafts and handles) and **`iron`** `#5a554e` (spear socket, flail ball, hammer head); coins use the sacred shield's gold `#c4a048`. Added to `02-art-direction/palette/palette.md` as proposed |

## 8. Sounds (ids proposed; `07-audio/` fixes them in step 3.8)

| Sound id | Trigger |
|---|---|
| `sfx.item.take` | an item flies into his hand |
| `sfx.altar.out` | the candles go out |
| `sfx.scroll.open`, `sfx.scroll.ink`, `sfx.scroll.crumble` | the scroll opens; the runes rise; the paper turns to ink |
| `sfx.curse.start`, `sfx.curse.tick`, `sfx.curse.end` | a curse starts; each kill counts; it is fulfilled |
| `sfx.xp.absorb` | a mote reaches him |
| `sfx.coin.drop`, `sfx.coin.take` | a coin hits the floor; a coin is taken |
| `sfx.shield.restore`, `sfx.shield.repaired` | uses bought back; a broken shield repaired |

## 9. Text

Every name and description is a translator key; the UI decides where it shows.

| Key | English | Español |
|---|---|---|
| `item.sword.name` | Sacred Sword | Espada sagrada |
| `item.chainBlades.name` | Chain Blades | Espadas-gancho |
| `item.spear.name` | Spear | Lanza |
| `item.flail.name` | Flail | Mayal |
| `item.hammer.name` | Hammer | Martillo |
| `item.sacredShield.name` | Sacred Shield | Escudo sagrado |
| `item.iceShield.name` | Ice Shield | Escudo de hielo |
| `item.fireShield.name` | Fire Shield | Escudo de fuego |
| `item.potion.name` | Potion | Poción |
| `item.scroll.health.name` | Scroll of Health | Pergamino de salud |
| `item.scroll.power.name` | Scroll of Attack and Ability | Pergamino de ataque y habilidad |
| `item.scroll.cursed.name` | Cursed Scroll | Pergamino maldito |
| `item.coin.name` | Coins | Monedas |
| `item.xp.name` | Experience | Experiencia |
| `ui.prompt.take` | Take | Tomar |
| `ui.prompt.stored` | Stored — equip it from the pause menu | Guardado: equípalo en el menú de pausa |
| `item.shield.broken` | Broken | Roto |
| `item.shield.repair` | Repair (XP and a curse) | Reparar (XP y una maldición) |
| `item.shield.restore` | Restore uses (XP) | Recuperar usos (XP) |
| `item.curse.progress` | Curse: {n}/{total} — any damage kills you | Maldición: {n}/{total}. Cualquier daño te mata |

## 10. Never

- Nothing trembles: floating items bob slowly; coins spin only while they fly.
- No item is hand-drawn outside the sandbox; every PNG is exported from it.
- No colour outside the palette; no blood anywhere.
- The prompt never picks an item by itself: only G does.

## 11. Acceptance

1. Near an altar the prompt shows G and the name; G plays the pickup as in `altar/sheet-pickup.png`,
   and the candles go out.
2. A weapon taken is drawn at once and appears in the next free slot; the wheel skips empty slots.
3. A shield taken is stored, not equipped.
4. A scroll is read at once as in `scrolls/sheet-read.png`; the cursed one starts the curse ring and
   counter (`scrolls/sheet-cursed.png`).
5. During a curse any damage kills him; the tenth kill ends it.
6. A defeated enemy's XP flies to him; its coins bounce, lie flat and are taken by passing
   (`drops/sheet-drops.png`).
7. The ice shield spends a use per block and the fire shield per fire hit; broken, it looks as in
   `shields/ice-shield/sheet-break.png` on the arm and as `icon-broken.png` in both inventories.
8. Entering a zone refills the potions, not the shields.
