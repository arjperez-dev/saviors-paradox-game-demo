import 'package:saviors_paradox/core/contracts/kernel/facing.dart';

/// A side passage joining room [from] to room [to], leaving [from] by
/// [side] on grid [row] (layout.md §B.2 step 1).
final class RoomLink {
  const RoomLink({
    required this.from,
    required this.to,
    required this.side,
    required this.row,
  });

  final int from;
  final int to;
  final Facing side;
  final int row;

  @override
  bool operator ==(Object other) =>
      other is RoomLink &&
      other.from == from &&
      other.to == to &&
      other.side == side &&
      other.row == row;

  @override
  int get hashCode => Object.hash(from, to, side, row);
}
