import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

void main() {
  group('ZoneGrid', () {
    test("the standard grid is the sanctuary's", () {
      const grid = ZoneGrid.standard;

      // 04-zones/zone-1-suspended-sanctuary/layout.md §B.1, §B.2
      expect(grid.columns, 22);
      expect(grid.rows, 8);
      expect(grid.cellWidth, 1600);
      expect(grid.cellHeight, 1024);
      expect(grid.floorDepth, 700);
      expect(grid.passageHeight, 260);
      expect(grid.wallWidth, 50);
    });

    test('a zone spans its grid', () {
      final bounds = ZoneGrid.standard.bounds;

      // layout.md §B.1: 35 200 × 8192 su
      expect(bounds.left, 0);
      expect(bounds.top, 0);
      expect(bounds.right, 35200);
      expect(bounds.bottom, 8192);
    });

    test('grids are equal by value', () {
      const a = ZoneGrid(
        columns: 22,
        rows: 8,
        cellWidth: 1600,
        cellHeight: 1024,
        floorDepth: 700,
        passageHeight: 260,
        wallWidth: 50,
      );
      const b = ZoneGrid(
        columns: 22,
        rows: 8,
        cellWidth: 1600,
        cellHeight: 1024,
        floorDepth: 700,
        passageHeight: 260,
        wallWidth: 50,
      );
      const differentRows = ZoneGrid(
        columns: 22,
        rows: 9,
        cellWidth: 1600,
        cellHeight: 1024,
        floorDepth: 700,
        passageHeight: 260,
        wallWidth: 50,
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(differentRows));
    });
  });
}
