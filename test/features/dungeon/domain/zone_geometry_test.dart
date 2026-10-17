import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/features/dungeon/domain/hook_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_geometry.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_ids.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';

final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();

RoomTemplate _templateOf(RoomKind kind, String id) =>
    _kit.templatesOf(kind).firstWhere((template) => template.id == id);

// layout.md §B.1, §B.2; the sandbox's `ZT.start`: three rooms of zone 1 on
// `ZoneGrid.standard` — the sanctuary's `start`, `rings` and `ledgeEnd`,
// linked 0→1 and 1→2 each by `Passage(right, 0)`.
ZoneLayout _theLayout() {
  final start = PlacedRoom(
    index: 0,
    template: _templateOf(RoomKind.start, 'start'),
    column: 0,
    row: 2,
    depth: 0,
    from: null,
    isOnMainPath: true,
    role: null,
    linked: const [Passage(side: Facing.right, row: 0)],
  );
  final rings = PlacedRoom(
    index: 1,
    template: _templateOf(RoomKind.corridor, 'rings'),
    column: 1,
    row: 2,
    depth: 1,
    from: 0,
    isOnMainPath: true,
    role: null,
    linked: const [
      Passage(side: Facing.left, row: 0),
      Passage(side: Facing.right, row: 0),
    ],
  );
  final ledgeEnd = PlacedRoom(
    index: 2,
    template: _templateOf(RoomKind.deadEnd, 'ledgeEnd'),
    column: 3,
    row: 2,
    depth: 2,
    from: 1,
    isOnMainPath: false,
    role: null,
    linked: const [Passage(side: Facing.left, row: 0)],
  );
  return ZoneLayout(
    grid: ZoneGrid.standard,
    rooms: [start, rings, ledgeEnd],
    links: const [],
  );
}

void main() {
  final ids = ZoneIds(ZoneNumber.first);

  group('ZoneGeometry', () {
    test('an island becomes a solid at its place in the world', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      final box = geometry.solids.firstWhere(
        (solid) => solid.left == 0 && solid.top == 2748,
      );

      expect(box.left, 0);
      expect(box.top, 2748);
      expect(box.right, 1600);
      expect(box.bottom, 2828);
    });

    test('a ring stands at its place with its zone id', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      expect(geometry.rings, [
        const HookSpot(id: EntityId(1001000), position: Vec2(2680, 2408)),
        const HookSpot(id: EntityId(1001001), position: Vec2(3200, 2378)),
        const HookSpot(id: EntityId(1001002), position: Vec2(3720, 2408)),
      ]);
    });

    test(
      'a floor meeting an edge with no passage is closed by a broken wall',
      () {
        final geometry = ZoneGeometry.of(_theLayout(), ids);

        final wall = geometry.solids.firstWhere(
          (solid) => solid.left == 0 && solid.top == 2188,
        );

        expect(wall.right, 50);
        expect(wall.bottom, 2748);
      },
    );

    test('a linked passage stays open', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      final wallAtThePassage = geometry.solids.where(
        (solid) =>
            solid.left <= 1600 &&
            solid.right >= 1600 &&
            solid.top == 2188 &&
            solid.bottom == 2748,
      );

      expect(wallAtThePassage, isEmpty);
    });

    test('an edge with no floor stays open to the abyss', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      final atTheEdge = geometry.solids.where(
        (solid) => solid.left <= 6400 && solid.right >= 6400,
      );

      expect(atTheEdge, isEmpty);
    });

    test('a point inside an island is solid', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      expect(geometry.isSolidAt(const Vec2(800, 2760)), isTrue);
      expect(geometry.isSolidAt(const Vec2(800, 2700)), isFalse);
    });

    test('a point in no room is abyss', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      expect(geometry.isAbyssAt(const Vec2(800, 100)), isTrue);
    });

    test("a point in its room's last tile row is abyss", () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      expect(geometry.isAbyssAt(const Vec2(800, 3050)), isTrue);
      expect(geometry.isAbyssAt(const Vec2(800, 3030)), isFalse);
    });

    test('each point is in the room whose box holds it', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);

      expect(geometry.roomIndexAt(const Vec2(800, 2500)), 0);
      expect(geometry.roomIndexAt(const Vec2(3000, 2500)), 1);
      expect(geometry.roomIndexAt(const Vec2(800, 100)), -1);
    });

    test('rings near a point are found within the radius', () {
      final geometry = ZoneGeometry.of(_theLayout(), ids);
      final into = <HookSpot>[];

      geometry.ringsNear(const Vec2(3200, 2400), 30, into);

      expect(into, [
        const HookSpot(id: EntityId(1001001), position: Vec2(3200, 2378)),
      ]);
    });

    test('the same layout gives the same geometry', () {
      final a = ZoneGeometry.of(_theLayout(), ids);
      final b = ZoneGeometry.of(_theLayout(), ids);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(() => a.solids.add(a.solids.first), throwsUnsupportedError);
    });
  });
}
