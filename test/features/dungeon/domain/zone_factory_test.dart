import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_view.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

const ZoneFactory _factory = ZoneFactory();
final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();
const Iterable<int> _seeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// Acceptance: "the zone of Seed(s)" is the Success value of create(...).
Zone _zoneOf(int seed) {
  final result = _factory.create(ZoneNumber.first, _kit, Seed(seed));
  return (result as Success<Zone, ZoneFailure>).value;
}

List<Zone> _zonesOf(Iterable<int> seeds) => [
  for (final seed in seeds) _zoneOf(seed),
];

RoomView _roomOf(Zone zone, EntityId id) =>
    zone.rooms.firstWhere((room) => room.room == id);

Set<EntityId> _reachableFrom(Zone zone, EntityId start) {
  final reached = <EntityId>{start};
  final open = [start];
  while (open.isNotEmpty) {
    final id = open.removeLast();
    for (final neighbour in _roomOf(zone, id).neighbours) {
      if (reached.add(neighbour)) {
        open.add(neighbour);
      }
    }
  }
  return reached;
}

void main() {
  group('ZoneFactory', () {
    test('every seed builds a zone', () {
      for (final seed in _seeds) {
        final result = _factory.create(ZoneNumber.first, _kit, Seed(seed));

        expect(result, isA<Success<Zone, ZoneFailure>>());
      }
    });

    test('the same seed builds the same zone', () {
      final a = _zoneOf(1);
      final b = _zoneOf(1);

      expect(a.rooms, b.rooms);
      expect(a.altars, b.altars);
      expect(a.spirits, b.spirits);
      expect(a.start, b.start);
      expect(a.wayDown, b.wayDown);
    });

    test('another seed builds another zone', () {
      final a = _zoneOf(1);
      final b = _zoneOf(2);

      expect(a.rooms, isNot(b.rooms));
    });

    test('every zone holds 36 to 44 rooms', () {
      for (final zone in _zonesOf(_seeds)) {
        expect(zone.rooms.length, inInclusiveRange(36, 44));
      }
    });

    test('every zone has a main path of 13 rooms', () {
      for (final zone in _zonesOf(_seeds)) {
        final onMainPath = zone.rooms.where((room) => room.isOnMainPath);

        expect(onMainPath.length, 13);
      }
    });

    test('every zone has 8 altars and a lore spirit off the main path', () {
      for (final zone in _zonesOf(_seeds)) {
        expect(zone.altars.length, 8);
        for (final altar in zone.altars) {
          expect(_roomOf(zone, altar.room).isOnMainPath, isFalse);
        }

        final lore = zone.spirits.firstWhere(
          (spirit) => spirit.role == SpiritRole.lore,
        );
        final warning = zone.spirits.firstWhere(
          (spirit) => spirit.role == SpiritRole.warning,
        );

        expect(_roomOf(zone, lore.room).isOnMainPath, isFalse);
        expect(_roomOf(zone, warning.room).isOnMainPath, isTrue);
      }
    });

    test('every room is reachable from the start', () {
      for (final zone in _zonesOf(_seeds)) {
        final start = zone.roomContaining(zone.start);

        expect(start, isNotNull);
        expect(_reachableFrom(zone, start!).length, zone.rooms.length);
      }
    });

    test('the boss room is two cells wide on the main path', () {
      for (final zone in _zonesOf(_seeds)) {
        final boss = _roomOf(zone, zone.bossRoom);

        expect(boss.bounds.right - boss.bounds.left, 3200);
        expect(boss.bounds.bottom - boss.bounds.top, 1024);
        expect(boss.isOnMainPath, isTrue);
      }
    });

    test('a zone spans its grid', () {
      final zone = _zoneOf(1);

      expect(zone.bounds, edgesBox(0, 0, 35200, 8192));
    });
  });
}
