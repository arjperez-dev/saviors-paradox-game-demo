/// The identity of anything that lives in a zone.
///
/// Every id belongs to one owner's block, and each owner derives its ids
/// from its own indices, never from a counter shared with another:
///
/// | Owner | Value |
/// |---|---|
/// | `dungeon` | zone × 1 000 000 + a block of 1000 per kind |
/// | `akeris` | 100 000 000, the only one |
/// | `enemies` | 200 000 000 + zone × 1 000 000 + the spawn point's index in `ZoneState.spawns` |
/// | `bosses` | 300 000 000 + zone × 1 000 000 + the part's index |
/// | `hazards` | 400 000 000 + zone × 1 000 000 + the hazard's index |
/// | `abilities` | 500 000 000 + `AbilityId.index` × 1000 + the body's place among that ability's bodies alive at once |
///
/// `chain`, `narrative` and `combat` own no block.
extension type const EntityId(int value) {}
