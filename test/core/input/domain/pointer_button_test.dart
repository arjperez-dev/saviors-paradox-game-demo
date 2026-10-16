import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';

void main() {
  group('PointerButton', () {
    test('names the two mouse buttons', () {
      // 00-game/controls.md §2
      expect(PointerButton.values, [
        PointerButton.primary,
        PointerButton.secondary,
      ]);
    });
  });
}
