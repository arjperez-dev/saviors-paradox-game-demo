import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';

abstract base class WorldResumed implements GameEvent {
  const WorldResumed(this.cause);

  final HaltCause cause;
}
