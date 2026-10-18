---
factory_version: 4.3.0
---

# Contract kernel/entity_id

- **Date:** 2026-10-17
- **Outcome:** No allocator; each owner derives its ids inside its own block, written as the doc comment of `entity_id.dart`; value and semantics unchanged.
- **Decisions:** Derived ids are the same for the same seed and survive a save and restore with nothing more stored; two owners sharing an id would mix bodies in `CombatantRegistry`, so the table sits where implementers read it (operator). Dungeon keeps `ZoneIds`. Abilities derive from `AbilityId.index` and the body's place among that ability's bodies alive at once, reused on a new cast — bounded, not a counter. chain registers no body (its strikes carry Akeris's id, its hook points dungeon's ring ids), narrative's spirits use dungeon's spirit ids, combat's flights use `FlightId`: none owns a block.
- **Deviations:** The architect wrote documentation into a kernel file whose code did not change.
- **Evidence:** rejected: one allocator behind a port — a stateful service whose counter must be in a memento, with ids depending on creation order; rejected: a block reserved for every feature — space with no owner.
