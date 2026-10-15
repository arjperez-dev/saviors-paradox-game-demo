import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/rendering/domain/pool.dart';

final class FakePoolable implements Poolable {
  int resetCount = 0;

  @override
  void reset() => resetCount++;
}

void main() {
  group('Pool', () {
    test('hands out a different free object each time', () {
      final pool = Pool<FakePoolable>(size: 2, create: FakePoolable.new);

      final first = pool.acquire();
      final second = pool.acquire();

      expect(first, isNot(same(second)));
    });

    test('reuses the oldest active object when none is free', () {
      final pool = Pool<FakePoolable>(size: 2, create: FakePoolable.new);
      final first = pool.acquire();
      pool.acquire();

      final third = pool.acquire();

      expect(third, same(first));
    });

    test('counts the objects in use', () {
      final pool = Pool<FakePoolable>(size: 2, create: FakePoolable.new);
      expect(pool.activeCount, 0);

      pool.acquire();
      final second = pool.acquire();
      expect(pool.activeCount, 2);

      pool.acquire();
      expect(pool.activeCount, 2);

      pool.release(second);
      expect(pool.activeCount, 1);
    });

    test('hands a released object out again', () {
      final pool = Pool<FakePoolable>(size: 2, create: FakePoolable.new);
      pool.acquire();
      final second = pool.acquire();

      pool.release(second);
      final next = pool.acquire();

      expect(next, same(second));
    });

    test('resets an object before handing it out', () {
      final pool = Pool<FakePoolable>(size: 2, create: FakePoolable.new);

      final item = pool.acquire();

      expect(item.resetCount, 1);
    });

    test('ignores the release of an object that is not active', () {
      final pool = Pool<FakePoolable>(size: 2, create: FakePoolable.new);
      final item = pool.acquire();
      pool.acquire();

      pool.release(item);
      pool.release(item);

      expect(pool.activeCount, 1);
    });
  });
}
