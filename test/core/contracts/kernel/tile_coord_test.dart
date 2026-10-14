import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/tile_coord.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

void main() {
  group('TileCoord', () {
    test('places a tile at its top-left corner in world units', () {
      expect(const TileCoord(3, 2).toWorld(), const Vec2(96, 64));
    });

    test('places the centre of a tile in world units', () {
      expect(const TileCoord(3, 2).centreInWorld(), const Vec2(112, 80));
    });

    test('finds the tile that contains a world point', () {
      expect(
        TileCoord.containing(const Vec2(95.9, 64)),
        const TileCoord(2, 2),
      );
      expect(
        TileCoord.containing(const Vec2(-0.1, 0)),
        const TileCoord(-1, 0),
      );
    });

    test('equal tiles share a hash code', () {
      const a = TileCoord(1, 2);
      const b = TileCoord(1, 2);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });
  });
}
