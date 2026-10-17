import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';

/// A solid wall or column of a template, in su from its room's top left.
final class WallSpan {
  const WallSpan({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  }) : assert(right > left && bottom > top, 'a wall has a size');

  final double left;
  final double top;
  final double right;
  final double bottom;

  WallSpan mirrored(double roomWidth) => WallSpan(
    left: roomWidth - right,
    top: top,
    right: roomWidth - left,
    bottom: bottom,
  );

  WorldBox solidFrom(Vec2 origin) => edgesBox(
    origin.x + left,
    origin.y + top,
    origin.x + right,
    origin.y + bottom,
  );

  @override
  bool operator ==(Object other) =>
      other is WallSpan &&
      other.left == left &&
      other.top == top &&
      other.right == right &&
      other.bottom == bottom;

  @override
  int get hashCode => Object.hash(left, top, right, bottom);
}
