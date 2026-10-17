import 'package:saviors_paradox/core/contracts/ports/collision_hit.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point_kind.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';
import 'package:saviors_paradox/core/contracts/state/altar_snapshot.dart';
import 'package:saviors_paradox/core/contracts/state/room_snapshot.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_snapshot.dart';
import 'package:saviors_paradox/core/contracts/state/zone_state.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_view.dart';
import 'package:saviors_paradox/features/dungeon/domain/contact.dart';
import 'package:saviors_paradox/features/dungeon/domain/hook_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_view.dart';
import 'package:saviors_paradox/features/dungeon/domain/spirit_place.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';

// Dungeon's anti-corruption layer (architecture.md §2.2).

ZoneState readZoneState(Zone zone) => ZoneState(
  zone: zone.number,
  biome: zone.biome,
  seed: zone.seed,
  bounds: zone.bounds,
  rooms: _readRooms(zone),
  spawns: const [], // the enemy mix comes with a later dungeon wave
  altars: _readAltars(zone),
  spirits: _readSpirits(zone),
  start: zone.start,
  wayDown: zone.wayDown,
  bossRoom: zone.bossRoom,
  isBossRoomSealed: zone.isBossRoomSealed,
);

AltarGift readGift(AltarItem item) => switch (item) {
  AltarWeapon(:final weapon) => WeaponGift(weapon),
  AltarShield(:final shield) => ShieldGift(shield),
  AltarScroll(:final scroll) => ScrollGift(scroll),
};

AltarItem writeAltarItem(AltarGift gift) => switch (gift) {
  WeaponGift(:final weapon) => AltarWeapon(weapon: weapon),
  ShieldGift(:final shield) => AltarShield(shield: shield),
  ScrollGift(:final scroll) => AltarScroll(scroll: scroll),
};

HookPoint readHookPoint(HookSpot spot) =>
    HookPoint(id: spot.id, kind: HookPointKind.ring, position: spot.position);

CollisionHit readContact(Contact contact) => CollisionHit(
  point: contact.point,
  normal: contact.normal,
  fraction: contact.fraction,
);

AltarItem? _itemOf(AltarGift? gift) =>
    gift == null ? null : writeAltarItem(gift);

List<RoomSnapshot> _readRooms(Zone zone) => [
  for (final room in zone.rooms) _readRoom(room),
];

RoomSnapshot _readRoom(RoomView room) => RoomSnapshot(
  room: room.room,
  bounds: room.bounds,
  neighbours: room.neighbours,
  isOnMainPath: room.isOnMainPath,
  isBossRoom: room.isBossRoom,
);

List<AltarSnapshot> _readAltars(Zone zone) => [
  for (final altar in zone.altars) _readAltar(altar),
];

AltarSnapshot _readAltar(AltarView altar) => AltarSnapshot(
  altar: altar.altar,
  room: altar.room,
  position: altar.position,
  item: _itemOf(altar.gift),
);

List<SpiritSnapshot> _readSpirits(Zone zone) => [
  for (final spirit in zone.spirits) _readSpirit(spirit),
];

SpiritSnapshot _readSpirit(SpiritPlace spirit) => SpiritSnapshot(
  spirit: spirit.spirit,
  role: spirit.role,
  room: spirit.room,
  position: spirit.position,
);
