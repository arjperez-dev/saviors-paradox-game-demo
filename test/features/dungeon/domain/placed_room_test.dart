import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/dead_end_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

RoomTemplate _aTemplate({int cellsWide = 1, int cellsHigh = 1}) => RoomTemplate(
  id: 'isle',
  kind: RoomKind.combat,
  cellsWide: cellsWide,
  cellsHigh: cellsHigh,
  passages: const [],
  islands: const [],
);

PlacedRoom _aRoom({int depth = 0}) => PlacedRoom(
  index: 0,
  template: _aTemplate(),
  column: 1,
  row: 1,
  depth: depth,
  from: null,
  isOnMainPath: true,
  role: DeadEndRole.altar,
  linked: const [Passage(side: Facing.right, row: 0)],
);

void main() {
  group('PlacedRoom', () {
    test('a room stands where its cell is', () {
      final room = PlacedRoom(
        index: 0,
        template: _aTemplate(cellsWide: 2, cellsHigh: 1),
        column: 3,
        row: 2,
        depth: 0,
        from: null,
        isOnMainPath: true,
        role: null,
        linked: const [],
      );

      final origin = room.originOn(ZoneGrid.standard);
      final bounds = room.boundsOn(ZoneGrid.standard);

      // 04-zones/zone-1-suspended-sanctuary/layout.md §B.1: cells of 1600 × 1024 su.
      expect(origin, const Vec2(4800, 2048));
      expect(bounds.left, 4800);
      expect(bounds.top, 2048);
      expect(bounds.right, 8000);
      expect(bounds.bottom, 3072);
    });

    test('a room knows the passages that lead somewhere', () {
      final room = PlacedRoom(
        index: 0,
        template: _aTemplate(),
        column: 0,
        row: 0,
        depth: 0,
        from: null,
        isOnMainPath: true,
        role: null,
        linked: const [Passage(side: Facing.right, row: 0)],
      );

      expect(
        room.isLinkedAt(const Passage(side: Facing.right, row: 0)),
        isTrue,
      );
      expect(
        room.isLinkedAt(const Passage(side: Facing.left, row: 0)),
        isFalse,
      );
    });

    test('placed rooms are equal by value', () {
      final a = _aRoom();
      final b = _aRoom();
      final differentDepth = _aRoom(depth: 1);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(differentDepth));
      expect(
        () => a.linked.add(const Passage(side: Facing.left, row: 1)),
        throwsUnsupportedError,
      );
    });
  });
}
