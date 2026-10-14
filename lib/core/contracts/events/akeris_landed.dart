import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class AkerisLanded implements GameEvent {
  const AkerisLanded({
    required this.at,
    required this.fallSpeed,
  });

  final Vec2 at;
  final double fallSpeed;
}
