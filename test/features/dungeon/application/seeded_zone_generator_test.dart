import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/zone_entered.dart';
import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/features/dungeon/application/seeded_zone_generator.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

import '../mocks.dart';

void main() {
  group('SeededZoneGenerator', () {
    late MockZoneRepository zones;
    late MockEventSink events;
    late SeededZoneGenerator generator;

    setUpAll(() {
      final built = const ZoneFactory().create(
        ZoneNumber.first,
        SuspendedSanctuaryKit(),
        const Seed(1),
      );
      registerFallbackValue((built as Success<Zone, ZoneFailure>).value);
      registerFallbackValue(
        const ZoneEntered(
          zone: ZoneNumber.first,
          biome: Biome.suspendedSanctuary,
        ),
      );
    });

    setUp(() {
      zones = MockZoneRepository();
      events = MockEventSink();
      generator = SeededZoneGenerator(
        kits: [SuspendedSanctuaryKit()],
        zones: zones,
        events: events,
      );
    });

    test('generates zone 1 as the Suspended Sanctuary', () {
      final state = generator.generate(ZoneNumber.first, const Seed(42));

      expect(state.zone, ZoneNumber.first);
      expect(state.biome, Biome.suspendedSanctuary);
      expect(state.rooms.length, inInclusiveRange(36, 44));
    });

    test('saves the zone it generated', () {
      generator.generate(ZoneNumber.first, const Seed(42));

      final saved = verify(() => zones.save(captureAny())).captured;
      expect(saved, hasLength(1));
      expect((saved.single as Zone).number, ZoneNumber.first);
    });

    test('publishes the zone entered', () {
      generator.generate(ZoneNumber.first, const Seed(42));

      final published = verify(() => events.publish(captureAny())).captured;
      expect(published, hasLength(1));
      final entered = published.single as ZoneEntered;
      expect(entered.zone, ZoneNumber.first);
      expect(entered.biome, Biome.suspendedSanctuary);
    });

    test('the same seed generates the same zone', () {
      final a = generator.generate(ZoneNumber.first, const Seed(42));
      final b = generator.generate(ZoneNumber.first, const Seed(42));

      expect(a.rooms.length, b.rooms.length);
      for (var i = 0; i < a.rooms.length; i++) {
        expect(a.rooms[i].room, b.rooms[i].room);
        expect(a.rooms[i].bounds, b.rooms[i].bounds);
      }
    });

    test('another seed generates another zone', () {
      final a = generator.generate(ZoneNumber.first, const Seed(42));
      final b = generator.generate(ZoneNumber.first, const Seed(43));

      expect(a.rooms, isNot(b.rooms));
    });

    test('refuses a zone with no kit yet', () {
      expect(
        () => generator.generate(const ZoneNumber(2), const Seed(42)),
        throwsStateError,
      );

      verifyNever(() => zones.save(any()));
      verifyNever(() => events.publish(any()));
    });
  });
}
