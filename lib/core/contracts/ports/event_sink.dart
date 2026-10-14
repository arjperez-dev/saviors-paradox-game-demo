import 'package:saviors_paradox/core/contracts/events/game_event.dart';

abstract interface class EventSink {
  void publish(GameEvent event);
}
