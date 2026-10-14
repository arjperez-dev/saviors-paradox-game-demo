import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class TileCoord {
  const TileCoord(this.column, this.row);

  factory TileCoord.containing(Vec2 point) => TileCoord(
    (point.x / worldUnitsPerTile).floor(),
    (point.y / worldUnitsPerTile).floor(),
  );

  static const double worldUnitsPerTile = 32;

  final int column;
  final int row;

  Vec2 toWorld() =>
      Vec2(column * worldUnitsPerTile, row * worldUnitsPerTile);

  Vec2 centreInWorld() => Vec2(
    (column + 0.5) * worldUnitsPerTile,
    (row + 0.5) * worldUnitsPerTile,
  );

  @override
  bool operator ==(Object other) =>
      other is TileCoord && other.column == column && other.row == row;

  @override
  int get hashCode => Object.hash(column, row);
}
