import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/hint_footer.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';

void main() {
  group('HintFooter', () {
    const hint = 'W A S D or arrows · Enter choose · Esc back';
    const button0Key = Key('button0');
    const button1Key = Key('button1');

    Future<void> pumpFooter(WidgetTester tester, {required double width}) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1920, 1080);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InkTheme(
            child: Align(
              alignment: Alignment.topLeft,
              child: HintFooter(
                width: width,
                hint: hint,
                buttons: const [
                  SizedBox(key: button0Key, width: 120, height: 56),
                  SizedBox(key: button1Key, width: 120, height: 56),
                ],
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('the footer is its width by 56', (tester) async {
      await pumpFooter(tester, width: 1580);

      // 06-ui/pause-menu/pause-menu.md §3: buttons 56 tall.
      expect(tester.getSize(find.byType(HintFooter)), const Size(1580, 56));
    });

    testWidgets('the buttons sit from the left 22 apart', (tester) async {
      await pumpFooter(tester, width: 1580);

      final footerLeft = tester.getTopLeft(find.byType(HintFooter)).dx;
      final button0 = tester.getTopLeft(find.byKey(button0Key));
      final button1 = tester.getTopLeft(find.byKey(button1Key));

      expect(button0.dx, footerLeft);
      // 06-ui/sandbox/sandbox.html `pmFooter`: x += w + 22.
      expect(button1.dx, button0.dx + 120 + 22);
    });

    testWidgets("the hint ends on the footer's right edge", (tester) async {
      await pumpFooter(tester, width: 1580);

      final footerLeft = tester.getTopLeft(find.byType(HintFooter)).dx;
      final hintRight = tester.getTopRight(find.text(hint)).dx;

      // 06-ui/pause-menu/pause-menu.md §3: right-aligned.
      expect(hintRight, footerLeft + 1580);
    });

    testWidgets('the hint is lettered 24 in ink at .7', (tester) async {
      await pumpFooter(tester, width: 1580);

      final style = tester.widget<Text>(find.text(hint)).style;

      // 06-ui/pause-menu/pause-menu.md §3: 24 px;
      // 06-ui/sandbox/sandbox.html `pmFooter`.
      expect(style?.fontSize, 24);
      expect(style?.color, const Color.fromRGBO(26, 23, 21, 0.7));
    });

    testWidgets("the hint sits on the buttons' line", (tester) async {
      await pumpFooter(tester, width: 1580);

      final footerTop = tester.getTopLeft(find.byType(HintFooter)).dy;
      final hintCentre = tester.getRect(find.text(hint)).center.dy;

      expect(hintCentre, footerTop + 28);
    });
  });
}
