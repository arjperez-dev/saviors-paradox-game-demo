import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_builder.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_validator.dart';
import 'package:saviors_paradox/features/dungeon/infrastructure/in_memory_zone_repository.dart';

final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();
const ZoneValidator _validator = ZoneValidator(
  fewestRooms: 36,
  fewestDeadEnds: 9,
);

List<Zone> _firstValidZones(int count) {
  final zones = <Zone>[];
  for (var s = 1; zones.length < count; s++) {
    final layout = const ZoneBuilder().build(_kit, Seed(s));
    if (layout != null && _validator.isSatisfiedBy(layout)) {
      zones.add(
        Zone.of(
          number: ZoneNumber.first,
          kit: _kit,
          seed: Seed(s),
          layout: layout,
        ),
      );
    }
  }
  return zones;
}

void main() {
  group('InMemoryZoneRepository', () {
    late InMemoryZoneRepository repository;

    setUp(() => repository = InMemoryZoneRepository());

    test('holds no zone before one is saved', () {
      expect(repository.load(), isNull);
    });

    test('loads the zone saved last', () {
      final zones = _firstValidZones(2);
      final a = zones[0];
      final b = zones[1];

      repository.save(a);
      repository.save(b);

      expect(repository.load(), same(b));
    });
  });
}
