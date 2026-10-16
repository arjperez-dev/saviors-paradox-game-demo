import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/ui/presentation/cap_key.dart';

void main() {
  group('CapKey', () {
    test('cap keys are equal by key and name', () {
      const capKey = CapKey(InputKey.escape, label: 'Esc');
      const same = CapKey(InputKey.escape, label: 'Esc');
      const otherKey = CapKey(InputKey.enter, label: 'Esc');
      const otherLabel = CapKey(InputKey.escape, label: 'Back');

      expect(capKey, same);
      expect(capKey.hashCode, same.hashCode);
      expect(capKey, isNot(otherKey));
      expect(capKey, isNot(otherLabel));
    });

    test('a cap with no name is refused', () {
      expect(
        () => CapKey(InputKey.m, label: ''),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
