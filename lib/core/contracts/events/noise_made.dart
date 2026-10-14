import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class NoiseMade implements GameEvent {
  const NoiseMade({
    required this.at,
    required this.radius,
  });

  final Vec2 at;
  final double radius;
}
