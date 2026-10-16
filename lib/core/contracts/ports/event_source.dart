import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/ports/event_subscription.dart';

/// Where handlers subscribe to the events of one type.
abstract interface class EventSource {
  /// Subscribes [handler] to every event of type [E] until the returned
  /// subscription is cancelled.
  EventSubscription subscribe<E extends GameEvent>(
    void Function(E event) handler,
  );
}
