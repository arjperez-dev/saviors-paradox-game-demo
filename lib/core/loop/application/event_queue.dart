// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/event_source.dart';

final class EventQueue implements EventSink, EventSource {
  @override
  void publish(GameEvent event) {}

  @override
  void subscribe<E extends GameEvent>(void Function(E event) handler) {}
}
