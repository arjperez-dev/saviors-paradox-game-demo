import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

void main() {
  group('Seed', () {
    test('derives the same zone seed from the same run seed', () {
      expect(
        const Seed(42).forZone(const ZoneNumber(3)),
        const Seed(42).forZone(const ZoneNumber(3)),
      );
    });

    test('derives different seeds for different zones', () {
      expect(
        const Seed(42).forZone(const ZoneNumber(1)),
        isNot(const Seed(42).forZone(const ZoneNumber(2))),
      );
    });

    test('derives different zone seeds from different run seeds', () {
      expect(
        const Seed(42).forZone(const ZoneNumber(1)),
        isNot(const Seed(43).forZone(const ZoneNumber(1))),
      );
    });

    test(
      'derives different seeds for a zone, a room and an entity of one index',
      () {
        const seed = Seed(42);
        final zone = seed.forZone(const ZoneNumber(1));
        final room = seed.forRoom(1);
        final entity = seed.forEntity(const EntityId(1));

        expect(zone, isNot(room));
        expect(zone, isNot(entity));
        expect(room, isNot(entity));
      },
    );
  });
}
