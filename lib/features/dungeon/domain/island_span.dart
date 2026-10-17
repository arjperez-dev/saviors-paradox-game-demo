import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';

/// An island of a template, in su from its room's top left: its top is
/// the floor stood on; the rock under it is drawn, never solid.
final class IslandSpan {
  const IslandSpan({
    required this.left,
    required this.right,
    required this.top,
    required this.thickness,
    required this.underside,
    this.isHanging = false,
  }) : assert(right > left, 'an island has a width'),
       assert(thickness > 0, 'an island has a thickness'),
       assert(underside >= 0, 'the rock under an island is never negative');

  final double left;
  final double right;
  final double top;
  final double thickness;
  final double underside;
  final bool isHanging;

  IslandSpan mirrored(double roomWidth) => IslandSpan(
    left: roomWidth - right,
    right: roomWidth - left,
    top: top,
    thickness: thickness,
    underside: underside,
    isHanging: isHanging,
  );

  WorldBox solidFrom(Vec2 origin) => edgesBox(
    origin.x + left,
    origin.y + top,
    origin.x + right,
    origin.y + top + thickness,
  );

  @override
  bool operator ==(Object other) =>
      other is IslandSpan &&
      other.left == left &&
      other.right == right &&
      other.top == top &&
      other.thickness == thickness &&
      other.underside == underside &&
      other.isHanging == isHanging;

  @override
  int get hashCode =>
      Object.hash(left, right, top, thickness, underside, isHanging);
}
