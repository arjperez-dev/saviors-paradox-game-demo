import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

/// The ids of what a zone holds: 1 000 000 × its number, plus a block of
/// 1000 per kind (operator, 2026-10-16; no contract hands ids out yet).
final class ZoneIds {
  const ZoneIds(this.zone);

  final ZoneNumber zone;

  EntityId room(int index) => _at(0, index);

  EntityId ring(int index) => _at(1000, index);

  EntityId altar(int index) => _at(2000, index);

  EntityId spirit(int index) => _at(3000, index);

  EntityId platform(int index) => _at(4000, index);

  EntityId _at(int block, int index) {
    assert(index >= 0 && index < 1000, 'an index fits its block');
    return EntityId(zone.value * 1000000 + block + index);
  }

  @override
  bool operator ==(Object other) => other is ZoneIds && other.zone == zone;

  @override
  int get hashCode => zone.hashCode;
}
