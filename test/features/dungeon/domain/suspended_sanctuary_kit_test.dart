import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

List<String> _idsOf(SuspendedSanctuaryKit kit, RoomKind kind) =>
    kit.templatesOf(kind).map((template) => template.id).toList();

void main() {
  group('SuspendedSanctuaryKit', () {
    test("the sanctuary's catalog holds its fifteen templates", () {
      final kit = SuspendedSanctuaryKit();

      expect(_idsOf(kit, RoomKind.start), ['start']);
      expect(_idsOf(kit, RoomKind.corridor), [
        'gap',
        'steps',
        'rings',
        'bridge',
      ]);
      expect(_idsOf(kit, RoomKind.combat), ['hall', 'isle']);
      expect(_idsOf(kit, RoomKind.shaft), ['lift', 'columns']);
      expect(_idsOf(kit, RoomKind.deadEnd), [
        'isleEnd',
        'ledgeEnd',
        'shrineEnd',
      ]);
      expect(_idsOf(kit, RoomKind.antechamber), ['ante']);
      expect(_idsOf(kit, RoomKind.boss), ['golemRoom']);
      expect(_idsOf(kit, RoomKind.wayDown), ['exit']);
    });

    test('the main path runs in its fixed order', () {
      final kit = SuspendedSanctuaryKit();

      expect(kit.mainPath, [
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
    });

    test('a sanctuary zone holds 36 to 44 rooms and 8 altars', () {
      final kit = SuspendedSanctuaryKit();

      expect(kit.fewestRooms, 36);
      expect(kit.mostRooms, 44);
      expect(kit.altarCount, 8);
    });

    test("the golem's room is two cells wide with three hanging slabs and no rings", () {
      final kit = SuspendedSanctuaryKit();

      final golemRoom = kit.templatesOf(RoomKind.boss).single;

      expect(golemRoom.cellsWide, 2);
      expect(golemRoom.cellsHigh, 1);
      final hangingIslands = golemRoom.islands.where(
        (island) => island.isHanging,
      );
      expect(hangingIslands.length, 3);
      expect(
        hangingIslands.map((island) => island.left),
        [640, 1400, 2160],
      );
      expect(
        hangingIslands.map((island) => island.right),
        [1040, 1800, 2560],
      );
      expect(
        hangingIslands.map((island) => island.right - island.left),
        [400, 400, 400],
      );
      expect(hangingIslands.map((island) => island.top), [430, 300, 430]);
      expect(golemRoom.rings, isEmpty);
      expect(golemRoom.spot(SpotKind.boss), const Vec2(1600, 700));
    });

    test('every shaft opens on both of its rows', () {
      final kit = SuspendedSanctuaryKit();

      for (final shaft in kit.templatesOf(RoomKind.shaft)) {
        expect(shaft.cellsWide, 1);
        expect(shaft.cellsHigh, 2);
        expect(shaft.passages, [
          const Passage(side: Facing.left, row: 0),
          const Passage(side: Facing.right, row: 0),
          const Passage(side: Facing.left, row: 1),
          const Passage(side: Facing.right, row: 1),
        ]);
      }
    });

    test('every template stays inside its cells', () {
      final kit = SuspendedSanctuaryKit();
      const grid = ZoneGrid.standard;

      for (final kind in RoomKind.values) {
        for (final template in kit.templatesOf(kind)) {
          final width = template.widthOn(grid);
          final height = template.heightOn(grid);
          for (final island in template.islands) {
            expect(island.left, inInclusiveRange(0, width));
            expect(island.right, inInclusiveRange(0, width));
            expect(island.top, inInclusiveRange(0, height));
            expect(island.top + island.thickness, inInclusiveRange(0, height));
          }
          for (final wall in template.walls) {
            expect(wall.left, inInclusiveRange(0, width));
            expect(wall.right, inInclusiveRange(0, width));
            expect(wall.top, inInclusiveRange(0, height));
            expect(wall.bottom, inInclusiveRange(0, height));
          }
        }
      }
    });

    test("the sanctuary is zone 1's biome with the golem", () {
      final kit = SuspendedSanctuaryKit();

      expect(kit.biome, Biome.suspendedSanctuary);
      expect(kit.boss, BossId.golem);
      expect(kit.grid, ZoneGrid.standard);
      expect(kit.branchKinds, [
        RoomKind.corridor,
        RoomKind.corridor,
        RoomKind.combat,
        RoomKind.shaft,
      ]);
    });
  });
}
