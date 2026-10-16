import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_answer.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_question.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_texts.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_frame.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/menu_button.dart';

void main() {
  group('ConfirmQuestion', () {
    const texts = ConfirmTexts(
      ask: 'Quit?',
      note: 'Saved.',
      yes: 'Quit',
      no: 'Stay',
    );

    Future<List<ConfirmAnswer>> pumpQuestion(
      WidgetTester tester, {
      ConfirmAnswer focused = ConfirmAnswer.no,
    }) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1920, 1080);
      addTearDown(tester.view.reset);
      final answers = <ConfirmAnswer>[];
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InkTheme(
            child: Align(
              alignment: Alignment.topLeft,
              child: ConfirmQuestion(
                texts: texts,
                focused: focused,
                onAnswer: answers.add,
                seed: const Seed(31400),
              ),
            ),
          ),
        ),
      );
      return answers;
    }

    testWidgets('the question box is 800 by 290', (tester) async {
      await pumpQuestion(tester);

      // 06-ui/pause-menu/pause-menu.md §3.
      expect(
        tester.getSize(find.byType(ConfirmQuestion)),
        const Size(800, 290),
      );
    });

    testWidgets('the answers sit at their places in the box', (
      tester,
    ) async {
      await pumpQuestion(tester);

      final origin = tester.getTopLeft(find.byType(ConfirmQuestion));
      final yes = tester.getRect(find.widgetWithText(MenuButton, 'Quit'));
      final no = tester.getRect(find.widgetWithText(MenuButton, 'Stay'));

      // 06-ui/pause-menu/pause-menu.md §3: (640, 572) and (980, 572) from
      // (560, 380).
      expect(yes.topLeft - origin, const Offset(80, 192));
      expect(yes.size, const Size(300, 64));
      expect(no.topLeft - origin, const Offset(420, 192));
      expect(no.size, const Size(300, 64));
    });

    testWidgets('the box takes the thick frame on bright paper', (
      tester,
    ) async {
      await pumpQuestion(tester);

      final box = tester.widgetList<InkFrame>(find.byType(InkFrame)).first;

      // 06-ui/sandbox/sandbox.html ttConfirm: on: true, .97.
      expect(box.style.look, FrameLook.question);
      expect(box.style.focused, isTrue);
    });

    testWidgets('the question and its note are centred on their lines', (
      tester,
    ) async {
      await pumpQuestion(tester);

      final origin = tester.getTopLeft(find.byType(ConfirmQuestion));
      final ask = tester.getCenter(find.text('Quit?'));
      final note = tester.getCenter(find.text('Saved.'));

      // 06-ui/sandbox/sandbox.html ttConfirm: y 452 and 506, from (560, 380).
      expect(ask - origin, const Offset(400, 72));
      expect(note - origin, const Offset(400, 126));
    });

    testWidgets('the question and its note are lettered 42 and 28', (
      tester,
    ) async {
      await pumpQuestion(tester);

      final askStyle = tester.widget<Text>(find.text('Quit?')).style;
      final noteStyle = tester.widget<Text>(find.text('Saved.')).style;

      // 06-ui/sandbox/sandbox.html ttConfirm.
      expect(askStyle?.fontSize, 42);
      expect(askStyle?.color, Palette.ink);
      expect(noteStyle?.fontSize, 28);
      expect(noteStyle?.color, const Color.fromRGBO(26, 23, 21, 0.8));
    });

    testWidgets('the focus is on the answer the screen gives', (
      tester,
    ) async {
      await pumpQuestion(tester, focused: ConfirmAnswer.no);

      final yes = tester.widget<MenuButton>(
        find.widgetWithText(MenuButton, 'Quit'),
      );
      final no = tester.widget<MenuButton>(
        find.widgetWithText(MenuButton, 'Stay'),
      );

      // 06-ui/title/title.md U39: focus on Stay.
      expect(no.state.focused, isTrue);
      expect(yes.state.focused, isFalse);
    });

    testWidgets('clicking an answer gives it', (tester) async {
      final answers = await pumpQuestion(tester);

      await tester.tap(find.widgetWithText(MenuButton, 'Stay'));
      await tester.tap(find.widgetWithText(MenuButton, 'Quit'));

      expect(answers, [ConfirmAnswer.no, ConfirmAnswer.yes]);
    });

    testWidgets("the answers' seeds follow the box's", (tester) async {
      await pumpQuestion(tester);

      final yes = tester.widget<MenuButton>(
        find.widgetWithText(MenuButton, 'Quit'),
      );
      final no = tester.widget<MenuButton>(
        find.widgetWithText(MenuButton, 'Stay'),
      );

      // 06-ui/sandbox/sandbox.html ttConfirm: sid + 10, sid + 20.
      expect(yes.state.seed, const Seed(31410));
      expect(no.state.seed, const Seed(31420));
    });
  });
}
