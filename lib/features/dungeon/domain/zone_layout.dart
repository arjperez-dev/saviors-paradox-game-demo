import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_link.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

/// The rooms of one attempt and the passages between them.
final class ZoneLayout {
  ZoneLayout({
    required this.grid,
    required List<PlacedRoom> rooms,
    required List<RoomLink> links,
  }) : rooms = List.unmodifiable(rooms),
       links = List.unmodifiable(links);

  final ZoneGrid grid;
  final List<PlacedRoom> rooms;
  final List<RoomLink> links;

  /// The rooms a passage joins to room [index], in the order linked.
  List<int> neighboursOf(int index) => [
    for (final link in links)
      if (link.from == index) link.to else if (link.to == index) link.from,
  ];

  @override
  bool operator ==(Object other) =>
      other is ZoneLayout &&
      other.grid == grid &&
      _same(other.rooms, rooms) &&
      _same(other.links, links);

  @override
  int get hashCode =>
      Object.hash(grid, Object.hashAll(rooms), Object.hashAll(links));
}

bool _same<T>(List<T> a, List<T> b) {
  if (a.length != b.length) {
    return false;
  }
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}
