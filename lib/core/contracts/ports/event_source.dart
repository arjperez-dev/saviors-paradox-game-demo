import 'package:saviors_paradox/core/contracts/events/game_event.dart';

abstract interface class EventSource {
  void subscribe<E extends GameEvent>(void Function(E event) handler);
}
