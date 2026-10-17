import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';

/// The grid a zone is laid on (layout.md §B.1, §B.2; the sandbox's `ZC`).
final class ZoneGrid {
  const ZoneGrid({
    required this.columns,
    required this.rows,
    required this.cellWidth,
    required this.cellHeight,
    required this.floorDepth,
    required this.passageHeight,
    required this.wallWidth,
  }) : assert(columns > 0 && rows > 0, 'a grid has cells'),
       assert(cellWidth > 0 && cellHeight > 0, 'a cell has a size');

  /// layout.md §B.1: 22 × 8 cells of 1600 × 1024 su; §B.2: the floor
  /// 700 su below a row's top, passages 260 su tall; `ZC.wall`: 50.
  static const ZoneGrid standard = ZoneGrid(
    columns: 22,
    rows: 8,
    cellWidth: 1600,
    cellHeight: 1024,
    floorDepth: 700,
    passageHeight: 260,
    wallWidth: 50,
  );

  final int columns;
  final int rows;
  final double cellWidth;
  final double cellHeight;
  final double floorDepth;
  final double passageHeight;
  final double wallWidth;

  WorldBox get bounds => edgesBox(0, 0, columns * cellWidth, rows * cellHeight);

  @override
  bool operator ==(Object other) =>
      other is ZoneGrid &&
      other.columns == columns &&
      other.rows == rows &&
      other.cellWidth == cellWidth &&
      other.cellHeight == cellHeight &&
      other.floorDepth == floorDepth &&
      other.passageHeight == passageHeight &&
      other.wallWidth == wallWidth;

  @override
  int get hashCode => Object.hash(
    columns,
    rows,
    cellWidth,
    cellHeight,
    floorDepth,
    passageHeight,
    wallWidth,
  );
}
