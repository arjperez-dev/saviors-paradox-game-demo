---
factory_version: 4.3.0
---

# Modules

- **Date:** 2026-10-14
- **Outcome:** 4 shared (loop, rendering, input, localization), 20 features in six rings with dependencies only inward, and integration.
- **Decisions:** rings — dungeon, combat; chain, akeris; hazards, enemies, bosses, arsenal, inventory; abilities; run (process manager), narrative; save, settings, audio, hud, map, pause, cinematics, home. An inner module that needs an outer one declares the port (client-owned), and an outer one learns of inner facts by events.
- **Deviations:** `architecture.md` §2.1 gains hazards, map, pause and cinematics; §2.3's two-way edges removed; XP moves from run to arsenal; the memento is captured per originator with save as caretaker (operator, 2026-10-14). Seven new terms approved for the glossary: Combatant, WorldBox, HookPoint, RaisedShield, StageChange, ChainPull, Snapshot.
- **Evidence:** rejected: `architecture.md` §2.3 as written (akeris ⇄ combat, enemies ⇄ combat); a `core/physics` shared module; map and cinematics inside dungeon and narrative.
