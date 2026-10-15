/// An object a [Pool] hands out again instead of a new one.
abstract interface class Poolable {
  /// Returns the object to the state of a fresh one.
  void reset();
}

/// A fixed set of short-lived objects, built once and reused: [acquire]
/// resets and returns a free one; when none is free it reuses the oldest
/// active one rather than allocating (design-patterns.md §8).
final class Pool<T extends Poolable> {
  Pool({required int size, required T Function() create})
    : assert(size > 0),
      _items = List.generate(size, (_) => create(), growable: false),
      _acquiredAt = List.filled(size, _free);

  static const int _free = -1;

  final List<T> _items;

  /// When each item was acquired, by acquisition count; [_free] when free.
  final List<int> _acquiredAt;
  int _acquisitions = 0;
  int _activeCount = 0;

  int get size => _items.length;

  int get activeCount => _activeCount;

  /// A reset item, marked active.
  T acquire() {
    final free = _acquiredAt.indexOf(_free);
    final index = free >= 0 ? free : _oldestIndex();
    if (free >= 0) {
      _activeCount++;
    }
    _acquiredAt[index] = _acquisitions++;
    return _items[index]..reset();
  }

  /// Marks [item] free again; an item that is not active is ignored.
  void release(T item) {
    final index = _items.indexOf(item);
    if (index >= 0 && _acquiredAt[index] != _free) {
      _acquiredAt[index] = _free;
      _activeCount--;
    }
  }

  int _oldestIndex() {
    var oldest = 0;
    for (var i = 1; i < _acquiredAt.length; i++) {
      if (_acquiredAt[i] < _acquiredAt[oldest]) {
        oldest = i;
      }
    }
    return oldest;
  }
}
