import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap_size.dart';

void main() {
  group('KeyCapSize', () {
    test('a cap is 32 tall unless told', () {
      // 06-ui/sandbox/sandbox.html keyCap: 32 tall.
      expect(const KeyCapSize().height, 32);
    });

    test('sizes are equal by height', () {
      const a = KeyCapSize(height: 36);
      const b = KeyCapSize(height: 36);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(const KeyCapSize()));
    });

    test('a cap with no height is refused', () {
      expect(() => KeyCapSize(height: 0), throwsAssertionError);
    });
  });
}
