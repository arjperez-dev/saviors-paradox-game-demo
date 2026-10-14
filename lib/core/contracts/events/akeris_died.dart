import 'package:saviors_paradox/core/contracts/events/death_cause.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class AkerisDied implements GameEvent {
  const AkerisDied({
    required this.cause,
    required this.at,
  });

  final DeathCause cause;
  final Vec2 at;
}
