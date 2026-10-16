import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_style.dart';

void main() {
  group('FrameStyle', () {
    test('styles are equal by value', () {
      const style = FrameStyle(
        seed: Seed(1),
        look: FrameLook.faint,
        focused: true,
      );
      const same = FrameStyle(
        seed: Seed(1),
        look: FrameLook.faint,
        focused: true,
      );
      const otherSeed = FrameStyle(
        seed: Seed(2),
        look: FrameLook.faint,
        focused: true,
      );
      const otherLook = FrameStyle(
        seed: Seed(1),
        look: FrameLook.paper,
        focused: true,
      );
      const otherFocused = FrameStyle(
        seed: Seed(1),
        look: FrameLook.faint,
        focused: false,
      );
      const otherHovered = FrameStyle(
        seed: Seed(1),
        look: FrameLook.faint,
        focused: true,
        hovered: true,
      );

      expect(style, same);
      expect(style.hashCode, same.hashCode);
      expect(style, isNot(otherSeed));
      expect(style, isNot(otherLook));
      expect(style, isNot(otherFocused));
      expect(style, isNot(otherHovered));
    });
  });
}
