---
factory_version: 4.3.0
---

# Contract events/player_command

- **Date:** 2026-10-14
- **Outcome:** `PlayerCommand`, emitted by input, pause; consumed by abilities, akeris, arsenal, cinematics, dungeon, hazards, home, map, narrative, settings.
- **Decisions:** A sealed family of intents: press/release pairs, aim, menu, map and pause-menu commands (`design-patterns.md` §5). An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** `design-patterns.md` §5 names the type a contract; placed in `events/` because the four folders hold no commands (operator, 2026-10-14).
- **Evidence:** rejected: keeping it in `core/input` as shared code, which `pause` could not emit before `input` reached `main`.
