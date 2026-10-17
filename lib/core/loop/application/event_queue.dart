import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/event_source.dart';
import 'package:saviors_paradox/core/contracts/ports/event_subscription.dart';

/// The one queue every feature publishes to (design-patterns.md §7).
///
/// Events wait until [deliver]; then each reaches, in the order it was
/// published, every handler of its type, in the order they subscribed.
/// A cancelled handler gets nothing more, and its place is released when
/// the delivery ends.
final class EventQueue implements EventSink, EventSource {
  final List<_Subscription<GameEvent>> _subscriptions = [];
  List<GameEvent> _pending = [];
  List<GameEvent> _delivering = [];

  @override
  void publish(GameEvent event) => _pending.add(event);

  @override
  EventSubscription subscribe<E extends GameEvent>(
    void Function(E event) handler,
  ) {
    final subscription = _Subscription<E>(handler);
    _subscriptions.add(subscription);
    return subscription;
  }

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
    _releaseCancelled();
  }

  // Indexed loops: no iterator is allocated in the per-frame path
  // (architecture.md §6.1).
  void _offer(GameEvent event) {
    for (var i = 0; i < _subscriptions.length; i++) {
      _subscriptions[i].offer(event);
    }
  }

  // Compacts the list in place, keeping the order: removeWhere would
  // allocate (architecture.md §6.1). Run only after a delivery, so a
  // cancel during one never shifts the handlers still to be offered.
  void _releaseCancelled() {
    var kept = 0;
    for (var i = 0; i < _subscriptions.length; i++) {
      final subscription = _subscriptions[i];
      if (subscription.isActive) {
        _subscriptions[kept] = subscription;
        kept++;
      }
    }
    _subscriptions.length = kept;
  }
}

final class _Subscription<E extends GameEvent> implements EventSubscription {
  _Subscription(this._handler);

  final void Function(E event) _handler;
  bool _isActive = true;

  bool get isActive => _isActive;

  void offer(GameEvent event) {
    if (_isActive && event is E) {
      _handler(event);
    }
  }

  @override
  void cancel() => _isActive = false;
}
