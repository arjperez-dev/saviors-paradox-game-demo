---
factory_version: 4.3.0
---

# Wave 5 carries dungeon, combat, akeris and chain

- **Date:** 2026-10-17
- **Outcome:** 56 tasks: dungeon T107–T112, T140–T142; combat T113, T114, T143–T145; akeris T115–T139, T146, T147; chain T148–T162. No wiring: presentation and the `core/app` wiring are wave 6.
- **Decisions:** the first playable slice's logic (architecture §2.3 ring 2), tested headless through the loop; the operator kept all 56 in one wave, since chain's critical path (6) runs beside akeris's (12) (operator, 2026-10-17).
- **Deviations:** Akeris's fighting, chain's fighting uses, noise, stagger and the akeris memento are left for later waves.
- **Evidence:** rejected: splitting chain into wave 6; wiring systems nothing draws yet.
