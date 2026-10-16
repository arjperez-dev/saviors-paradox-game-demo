import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

void main() {
  group('RawInput', () {
    test('raw inputs are equal by value', () {
      const keyDownA1 = KeyDown(InputKey.a);
      const keyDownA2 = KeyDown(InputKey.a);
      const keyUpA = KeyUp(InputKey.a);
      const keyDownD = KeyDown(InputKey.d);

      const keyUpA2 = KeyUp(InputKey.a);
      const keyUpD = KeyUp(InputKey.d);

      expect(keyDownA1, keyDownA2);
      expect(keyDownA1.hashCode, keyDownA2.hashCode);
      expect(keyDownA1 == keyUpA, isFalse);
      expect(keyDownA1 == keyDownD, isFalse);
      expect(keyUpA, keyUpA2);
      expect(keyUpA.hashCode, keyUpA2.hashCode);
      expect(keyUpA == keyDownA1, isFalse);
      expect(keyUpA == keyUpD, isFalse);

      const buttonDownPrimary1 = ButtonDown(PointerButton.primary);
      const buttonDownPrimary2 = ButtonDown(PointerButton.primary);
      const buttonUpPrimary = ButtonUp(PointerButton.primary);
      const buttonDownSecondary = ButtonDown(PointerButton.secondary);

      const buttonUpPrimary2 = ButtonUp(PointerButton.primary);
      const buttonUpSecondary = ButtonUp(PointerButton.secondary);

      expect(buttonDownPrimary1, buttonDownPrimary2);
      expect(buttonDownPrimary1.hashCode, buttonDownPrimary2.hashCode);
      expect(buttonDownPrimary1 == buttonUpPrimary, isFalse);
      expect(buttonDownPrimary1 == buttonDownSecondary, isFalse);
      expect(buttonUpPrimary, buttonUpPrimary2);
      expect(buttonUpPrimary.hashCode, buttonUpPrimary2.hashCode);
      expect(buttonUpPrimary == buttonDownPrimary1, isFalse);
      expect(buttonUpPrimary == buttonUpSecondary, isFalse);

      const moved1 = PointerMoved(
        position: ScreenVec2(Vec2(10, 20)),
        delta: ScreenVec2(Vec2(3, -4)),
      );
      const moved2 = PointerMoved(
        position: ScreenVec2(Vec2(10, 20)),
        delta: ScreenVec2(Vec2(3, -4)),
      );
      const movedOtherPosition = PointerMoved(
        position: ScreenVec2(Vec2(11, 20)),
        delta: ScreenVec2(Vec2(3, -4)),
      );
      const movedOtherDelta = PointerMoved(
        position: ScreenVec2(Vec2(10, 20)),
        delta: ScreenVec2(Vec2(3, -5)),
      );

      expect(moved1, moved2);
      expect(moved1.hashCode, moved2.hashCode);
      expect(moved1 == movedOtherPosition, isFalse);
      expect(moved1 == movedOtherDelta, isFalse);

      const scrolled1 = Scrolled(steps: 1);
      const scrolled2 = Scrolled(steps: 1);
      const scrolledOther = Scrolled(steps: -1);

      expect(scrolled1, scrolled2);
      expect(scrolled1.hashCode, scrolled2.hashCode);
      expect(scrolled1 == scrolledOther, isFalse);
    });

    test('a pointer move carries its position and movement', () {
      const moved = PointerMoved(
        position: ScreenVec2(Vec2(10, 20)),
        delta: ScreenVec2(Vec2(3, -4)),
      );

      expect(moved.position, const ScreenVec2(Vec2(10, 20)));
      expect(moved.delta, const ScreenVec2(Vec2(3, -4)));
    });
  });
}
