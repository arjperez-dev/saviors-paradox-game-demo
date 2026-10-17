import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/biome_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/drift_path.dart';
import 'package:saviors_paradox/features/dungeon/domain/island_span.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/wall_span.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

/// Zone 1's kit: the Suspended Sanctuary (layout.md §B.2, §B.3; the
/// sandbox's `ZT`, `MAIN_PLAN`, `ZONE_TARGET`, `ZONE_ALTARS`).
final class SuspendedSanctuaryKit implements BiomeKit {
  SuspendedSanctuaryKit() : _catalog = _sanctuaryCatalog();

  final Map<RoomKind, List<RoomTemplate>> _catalog;

  @override
  Biome get biome => Biome.suspendedSanctuary;

  @override
  BossId get boss => BossId.golem;

  @override
  ZoneGrid get grid => ZoneGrid.standard;

  @override
  List<RoomKind> get mainPath => const [
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
  ];

  @override
  List<RoomKind> get branchKinds => const [
    RoomKind.corridor,
    RoomKind.corridor,
    RoomKind.combat,
    RoomKind.shaft,
  ];

  @override
  int get fewestRooms => 36;

  @override
  int get mostRooms => 44;

  @override
  int get altarCount => 8;

  @override
  List<RoomTemplate> templatesOf(RoomKind kind) => _catalog[kind] ?? const [];
}

const Passage _left0 = Passage(side: Facing.left, row: 0);
const Passage _right0 = Passage(side: Facing.right, row: 0);
const Passage _left1 = Passage(side: Facing.left, row: 1);
const Passage _right1 = Passage(side: Facing.right, row: 1);

// The sandbox's I(x0, x1, y, t, u).
IslandSpan _island(
  double left,
  double right,
  double top,
  double thickness,
  double underside, {
  bool isHanging = false,
}) => IslandSpan(
  left: left,
  right: right,
  top: top,
  thickness: thickness,
  underside: underside,
  isHanging: isHanging,
);

DriftPath _drift(
  double left,
  double top,
  double width,
  Vec2 travel,
  double period,
) => DriftPath(
  left: left,
  top: top,
  width: width,
  travel: travel,
  period: Seconds(period),
);

RoomSpot _spot(SpotKind kind, double x, double y) =>
    RoomSpot(kind: kind, position: Vec2(x, y));

Map<RoomKind, List<RoomTemplate>> _sanctuaryCatalog() => {
  RoomKind.start: List.unmodifiable([
    RoomTemplate(
      id: 'start',
      kind: RoomKind.start,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_right0],
      islands: [_island(0, 1600, 700, 80, 320)],
      walls: const [WallSpan(left: 0, top: 160, right: 60, bottom: 700)],
      spots: [_spot(SpotKind.start, 660, 700)],
    ),
  ]),
  RoomKind.corridor: List.unmodifiable([
    RoomTemplate(
      id: 'gap',
      kind: RoomKind.corridor,
      cellsWide: 2,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [
        _island(0, 900, 700, 80, 260),
        _island(2240, 3200, 700, 80, 260),
      ],
      drifts: [
        _drift(1000, 700, 240, const Vec2(480, 0), 5.2),
        _drift(1800, 620, 240, const Vec2(0, 220), 3.6),
      ],
      rings: const [Vec2(1350, 330), Vec2(1980, 300)],
      hasChasm: true,
    ),
    RoomTemplate(
      id: 'steps',
      kind: RoomKind.corridor,
      cellsWide: 2,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [
        _island(0, 720, 700, 80, 240),
        _island(860, 1260, 560, 70, 240),
        _island(1400, 1800, 430, 70, 280),
        _island(1940, 2340, 560, 70, 240),
        _island(2480, 3200, 700, 80, 240),
      ],
      hasChasm: true,
    ),
    RoomTemplate(
      id: 'rings',
      kind: RoomKind.corridor,
      cellsWide: 2,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [
        _island(0, 760, 700, 80, 260),
        _island(1450, 1750, 760, 60, 180),
        _island(2440, 3200, 700, 80, 260),
      ],
      rings: const [Vec2(1080, 360), Vec2(1600, 330), Vec2(2120, 360)],
      hasChasm: true,
    ),
    RoomTemplate(
      id: 'bridge',
      kind: RoomKind.corridor,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [
        _island(0, 520, 700, 80, 260),
        _island(1080, 1600, 700, 80, 260),
      ],
      drifts: [_drift(640, 700, 320, const Vec2(0, 150), 4.2)],
      hasChasm: true,
    ),
  ]),
  RoomKind.combat: List.unmodifiable([
    RoomTemplate(
      id: 'hall',
      kind: RoomKind.combat,
      cellsWide: 2,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [
        _island(0, 3200, 700, 90, 340),
        _island(1350, 1850, 500, 60, 120),
      ],
      spots: [_spot(SpotKind.foe, 2350, 700)],
    ),
    RoomTemplate(
      id: 'isle',
      kind: RoomKind.combat,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [
        _island(0, 640, 700, 80, 260),
        _island(760, 1600, 700, 80, 300),
        _island(980, 1340, 480, 60, 120),
      ],
      spots: [_spot(SpotKind.foe, 1250, 700)],
      hasChasm: true,
    ),
  ]),
  RoomKind.shaft: List.unmodifiable([
    RoomTemplate(
      id: 'lift',
      kind: RoomKind.shaft,
      cellsWide: 1,
      cellsHigh: 2,
      passages: const [_left0, _right0, _left1, _right1],
      islands: [
        _island(0, 360, 700, 80, 150),
        _island(1240, 1600, 700, 80, 150),
        _island(0, 360, 1724, 80, 200),
        _island(1240, 1600, 1724, 80, 200),
      ],
      drifts: [
        _drift(420, 1524, 240, const Vec2(0, -640), 6),
        _drift(940, 860, 240, const Vec2(0, 640), 6),
      ],
      rings: const [Vec2(800, 420)],
      hasChasm: true,
    ),
    RoomTemplate(
      id: 'columns',
      kind: RoomKind.shaft,
      cellsWide: 1,
      cellsHigh: 2,
      passages: const [_left0, _right0, _left1, _right1],
      islands: [
        _island(0, 360, 700, 80, 150),
        _island(1240, 1600, 700, 80, 150),
        _island(0, 360, 1724, 80, 200),
        _island(1240, 1600, 1724, 80, 200),
        _island(360, 560, 1450, 60, 100),
        _island(1040, 1240, 1200, 60, 100),
        _island(360, 560, 950, 60, 100),
      ],
      walls: const [
        WallSpan(left: 560, top: 380, right: 620, bottom: 1560),
        WallSpan(left: 980, top: 380, right: 1040, bottom: 1560),
      ],
      rings: const [Vec2(800, 1150), Vec2(800, 660)],
      hasChasm: true,
    ),
  ]),
  RoomKind.deadEnd: List.unmodifiable([
    RoomTemplate(
      id: 'isleEnd',
      kind: RoomKind.deadEnd,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_left0],
      islands: [_island(0, 1080, 700, 80, 300)],
      spots: [_spot(SpotKind.feature, 760, 700)],
    ),
    RoomTemplate(
      id: 'ledgeEnd',
      kind: RoomKind.deadEnd,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_left0],
      islands: [
        _island(0, 520, 700, 80, 240),
        _island(640, 1180, 600, 80, 280),
      ],
      spots: [_spot(SpotKind.feature, 900, 600)],
      hasChasm: true,
    ),
    RoomTemplate(
      id: 'shrineEnd',
      kind: RoomKind.deadEnd,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_left0],
      islands: [_island(0, 1250, 700, 80, 320)],
      spots: [_spot(SpotKind.feature, 850, 700)],
    ),
  ]),
  RoomKind.antechamber: List.unmodifiable([
    RoomTemplate(
      id: 'ante',
      kind: RoomKind.antechamber,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [_island(0, 1600, 700, 80, 320)],
      spots: [_spot(SpotKind.warning, 640, 700)],
    ),
  ]),
  // boss-room.md: three slabs hanging 270, 400 and 270 su above the floor;
  // no rings (operator, 2026-10-01).
  RoomKind.boss: List.unmodifiable([
    RoomTemplate(
      id: 'golemRoom',
      kind: RoomKind.boss,
      cellsWide: 2,
      cellsHigh: 1,
      passages: const [_left0, _right0],
      islands: [
        _island(0, 3200, 700, 90, 380),
        _island(640, 1040, 430, 50, 60, isHanging: true),
        _island(1400, 1800, 300, 50, 60, isHanging: true),
        _island(2160, 2560, 430, 50, 60, isHanging: true),
      ],
      spots: [_spot(SpotKind.boss, 1600, 700)],
    ),
  ]),
  RoomKind.wayDown: List.unmodifiable([
    RoomTemplate(
      id: 'exit',
      kind: RoomKind.wayDown,
      cellsWide: 1,
      cellsHigh: 1,
      passages: const [_left0],
      islands: [_island(0, 1100, 700, 80, 300)],
      spots: [_spot(SpotKind.wayDown, 1120, 700)],
    ),
  ]),
};
