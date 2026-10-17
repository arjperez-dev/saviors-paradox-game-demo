import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/dead_end_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

/// A room as one attempt placed it on the grid; its template is already
/// mirrored when it was placed mirrored.
final class PlacedRoom {
  PlacedRoom({
    required this.index,
    required this.template,
    required this.column,
    required this.row,
    required this.depth,
    required this.from,
    required this.isOnMainPath,
    required this.role,
    required List<Passage> linked,
  }) : assert(index >= 0 && depth >= 0, 'a room has a place in the zone'),
       linked = List.unmodifiable(linked);

  final int index;
  final RoomTemplate template;
  final int column;
  final int row;
  final int depth;
  final int? from;
  final bool isOnMainPath;
  final DeadEndRole? role;
  final List<Passage> linked;

  RoomKind get kind => template.kind;

  Vec2 originOn(ZoneGrid grid) =>
      Vec2(column * grid.cellWidth, row * grid.cellHeight);

  WorldBox boundsOn(ZoneGrid grid) {
    final origin = originOn(grid);
    return edgesBox(
      origin.x,
      origin.y,
      origin.x + template.widthOn(grid),
      origin.y + template.heightOn(grid),
    );
  }

  bool isLinkedAt(Passage passage) => linked.contains(passage);

  @override
  bool operator ==(Object other) =>
      other is PlacedRoom &&
      other.index == index &&
      other.template == template &&
      other.column == column &&
      other.row == row &&
      other.depth == depth &&
      other.from == from &&
      other.isOnMainPath == isOnMainPath &&
      other.role == role &&
      _samePassages(other.linked, linked);

  @override
  int get hashCode => Object.hash(
    index,
    template,
    column,
    row,
    depth,
    from,
    isOnMainPath,
    role,
    Object.hashAll(linked),
  );
}

bool _samePassages(List<Passage> a, List<Passage> b) {
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
