import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// A small pit in a stone: an ink ellipse.
final class StonePit {
  const StonePit({
    required this.centre,
    required this.radii,
    required this.rotation,
  });

  final Vec2 centre;
  final Vec2 radii;
  final double rotation;
}
