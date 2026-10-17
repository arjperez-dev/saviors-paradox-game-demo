import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point_kind.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_collision_world.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

import '../mocks.dart';

const ZoneFactory _factory = ZoneFactory();
final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();

// Acceptance: "the zone" is the zone of Seed(1), and `start` is its `start`.
Zone _theZone() {
  final result = _factory.create(ZoneNumber.first, _kit, const Seed(1));
  return (result as Success<Zone, ZoneFailure>).value;
}

void main() {
  group('ZoneCollisionWorld', () {
    late MockZoneRepository zones;
    late ZoneCollisionWorld world;
    late Zone zone;
    late Vec2 start;

    setUp(() {
      zones = MockZoneRepository();
      zone = _theZone();
      start = zone.start;
      when(() => zones.load()).thenReturn(zone);
      world = ZoneCollisionWorld(zones);
    });

    test('a body dropped above the start lands on its floor', () {
      final box = WorldBox(
        centre: start - const Vec2(0, 200),
        halfWidth: 20,
        halfHeight: 96,
      );

      final hit = world.sweep(box, const Vec2(0, 400));

      expect(hit, isNotNull);
      expect(hit!.normal, const Vec2(0, -1));
      expect(hit.point.y, closeTo(start.y - 96, 1e-9));
    });

    test('a cast through the floor meets it', () {
      final hit = world.cast(
        start - const Vec2(0, 50),
        start + const Vec2(0, 50),
      );

      expect(hit, isNotNull);
      expect(hit!.point.y, closeTo(start.y, 1e-9));
      expect(hit.fraction, closeTo(0.5, 1e-9));
    });

    test("the start's floor is solid and its air is not", () {
      expect(world.isSolidAt(start + const Vec2(0, 10)), isTrue);
      expect(world.isSolidAt(start - const Vec2(0, 10)), isFalse);
    });

    test('a point outside every room is abyss', () {
      expect(world.isAbyssAt(const Vec2(-1, -1)), isTrue);
      expect(world.isAbyssAt(start - const Vec2(0, 10)), isFalse);
    });

    test("the zone's rings are ring hook points", () {
      final points = world.hookPointsNear(zone.bounds.centre, 1e9).toList();

      expect(points, isNotEmpty);
      for (final point in points) {
        expect(point.kind, HookPointKind.ring);
        expect(point.id.value, inInclusiveRange(1001000, 1001999));
      }
    });

    test('before any zone nothing collides', () {
      final empty = MockZoneRepository();
      when(() => empty.load()).thenReturn(null);
      final emptyWorld = ZoneCollisionWorld(empty);

      expect(
        emptyWorld.sweep(
          const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
          const Vec2(0, 1),
        ),
        isNull,
      );
      expect(emptyWorld.cast(Vec2.zero, const Vec2(0, 1)), isNull);
      expect(emptyWorld.isSolidAt(Vec2.zero), isFalse);
      expect(emptyWorld.isAbyssAt(Vec2.zero), isFalse);
      expect(emptyWorld.hookPointsNear(Vec2.zero, 1), isEmpty);
    });
  });
}
