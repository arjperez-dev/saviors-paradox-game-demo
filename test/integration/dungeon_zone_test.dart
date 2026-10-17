import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_cued.dart';
import 'package:saviors_paradox/core/contracts/events/zone_entered.dart';
import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/features/dungeon/application/boss_room_doors.dart';
import 'package:saviors_paradox/features/dungeon/application/seeded_zone_generator.dart';
import 'package:saviors_paradox/features/dungeon/application/step_zone.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_altars.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_collision_world.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/infrastructure/in_memory_zone_repository.dart';

const Seconds _oneFrame = Seconds(1 / 60);

// Acceptance (hazards.md): the first of seeds 1-10 whose generated zone
// holds drifting platforms.
List<WorldBox>? _firstSeededPlatforms(
  SeededZoneGenerator generator,
  InMemoryZoneRepository zones,
) {
  for (var seed = 1; seed <= 10; seed++) {
    generator.generate(ZoneNumber.first, Seed(seed));
    final platforms = zones.load()!.platforms;
    if (platforms.isNotEmpty) {
      return List.of(platforms);
    }
  }
  return null;
}

bool _anyBoxChanged(List<WorldBox> before, List<WorldBox> after) {
  for (var i = 0; i < before.length; i++) {
    if (before[i] != after[i]) {
      return true;
    }
  }
  return false;
}

void main() {
  group('a zone from its seed to its collisions through the loop', () {
    late InMemoryZoneRepository zones;
    late EventQueue queue;
    late SeededZoneGenerator generator;
    late ZoneCollisionWorld collisionWorld;
    late BossRoomDoors doors;
    late ZoneAltars altars;
    late StepZone stepZone;
    late GameLoop loop;

    setUp(() {
      zones = InMemoryZoneRepository();
      queue = EventQueue();
      generator = SeededZoneGenerator(
        kits: [SuspendedSanctuaryKit()],
        zones: zones,
        events: queue,
      );
      collisionWorld = ZoneCollisionWorld(zones);
      doors = BossRoomDoors(zones, queue);
      altars = ZoneAltars(zones);
      stepZone = StepZone(zones);
      loop = GameLoop(
        queue: queue,
        clock: StepClock(),
        systems: [stepZone.step],
      );
    });

    test("a run's seed becomes a zone the loop publishes", () {
      final published = <GameEvent>[];
      queue.subscribe<GameEvent>(published.add);

      generator.generate(ZoneNumber.first, const Seed(42));
      loop.advance(_oneFrame);

      expect(published, hasLength(1));
      final entered = published.single as ZoneEntered;
      expect(entered.zone, ZoneNumber.first);
      expect(entered.biome, Biome.suspendedSanctuary);
      final rooms = stepZone.state.rooms;
      // layout.md §B.1: 36-44 rooms, a main path of 13.
      expect(rooms.length, inInclusiveRange(36, 44));
      expect(rooms.where((room) => room.isOnMainPath).length, 13);
    });

    test('a body dropped at the start lands on the generated floor', () {
      final state = generator.generate(ZoneNumber.first, const Seed(42));

      final hit = collisionWorld.sweep(
        WorldBox(
          centre: state.start - const Vec2(0, 200),
          halfWidth: 20,
          halfHeight: 96,
        ),
        const Vec2(0, 400),
      );

      expect(hit, isNotNull);
      expect(hit!.normal, const Vec2(0, -1));
      expect(hit.point.y, closeTo(state.start.y - 96, 1e-9));
    });

    test('the drifting platforms move while the loop steps', () {
      final before = _firstSeededPlatforms(generator, zones);
      if (before == null) {
        fail('no zone of seeds 1-10 holds drifting platforms');
      }

      for (var frame = 0; frame < 60; frame++) {
        loop.advance(_oneFrame);
      }

      expect(_anyBoxChanged(before, zones.load()!.platforms), isTrue);
    });

    test('opening sealed doors sounds through the loop', () {
      generator.generate(ZoneNumber.first, const Seed(42));
      loop.advance(_oneFrame);
      zones.load()!.sealBossRoom();
      final published = <GameEvent>[];
      queue.subscribe<GameEvent>(published.add);

      doors.unseal();
      loop.advance(_oneFrame);

      expect(published, hasLength(1));
      final cued = published.single as SoundEffectCued;
      expect(cued.sound, BossRoomDoors.opened);
      expect(stepZone.state.isBossRoomSealed, isFalse);
    });

    test("an item returned to an altar shows in the zone's state", () {
      final state = generator.generate(ZoneNumber.first, const Seed(42));

      altars.returnTo(
        state.altars.first.altar,
        const AltarShield(shield: ShieldId.ice),
      );

      final item = stepZone.state.altars.first.item;
      expect(item, isA<AltarShield>());
      expect((item as AltarShield).shield, ShieldId.ice);
    });
  });
}
