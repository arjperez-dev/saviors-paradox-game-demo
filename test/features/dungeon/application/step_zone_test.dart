import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/features/dungeon/application/step_zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

import '../mocks.dart';

const ZoneFactory _factory = ZoneFactory();
final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();

Zone _zoneOf(int seed) {
  final result = _factory.create(ZoneNumber.first, _kit, Seed(seed));
  return (result as Success<Zone, ZoneFailure>).value;
}

// Acceptance: the first zone of seeds 1-10 that holds drifting platforms
// (04-zones/zone-1-suspended-sanctuary/hazards.md).
Zone _theZone() {
  for (var seed = 1; seed <= 10; seed++) {
    final zone = _zoneOf(seed);
    if (zone.platforms.isNotEmpty) {
      return zone;
    }
  }
  fail('no zone of seeds 1-10 holds drifting platforms');
}

bool _anyPlatformMoved(Zone zone, List<Object> before) {
  for (var i = 0; i < zone.platforms.length; i++) {
    if (zone.platforms[i] != before[i]) {
      return true;
    }
  }
  return false;
}

void main() {
  setUpAll(() => registerFallbackValue(_zoneOf(1)));

  group('StepZone', () {
    late MockZoneRepository zones;
    late StepZone step;

    setUp(() {
      zones = MockZoneRepository();
      step = StepZone(zones);
    });

    test('moves the drifting platforms with the step', () {
      final zone = _theZone();
      when(() => zones.load()).thenReturn(zone);
      final before = List.of(zone.platforms);

      step.step(const Seconds(1));

      expect(_anyPlatformMoved(zone, before), isTrue);
      verify(() => zones.save(zone)).called(1);
    });

    test('the state shows the zone it holds', () {
      final zone = _theZone();
      when(() => zones.load()).thenReturn(zone);

      final state = step.state;

      expect(state.zone, ZoneNumber.first);
      expect(state.rooms.length, zone.rooms.length);
    });

    test('the state is rebuilt only when the zone changes', () {
      final zone = _theZone();
      when(() => zones.load()).thenReturn(zone);

      final first = step.state;
      final second = step.state;
      expect(second, same(first));

      zone.sealBossRoom();
      final third = step.state;
      expect(third, isNot(same(first)));
      expect(third.isBossRoomSealed, isTrue);

      step.step(const Seconds(1 / 60));
      final fourth = step.state;
      expect(fourth, same(third));
    });

    test('before any zone the state is refused', () {
      when(() => zones.load()).thenReturn(null);

      expect(() => step.state, throwsStateError);
      step.step(const Seconds(1 / 60));

      verifyNever(() => zones.save(any()));
    });
  });
}
