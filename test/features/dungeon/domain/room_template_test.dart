import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/drift_path.dart';
import 'package:saviors_paradox/features/dungeon/domain/island_span.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

RoomTemplate _aTemplate() => RoomTemplate(
  id: 'gap',
  kind: RoomKind.corridor,
  cellsWide: 1,
  cellsHigh: 1,
  passages: const [Passage(side: Facing.right, row: 0)],
  islands: const [
    IslandSpan(left: 0, right: 520, top: 700, thickness: 80, underside: 260),
  ],
  rings: const [Vec2(800, 420)],
  drifts: [
    DriftPath(
      left: 640,
      top: 700,
      width: 320,
      travel: const Vec2(0, 150),
      period: const Seconds(4.2),
    ),
  ],
  spots: const [RoomSpot(kind: SpotKind.feature, position: Vec2(900, 600))],
);

void main() {
  group('RoomTemplate', () {
    test('a mirrored template mirrors every part', () {
      final template = _aTemplate();

      final mirrored = template.mirrored(ZoneGrid.standard);

      expect(mirrored.passages, [
        const Passage(side: Facing.left, row: 0),
      ]);
      expect(mirrored.islands, [
        const IslandSpan(
          left: 1080,
          right: 1600,
          top: 700,
          thickness: 80,
          underside: 260,
        ),
      ]);
      expect(mirrored.rings, [const Vec2(800, 420)]);
      expect(mirrored.drifts.single.left, 640);
      expect(mirrored.drifts.single.travel, const Vec2(0, 150));
      expect(mirrored.spots, [
        const RoomSpot(kind: SpotKind.feature, position: Vec2(700, 600)),
      ]);
    });

    test('a template finds its spot by kind', () {
      final template = _aTemplate();

      expect(template.spot(SpotKind.feature), const Vec2(900, 600));
      expect(template.spot(SpotKind.start), isNull);
    });

    test("a template's lists cannot be changed", () {
      final template = _aTemplate();

      expect(
        () => template.passages.add(
          const Passage(side: Facing.left, row: 1),
        ),
        throwsUnsupportedError,
      );
      expect(() => template.islands.clear(), throwsUnsupportedError);
    });

    test('templates are equal by value', () {
      final a = _aTemplate();
      final b = _aTemplate();
      final differentIslands = RoomTemplate(
        id: a.id,
        kind: a.kind,
        cellsWide: a.cellsWide,
        cellsHigh: a.cellsHigh,
        passages: a.passages,
        islands: const [
          IslandSpan(
            left: 0,
            right: 400,
            top: 700,
            thickness: 80,
            underside: 260,
          ),
        ],
        rings: a.rings,
        drifts: a.drifts,
        spots: a.spots,
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(differentIslands));
    });
  });
}
