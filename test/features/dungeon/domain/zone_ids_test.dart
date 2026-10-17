import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_ids.dart';

void main() {
  group('ZoneIds', () {
    test('each kind takes its own block of ids', () {
      final zone1 = ZoneIds(const ZoneNumber(1));

      // operator, 2026-10-16
      expect(zone1.room(3), const EntityId(1000003));
      expect(zone1.ring(2), const EntityId(1001002));
      expect(zone1.altar(0), const EntityId(1002000));
      expect(zone1.spirit(1), const EntityId(1003001));
      expect(zone1.platform(4), const EntityId(1004004));

      final zone2 = ZoneIds(const ZoneNumber(2));
      expect(zone2.room(0), const EntityId(2000000));
    });
  });
}
