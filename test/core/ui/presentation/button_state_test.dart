import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/ui/presentation/button_look.dart';
import 'package:saviors_paradox/core/ui/presentation/button_state.dart';
import 'package:saviors_paradox/core/ui/presentation/flash_kind.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';

void main() {
  group('ButtonState', () {
    test('states are equal by value', () {
      const state = ButtonState(
        seed: Seed(1),
        look: ButtonLook.faint,
        focused: true,
        flash: InkFlash(FlashKind.done, serial: 1),
      );
      const same = ButtonState(
        seed: Seed(1),
        look: ButtonLook.faint,
        focused: true,
        flash: InkFlash(FlashKind.done, serial: 1),
      );
      const otherSeed = ButtonState(
        seed: Seed(2),
        look: ButtonLook.faint,
        focused: true,
        flash: InkFlash(FlashKind.done, serial: 1),
      );
      const otherLook = ButtonState(
        seed: Seed(1),
        look: ButtonLook.plain,
        focused: true,
        flash: InkFlash(FlashKind.done, serial: 1),
      );
      const otherFocused = ButtonState(
        seed: Seed(1),
        look: ButtonLook.faint,
        focused: false,
        flash: InkFlash(FlashKind.done, serial: 1),
      );
      const otherFlash = ButtonState(
        seed: Seed(1),
        look: ButtonLook.faint,
        focused: true,
        flash: InkFlash(FlashKind.done, serial: 2),
      );

      expect(state, same);
      expect(state.hashCode, same.hashCode);
      expect(state, isNot(otherSeed));
      expect(state, isNot(otherLook));
      expect(state, isNot(otherFocused));
      expect(state, isNot(otherFlash));
    });
  });
}
