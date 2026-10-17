part of 'zone.dart';

// Builds a zone's parts from its layout (layout.md §B.4).
final class _Assembly {
  _Assembly(this.layout, this.ids, this.kit, this.seed);

  final ZoneLayout layout;
  final ZoneIds ids;
  final BiomeKit kit;
  final Seed seed;

  ZoneGrid get _grid => layout.grid;

  _Parts parts() => _Parts(_rooms(), _altars(), _platforms());

  PlacedRoom roomOf(RoomKind kind) => roomWhere((room) => room.kind == kind);

  PlacedRoom roomWhere(bool Function(PlacedRoom room) test) =>
      layout.rooms.firstWhere(
        test,
        orElse: () => throw StateError('the layout lacks a room a zone needs'),
      );

  Vec2 spotIn(PlacedRoom room, SpotKind kind) {
    final spot = room.template.spot(kind);
    if (spot == null) {
      throw StateError('room ${room.template.id} has no ${kind.name} spot');
    }
    return room.originOn(_grid) + spot;
  }

  List<SpiritPlace> spirits() {
    final lore = roomWhere((room) => room.role == DeadEndRole.lore);
    final warning = roomOf(RoomKind.antechamber);
    return [
      SpiritPlace(
        spirit: ids.spirit(0),
        role: SpiritRole.lore,
        room: ids.room(lore.index),
        position: spotIn(lore, SpotKind.feature),
      ),
      SpiritPlace(
        spirit: ids.spirit(1),
        role: SpiritRole.warning,
        room: ids.room(warning.index),
        position: spotIn(warning, SpotKind.warning),
      ),
    ];
  }

  List<Room> _rooms() => [
    for (final room in layout.rooms)
      Room._(
        id: ids.room(room.index),
        bounds: room.boundsOn(_grid),
        neighbours: [
          for (final next in layout.neighboursOf(room.index)) ids.room(next),
        ],
        isOnMainPath: room.isOnMainPath,
        isBossRoom: room.kind == RoomKind.boss,
      ),
  ];

  List<Altar> _altars() {
    final altars = <Altar>[];
    for (final room in layout.rooms) {
      if (room.role == DeadEndRole.altar) {
        altars.add(
          Altar._(
            id: ids.altar(altars.length),
            room: ids.room(room.index),
            position: spotIn(room, SpotKind.feature),
          ),
        );
      }
    }
    return altars;
  }

  List<DriftingPlatform> _platforms() {
    final platforms = <DriftingPlatform>[];
    for (final room in layout.rooms) {
      for (final path in room.template.drifts) {
        platforms.add(
          DriftingPlatform._(
            id: ids.platform(platforms.length),
            origin: room.originOn(_grid),
            path: path,
            // The sandbox's zoneBuild: ((room × 37 + platforms × 11) % 100) / 100.
            phase: ((room.index * 37 + platforms.length * 11) % 100) / 100,
          ),
        );
      }
    }
    return platforms;
  }
}

// The entities of one zone, made once, and the buffers the root reuses.
final class _Parts {
  _Parts(this.rooms, this.altars, this.platforms)
    : platformBoxes = [for (final platform in platforms) platform._box];

  final List<Room> rooms;
  final List<Altar> altars;
  final List<DriftingPlatform> platforms;
  final List<WorldBox> platformBoxes;
  final List<HookSpot> ringBuffer = [];
}
