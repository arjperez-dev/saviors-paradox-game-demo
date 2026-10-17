import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/drift_path.dart';
import 'package:saviors_paradox/features/dungeon/domain/island_span.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/wall_span.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

/// One hand-drawn room of a biome's catalog (layout.md §B.3).
final class RoomTemplate {
  RoomTemplate({
    required this.id,
    required this.kind,
    required this.cellsWide,
    required this.cellsHigh,
    required List<Passage> passages,
    required List<IslandSpan> islands,
    List<WallSpan> walls = const [],
    List<Vec2> rings = const [],
    List<DriftPath> drifts = const [],
    List<RoomSpot> spots = const [],
    this.hasChasm = false,
  }) : assert(cellsWide >= 1 && cellsHigh >= 1, 'a room fills a cell'),
       passages = List.unmodifiable(passages),
       islands = List.unmodifiable(islands),
       walls = List.unmodifiable(walls),
       rings = List.unmodifiable(rings),
       drifts = List.unmodifiable(drifts),
       spots = List.unmodifiable(spots);

  final String id;
  final RoomKind kind;
  final int cellsWide;
  final int cellsHigh;
  final List<Passage> passages;
  final List<IslandSpan> islands;
  final List<WallSpan> walls;
  final List<Vec2> rings;
  final List<DriftPath> drifts;
  final List<RoomSpot> spots;
  final bool hasChasm;

  double widthOn(ZoneGrid grid) => cellsWide * grid.cellWidth;

  double heightOn(ZoneGrid grid) => cellsHigh * grid.cellHeight;

  /// The same room drawn the other way round (layout.md §B.3).
  RoomTemplate mirrored(ZoneGrid grid) {
    final width = widthOn(grid);
    return RoomTemplate(
      id: id,
      kind: kind,
      cellsWide: cellsWide,
      cellsHigh: cellsHigh,
      passages: [for (final passage in passages) passage.mirrored()],
      islands: [for (final island in islands) island.mirrored(width)],
      walls: [for (final wall in walls) wall.mirrored(width)],
      rings: [for (final ring in rings) Vec2(width - ring.x, ring.y)],
      drifts: [for (final drift in drifts) drift.mirrored(width)],
      spots: [for (final spot in spots) spot.mirrored(width)],
      hasChasm: hasChasm,
    );
  }

  /// Where the spot of [kind] stands, or null when the room has none.
  Vec2? spot(SpotKind kind) {
    for (final spot in spots) {
      if (spot.kind == kind) {
        return spot.position;
      }
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      other is RoomTemplate &&
      other.id == id &&
      other.kind == kind &&
      other.cellsWide == cellsWide &&
      other.cellsHigh == cellsHigh &&
      _same(other.passages, passages) &&
      _same(other.islands, islands) &&
      _same(other.walls, walls) &&
      _same(other.rings, rings) &&
      _same(other.drifts, drifts) &&
      _same(other.spots, spots) &&
      other.hasChasm == hasChasm;

  @override
  int get hashCode => Object.hash(
    id,
    kind,
    cellsWide,
    cellsHigh,
    Object.hashAll(passages),
    Object.hashAll(islands),
    Object.hashAll(walls),
    Object.hashAll(rings),
    Object.hashAll(drifts),
    Object.hashAll(spots),
    hasChasm,
  );
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
