# Zone 1 — Suspended Sanctuary: hazards

- **Status:** approved 2026-10-01
- **Sandbox:** [`sandbox/sandbox.html`](sandbox/sandbox.html) (*Ir a… → abismo*) · **Captures:**
  [`abismo`](sandbox/captures/abismo.png), [`deriva`](sandbox/captures/deriva.png),
  [`caida`](sandbox/captures/caida.png)
- **Sources:** `VISION.md` §Scope («drifting platforms and chasms (1)») · the operator's decision of
  2026-10-01 (a fall costs health and returns to the last firm ground) · `05-items/scrolls/` (the curse)
- **Read by:** the tasks that build the hazards; the tester

The list is closed: the zone 1 hazards are the abyss and the drifting platforms. The Golem's
levitation field and its rock rain belong to its contract (step 3.11).

| Hazard | Where | Telegraph (s) | Effect on the player | Look | Sound |
|---|---|---|---|---|---|
| **abyss** | every gap between islands; the void below a room | none: it is always visible as void, darker the deeper | falling below the bottom of the room he was in: the fall runs 0.45 s, the screen goes dark in 0.25 s, Akeris is back at the **last firm ground** and loses health (sandbox: 2; **the game decides**); the dark lifts in 0.3 s. With a curse active, the damage kills him, as any damage does | the void: far cavern, fog, darkness | `sfx.zone1.fall` |
| **drifting platform** | corridors `gap` and `bridge`, shaft `lift` | its whole path is its motion: it eases out and back (`(1 − cos)/2`) along one line, never jerks | carries Akeris while he stands on it; if it rises into him from below, he ends up on top; it never crushes | a small island (`sheet.png`) | — |

**Last firm ground:** the last place where Akeris stood still or landed on an island (never on a
platform) with both feet on stone (26 su each side of his centre). Teleports to a room count as firm
ground.

## Proposals for the operator (Z10–Z11)

| # | Question | Proposal (as the sandbox does it) |
|---|---|---|
| Z10 | The fall | 0.45 s of falling, 0.25 s to dark, back at the last firm ground, 0.3 s to light; a stand-in 2 of damage until the game sets it |
| Z11 | Platform motion | eased back and forth along a line, periods of 3.6–6 s; they carry Akeris and never crush him |

## Never

- A fall that kills outright (except with the curse).
- A respawn on a platform or at the edge of a gap.
- A platform that jitters, snaps or leaves Akeris standing in the air.

## Acceptance

1. Falling into any gap returns Akeris to his last firm ground, with the damage and the dark of the
   table, and plays `sfx.zone1.fall`.
2. With a curse active, falling kills him.
3. Standing on a drifting platform carries him with it, up, down and sideways, with no slipping.
4. A platform rising under him puts him on top.
