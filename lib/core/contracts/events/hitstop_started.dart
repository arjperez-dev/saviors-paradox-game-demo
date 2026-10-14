import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';

final class HitstopStarted implements GameEvent {
  const HitstopStarted({
    required this.duration,
  });

  final Seconds duration;
}
