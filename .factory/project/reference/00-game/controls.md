# Canonical controls

- **Status:** approved 2026-10-06 (G22, the torch in the hand); approved 2026-09-30 before that (step 3.6 adds G and G17, from the operator's decisions of 2026-09-30)
- **Sources:** `VISION.md` §Mechanics, §Input scheme, §Non-goals · operator decisions of 2026-09-30
  (§5)
- **Read by:** any task that reads input, draws a control prompt or writes a tutorial line; the
  tester, to check a binding.

> [!IMPORTANT]
> **`VISION.md` owns the controls. This file is a copy, arranged as tables, plus the operator's
> decisions of 2026-09-30 (§5), which settle what the vision left open and change a few things it
> said.** Rows marked **(D)** come from those decisions. The translator moves them into `VISION.md`
> in the `revision` session (plan step 5.1); until then no task is planned against a (D) row. Where
> this file and `VISION.md` disagree on anything not marked (D), `VISION.md` wins and this file has
> a defect. No other reference defines a control: a sandbox's keys are browser stand-ins
> (`02-art-direction/ART_DIRECTION.md`, scope note).

Keyboard and mouse are the only input. Gamepad and touch are non-goals, and so is rebinding: the
settings hold only music volume, sound-effect volume and language.

---

## 1. Moving

| Input | Action | Source |
|---|---|---|
| A / D | move left / right: Akeris starts walking and, while the key is held, speeds up into a run | `VISION.md` · (D) G1 |
| Space | jump: a tap is the normal jump; holding Space jumps higher, up to the high jump (let go early and the rise stops at the normal height) | `VISION.md` · (D) G2 |
| Space held + D / A | the high jump to the right / to the left | (D) G2 |
| S (in the air) | fast descent; stuns enemies where it lands | `VISION.md` · (D) G2 |
| Shift | roll, with brief invulnerability; it cuts whatever Akeris is doing on the ground (a strike of any weapon, the shield's pushback, a hook-blades action), so it never waits for a strike to end (operator, 2026-10-01) | `VISION.md`, (D) G18 |
| Space while rolling | the roll ends in a jump that keeps the roll's speed (holding Space: the high jump); the roll's invulnerability ends there | (D) G18 |
| Shift (in the air) | air roll: a somersault with the same brief invulnerability, keeping the jump's path; once per jump, back on landing | (D) G18 |
| Left Ctrl | crouch, to pass through tunnels and low gaps | `VISION.md` |

## 2. Fighting

| Input | Action | Source |
|---|---|---|
| Left click, repeated | melee combo with the equipped weapon: diagonal slash → rising slash → thrust | `VISION.md` · (D) G3 |
| W + left click | overhead strike | (D) G3 |
| Left click (in the air) | aerial attack | `VISION.md` · (D) G3 |
| Right click, held | raise the equipped shield; it lowers on release. The only block | `VISION.md` · (D) G4 |
| Right click raised just before a **melee** hit, **sacred shield** | counter: 1 s of ultra-fast strikes with afterimages (a ranged burst with the chain blades) | `VISION.md` · (D) G7, G16 |
| Right click raised just before a **melee** hit, **ice shield** | the attacker is frozen for 1.5 s, and its defence drops while it is frozen; no counter. A block at any other moment only stops the hit | (D) G16 |
| Right click raised just before a **melee** hit, **fire shield** | the attacker burns for 1.5 s, losing health; no counter. A block at any other moment only stops the hit | (D) G16 |
| Right click raised just before a **projectile** hits | the projectile flies back, faster, at whoever threw it, and damages it when it hits (with the ice shield it also freezes it 0.5 s, with the fire shield it burns it 0.5 s); no counter. A block at any other moment only stops it | (D) G7, G16 |
| Q / E / R | the three equipped abilities | `VISION.md` |
| Hold F | drink a potion; when it is finished, Akeris is back to the weapon he held before | `VISION.md` · (D) G8, G9 |
| Mouse wheel | cycle through the weapon slots | `VISION.md` · (D) G8 |
| 1 / 2 / 3 / 4 / 5 | sacred sword / chain blades / free slots 1–3 | (D) G8 |

Projectiles are dodged or blocked; attacks do not split them (D, G7). The equipped shield is changed
only in the pause menu's full inventory (`VISION.md` §Mechanics, Shields).

## 3. The chain blades

With the chain blades equipped, the mouse aims and a left click throws toward it. What the throw does
is decided by what it reaches and by the key held with it (D, G5, G6):

| Input | Target | Action |
|---|---|---|
| Left click | a ring within reach: on the ground, above Akeris; **in the air, also level with him or a little below** (jumping at it). If the mouse aims, the ring nearest the aim; if not, the nearest one ahead | hook it and hang: §3.1 · (D) G19 |
| Space, then left click | a wall Akeris is next to | climb it |
| Left click, in the air (for example after jumping off a wall) | another wall across a gap, within reach, toward the mouse (or ahead) | the blade bites it, the chain pulls him across and he hangs from it; from there he climbs or jumps to the next · (D) G20 |
| Left click | a boss part | hook it |
| Left click | an object an enemy holds that can be snatched (the knight's shield, the skeleton's skull) | snatch it |
| Left click | an enemy | ranged strike; pull toward it |
| W + left click | — | overhead arc |
| S + left click | the floor | anchor (the only escape from the golem's levitation) |
| Left click, held | — | area spin |

> [!NOTE]
> An enemy is both *ranged strike* and *pull* in `VISION.md`; how the two are told apart is left to
> Akeris's mechanics (plan step 3.5), which proposes it to the operator.

### 3.1 Hanging from a ring — the free hand (D)

A ring is caught only with the chain blades equipped. While Akeris hangs, one hand holds the chain
and the other is free, so he can fight in the air — in a boss room, for example — without letting go.

| Input (hanging) | Action |
|---|---|
| A / D | swing |
| Space | let go |
| Left click | throw the free hook blade to the next ring, hand over hand; the hand that was holding becomes the free one, and it holds its **hook blade** again |
| Mouse wheel | switch the free hand between its **hook blade** and the equipped **shield**. It always starts with the hook blade |
| Right click, hook blade in the free hand | ranged throw where the mouse aims: strike, snatch or hook a boss part. It cannot pull, climb or anchor: the other hand is on the ring |
| Right click, shield in the free hand | block, as on the ground (held) |
| Shield raised just before a melee hit | with the sacred shield, counter: 1 s of ultra-fast strikes with the free hand's hook blade, without letting go; the ice and fire shields freeze or burn the attacker, as on the ground |
| Shield raised just before a projectile hits | it flies back at its thrower and damages it, as on the ground |
| Q / E / R | abilities, as on the ground |
| F | nothing: Akeris cannot drink while hanging |

## 4. Talking, the map and the menus

| Input | Action | Source |
|---|---|---|
| H (near a spirit) | talk | `VISION.md` |
| G (near an altar) | take the weapon, shield or scroll on it (`05-items/items.md` §2) | (D) G17 |
| G (near a torch, zone 4) | take it in the free hand; G again lays it down burning (`04-zones/zone-4-rotting-canopy/hazards.md` Z49) | (D) G22 |
| Enter (in dialogue) | advance | `VISION.md` |
| M | zone map; the game pauses while it is open; M or Esc closes it | `VISION.md` · (D) G11 |
| W / A / S / D or arrows, drag, wheel, Q / E, Enter (map open) | move the view; zoom out (wheel down, Q) or in (wheel up, E), three levels; Enter centres on Akeris | (D) G21 |
| Esc | pause menu: manual save, full inventory, stats | `VISION.md` |
| Mouse (point, click) or W / S / arrow keys + Enter | choose in any menu | (D) G10 |
| Esc (in a menu) | back, or close | (D) G10 |

## 5. Operator decisions of 2026-09-30

Each answers a gap the vision left, or changes what it said. The translator moves them into
`VISION.md` in plan step 5.1.

| # | Question | Decision | Changes `VISION.md` |
|---|---|---|---|
| G1 | How does Akeris run? | holding A/D speeds the walk into a run | no, settles it |
| G2 | What do W/S do in a jump? | a tap of Space is the normal jump; **holding Space is the high jump** (released before the normal height, the rise stops there), with A or D to the side; W does not change the jump; S in the air is the fast descent. Revised by the operator on 2026-10-01: it was Space + W | yes: §Mechanics, Movement |
| G3 | How is each melee attack chosen? | repeated clicks are the combo (diagonal, rising, thrust); W + click the overhead strike; in the air the aerial attack | no, settles it |
| G4 | Shield held or toggled? | held | no, settles it |
| G5 | How is each chain use chosen? | by the target the mouse reaches, and by W, S or holding the click | no, settles it |
| G6 | How is a ring caught? | chain blades equipped, left click with a ring in reach near or above | no, settles it |
| G7 | What opens the counter? | only a shield block just before a **melee** hit. A projectile blocked just before impact flies back, faster, at its thrower and damages it, without a counter. Projectiles can no longer be split | yes: §Mechanics, Counter; §Bosses, Golem ("dodge or split them") |
| G8 | What do the wheel and the number keys do? | weapons only: the wheel cycles the slots, 1–5 pick one. Potions only on F, abilities only on Q/E/R | yes: §Mechanics, Potions and Weapons (quick inventory) |
| G9 | What is in hand after drinking? | the weapon held before | yes: §Mechanics, Potions ("select one with the wheel and hold attack" is removed) |
| G10 | How are menus navigated? | mouse and keyboard; Esc goes back | no, settles it |
| G11 | Does the map pause? | yes | no, settles it |
| G12 | What does the free hand hold on catching a ring? | always the hook blade; the wheel swaps it for the shield while hanging; a throw to the next ring swaps hands and gives the new free hand its hook blade | yes: new mechanic (§3.1) |
| G13 | A block just before a melee hit while hanging? | opens a counter, struck with the free hook blade | yes: new mechanic |
| G14 | What can the free hand's throw do? | strike, snatch, hook a boss part; not pull, climb or anchor | yes: new mechanic |
| G15 | Potion or abilities while hanging? | abilities yes, potion no | yes: new mechanic |
| G16 | What does each shield do when it blocks a melee hit? | **sacred:** a perfect block opens the counter; it is the only shield that does. **Ice:** a perfect block freezes the attacker for 1.5 s and lowers its defence while frozen. **Fire:** a perfect block sets the attacker burning for 1.5 s, losing health. With both, a block at any other moment only stops the hit (revised by the operator, 2026-09-30: it was "any block"). Only the fire shield blocks fire attacks, and only the ice shield blocks ice attacks, without Akeris taking damage; with any other shield he takes the hit (`02-art-direction/fx/elements/elements.md`). A perfect block against a projectile reflects it with any shield that stops it: reflecting is not a counter. The reflected projectile damages its thrower; reflected with the ice shield it also freezes it 0.5 s, with the fire shield it burns it 0.5 s | yes: §Mechanics, Counter and Shields (the ice shield no longer "raises counter-burst damage") |
| G17 | How are items picked up? | weapons, shields and scrolls lie on stone altars off the main path; G near an altar takes what is on it. XP and coins are collected without a key (`05-items/items.md` §6, D-I6) | yes: §Mechanics, §Input scheme (new key G) |
| G18 | Can a roll be cancelled, and can he roll in the air? | Space while rolling jumps out of the roll keeping its speed (holding Space, the high jump). Shift in the air is an air roll: a somersault with the roll's brief invulnerability, keeping the jump's path, once per jump. Shift also cuts a strike: on the ground the roll interrupts any strike, the shield's pushback and the hook-blades' actions (their chains come back); in the air it interrupts the air strike (operator, 2026-10-01). Being hurt, the counter, drinking, hanging and the walls are not cut | yes: §Mechanics, Movement |
| G19 | Can a ring be caught in mid-jump? | yes: with the chain blades, a click in the air catches a ring in reach even when it is level with Akeris or a little below; aiming the mouse picks the ring nearest the aim (refines G6) | no, settles it |
| G20 | Can he go from wall to wall? | yes: in the air, a click toward another wall within reach drives the blade into it; the chain pulls him across (0.3 s in the sandbox) and he hangs from that wall, ready to climb it or jump to the next | yes: §Mechanics, Chain blades (climb walls) |
| G21 | How is the map moved and zoomed? (`06-ui/map/map.md` U19–U21) | W / A / S / D or the arrows (held), or dragging with the mouse, move the view without leaving the zone; the mouse wheel or Q / E zoom (Q out, E in) between three levels (the whole zone, near, close); Enter centres it on Akeris | no, settles it (adds Q / E on the map) |
| G22 | Can Akeris carry a torch? (zone 4, operator 2026-10-06) | yes: G next to a torch takes it in the free hand (an altar in reach comes first) and G lays it down burning; it burns the webs and curtains he touches and what its flame touches; while carried the shield cannot be raised; a hit drops it; it is never thrown | yes: new mechanic |
