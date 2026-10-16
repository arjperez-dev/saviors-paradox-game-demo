import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/flash_kind.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_frame.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap_size.dart';

// A Paint's strokeWidth round-trips through a single-precision buffer; a
// double literal compared against one read back must go through the same
// rounding.
double _f32(double value) => Float32List.fromList([value]).first;

Future<void> _setView(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(1920, 1080);
  addTearDown(tester.view.reset);
}

Widget _keyCap({
  required String label,
  Seed seed = const Seed(1),
  KeyCapSize size = const KeyCapSize(),
  InkFlash? flash,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: InkTheme(
    child: Align(
      alignment: Alignment.topLeft,
      child: KeyCap(label: label, seed: seed, size: size, flash: flash),
    ),
  ),
);

void main() {
  group('KeyCap', () {
    testWidgets('a one-letter cap is 48 by 32', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(_keyCap(label: 'M'));

      // 06-ui/sandbox/sandbox.html keyCap: 48 wide, 32 tall.
      expect(tester.getSize(find.byType(KeyCap)), const Size(48, 32));
      expect(KeyCap.widthOf('M'), 48);
    });

    testWidgets('a longer name widens the cap by 14 on each side', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(_keyCap(label: 'Enter'));

      // 06-ui/sandbox/sandbox.html dlKey: the name + 28.
      final expectedWidth =
          InkThemeData.widthOf('Enter', InkLettering.keyCap) + 28;
      expect(tester.getSize(find.byType(KeyCap)).width, expectedWidth);
      expect(KeyCap.widthOf('Enter'), expectedWidth);
    });

    testWidgets("the dialogue's cap is 36 tall", (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _keyCap(label: 'Enter', size: const KeyCapSize(height: 36)),
      );

      // 06-ui/dialogue/dialogue.md §3: y 976-1012.
      expect(tester.getSize(find.byType(KeyCap)).height, 36);
    });

    testWidgets('the cap shows its name in the key cap lettering', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(_keyCap(label: 'Esc'));

      final text = tester.widget<Text>(find.text('Esc'));
      // keyCap: 20, ink.
      expect(text.style?.fontSize, 20);
      expect(text.style?.color, Palette.ink);
      expect(
        tester.getCenter(find.text('Esc')),
        tester.getCenter(find.byType(KeyCap)),
      );
    });

    testWidgets('the cap is opaque paper in a thin frame', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(_keyCap(label: 'Esc'));

      // 06-ui/sandbox/sandbox.html keyCap: fill '#efe6d6', a thin frame.
      expect(
        find.byType(KeyCap),
        paints
          ..path(color: Palette.paperLight, style: PaintingStyle.fill)
          ..path(
            color: InkThemeData.frameColour,
            strokeWidth: _f32(InkThemeData.frameWidth),
            style: PaintingStyle.stroke,
          ),
      );
    });

    testWidgets('the cap passes its flash to its frame', (tester) async {
      await _setView(tester);
      const flash = InkFlash(FlashKind.denied, serial: 2);
      await tester.pumpWidget(_keyCap(label: 'Enter', flash: flash));

      expect(tester.widget<InkFrame>(find.byType(InkFrame)).flash, flash);
    });
  });
}
