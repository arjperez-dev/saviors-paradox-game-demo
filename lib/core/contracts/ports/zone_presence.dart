import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// Where Akeris stands in the zone, told once per step.
abstract interface class ZonePresence {
  /// Akeris is now at [position], as `AkerisState.position` names it.
  void movedTo(Vec2 position);
}
