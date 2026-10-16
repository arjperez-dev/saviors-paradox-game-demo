/// A handler's hold on an `EventSource`, kept by whoever subscribed it.
abstract interface class EventSubscription {
  /// Releases the handler: no event reaches it after this call. Calling it
  /// again does nothing, and a cancel during delivery skips no other
  /// handler.
  void cancel();
}
