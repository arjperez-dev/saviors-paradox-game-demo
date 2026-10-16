import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/paper_sheet.dart';

void main() {
  group('PaperSheet', () {
    Future<void> pumpSheet(
      WidgetTester tester, {
      required Size viewSize,
      required UiVec2 size,
      required Seed seed,
      Widget? child,
    }) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = viewSize;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InkTheme(
            child: Align(
              alignment: Alignment.topLeft,
              child: PaperSheet(size: size, seed: seed, child: child),
            ),
          ),
        ),
      );
    }

    testWidgets('the sheet takes its size in hu', (tester) async {
      await pumpSheet(
        tester,
        viewSize: const Size(960, 540),
        size: const UiVec2(Vec2(800, 400)),
        seed: const Seed(9),
      );

      // 06-ui/ui.md §3: 540 ÷ 1080 of 800 × 400 hu.
      expect(tester.getSize(find.byType(PaperSheet)), const Size(400, 200));
    });

    testWidgets(
      'the sheet paints its shadow, paper, light, border and inner line in order',
      (tester) async {
        await pumpSheet(
          tester,
          viewSize: const Size(1920, 1080),
          size: const UiVec2(Vec2(400, 200)),
          seed: const Seed(9),
        );

        expect(
          find.byType(PaperSheet),
          paints
            ..path(color: InkThemeData.sheetShadowColour)
            ..path(color: Palette.paper)
            ..save()
            ..rect()
            ..restore()
            ..path(
              color: Palette.ink,
              strokeWidth: Float32List.fromList([
                InkThemeData.sheetBorderWidth,
              ]).first,
            )
            ..path(
              color: InkThemeData.sheetInnerColour,
              strokeWidth: Float32List.fromList([
                InkThemeData.sheetInnerWidth,
              ]).first,
            ),
        );
      },
    );

    testWidgets('the shadow is blurred 17 hu', (tester) async {
      await pumpSheet(
        tester,
        viewSize: const Size(1920, 1080),
        size: const UiVec2(Vec2(400, 200)),
        seed: const Seed(9),
      );

      // 06-ui/sandbox/sandbox.html `sheetAt`: shadowBlur 34 is a Gaussian of
      // sigma 17.
      expect(
        find.byType(PaperSheet),
        paints..something((methodName, arguments) {
          if (methodName != #drawPath) {
            return false;
          }
          final paint = arguments[1] as Paint;
          return paint.maskFilter ==
              const MaskFilter.blur(
                BlurStyle.normal,
                17,
              );
        }),
      );
    });

    testWidgets("the screen's child sits on the sheet", (tester) async {
      await pumpSheet(
        tester,
        viewSize: const Size(1920, 1080),
        size: const UiVec2(Vec2(400, 200)),
        seed: const Seed(9),
        child: const Text('x'),
      );

      expect(
        tester.getTopLeft(find.text('x')),
        tester.getTopLeft(find.byType(PaperSheet)),
      );
    });
  });
}
