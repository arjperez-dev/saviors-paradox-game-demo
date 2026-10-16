import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/ui/presentation/button_content.dart';
import 'package:saviors_paradox/core/ui/presentation/button_look.dart';
import 'package:saviors_paradox/core/ui/presentation/button_shape.dart';
import 'package:saviors_paradox/core/ui/presentation/button_state.dart';
import 'package:saviors_paradox/core/ui/presentation/flash_kind.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_frame.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap.dart';
import 'package:saviors_paradox/core/ui/presentation/label_placement.dart';
import 'package:saviors_paradox/core/ui/presentation/menu_button.dart';

Future<void> _setView(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(1920, 1080);
  addTearDown(tester.view.reset);
}

Widget _button({
  required ButtonContent content,
  required ButtonShape shape,
  ButtonState state = const ButtonState(seed: Seed(5)),
  VoidCallback? onPressed,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: InkTheme(
    child: Align(
      alignment: Alignment.topLeft,
      child: MenuButton(
        content: content,
        shape: shape,
        state: state,
        onPressed: onPressed,
      ),
    ),
  ),
);

void main() {
  group('MenuButton', () {
    testWidgets('a button with no width is its label plus 56', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
        ),
      );

      // 06-ui/sandbox/sandbox.html pmFooter.
      final expectedWidth =
          InkThemeData.widthOf('Save', InkLettering.button) + 56;
      expect(
        tester.getSize(find.byType(MenuButton)),
        Size(expectedWidth, 56),
      );
    });

    testWidgets(
      'a button with a key cap is its label plus the cap plus 56',
      (tester) async {
        await _setView(tester);
        await tester.pumpWidget(
          _button(
            content: const ButtonContent(label: 'Resume', keyLabel: 'Esc'),
            shape: const ButtonShape(height: 56),
          ),
        );

        // 06-ui/sandbox/sandbox.html pmFooter: the label + 104 with a
        // 48-wide cap.
        final expectedWidth =
            InkThemeData.widthOf('Resume', InkLettering.button) +
            28 +
            6 +
            KeyCap.widthOf('Esc') +
            22;
        expect(
          tester.getSize(find.byType(MenuButton)),
          Size(expectedWidth, 56),
        );
      },
    );

    testWidgets('the label sits 28 in from the left', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
        ),
      );

      final buttonLeft = tester.getTopLeft(find.byType(MenuButton)).dx;
      final labelLeft = tester.getTopLeft(find.text('Save')).dx;

      // 06-ui/sandbox/sandbox.html pmFooter, ttMain.
      expect(labelLeft, buttonLeft + 28);
    });

    testWidgets('the key cap sits 22 in from the right in the middle', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Resume', keyLabel: 'Esc'),
          shape: const ButtonShape(height: 56),
        ),
      );

      final button = tester.getRect(find.byType(MenuButton));
      final cap = tester.getRect(find.byType(KeyCap));

      // 06-ui/sandbox/sandbox.html pmFooter: the cap at x + w - 70, y + 12.
      expect(cap.right, button.right - 22);
      expect(cap.top, button.top + 12);
    });

    testWidgets('a button given a width takes it', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Resume'),
          shape: const ButtonShape(height: 64, width: 470),
        ),
      );

      // 06-ui/sandbox/sandbox.html ttMain: 470 x 64.
      expect(tester.getSize(find.byType(MenuButton)), const Size(470, 64));
    });

    testWidgets('a centred label sits in the middle', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Confirm'),
          shape: const ButtonShape(
            height: 64,
            width: 300,
            placement: LabelPlacement.centre,
          ),
        ),
      );

      final buttonLeft = tester.getTopLeft(find.byType(MenuButton)).dx;
      final labelCentre = tester.getCenter(find.text('Confirm')).dx;

      // 06-ui/sandbox/sandbox.html ttConfirm.
      expect(labelCentre, buttonLeft + 150);
    });

    testWidgets('a click calls the button', (tester) async {
      await _setView(tester);
      var calls = 0;
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
          onPressed: () => calls++,
        ),
      );

      await tester.tap(find.byType(MenuButton));

      expect(calls, 1);
    });

    testWidgets('the mouse over a button shows the hand', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
        ),
      );
      final gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
        pointer: 1,
      );
      addTearDown(gesture.removePointer);
      await gesture.addPointer(location: Offset.zero);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(MenuButton)));
      await tester.pump();

      // 06-ui/ui.md §3.
      expect(
        RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
        SystemMouseCursors.click,
      );
    });

    testWidgets('the mouse over a button brightens its paper', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
        ),
      );
      final gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
        pointer: 1,
      );
      addTearDown(gesture.removePointer);
      await gesture.addPointer(location: Offset.zero);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(MenuButton)));
      await tester.pump();
      // 06-ui/ui.md §3; 06-ui/sandbox/sandbox.html ttBox.
      expect(
        find.byType(MenuButton),
        paints..path(
          color: InkThemeData.paperFillHovered,
          style: PaintingStyle.fill,
        ),
      );

      await gesture.moveTo(const Offset(1900, 1060));
      await tester.pump();
      expect(
        find.byType(MenuButton),
        paints..path(color: InkThemeData.paperFill, style: PaintingStyle.fill),
      );
    });

    testWidgets('a faint button letters its label faint', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Shop'),
          shape: const ButtonShape(height: 56),
          state: const ButtonState(seed: Seed(5), look: ButtonLook.faint),
        ),
      );

      final text = tester.widget<Text>(find.text('Shop'));
      // 06-ui/title/title.md §4; 06-ui/sandbox/sandbox.html ttMain.
      expect(text.style?.color, const Color.fromRGBO(26, 23, 21, 0.45));
      expect(
        tester.widget<InkFrame>(find.byType(InkFrame)).style.look,
        FrameLook.faint,
      );
    });

    testWidgets("the screen's focus thickens the frame", (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
          state: const ButtonState(seed: Seed(5), focused: true),
        ),
      );

      // 06-ui/ui.md §3.
      expect(
        tester.widget<InkFrame>(find.byType(InkFrame)).style.focused,
        isTrue,
      );

      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
          state: const ButtonState(seed: Seed(5)),
        ),
      );

      expect(
        tester.widget<InkFrame>(find.byType(InkFrame)).style.focused,
        isFalse,
      );
    });

    testWidgets("the cap's seed is the button's plus 10", (tester) async {
      await _setView(tester);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Resume', keyLabel: 'Esc'),
          shape: const ButtonShape(height: 56),
          state: const ButtonState(seed: Seed(42420)),
        ),
      );

      // 06-ui/sandbox/sandbox.html ttSlots.
      expect(
        tester.widget<KeyCap>(find.byType(KeyCap)).seed,
        const Seed(42430),
      );
    });

    testWidgets('a button passes its flash to its frame', (tester) async {
      await _setView(tester);
      const flash = InkFlash(FlashKind.denied, serial: 3);
      await tester.pumpWidget(
        _button(
          content: const ButtonContent(label: 'Save'),
          shape: const ButtonShape(height: 56),
          state: const ButtonState(seed: Seed(5), flash: flash),
        ),
      );

      expect(tester.widget<InkFrame>(find.byType(InkFrame)).flash, flash);
    });
  });
}
