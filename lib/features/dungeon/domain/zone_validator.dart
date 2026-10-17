import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';

/// Whether a layout makes a playable zone (layout.md §B.2 step 4,
/// Acceptance 2–3).
final class ZoneValidator {
  const ZoneValidator({
    required this.fewestRooms,
    required this.fewestDeadEnds,
  });

  final int fewestRooms;
  final int fewestDeadEnds;

  bool isSatisfiedBy(ZoneLayout layout) =>
      layout.rooms.length >= fewestRooms &&
      _deadEnds(layout) >= fewestDeadEnds &&
      _everyRoomReached(layout) &&
      _bossOnMainPath(layout);

  static int _deadEnds(ZoneLayout layout) =>
      layout.rooms.where((room) => room.kind == RoomKind.deadEnd).length;

  static bool _everyRoomReached(ZoneLayout layout) {
    final start = _indexOf(layout, RoomKind.start);
    return start >= 0 &&
        _reached(layout, start, (room) => true).length == layout.rooms.length;
  }

  static bool _bossOnMainPath(ZoneLayout layout) {
    final start = _indexOf(layout, RoomKind.start);
    final boss = _indexOf(layout, RoomKind.boss);
    return start >= 0 &&
        boss >= 0 &&
        _reached(layout, start, (room) => room.isOnMainPath).contains(boss);
  }

  static int _indexOf(ZoneLayout layout, RoomKind kind) =>
      layout.rooms.indexWhere((room) => room.kind == kind);

  static Set<int> _reached(
    ZoneLayout layout,
    int start,
    bool Function(PlacedRoom room) canEnter,
  ) {
    final reached = <int>{start};
    _visit(layout, start, reached, canEnter);
    return reached;
  }

  static void _visit(
    ZoneLayout layout,
    int room,
    Set<int> reached,
    bool Function(PlacedRoom room) canEnter,
  ) {
    for (final next in layout.neighboursOf(room)) {
      if (canEnter(layout.rooms[next]) && reached.add(next)) {
        _visit(layout, next, reached, canEnter);
      }
    }
  }
}
