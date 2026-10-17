import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/features/dungeon/domain/dead_end_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_builder.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';

List<ZoneLayout> _validLayouts() {
  const builder = ZoneBuilder();
  final kit = SuspendedSanctuaryKit();
  return [
    for (var seed = 1; seed <= 20; seed++) ?builder.build(kit, Seed(seed)),
  ];
}

void main() {
  group('ZoneBuilder', () {
    test('the same seed lays out the same zone', () {
      const builder = ZoneBuilder();
      final kit = SuspendedSanctuaryKit();

      for (var seed = 1; seed <= 20; seed++) {
        final first = builder.build(kit, Seed(seed));
        final second = builder.build(kit, Seed(seed));

        expect(second, first);
      }
    });

    test('another seed lays out another zone', () {
      const builder = ZoneBuilder();
      final kit = SuspendedSanctuaryKit();

      final layouts = [
        for (var seed = 1; seed <= 20; seed++) builder.build(kit, Seed(seed)),
      ];
      final distinct = {
        for (final layout in layouts) ?layout,
      };

      expect(layouts.any((layout) => layout != null), isTrue);
      expect(distinct.length, greaterThanOrEqualTo(2));
    });

    test('the start stands in column 0 on rows 2 to 5', () {
      for (final layout in _validLayouts()) {
        final start = layout.rooms[0];

        expect(start.kind, RoomKind.start);
        expect(start.column, 0);
        expect(start.row, inInclusiveRange(2, 5)); // layout.md §B.2 step 2
      }
    });

    test('the main path holds its kinds in their fixed order', () {
      for (final layout in _validLayouts()) {
        final mainPath = [
          for (final room in layout.rooms)
            if (room.isOnMainPath) room,
        ]..sort((a, b) => a.index.compareTo(b.index));

        // layout.md §B.2 step 2: the main path's fixed order of kinds.
        expect(mainPath.map((room) => room.kind), [
          RoomKind.start,
          RoomKind.corridor,
          RoomKind.combat,
          RoomKind.shaft,
          RoomKind.corridor,
          RoomKind.corridor,
          RoomKind.combat,
          RoomKind.shaft,
          RoomKind.corridor,
          RoomKind.combat,
          RoomKind.antechamber,
          RoomKind.boss,
          RoomKind.wayDown,
        ]);
      }
    });

    test('the main path always runs to the right', () {
      for (final layout in _validLayouts()) {
        final mainPath = [
          for (final room in layout.rooms)
            if (room.isOnMainPath) room,
        ]..sort((a, b) => a.index.compareTo(b.index));

        for (var i = 1; i < mainPath.length; i++) {
          expect(mainPath[i].column, greaterThan(mainPath[i - 1].column));
        }
      }
    });

    test('no two rooms share a cell', () {
      for (final layout in _validLayouts()) {
        final seen = <int>{};
        for (final room in layout.rooms) {
          final cellsWide = room.template.cellsWide;
          final cellsHigh = room.template.cellsHigh;
          for (var k = 0; k < cellsWide * cellsHigh; k++) {
            final column = room.column + k % cellsWide;
            final row = room.row + k ~/ cellsWide;

            expect(column, inInclusiveRange(0, layout.grid.columns - 1));
            expect(row, inInclusiveRange(0, layout.grid.rows - 1));
            expect(seen.add(column + row * layout.grid.columns), isTrue);
          }
        }
      }
    });

    test(
      'branches never leave the start, the antechamber, the boss room or the way down',
      () {
        for (final layout in _validLayouts()) {
          for (final room in layout.rooms) {
            final neighbours = layout.neighboursOf(room.index).length;
            if (room.kind == RoomKind.start || room.kind == RoomKind.wayDown) {
              expect(neighbours, 1);
            } else if (room.kind == RoomKind.antechamber ||
                room.kind == RoomKind.boss) {
              expect(neighbours, 2);
            }
          }
        }
      },
    );

    test('the deepest dead end holds the lore spirit', () {
      for (final layout in _validLayouts()) {
        final deadEnds = [
          for (final room in layout.rooms)
            if (room.kind == RoomKind.deadEnd) room,
        ];
        final loreEnds = deadEnds.where(
          (room) => room.role == DeadEndRole.lore,
        );
        final altarEnds = deadEnds.where(
          (room) => room.role == DeadEndRole.altar,
        );
        final lookoutEnds = deadEnds.where(
          (room) => room.role == DeadEndRole.lookout,
        );
        final deepest = deadEnds
            .map((room) => room.depth)
            .reduce((a, b) => a > b ? a : b);

        expect(loreEnds.length, 1);
        expect(loreEnds.single.depth, deepest);
        expect(altarEnds.length, lessThanOrEqualTo(8)); // layout.md §B.2 step 5
        expect(
          loreEnds.length + altarEnds.length + lookoutEnds.length,
          deadEnds.length,
        );
      }
    });
  });
}
