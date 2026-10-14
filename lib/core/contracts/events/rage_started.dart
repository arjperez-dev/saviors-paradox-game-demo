import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';

final class RageStarted implements GameEvent {
  const RageStarted({
    required this.duration,
  });

  final Seconds duration;
}
