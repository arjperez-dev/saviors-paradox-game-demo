import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/domain/dashed_outline.dart';
import 'package:saviors_paradox/core/ui/domain/pencil_box.dart';
import 'package:saviors_paradox/core/ui/presentation/flash_kind.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_style.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_frame.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';

const UiVec2 _size = UiVec2(Vec2(200, 60));
const FrameStyle _style = FrameStyle(seed: Seed(4));

// A Paint's values are stored in a native single-precision buffer; a double
// literal compared against one read back must go through the same rounding.
double _f32(double value) => Float32List.fromList([value]).first;

Future<void> _setView(
  WidgetTester tester, {
  Size size = const Size(1920, 1080),
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

Widget _frame({
  UiVec2 size = _size,
  FrameStyle style = _style,
  InkFlash? flash,
  Widget? child,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: InkTheme(
    child: Align(
      alignment: Alignment.topLeft,
      child: InkFrame(size: size, style: style, flash: flash, child: child),
    ),
  ),
);

void main() {
  group('InkFrame', () {
    testWidgets('the frame takes its size in hu', (tester) async {
      await _setView(tester, size: const Size(2560, 1440));
      await tester.pumpWidget(_frame());

      final size = tester.getSize(find.byType(InkFrame));

      // 06-ui/ui.md §3: hu scaled by screen height ÷ 1080; 1440 ÷ 1080.
      expect(size.width, closeTo(266.666667, 1e-6));
      expect(size.height, closeTo(80, 1e-6));
    });

    testWidgets('a frame at rest paints its paper and a thin frame', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(_frame());

      expect(
        find.byType(InkFrame),
        paints
          ..path(color: InkThemeData.paperFill, style: PaintingStyle.fill)
          ..path(
            color: InkThemeData.frameColour,
            strokeWidth: _f32(InkThemeData.frameWidth),
            style: PaintingStyle.stroke,
          ),
      );
    });

    testWidgets('the mouse over a frame brightens its paper', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _frame(style: const FrameStyle(seed: Seed(4), hovered: true)),
      );

      expect(
        find.byType(InkFrame),
        paints..path(
          color: InkThemeData.paperFillHovered,
          style: PaintingStyle.fill,
        ),
      );
    });

    testWidgets('a focused frame is thick with an inner line', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(
        _frame(style: const FrameStyle(seed: Seed(4), focused: true)),
      );

      expect(
        find.byType(InkFrame),
        paints
          ..path(color: InkThemeData.paperFill, style: PaintingStyle.fill)
          ..path(color: Palette.ink, strokeWidth: _f32(InkThemeData.focusWidth))
          ..path(
            color: InkThemeData.focusInnerColour,
            strokeWidth: _f32(InkThemeData.focusInnerWidth),
          ),
      );
      expect(
        find.byType(InkFrame),
        isNot(paints..path(strokeWidth: _f32(InkThemeData.frameWidth))),
      );
    });

    testWidgets('each look paints its own paper', (tester) async {
      await _setView(tester);

      await tester.pumpWidget(
        _frame(style: const FrameStyle(seed: Seed(4), look: FrameLook.faint)),
      );
      expect(
        find.byType(InkFrame),
        paints..path(color: InkThemeData.faintFill, style: PaintingStyle.fill),
      );

      await tester.pumpWidget(
        _frame(
          style: const FrameStyle(seed: Seed(4), look: FrameLook.keyCap),
        ),
      );
      expect(
        find.byType(InkFrame),
        paints..path(color: Palette.paperLight, style: PaintingStyle.fill),
      );

      await tester.pumpWidget(
        _frame(
          style: const FrameStyle(seed: Seed(4), look: FrameLook.question),
        ),
      );
      expect(
        find.byType(InkFrame),
        paints..path(
          color: InkThemeData.questionFill,
          style: PaintingStyle.fill,
        ),
      );
    });

    testWidgets('an empty box paints dashes', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _frame(style: const FrameStyle(seed: Seed(4), look: FrameLook.dashed)),
      );

      // 06-ui/sandbox/sandbox.html hudBox: setLineDash([7, 6]).
      final dashCount = DashedOutline.along(
        PencilBox.generate(_size, seed: const Seed(4)).outline,
        on: 7,
        off: 6,
      ).dashes.length;

      var expected =
          paints..path(color: InkThemeData.dashedFill, style: PaintingStyle.fill);
      for (var i = 0; i < dashCount; i++) {
        expected = expected
          ..path(
            color: InkThemeData.dashColour,
            strokeWidth: _f32(InkThemeData.dashWidth),
          );
      }
      expect(find.byType(InkFrame), expected);
      expect(
        find.byType(InkFrame),
        isNot(paints..path(strokeWidth: _f32(InkThemeData.frameWidth))),
      );
    });

    testWidgets('a focused empty box adds the thick frame', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _frame(
          style: const FrameStyle(
            seed: Seed(4),
            look: FrameLook.dashed,
            focused: true,
          ),
        ),
      );

      final dashCount = DashedOutline.along(
        PencilBox.generate(_size, seed: const Seed(4)).outline,
        on: 7,
        off: 6,
      ).dashes.length;

      var expected =
          paints..path(color: InkThemeData.dashedFill, style: PaintingStyle.fill);
      for (var i = 0; i < dashCount; i++) {
        expected = expected
          ..path(
            color: InkThemeData.dashColour,
            strokeWidth: _f32(InkThemeData.dashWidth),
          );
      }
      expected = expected
        ..path(color: Palette.ink, strokeWidth: _f32(InkThemeData.focusWidth));
      expect(find.byType(InkFrame), expected);
    });

    testWidgets('a new flash fades the thick frame out over its duration', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(_frame());
      await tester.pumpWidget(
        _frame(flash: const InkFlash(FlashKind.denied, serial: 1)),
      );

      // 06-ui/pause-menu/pause-menu.md §7: denied, 0.35 s; halfway through.
      await tester.pump(const Duration(milliseconds: 175));

      expect(
        find.byType(InkFrame),
        paints
          ..path(color: InkThemeData.paperFill, style: PaintingStyle.fill)
          ..path(
            color: InkThemeData.frameColour,
            strokeWidth: _f32(InkThemeData.frameWidth),
          )
          ..path(
            color: Palette.ink.withValues(alpha: 0.5),
            strokeWidth: _f32(InkThemeData.focusWidth),
          ),
      );

      await tester.pump(const Duration(milliseconds: 200));

      expect(
        find.byType(InkFrame),
        isNot(paints..path(strokeWidth: _f32(InkThemeData.focusWidth))),
      );
    });

    testWidgets('the same flash given again does not flash', (tester) async {
      await _setView(tester);
      const flash = InkFlash(FlashKind.denied, serial: 1);

      await tester.pumpWidget(_frame());
      await tester.pumpWidget(_frame(flash: flash));
      await tester.pump(const Duration(milliseconds: 400));

      await tester.pumpWidget(_frame(flash: flash));
      await tester.pump(const Duration(milliseconds: 16));

      expect(
        find.byType(InkFrame),
        isNot(paints..path(strokeWidth: _f32(InkThemeData.focusWidth))),
      );
    });

    testWidgets('a frame built with a flash does not flash', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _frame(flash: const InkFlash(FlashKind.done, serial: 1)),
      );
      await tester.pump(const Duration(milliseconds: 16));

      expect(
        find.byType(InkFrame),
        isNot(paints..path(strokeWidth: _f32(InkThemeData.focusWidth))),
      );
    });

    testWidgets('the child sits inside the frame', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(_frame(child: const Text('x')));

      expect(
        tester.getTopLeft(find.text('x')),
        tester.getTopLeft(find.byType(InkFrame)),
      );
    });
  });
}
