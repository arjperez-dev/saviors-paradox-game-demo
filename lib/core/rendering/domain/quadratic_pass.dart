import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// One quadratic curve of a pencil line, in sandbox units.
final class QuadraticPass {
  const QuadraticPass({
    required this.start,
    required this.control,
    required this.end,
    required this.width,
    required this.alpha,
  });

  final Vec2 start;
  final Vec2 control;
  final Vec2 end;
  final double width;
  final double alpha;

  @override
  bool operator ==(Object other) =>
      other is QuadraticPass &&
      other.start == start &&
      other.control == control &&
      other.end == end &&
      other.width == width &&
      other.alpha == alpha;

  @override
  int get hashCode => Object.hash(start, control, end, width, alpha);
}
