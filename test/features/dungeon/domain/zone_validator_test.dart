import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/features/dungeon/domain/dead_end_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_link.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_validator.dart';

final _kit = SuspendedSanctuaryKit();

PlacedRoom _room({
  required int index,
  required RoomKind kind,
  required int depth,
  int? from,
  bool isOnMainPath = true,
  DeadEndRole? role,
}) => PlacedRoom(
  index: index,
  template: _kit.templatesOf(kind).first,
  column: index,
  row: 0,
  depth: depth,
  from: from,
  isOnMainPath: isOnMainPath,
  role: role,
  linked: const [],
);

/// Start (0) → antechamber (1) → boss (2) → way down (3), all on the main
/// path, plus a dead end (4) linked to the start.
List<PlacedRoom> _playableRooms({bool anteOnMainPath = true}) => [
  _room(index: 0, kind: RoomKind.start, depth: 0),
  _room(
    index: 1,
    kind: RoomKind.antechamber,
    depth: 1,
    from: 0,
    isOnMainPath: anteOnMainPath,
  ),
  _room(index: 2, kind: RoomKind.boss, depth: 2, from: 1),
  _room(index: 3, kind: RoomKind.wayDown, depth: 3, from: 2),
  _room(
    index: 4,
    kind: RoomKind.deadEnd,
    depth: 1,
    from: 0,
    isOnMainPath: false,
    role: DeadEndRole.altar,
  ),
];

List<RoomLink> _playableLinks({bool withDeadEndLink = true}) => [
  const RoomLink(from: 0, to: 1, side: Facing.right, row: 0),
  const RoomLink(from: 1, to: 2, side: Facing.right, row: 0),
  const RoomLink(from: 2, to: 3, side: Facing.right, row: 0),
  if (withDeadEndLink)
    const RoomLink(from: 0, to: 4, side: Facing.left, row: 0),
];

ZoneLayout _layout({
  List<PlacedRoom>? rooms,
  List<RoomLink>? links,
}) => ZoneLayout(
  grid: ZoneGrid.standard,
  rooms: rooms ?? _playableRooms(),
  links: links ?? _playableLinks(),
);

void main() {
  group('ZoneValidator', () {
    const validator = ZoneValidator(fewestRooms: 4, fewestDeadEnds: 1);

    test('a playable layout passes', () {
      expect(validator.isSatisfiedBy(_layout()), isTrue);
    });

    test('a layout with fewer rooms than the fewest fails', () {
      const strict = ZoneValidator(fewestRooms: 6, fewestDeadEnds: 1);

      expect(strict.isSatisfiedBy(_layout()), isFalse);
    });

    test('a layout with too few dead ends fails', () {
      const strict = ZoneValidator(fewestRooms: 4, fewestDeadEnds: 2);

      expect(strict.isSatisfiedBy(_layout()), isFalse);
    });

    test('a layout with a room no passage reaches fails', () {
      final layout = _layout(links: _playableLinks(withDeadEndLink: false));

      expect(validator.isSatisfiedBy(layout), isFalse);
    });

    test('a layout whose boss is reached only through a branch fails', () {
      final layout = _layout(rooms: _playableRooms(anteOnMainPath: false));

      expect(validator.isSatisfiedBy(layout), isFalse);
    });
  });
}
