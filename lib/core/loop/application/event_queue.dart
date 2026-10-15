import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/event_source.dart';

/// The one queue every feature publishes to (design-patterns.md §7).
///
/// Events wait until [deliver]; then each reaches, in the order it was
/// published, every handler of its type, in the order they subscribed.
final class EventQueue implements EventSink, EventSource {
  final List<_Subscription<GameEvent>> _subscriptions = [];
  List<GameEvent> _pending = [];
  List<GameEvent> _delivering = [];

  @override
  void publish(GameEvent event) => _pending.add(event);

  @override
  void subscribe<E extends GameEvent>(void Function(E event) handler) =>
      _subscriptions.add(_Subscription<E>(handler));

  /// Delivers every event published before this call. An event published
  /// while delivering waits for the next call: no handler is re-entered.
  void deliver() {
    final delivering = _pending;
    _pending = _delivering;
    _delivering = delivering;
    for (var i = 0; i < delivering.length; i++) {
      _offer(delivering[i]);
    }
    delivering.clear();
  }

  // Indexed loops: no iterator is allocated in the per-frame path
  // (architecture.md §6.1).
  void _offer(GameEvent event) {
    for (var i = 0; i < _subscriptions.length; i++) {
      _subscriptions[i].offer(event);
    }
  }
}

final class _Subscription<E extends GameEvent> {
  const _Subscription(this._handler);

  final void Function(E event) _handler;

  void offer(GameEvent event) {
    if (event is E) {
      _handler(event);
    }
  }
}
