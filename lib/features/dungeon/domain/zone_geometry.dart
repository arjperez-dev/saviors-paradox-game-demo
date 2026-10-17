import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/tile_coord.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/hook_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_ids.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';

/// A zone's still world: its solids, its rings and its rooms' boxes.
final class ZoneGeometry {
  ZoneGeometry._({
    required List<WorldBox> solids,
    required List<HookSpot> rings,
    required List<WorldBox> rooms,
  }) : solids = List.unmodifiable(solids),
       rings = List.unmodifiable(rings),
       rooms = List.unmodifiable(rooms);

  factory ZoneGeometry.of(ZoneLayout layout, ZoneIds ids) {
    final survey = _Survey(layout.grid, ids);
    for (final room in layout.rooms) {
      survey.add(room);
    }
    for (final room in layout.rooms) {
      survey.close(room);
    }
    return ZoneGeometry._(
      solids: [...survey.islands, ...survey.walls],
      rings: survey.rings,
      rooms: survey.rooms,
    );
  }

  /// The sandbox's `zoneBuild`: a closing wall stands 560 su above its
  /// floor.
  static const double closingWallHeight = 560;

  final List<WorldBox> solids;
  final List<HookSpot> rings;
  final List<WorldBox> rooms;

  bool isSolidAt(Vec2 point) {
    for (var i = 0; i < solids.length; i++) {
      if (solids[i].contains(point)) {
        return true;
      }
    }
    return false;
  }

  /// hazards.md: a fall is leaving the bottom of the room; abyss is no
  /// room at all, or the room's last tile row.
  bool isAbyssAt(Vec2 point) {
    final index = roomIndexAt(point);
    return index < 0 ||
        point.y >= rooms[index].bottom - TileCoord.worldUnitsPerTile;
  }

  /// The index of the room holding [point], or -1.
  int roomIndexAt(Vec2 point) {
    for (var i = 0; i < rooms.length; i++) {
      if (rooms[i].contains(point)) {
        return i;
      }
    }
    return -1;
  }

  /// Adds to [into] every ring within [radius] of [point].
  void ringsNear(Vec2 point, double radius, List<HookSpot> into) {
    for (var i = 0; i < rings.length; i++) {
      if (rings[i].position.distanceTo(point) <= radius) {
        into.add(rings[i]);
      }
    }
  }

  @override
  bool operator ==(Object other) =>
      other is ZoneGeometry &&
      _same(other.solids, solids) &&
      _same(other.rings, rings) &&
      _same(other.rooms, rooms);

  @override
  int get hashCode => Object.hash(
    Object.hashAll(solids),
    Object.hashAll(rings),
    Object.hashAll(rooms),
  );
}

final class _Survey {
  _Survey(this._grid, this._ids);

  final ZoneGrid _grid;
  final ZoneIds _ids;
  final List<WorldBox> islands = [];
  final List<WorldBox> walls = [];
  final List<HookSpot> rings = [];
  final List<WorldBox> rooms = [];

  void add(PlacedRoom room) {
    final origin = room.originOn(_grid);
    rooms.add(room.boundsOn(_grid));
    for (final island in room.template.islands) {
      islands.add(island.solidFrom(origin));
    }
    for (final wall in room.template.walls) {
      walls.add(wall.solidFrom(origin));
    }
    for (final ring in room.template.rings) {
      rings.add(HookSpot(id: _ids.ring(rings.length), position: origin + ring));
    }
  }

  void close(PlacedRoom room) {
    for (var row = 0; row < room.template.cellsHigh; row++) {
      _closeEdge(room, Passage(side: Facing.left, row: row));
      _closeEdge(room, Passage(side: Facing.right, row: row));
    }
  }

  // layout.md §B.2 step 6: a floor that meets an edge with no passage is
  // closed by a broken column-wall; with no floor, the edge is the abyss.
  void _closeEdge(PlacedRoom room, Passage edge) {
    if (room.isLinkedAt(edge)) {
      return;
    }
    final bounds = room.boundsOn(_grid);
    final x = edge.side == Facing.left ? bounds.left : bounds.right;
    final floor = bounds.top + edge.row * _grid.cellHeight + _grid.floorDepth;
    if (!_meetsFloorAt(x, floor)) {
      return;
    }
    walls.add(_closingWallAt(x, floor, edge.side));
  }

  bool _meetsFloorAt(double x, double floor) => islands.any(
    (solid) =>
        (solid.top - floor).abs() < 2 && solid.left <= x && solid.right >= x,
  );

  WorldBox _closingWallAt(double x, double floor, Facing side) {
    final left = side == Facing.left ? x : x - _grid.wallWidth;
    return edgesBox(
      left,
      floor - ZoneGeometry.closingWallHeight,
      left + _grid.wallWidth,
      floor,
    );
  }
}

bool _same<T>(List<T> a, List<T> b) {
  if (a.length != b.length) {
    return false;
  }
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}
