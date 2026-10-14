---
factory_version: 4.3.0
---

# Contract ports/run_memento_source

- **Date:** 2026-10-14
- **Outcome:** `RunMementoSource`, implemented by abilities, akeris, arsenal, dungeon, enemies, hazards, inventory, map, run; consumed by save.
- **Decisions:** Every feature with run state is an originator; `save` is the caretaker (`design-patterns.md` §11). An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** `design-patterns.md` §11 had `Run.capture()` gather everything; split per originator (operator, 2026-10-14).
- **Evidence:** rejected: `run` capturing every feature's state, which would make it depend on all of them.
