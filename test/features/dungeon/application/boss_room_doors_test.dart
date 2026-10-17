import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_cued.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/features/dungeon/application/boss_room_doors.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

import '../mocks.dart';

const ZoneFactory _factory = ZoneFactory();
final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();

// Acceptance: "the zone of Seed(1)" is the Success value of create(...).
Zone _zoneOfSeed1() {
  final result = _factory.create(ZoneNumber.first, _kit, const Seed(1));
  return (result as Success<Zone, ZoneFailure>).value;
}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const SoundEffectCued(sound: SoundEffectId('fallback'), at: Vec2.zero),
    );
    registerFallbackValue(_zoneOfSeed1());
  });

  group('BossRoomDoors', () {
    late MockZoneRepository zones;
    late MockEventSink events;
    late BossRoomDoors doors;

    setUp(() {
      zones = MockZoneRepository();
      events = MockEventSink();
      doors = BossRoomDoors(zones, events);
    });

    test('opens sealed doors with their sound', () {
      final zone = _zoneOfSeed1();
      zone.sealBossRoom();
      when(() => zones.load()).thenReturn(zone);
      final centre = zone.rooms
          .firstWhere((room) => room.room == zone.bossRoom)
          .bounds
          .centre;

      doors.unseal();

      expect(zone.isWayDownOpen, isTrue);
      final captured = verify(() => events.publish(captureAny())).captured;
      expect(captured, hasLength(1));
      final cued = captured.single as SoundEffectCued;
      expect(cued.sound, BossRoomDoors.opened);
      expect(cued.at, centre);
      verify(() => zones.save(zone)).called(1);
    });

    test('doors that never sealed stay as they were', () {
      final zone = _zoneOfSeed1();
      when(() => zones.load()).thenReturn(zone);

      doors.unseal();

      expect(zone.isWayDownOpen, isFalse);
      verifyNever(() => events.publish(any()));
      verify(() => zones.save(zone)).called(1);
    });

    test('with no zone nothing happens', () {
      when(() => zones.load()).thenReturn(null);

      doors.unseal();

      verifyNever(() => events.publish(any()));
      verifyNever(() => zones.save(any()));
    });
  });
}
