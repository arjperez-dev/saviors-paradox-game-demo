import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';
import 'package:saviors_paradox/core/input/presentation/input_listener.dart';

Future<void> _pump(WidgetTester tester, List<RawInput> received) async {
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: InputListener(
        onInput: received.add,
        child: const SizedBox(
          width: 400,
          height: 300,
          child: ColoredBox(color: Color(0x00000000)),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('InputListener', () {
    testWidgets('a key press then release reach the input', (tester) async {
      final received = <RawInput>[];
      await _pump(tester, received);

      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyA);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyA);

      expect(received, [const KeyDown(InputKey.a), const KeyUp(InputKey.a)]);
    });

    testWidgets('both shift keys reach the input as Shift', (tester) async {
      final received = <RawInput>[];
      await _pump(tester, received);

      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftRight);

      expect(received, [
        const KeyDown(InputKey.shift),
        const KeyDown(InputKey.shift),
      ]);
    });

    testWidgets('a key the game does not read is left to others', (
      tester,
    ) async {
      final received = <RawInput>[];
      await _pump(tester, received);

      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyZ);

      expect(received, isEmpty);
    });

    testWidgets("a held key's repeats are not sent", (tester) async {
      final received = <RawInput>[];
      await _pump(tester, received);

      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyD);
      await tester.sendKeyRepeatEvent(LogicalKeyboardKey.keyD);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyD);

      expect(received, [const KeyDown(InputKey.d), const KeyUp(InputKey.d)]);
    });

    testWidgets('mouse buttons reach the input as they change', (
      tester,
    ) async {
      final received = <RawInput>[];
      await _pump(tester, received);

      await tester.sendEventToBinding(
        const PointerDownEvent(pointer: 1, buttons: kPrimaryButton),
      );
      await tester.sendEventToBinding(const PointerUpEvent(pointer: 1));
      await tester.sendEventToBinding(
        const PointerDownEvent(pointer: 2, buttons: kSecondaryButton),
      );
      await tester.sendEventToBinding(const PointerUpEvent(pointer: 2));

      expect(received, [
        const ButtonDown(PointerButton.primary),
        const ButtonUp(PointerButton.primary),
        const ButtonDown(PointerButton.secondary),
        const ButtonUp(PointerButton.secondary),
      ]);
    });

    testWidgets(
      'a second button pressed while one is held reaches the input',
      (tester) async {
        final received = <RawInput>[];
        await _pump(tester, received);
        await tester.sendEventToBinding(
          const PointerDownEvent(pointer: 1, buttons: kPrimaryButton),
        );
        received.clear();

        await tester.sendEventToBinding(
          const PointerMoveEvent(
            pointer: 1,
            buttons: kPrimaryButton | kSecondaryButton,
          ),
        );

        expect(received, [const ButtonDown(PointerButton.secondary)]);
        await tester.sendEventToBinding(const PointerUpEvent(pointer: 1));
      },
    );

    testWidgets('moving the pointer sends its position and movement', (
      tester,
    ) async {
      final received = <RawInput>[];
      await _pump(tester, received);
      await tester.sendEventToBinding(
        const PointerHoverEvent(position: Offset(100, 100)),
      );
      received.clear();

      await tester.sendEventToBinding(
        const PointerHoverEvent(position: Offset(130, 80)),
      );

      expect(received, [
        const PointerMoved(
          position: ScreenVec2(Vec2(130, 80)),
          delta: ScreenVec2(Vec2(30, -20)),
        ),
      ]);
    });

    testWidgets('the wheel sends one step per event, down positive', (
      tester,
    ) async {
      final received = <RawInput>[];
      await _pump(tester, received);

      await tester.sendEventToBinding(
        const PointerScrollEvent(
          position: Offset(10, 10),
          scrollDelta: Offset(0, 120),
        ),
      );
      await tester.sendEventToBinding(
        const PointerScrollEvent(
          position: Offset(10, 10),
          scrollDelta: Offset(0, -40),
        ),
      );

      expect(received, [const Scrolled(steps: 1), const Scrolled(steps: -1)]);
    });
  });
}
