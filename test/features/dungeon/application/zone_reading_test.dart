import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point_kind.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_role.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_reading.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';
import 'package:saviors_paradox/features/dungeon/domain/contact.dart';
import 'package:saviors_paradox/features/dungeon/domain/hook_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

const ZoneFactory _factory = ZoneFactory();
final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();

// Acceptance: "the zone" is the zone of Seed(1).
Zone _theZone() {
  final result = _factory.create(ZoneNumber.first, _kit, const Seed(1));
  return (result as Success<Zone, ZoneFailure>).value;
}

void main() {
  group('readZoneState', () {
    test('reads a zone into its state', () {
      final zone = _theZone();

      final state = readZoneState(zone);

      expect(state.zone, ZoneNumber.first);
      expect(state.biome, Biome.suspendedSanctuary);
      expect(state.seed, zone.seed);
      expect(state.bounds, zone.bounds);

      expect(state.rooms.length, zone.rooms.length);
      for (var i = 0; i < zone.rooms.length; i++) {
        final room = zone.rooms[i];
        final snapshot = state.rooms[i];
        expect(snapshot.room, room.room);
        expect(snapshot.bounds, room.bounds);
        expect(snapshot.neighbours, room.neighbours);
        expect(snapshot.isOnMainPath, room.isOnMainPath);
        expect(snapshot.isBossRoom, room.isBossRoom);
      }

      expect(state.spawns, isEmpty);

      expect(state.altars.length, 8);
      for (final altar in state.altars) {
        expect(altar.item, isNull);
      }

      expect(state.spirits.length, 2);
      expect(state.spirits[0].role, SpiritRole.lore);
      expect(state.spirits[0].room, zone.spirits[0].room);
      expect(state.spirits[0].position, zone.spirits[0].position);
      expect(state.spirits[1].role, SpiritRole.warning);
      expect(state.spirits[1].room, zone.spirits[1].room);
      expect(state.spirits[1].position, zone.spirits[1].position);

      expect(state.start, zone.start);
      expect(state.wayDown, zone.wayDown);
      expect(state.bossRoom, zone.bossRoom);
      expect(state.isBossRoomSealed, isFalse);
    });

    test('reads a sealed zone as sealed', () {
      final zone = _theZone();

      zone.sealBossRoom();

      expect(readZoneState(zone).isBossRoomSealed, isTrue);
    });

    test("reads an altar's gift into its item", () {
      final zone = _theZone();
      final altar = zone.altars.first.altar;
      const cursed = ScrollKind.cursed;

      zone.returnTo(altar, const ScrollGift(cursed));

      final snapshot = readZoneState(
        zone,
      ).altars.firstWhere((a) => a.altar == altar);
      expect(snapshot.item, isA<AltarScroll>());
      expect((snapshot.item! as AltarScroll).scroll, cursed);
    });
  });

  group('readGift and writeAltarItem', () {
    test('reads each altar item into a gift and back', () {
      const hammer = WeaponId.hammer;
      const fire = ShieldId.fire;
      const health = ScrollKind.health;

      final weaponGift = readGift(const AltarWeapon(weapon: hammer));
      final shieldGift = readGift(const AltarShield(shield: fire));
      final scrollGift = readGift(const AltarScroll(scroll: health));

      expect(weaponGift, const WeaponGift(hammer));
      expect(shieldGift, const ShieldGift(fire));
      expect(scrollGift, const ScrollGift(health));

      final weaponItem = writeAltarItem(weaponGift);
      final shieldItem = writeAltarItem(shieldGift);
      final scrollItem = writeAltarItem(scrollGift);

      expect(weaponItem, isA<AltarWeapon>());
      expect((weaponItem as AltarWeapon).weapon, hammer);
      expect(shieldItem, isA<AltarShield>());
      expect((shieldItem as AltarShield).shield, fire);
      expect(scrollItem, isA<AltarScroll>());
      expect((scrollItem as AltarScroll).scroll, health);
    });
  });

  group('readHookPoint', () {
    test('reads a ring into a hook point', () {
      final spot = HookSpot(
        id: const EntityId(1001000),
        position: const Vec2(2680, 2408),
      );

      final point = readHookPoint(spot);

      expect(point.id, spot.id);
      expect(point.position, spot.position);
      expect(point.kind, HookPointKind.ring);
    });
  });

  group('readContact', () {
    test('reads a contact into a collision hit', () {
      const contact = Contact(
        point: Vec2(1, 2),
        normal: Vec2(0, -1),
        fraction: 0.5,
      );

      final hit = readContact(contact);

      expect(hit.point, contact.point);
      expect(hit.normal, contact.normal);
      expect(hit.fraction, contact.fraction);
    });
  });
}
