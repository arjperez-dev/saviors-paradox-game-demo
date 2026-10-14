import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class FastDescentLanded implements GameEvent {
  const FastDescentLanded({
    required this.at,
  });

  final Vec2 at;
}
