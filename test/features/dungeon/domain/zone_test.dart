import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';
import 'package:saviors_paradox/features/dungeon/domain/dead_end_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_builder.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_event.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_validator.dart';

final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();
const ZoneValidator _validator = ZoneValidator(
  fewestRooms: 36,
  fewestDeadEnds: 9,
);

// Acceptance: the first seed from 1 whose layout the validator passes.
List<({int seed, ZoneLayout layout})> _firstValidLayouts(int count) {
  final found = <({int seed, ZoneLayout layout})>[];
  for (var s = 1; found.length < count; s++) {
    final layout = const ZoneBuilder().build(_kit, Seed(s));
    if (layout != null && _validator.isSatisfiedBy(layout)) {
      found.add((seed: s, layout: layout));
    }
  }
  return found;
}

final List<({int seed, ZoneLayout layout})> _found = _firstValidLayouts(3);

Zone _zoneFrom(({int seed, ZoneLayout layout}) found) => Zone.of(
  number: ZoneNumber.first,
  kit: _kit,
  seed: Seed(found.seed),
  layout: found.layout,
);

Zone _aZone() => _zoneFrom(_found.first);

Zone? _firstZoneWithPlatforms() {
  for (final found in _found) {
    final zone = _zoneFrom(found);
    if (zone.platforms.isNotEmpty) {
      return zone;
    }
  }
  return null;
}

Vec2 _featureSpotOf(PlacedRoom room, ZoneGrid grid) {
  final spot = room.template.spot(SpotKind.feature);
  if (spot == null) {
    fail('room ${room.template.id} has no feature spot');
  }
  return room.originOn(grid) + spot;
}

void main() {
  group('Zone', () {
    test('a zone holds a room for every room of its layout', () {
      final zone = _aZone();

      expect(zone.rooms.length, _found.first.layout.rooms.length);
      for (var i = 0; i < zone.rooms.length; i++) {
        expect(zone.rooms[i].room, EntityId(1000000 + i));
      }
      final bossRooms = zone.rooms.where((room) => room.isBossRoom);
      expect(bossRooms.length, 1);
      expect(bossRooms.single.room, zone.bossRoom);
    });

    test('the room holding a point is found by its id', () {
      final zone = _aZone();

      expect(zone.roomContaining(zone.start), zone.rooms.first.room);
      expect(zone.roomContaining(const Vec2(-10, -10)), isNull);
    });

    test(
      'a zone stands its spirits, start and way down where the layout says',
      () {
        final zone = _aZone();
        final layout = _found.first.layout;
        final startRoom = layout.rooms.firstWhere(
          (room) => room.kind == RoomKind.start,
        );
        final exitRoom = layout.rooms.firstWhere(
          (room) => room.kind == RoomKind.wayDown,
        );
        final loreRoom = layout.rooms.firstWhere(
          (room) => room.role == DeadEndRole.lore,
        );
        final anteRoom = layout.rooms.firstWhere(
          (room) => room.kind == RoomKind.antechamber,
        );

        expect(zone.spirits.length, 2);
        final lore = zone.spirits.firstWhere(
          (spirit) => spirit.role == SpiritRole.lore,
        );
        final warning = zone.spirits.firstWhere(
          (spirit) => spirit.role == SpiritRole.warning,
        );
        expect(lore.room, EntityId(1000000 + loreRoom.index));
        expect(warning.room, EntityId(1000000 + anteRoom.index));

        expect(
          zone.start,
          startRoom.originOn(layout.grid) + const Vec2(660, 700),
        );
        expect(
          zone.wayDown,
          exitRoom.originOn(layout.grid) + const Vec2(1120, 700),
        );
      },
    );

    test('a zone holds an empty altar in each altar dead end', () {
      final zone = _aZone();
      final layout = _found.first.layout;
      final altarRooms = [
        for (final room in layout.rooms)
          if (room.role == DeadEndRole.altar) room,
      ];

      expect(zone.altars.length, 8);
      expect(altarRooms.length, 8);
      for (var i = 0; i < zone.altars.length; i++) {
        final view = zone.altars[i];
        final room = altarRooms[i];

        expect(view.gift, isNull);
        expect(view.room, EntityId(1000000 + room.index));
        expect(view.position, _featureSpotOf(room, layout.grid));
      }
    });

    test('the altar within 80 su of a point is found', () {
      final zone = _aZone();
      final altar = zone.altars.first.altar;
      final position = zone.altars.first.position;

      expect(zone.altarWithinReach(position + const Vec2(80, 0)), altar);
      final beyond = zone.altarWithinReach(position + const Vec2(80.01, 0));
      expect(beyond == altar, isFalse);
    });

    test('taking from an empty altar changes nothing', () {
      final zone = _aZone();
      final altar = zone.altars.first.altar;

      expect(zone.takeFrom(altar), isNull);
      expect(zone.revision, 0);
    });

    test('an item returns only to an empty altar', () {
      final zone = _aZone();
      final altar = zone.altars.first.altar;
      const gift = ScrollGift(ScrollKind.health);

      final returned = zone.returnTo(altar, gift);

      expect(returned, ItemReturnedToAltar(altar: altar, gift: gift));
      expect(zone.returnTo(altar, const WeaponGift(WeaponId.spear)), isNull);
      expect(zone.giftOn(altar), gift);
    });

    test('taking from an altar empties it', () {
      final zone = _aZone();
      final altar = zone.altars.first.altar;
      final position = zone.altars.first.position;
      const gift = ShieldGift(ShieldId.ice);

      zone.returnTo(altar, gift);
      final taken = zone.takeFrom(altar);

      expect(taken, ItemTakenFromAltar(altar: altar, gift: gift, at: position));
      expect(zone.giftOn(altar), isNull);
    });

    test('the doors seal once', () {
      final zone = _aZone();

      final sealed = zone.sealBossRoom();

      expect(sealed, BossRoomSealed(room: zone.bossRoom, boss: BossId.golem));
      expect(zone.isBossRoomSealed, isTrue);
      expect(zone.sealBossRoom(), isNull);
    });

    test('the doors open only after they sealed', () {
      final zone = _aZone();

      expect(zone.unsealBossRoom(), isNull);
      expect(zone.isWayDownOpen, isFalse);
      expect(zone.isBossRoomSealed, isFalse);
    });

    test('the way down stays closed until the doors open', () {
      final zone = _aZone();
      final layout = _found.first.layout;
      final bossRoom = layout.rooms.firstWhere(
        (room) => room.kind == RoomKind.boss,
      );
      final centre = bossRoom.boundsOn(layout.grid).centre;

      expect(zone.isWayDownOpen, isFalse);
      zone.sealBossRoom();
      expect(zone.isWayDownOpen, isFalse);

      final unsealed = zone.unsealBossRoom();

      expect(unsealed, BossRoomUnsealed(room: zone.bossRoom, at: centre));
      expect(zone.isWayDownOpen, isTrue);
      expect(zone.sealBossRoom(), isNull);
    });

    test('every change raises the revision', () {
      final zone = _aZone();
      final altar = zone.altars.first.altar;

      expect(zone.revision, 0);

      zone.returnTo(altar, const ScrollGift(ScrollKind.health));
      expect(zone.revision, 1);

      zone.takeFrom(altar);
      expect(zone.revision, 2);

      zone.sealBossRoom();
      expect(zone.revision, 3);

      zone.unsealBossRoom();
      expect(zone.revision, 4);

      zone.advance(const Seconds(1));
      expect(zone.revision, 4);
    });

    test('the views a zone shows cannot be changed', () {
      final zone = _aZone();

      expect(() => zone.rooms.add(zone.rooms.first), throwsUnsupportedError);
      expect(() => zone.altars.clear(), throwsUnsupportedError);
      expect(() => zone.spirits.removeLast(), throwsUnsupportedError);
      expect(
        () => zone.platforms.add(
          const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
        ),
        throwsUnsupportedError,
      );
    });

    test('the platforms move with time', () {
      final zones = [for (final found in _found) _zoneFrom(found)];
      final withPlatforms = [
        for (final zone in zones)
          if (zone.platforms.isNotEmpty) zone,
      ];

      expect(withPlatforms, isNotEmpty);
      for (final zone in withPlatforms) {
        final before = List<WorldBox>.of(zone.platforms);

        zone.advance(const Seconds(1));

        var changed = false;
        for (var i = 0; i < zone.platforms.length; i++) {
          final box = zone.platforms[i];
          expect(
            box.right - box.left,
            closeTo(before[i].right - before[i].left, 1e-9),
          );
          expect(box.bottom - box.top, closeTo(44, 1e-9));
          if (box != before[i]) {
            changed = true;
          }
        }
        expect(changed, isTrue);
      }
    });

    test("a box falls onto the start's floor", () {
      final zone = _aZone();
      final box = WorldBox(
        centre: zone.start - const Vec2(0, 150),
        halfWidth: 20,
        halfHeight: 96,
      );

      final contact = zone.sweep(box, const Vec2(0, 200));

      expect(contact, isNotNull);
      expect(contact!.normal, const Vec2(0, -1));
      expect(contact.point.y, closeTo(zone.start.y - 96, 1e-9));
    });

    test('a box meets a platform where it stands now', () {
      final zone = _firstZoneWithPlatforms();

      expect(zone, isNotNull);
      final platform = zone!.platforms.first;
      final box = WorldBox(
        centre: Vec2((platform.left + platform.right) / 2, platform.top - 50),
        halfWidth: 10,
        halfHeight: 10,
      );

      final contact = zone.sweep(box, const Vec2(0, 100));

      expect(contact, isNotNull);
      expect(contact!.normal, const Vec2(0, -1));
      expect(contact.point.y, closeTo(platform.top - 10, 1e-9));
    });

    test('the zone answers whether a point is solid or abyss', () {
      final zone = _aZone();

      expect(zone.isSolidAt(zone.start + const Vec2(0, 10)), isTrue);
      expect(zone.isSolidAt(zone.start - const Vec2(0, 10)), isFalse);
      expect(zone.isAbyssAt(const Vec2(-1, -1)), isTrue);
      expect(zone.isAbyssAt(zone.start - const Vec2(0, 10)), isFalse);
    });
  });
}
