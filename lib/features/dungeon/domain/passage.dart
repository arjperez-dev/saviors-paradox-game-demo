import 'package:saviors_paradox/core/contracts/kernel/facing.dart';

/// A side passage of a room, on one of its cell rows (layout.md §B.2).
final class Passage {
  const Passage({required this.side, required this.row})
    : assert(row >= 0, 'a passage is on one of the room rows');

  final Facing side;
  final int row;

  Passage mirrored() => Passage(side: side.opposite, row: row);

  @override
  bool operator ==(Object other) =>
      other is Passage && other.side == side && other.row == row;

  @override
  int get hashCode => Object.hash(side, row);
}
