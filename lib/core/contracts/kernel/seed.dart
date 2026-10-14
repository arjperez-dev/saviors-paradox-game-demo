import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

extension type const Seed(int value) {
  Seed forZone(ZoneNumber zone) => _derived(1, zone.value);

  Seed forRoom(int roomIndex) => _derived(2, roomIndex);

  Seed forEntity(EntityId entity) => _derived(3, entity.value);

  Seed _derived(int salt, int index) {
    var mixed =
        value ^ (salt * 0x9E3779B97F4A7C15) ^ (index * 0x632BE59BD9B4E019);
    mixed = (mixed ^ (mixed >>> 30)) * 0xBF58476D1CE4E5B9;
    mixed = (mixed ^ (mixed >>> 27)) * 0x94D049BB133111EB;
    return Seed(mixed ^ (mixed >>> 31));
  }
}
