import 'dart:collection';

import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_view.dart';
import 'package:saviors_paradox/features/dungeon/domain/biome_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/contact.dart';
import 'package:saviors_paradox/features/dungeon/domain/dead_end_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/drift_path.dart';
import 'package:saviors_paradox/features/dungeon/domain/hook_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_view.dart';
import 'package:saviors_paradox/features/dungeon/domain/spirit_place.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/sweep.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_event.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_geometry.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_ids.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';

part 'altar.dart';
part 'altar_book.dart';
part 'drifting_platform.dart';
part 'room.dart';
part 'zone_assembly.dart';

enum _Doors { open, sealed, opened }

/// A generated zone (glossary §6): its rooms, altars, drifting platforms,
/// the boss room's doors and its solid world. Every change goes through
/// this root.
final class Zone {
  factory Zone.of({
    required ZoneNumber number,
    required BiomeKit kit,
    required Seed seed,
    required ZoneLayout layout,
  }) {
    final assembly = _Assembly(layout, ZoneIds(number), kit, seed);
    return Zone._(assembly, assembly.parts());
  }

  Zone._(_Assembly assembly, _Parts parts)
    : number = assembly.ids.zone,
      biome = assembly.kit.biome,
      boss = assembly.kit.boss,
      seed = assembly.seed,
      bounds = assembly.layout.grid.bounds,
      start = assembly.spotIn(
        assembly.roomOf(RoomKind.start),
        SpotKind.start,
      ),
      wayDown = assembly.spotIn(
        assembly.roomOf(RoomKind.wayDown),
        SpotKind.wayDown,
      ),
      bossRoom = assembly.ids.room(assembly.roomOf(RoomKind.boss).index),
      spirits = List.unmodifiable(assembly.spirits()),
      rooms = List.unmodifiable([for (final room in parts.rooms) room._view]),
      platforms = UnmodifiableListView(parts.platformBoxes),
      _bossRoomBounds = assembly
          .roomOf(RoomKind.boss)
          .boundsOn(assembly.layout.grid),
      _geometry = ZoneGeometry.of(assembly.layout, assembly.ids),
      _rooms = parts.rooms,
      _altarBook = _AltarBook(parts.altars),
      _platforms = parts.platforms,
      _platformBoxes = parts.platformBoxes,
      _ringBuffer = parts.ringBuffer,
      _rings = UnmodifiableListView(parts.ringBuffer);

  /// items.md §2: within 80 su of its centre (the sandbox's stand-in;
  /// operator, 2026-10-16).
  static const double altarReach = 80;

  final ZoneNumber number;
  final Biome biome;
  final BossId boss;
  final Seed seed;
  final WorldBox bounds;
  final Vec2 start;
  final Vec2 wayDown;
  final EntityId bossRoom;
  final List<SpiritPlace> spirits;
  final List<RoomView> rooms;
  final List<WorldBox> platforms;
  final WorldBox _bossRoomBounds;
  final ZoneGeometry _geometry;
  final List<Room> _rooms;
  final _AltarBook _altarBook;
  final List<DriftingPlatform> _platforms;
  final List<WorldBox> _platformBoxes;
  final List<HookSpot> _ringBuffer;
  final Iterable<HookSpot> _rings;
  _Doors _doors = _Doors.open;
  int _revision = 0;

  int get revision => _revision;

  List<AltarView> get altars => _altarBook.views;

  bool get isBossRoomSealed => _doors == _Doors.sealed;

  bool get isWayDownOpen => _doors == _Doors.opened;

  EntityId? roomContaining(Vec2 point) {
    final index = _geometry.roomIndexAt(point);
    return index < 0 ? null : _rooms[index]._id;
  }

  /// The nearest altar within [altarReach] of [point], or null.
  EntityId? altarWithinReach(Vec2 point) =>
      _altarBook.nearestWithin(point, altarReach);

  AltarGift? giftOn(EntityId altar) => _altarBook.giftOn(altar);

  /// Takes the gift on [altar]; null when the altar is empty or unknown.
  ItemTakenFromAltar? takeFrom(EntityId altar) {
    final taken = _altarBook.take(altar);
    if (taken != null) {
      _revision++;
    }
    return taken;
  }

  /// Lays [gift] on [altar]; null when the altar holds a gift or is
  /// unknown.
  ItemReturnedToAltar? returnTo(EntityId altar, AltarGift gift) {
    final returned = _altarBook.give(altar, gift);
    if (returned != null) {
      _revision++;
    }
    return returned;
  }

  /// Seals the boss room's doors; null unless they were open.
  BossRoomSealed? sealBossRoom() {
    if (_doors != _Doors.open) {
      return null;
    }
    _doors = _Doors.sealed;
    _revision++;
    return BossRoomSealed(room: bossRoom, boss: boss);
  }

  /// Opens the sealed doors for good; null unless they were sealed.
  BossRoomUnsealed? unsealBossRoom() {
    if (_doors != _Doors.sealed) {
      return null;
    }
    _doors = _Doors.opened;
    _revision++;
    return BossRoomUnsealed(room: bossRoom, at: _bossRoomBounds.centre);
  }

  void advance(Seconds dt) {
    for (var i = 0; i < _platforms.length; i++) {
      _platforms[i]._advance(dt);
      _platformBoxes[i] = _platforms[i]._box;
    }
  }

  Contact? sweep(WorldBox box, Vec2 displacement) => _earliest(
    const Sweep().box(box, displacement, _geometry.solids),
    const Sweep().box(box, displacement, _platformBoxes),
  );

  Contact? cast(Vec2 from, Vec2 to) => _earliest(
    const Sweep().ray(from, to, _geometry.solids),
    const Sweep().ray(from, to, _platformBoxes),
  );

  bool isSolidAt(Vec2 point) {
    if (_geometry.isSolidAt(point)) {
      return true;
    }
    for (var i = 0; i < _platformBoxes.length; i++) {
      if (_platformBoxes[i].contains(point)) {
        return true;
      }
    }
    return false;
  }

  bool isAbyssAt(Vec2 point) => _geometry.isAbyssAt(point);

  /// The rings within [radius] of [point]; the same view is refilled by
  /// the next call.
  Iterable<HookSpot> ringsNear(Vec2 point, double radius) {
    _ringBuffer.clear();
    _geometry.ringsNear(point, radius, _ringBuffer);
    return _rings;
  }

  static Contact? _earliest(Contact? a, Contact? b) {
    if (a == null) {
      return b;
    }
    return b == null || a.fraction <= b.fraction ? a : b;
  }
}
