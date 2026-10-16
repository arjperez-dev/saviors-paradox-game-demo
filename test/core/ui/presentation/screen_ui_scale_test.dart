import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/ui/presentation/screen_ui_scale.dart';

void main() {
  group('ScreenUiScale', () {
    test('a UI point scales to the screen by its height over 1080', () {
      const scale = ScreenUiScale(screenHeight: 1440);

      final screen = scale.toScreen(const UiVec2(Vec2(960, 540)));

      // 06-ui/ui.md §3: a hu point scales by screen height ÷ 1080.
      expect(screen, const ScreenVec2(Vec2(1280, 720)));
    });

    test('a screen point scales back to the UI frame', () {
      const scale = ScreenUiScale(screenHeight: 1440);

      final ui = scale.toUi(const ScreenVec2(Vec2(1280, 720)));

      expect(ui, const UiVec2(Vec2(960, 540)));
    });

    test('the reference height is one pixel per hu', () {
      const scale = ScreenUiScale(screenHeight: 1080);

      // 06-ui/ui.md §3: at the reference height, hu and pixels coincide.
      expect(scale.pixelsPerHu, 1);
      expect(
        scale.toScreen(const UiVec2(Vec2(1920, 1080))),
        const ScreenVec2(Vec2(1920, 1080)),
      );
    });

    test('the scale adds no offset', () {
      for (final screenHeight in [720.0, 1080.0, 1440.0]) {
        final scale = ScreenUiScale(screenHeight: screenHeight);

        expect(scale.toScreen(UiVec2.zero), ScreenVec2.zero);
        expect(scale.toUi(ScreenVec2.zero), UiVec2.zero);
      }
    });

    test('scales are equal by screen height', () {
      const a = ScreenUiScale(screenHeight: 1080);
      const b = ScreenUiScale(screenHeight: 1080);
      const c = ScreenUiScale(screenHeight: 1440);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a == c, isFalse);
    });

    test('a screen with no height is refused', () {
      expect(() => ScreenUiScale(screenHeight: 0), throwsAssertionError);
    });
  });
}
