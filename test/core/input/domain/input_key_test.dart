import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';

void main() {
  group('InputKey', () {
    test('names every key the controls bind', () {
      // 00-game/controls.md §1-§4
      expect(InputKey.values, [
        InputKey.a,
        InputKey.d,
        InputKey.w,
        InputKey.s,
        InputKey.space,
        InputKey.shift,
        InputKey.controlLeft,
        InputKey.q,
        InputKey.e,
        InputKey.r,
        InputKey.f,
        InputKey.g,
        InputKey.h,
        InputKey.m,
        InputKey.enter,
        InputKey.escape,
        InputKey.digit1,
        InputKey.digit2,
        InputKey.digit3,
        InputKey.digit4,
        InputKey.digit5,
        InputKey.arrowUp,
        InputKey.arrowDown,
        InputKey.arrowLeft,
        InputKey.arrowRight,
      ]);
    });
  });
}
