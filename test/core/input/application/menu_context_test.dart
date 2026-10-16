import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/input/application/menu_context.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

import '../mocks.dart';

void main() {
  group('MenuContext', () {
    setUpAll(() => registerFallbackValue(const PressEscape()));

    late MenuContext context;
    late MockInputReading reading;
    late MockEventSink commands;

    setUp(() {
      context = const MenuContext();
      reading = MockInputReading();
      commands = MockEventSink();
    });

    test('W and the up arrow move the focus up', () {
      context.translate(const KeyDown(InputKey.w), reading, commands);
      context.translate(const KeyDown(InputKey.arrowUp), reading, commands);

      verify(
        () => commands.publish(const MoveFocus(columns: 0, rows: -1)),
      ).called(2);
    });

    test('S and the down arrow move the focus down', () {
      context.translate(const KeyDown(InputKey.s), reading, commands);
      context.translate(const KeyDown(InputKey.arrowDown), reading, commands);

      verify(
        () => commands.publish(const MoveFocus(columns: 0, rows: 1)),
      ).called(2);
    });

    test('A and the left arrow move the focus left', () {
      context.translate(const KeyDown(InputKey.a), reading, commands);
      context.translate(const KeyDown(InputKey.arrowLeft), reading, commands);

      verify(
        () => commands.publish(const MoveFocus(columns: -1, rows: 0)),
      ).called(2);
    });

    test('D and the right arrow move the focus right', () {
      context.translate(const KeyDown(InputKey.d), reading, commands);
      context.translate(
        const KeyDown(InputKey.arrowRight),
        reading,
        commands,
      );

      verify(
        () => commands.publish(const MoveFocus(columns: 1, rows: 0)),
      ).called(2);
    });

    test('Enter is pressed then released as the confirm', () {
      context.translate(const KeyDown(InputKey.enter), reading, commands);
      verify(() => commands.publish(const PressConfirm())).called(1);

      context.translate(const KeyUp(InputKey.enter), reading, commands);
      verify(() => commands.publish(const ReleaseConfirm())).called(1);
    });

    test('Esc is pressed then released as a command', () {
      context.translate(const KeyDown(InputKey.escape), reading, commands);
      verify(() => commands.publish(const PressEscape())).called(1);

      context.translate(const KeyUp(InputKey.escape), reading, commands);
      verify(() => commands.publish(const ReleaseEscape())).called(1);
    });

    test('releasing a focus key publishes nothing', () {
      for (final key in [
        InputKey.w,
        InputKey.a,
        InputKey.s,
        InputKey.d,
        InputKey.arrowUp,
        InputKey.arrowDown,
        InputKey.arrowLeft,
        InputKey.arrowRight,
      ]) {
        context.translate(KeyUp(key), reading, commands);
      }

      verifyNever(() => commands.publish(any()));
    });

    test('the pointer, its buttons and the wheel publish nothing', () {
      context.translate(
        const ButtonDown(PointerButton.primary),
        reading,
        commands,
      );
      context.translate(
        const ButtonDown(PointerButton.secondary),
        reading,
        commands,
      );
      context.translate(
        const ButtonUp(PointerButton.primary),
        reading,
        commands,
      );
      context.translate(
        const ButtonUp(PointerButton.secondary),
        reading,
        commands,
      );
      context.translate(
        const PointerMoved(
          position: ScreenVec2.zero,
          delta: ScreenVec2.zero,
        ),
        reading,
        commands,
      );
      context.translate(const Scrolled(steps: 1), reading, commands);

      verifyNever(() => commands.publish(any()));
    });

    test('every other key publishes nothing', () {
      for (final key in [
        InputKey.m,
        InputKey.g,
        InputKey.h,
        InputKey.space,
        InputKey.shift,
        InputKey.q,
        InputKey.digit1,
      ]) {
        context.translate(KeyDown(key), reading, commands);
      }

      verifyNever(() => commands.publish(any()));
    });
  });
}
