import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_link.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';

RoomTemplate _aTemplate() => RoomTemplate(
  id: 'isle',
  kind: RoomKind.combat,
  cellsWide: 1,
  cellsHigh: 1,
  passages: const [],
  islands: const [],
);

PlacedRoom _aRoom(int index) => PlacedRoom(
  index: index,
  template: _aTemplate(),
  column: index,
  row: 0,
  depth: index,
  from: index == 0 ? null : index - 1,
  isOnMainPath: true,
  role: null,
  linked: const [],
);

void main() {
  group('ZoneLayout', () {
    test("a room's neighbours are the rooms its links join", () {
      final layout = ZoneLayout(
        grid: ZoneGrid.standard,
        rooms: [_aRoom(0), _aRoom(1), _aRoom(2)],
        links: const [
          RoomLink(from: 0, to: 1, side: Facing.right, row: 0),
          RoomLink(from: 1, to: 2, side: Facing.right, row: 0),
        ],
      );

      expect(layout.neighboursOf(1), [0, 2]);
      expect(layout.neighboursOf(0), [1]);
      expect(layout.neighboursOf(2), [1]);
    });

    test('layouts are equal by value', () {
      final rooms = [_aRoom(0), _aRoom(1)];
      const links = [RoomLink(from: 0, to: 1, side: Facing.right, row: 0)];

      final a = ZoneLayout(grid: ZoneGrid.standard, rooms: rooms, links: links);
      final b = ZoneLayout(grid: ZoneGrid.standard, rooms: rooms, links: links);
      final withoutLink = ZoneLayout(
        grid: ZoneGrid.standard,
        rooms: rooms,
        links: const [],
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(withoutLink));
    });
  });
}
