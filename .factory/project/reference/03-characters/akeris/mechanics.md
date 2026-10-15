# Akeris — mechanics

- **Status:** approved 2026-09-30 (step 3.5)
- **Sources:** `VISION.md` §Mechanics, §Win / lose conditions · `../../00-game/controls.md` (G1–G16) ·
  `../../00-game/glossary.md`
- **Read by:** the tasks that implement Akeris's movement, combat, chain blades, potions, status
  effects and death; the tester, against §4.

This file is part of Akeris's contract ([`contract.md`](contract.md) §8). It says **which mechanic
each animation serves** and copies the numbers `VISION.md` gives. Every other gameplay number is
**the game's** (`VISION.md` owns them; the architect and the planner fix them there, not here). The
sandbox's own numbers (its speeds, its 0.2 s perfect-block window, its 0.3 s bite) are stand-ins so
that it can be played, never a target.

Rows marked **(D)** are operator decisions not yet in `VISION.md` (plan step 5.1 moves them). P1–P8
were proposed in this step and **decided by the operator on 2026-09-30** (§3), exactly as proposed;
they are (D) rows too.

---

## 1. Numbers

| Property | Value | Source |
|---|---|---|
| health | the game decides | `VISION.md` §Assumptions (open) |
| walk and run speeds | the game decides; holding A/D speeds the walk into a run | `VISION.md` §Mechanics · (D) G1 |
| jump height, high-jump height | the game decides; one fixed height each, holding Space adds nothing | (D) G2 |
| roll: time and invulnerability | the game decides ("brief invulnerability") | `VISION.md` §Mechanics |
| standing height | 192 su = 26 % of the screen height | `VISION.md` §Art direction |
| crouching height | the game decides; the crouch and the roll are drawn lowered to fit it (sandbox: 138 and 112 su) | `VISION.md` §Art direction |
| hitboxes, reach, damage | the game decides | — |
| counter | 1 s of ultra-fast strikes (a ranged burst with the chain blades) | `VISION.md` §Mechanics |
| perfect-block window | the game decides | `VISION.md` §Assumptions (open) |
| frozen / burning, blocked melee hit | 1.5 s | (D) G16 |
| frozen / burning, reflected projectile | 0.5 s | (D) G16 |
| shields' uses | sacred unbreakable; ice 10 hits; fire 4 (fire hits); the special shields refill on entering each zone | `VISION.md` §Mechanics |
| potions carried | 3, refilled on entering each zone | `VISION.md` §Mechanics |
| what a potion heals, how long drinking takes | the game decides (`05-items/`, step 3.6) | — |
| chain range, bite time, spin time | the game decides | — |
| levitation: height, duration, radius | the golem decides (step 3.11) | `VISION.md` §Bosses |

## 2. Which mechanic each animation serves

| Mechanic | Animation (`animations.md` §4) | Notes |
|---|---|---|
| move, run | idle / walk / run, skid | the gait follows the distance the game moved him |
| jump (a tap of Space), high jump (Space held, to a side with A/D) | take-off, air, high jump, land | (D) G2 |
| fast descent (S in the air), stuns where it lands | fast descent | the stun is the game's |
| roll (Shift) | roll | brief invulnerability; cuts a strike in progress (operator, 2026-10-01; `00-game/controls.md` G18) |
| crouch (Left Ctrl) | crouch / crouch-walk | tunnels and low gaps |
| melee combo (clicks) | sword combo | (D) G3 |
| overhead strike (W + click) | overhead strike | (D) G3 |
| aerial attack (click in the air) | aerial attack | |
| block (right click held) | block, block impact | (D) G4 |
| counter, reflect, freeze, burn | counter, block impact | (D) G7, G16 |
| hurt | hurt | |
| chain: ranged strike, snatch, hook a boss part | chain throw | (D) G5 |
| chain: pull toward an enemy | bite → pull | (D) P1 |
| chain: overhead arc (W + click) | overhead arc | |
| chain: area spin (click held) | area spin | (D) P2 |
| chain: climb a wall (Space, then click) | wall climb, wall hang, mantle | |
| chain: ring (click near or above) | swing | (D) G6 |
| hanging: the free hand | free hand, hanging counter | (D) G12–G15, P4–P7 |
| chain: anchor (S + click), the only escape from levitation | anchor | |
| weapon slots (wheel, 1–5) | weapon swap | (D) G8 |
| drink a potion (hold F) | drink | (D) G8, G9, P3 |
| levitation (the golem) | levitate | a status effect |
| death | death | health reaches zero, or damage during the cursed challenge |
| abilities (Q/E/R) | defined with each boss's abilities (steps 3.11–3.15) | not drawn here |

## 3. Operator decisions of 2026-09-30 (D)

Proposed in this step and approved by the operator as proposed. The translator moves them into
`VISION.md` in plan step 5.1; until then no task is planned against them.

| # | Question | Decision (what the sandbox does) |
|---|---|---|
| P1 | `controls.md` §3 leaves open how a **ranged strike** and a **pull** toward an enemy are told apart | A click on an enemy is always a strike. If it hits, **the blade bites** and stays in the enemy for a moment (sandbox 0.3 s). **A second click while it bites pulls Akeris to the enemy**, and he strikes on arrival. No new key; the pull is always a choice made after a hit |
| P2 | A held click is the **area spin**, but a click is also the strike: when is it which? | A click at a ring or a wall acts at once. Otherwise the throw waits for the release: released before 0.18 s it is a strike; held past 0.18 s it becomes the spin, which lasts while the click is held |
| P3 | What happens while drinking? | Akeris stands still. Releasing F before he drinks (sandbox 1.1 s) cancels: nothing is drunk, the potion is not spent, and the weapon comes back at once. A hit interrupts the drink the same way |
| P4 | A hit while hanging from a ring | He never lets go: blocked or not, the swing is pushed away from the attacker. Only Space (or dying) lets go |
| P5 | Which forearm takes the shield when the free hand is the front one? | The shield goes to **whichever hand is free**; the free hand's hook blade goes to the belt |
| P6 | After the hanging counter | The free hand takes the shield back, as before the counter |
| P7 | The free hand's throw when the mouse has not moved (in the last 4 s, `weapons/hook-blades.md`; operator 2026-10-15) | Forward and down (37° below the horizontal), toward what he usually fights from a ring |
| P8 | Can he change weapon while levitating? | Yes (the wheel works), so he can take the chain blades and anchor |

## 4. Rules the tester checks

1. Every animation of `animations.md` §4 is reached from the input or event that `controls.md` gives
   it, and from nothing else.
2. A timed animation lasts the time the game gives it, not the sandbox's.
3. Only the sacred shield opens the counter; the ice and fire shields freeze or burn only on a perfect block, and a normal block only stops the hit;
   a perfect block against a projectile reflects it with any shield that stops it (G16).
4. The chain blades' throws alternate hands; the free hand while hanging always starts with its
   hook blade (G12).
5. The free hand's throw never pulls, climbs or anchors (G14); F does nothing while hanging (G15).
6. After drinking, the weapon held before is back in hand (G9).
7. The anchor needs the chain blades; it ends the levitation.
8. On death nothing of Akeris is left on screen once the ink smoke has gone.
