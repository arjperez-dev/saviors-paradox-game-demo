import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/ui_scale.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/screen_ui_scale.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('InkThemeData', () {
    test('hu scale to pixels by the screen height', () {
      const data = InkThemeData(ScreenUiScale(screenHeight: 1440));

      // 06-ui/ui.md §3: hu scaled by screen height ÷ 1080.
      expect(data.pixels(30), 40);
    });

    test('the theme gives the UI scale as the port', () {
      const data = InkThemeData(ScreenUiScale(screenHeight: 1440));

      final UiScale scale = data.scale;

      expect(
        scale.toScreen(const UiVec2(Vec2(960, 540))),
        const ScreenVec2(Vec2(1280, 720)),
      );
    });

    test('lettering is Patrick Hand at the scaled size', () {
      const data = InkThemeData(ScreenUiScale(screenHeight: 1440));

      final style = data.lettering(InkLettering.hint);

      expect(style.fontFamily, 'Patrick Hand');
      expect(style.fontSize, 32);
      expect(style.color, InkLettering.hint.colour);
    });

    test("a text is measured at its role's size in hu", () {
      final buttonWidth = InkThemeData.widthOf('Resume', InkLettering.button);
      final hintWidth = InkThemeData.widthOf('Resume', InkLettering.hint);

      expect(buttonWidth / hintWidth, closeTo(30 / 24, 1e-9));
      expect(InkThemeData.widthOf('', InkLettering.button), 0);
    });

    test("the theme carries the sandbox's stroke widths", () {
      // 06-ui/sandbox/sandbox.html sheetAt, hudBox;
      // 01-story/cinematics/sandbox/sandbox.html skipOverlay.
      expect(InkThemeData.sheetBorderWidth, 3.2);
      expect(InkThemeData.sheetInnerWidth, 1.2);
      expect(InkThemeData.sheetShadowSigma, 17);
      expect(InkThemeData.frameWidth, 1.7);
      expect(InkThemeData.focusWidth, 3.6);
      expect(InkThemeData.focusInnerWidth, 1);
      expect(InkThemeData.dashWidth, 1.4);
      expect(InkThemeData.dashOn, 7);
      expect(InkThemeData.dashOff, 6);
      expect(InkThemeData.ringBaseWidth, 1.4);
      expect(InkThemeData.ringArcWidth, 4.2);
    });

    test("the theme carries the sandbox's colours", () {
      // 06-ui/sandbox/sandbox.html sheetAt, hudBox, ttBox, ttMain, keyCap,
      // ttConfirm, pmConfirm; 01-story/cinematics/sandbox/sandbox.html
      // skipOverlay.
      expect(
        InkThemeData.sheetInnerColour,
        const Color.fromRGBO(26, 23, 21, 0.4),
      );
      expect(
        InkThemeData.sheetLight,
        const Color.fromRGBO(239, 230, 214, 0.32),
      );
      expect(InkThemeData.sheetShade, const Color.fromRGBO(14, 11, 9, 0.3));
      expect(
        InkThemeData.frameColour,
        const Color.fromRGBO(26, 23, 21, 0.62),
      );
      expect(InkThemeData.focusColour, Palette.ink);
      expect(
        InkThemeData.focusInnerColour,
        const Color.fromRGBO(26, 23, 21, 0.35),
      );
      expect(InkThemeData.dashColour, const Color.fromRGBO(26, 23, 21, 0.45));
      expect(
        InkThemeData.paperFill,
        const Color.fromRGBO(239, 230, 214, 0.78),
      );
      expect(
        InkThemeData.paperFillHovered,
        const Color.fromRGBO(239, 230, 214, 0.95),
      );
      expect(InkThemeData.faintFill, const Color.fromRGBO(212, 204, 190, 0.55));
      expect(
        InkThemeData.faintFillHovered,
        const Color.fromRGBO(212, 204, 190, 0.75),
      );
      expect(
        InkThemeData.dashedFill,
        const Color.fromRGBO(239, 230, 214, 0.28),
      );
      expect(
        InkThemeData.dashedFillHovered,
        const Color.fromRGBO(26, 23, 21, 0.08),
      );
      expect(InkThemeData.keyCapFill, Palette.paperLight);
      expect(
        InkThemeData.questionFill,
        const Color.fromRGBO(239, 230, 214, 0.97),
      );
      expect(InkThemeData.questionWash, const Color.fromRGBO(14, 11, 9, 0.45));
      expect(InkThemeData.ringOnPaper, Palette.ink);
      expect(
        InkThemeData.ringBaseOnPaper,
        const Color.fromRGBO(26, 23, 21, 0.3),
      );
      expect(InkThemeData.ringOnDark, const Color.fromRGBO(239, 230, 214, 0.9));
      expect(
        InkThemeData.ringBaseOnDark,
        const Color.fromRGBO(239, 230, 214, 0.3),
      );
    });

    test("the sheet's shadow is darkness at .55", () {
      // 02-art-direction/palette/palette.md §2 depth/pit base;
      // 06-ui/sandbox/sandbox.html sheetAt alpha .55.
      expect(
        InkThemeData.sheetShadowColour,
        const Color.fromRGBO(14, 11, 9, 0.55),
      );
    });
  });
}
