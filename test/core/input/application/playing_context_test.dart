import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/input/application/playing_context.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

import '../mocks.dart';

void main() {
  setUpAll(() => registerFallbackValue(const StopMoving()));

  group('PlayingContext', () {
    const context = PlayingContext();
    late MockInputReading reading;
    late MockEventSink commands;

    setUp(() {
      reading = MockInputReading();
      commands = MockEventSink();
    });

    test('pressing A starts moving left', () {
      context.translate(const KeyDown(InputKey.a), reading, commands);

      verify(
        () => commands.publish(const StartMoving(direction: Facing.left)),
      ).called(1);
    });

    test('pressing D starts moving right', () {
      context.translate(const KeyDown(InputKey.d), reading, commands);

      verify(
        () => commands.publish(const StartMoving(direction: Facing.right)),
      ).called(1);
    });

    test('releasing A while D is held moves right', () {
      when(() => reading.isHeld(InputKey.d)).thenReturn(true);
      when(() => reading.isHeld(InputKey.a)).thenReturn(true);

      context.translate(const KeyUp(InputKey.a), reading, commands);
      context.translate(const KeyUp(InputKey.d), reading, commands);

      final captured = verify(
        () => commands.publish(captureAny()),
      ).captured;
      expect(captured, [
        isA<StartMoving>().having(
          (c) => c.direction,
          'direction',
          Facing.right,
        ),
        isA<StartMoving>().having(
          (c) => c.direction,
          'direction',
          Facing.left,
        ),
      ]);
    });

    test('releasing the last movement key stops moving', () {
      when(() => reading.isHeld(InputKey.d)).thenReturn(false);

      context.translate(const KeyUp(InputKey.a), reading, commands);

      verify(() => commands.publish(const StopMoving())).called(1);
    });

    test('Space starts the jump until released', () {
      context.translate(const KeyDown(InputKey.space), reading, commands);
      context.translate(const KeyUp(InputKey.space), reading, commands);

      verify(() => commands.publish(const StartJump())).called(1);
      verify(() => commands.publish(const ReleaseJump())).called(1);
    });

    test('S publishes the fast descent', () {
      context.translate(const KeyDown(InputKey.s), reading, commands);

      verify(() => commands.publish(const Descend())).called(1);
    });

    test('Shift publishes a roll', () {
      context.translate(const KeyDown(InputKey.shift), reading, commands);
      context.translate(const KeyUp(InputKey.shift), reading, commands);

      final captured = verify(
        () => commands.publish(captureAny()),
      ).captured;
      expect(captured, [const Roll()]);
    });

    test('Left Ctrl crouches until released', () {
      context.translate(
        const KeyDown(InputKey.controlLeft),
        reading,
        commands,
      );
      context.translate(
        const KeyUp(InputKey.controlLeft),
        reading,
        commands,
      );

      verify(() => commands.publish(const StartCrouch())).called(1);
      verify(() => commands.publish(const StopCrouch())).called(1);
    });

    test('a left click attacks at the world point under the pointer', () {
      when(() => reading.aim).thenReturn(const Vec2(420, 310));
      when(() => reading.pointerStillFor).thenReturn(const Seconds(2));
      when(() => reading.isHeld(InputKey.w)).thenReturn(false);
      when(() => reading.isHeld(InputKey.s)).thenReturn(false);

      context.translate(
        const ButtonDown(PointerButton.primary),
        reading,
        commands,
      );

      final captured = verify(
        () => commands.publish(captureAny()),
      ).captured.single;
      expect(
        captured,
        isA<StartAttack>()
            .having((c) => c.aim, 'aim', const Vec2(420, 310))
            .having(
              (c) => c.pointerStillFor,
              'pointerStillFor',
              const Seconds(2),
            ),
      );
    });

    test('W or S held with the click marks the attack', () {
      when(() => reading.aim).thenReturn(Vec2.zero);
      when(() => reading.pointerStillFor).thenReturn(Seconds.zero);

      when(() => reading.isHeld(InputKey.w)).thenReturn(true);
      when(() => reading.isHeld(InputKey.s)).thenReturn(false);
      context.translate(
        const ButtonDown(PointerButton.primary),
        reading,
        commands,
      );

      when(() => reading.isHeld(InputKey.w)).thenReturn(false);
      when(() => reading.isHeld(InputKey.s)).thenReturn(true);
      context.translate(
        const ButtonDown(PointerButton.primary),
        reading,
        commands,
      );

      when(() => reading.isHeld(InputKey.w)).thenReturn(false);
      when(() => reading.isHeld(InputKey.s)).thenReturn(false);
      context.translate(
        const ButtonDown(PointerButton.primary),
        reading,
        commands,
      );

      final captured = verify(
        () => commands.publish(captureAny()),
      ).captured;
      expect(captured, [
        isA<StartAttack>()
            .having((c) => c.isUpHeld, 'isUpHeld', true)
            .having((c) => c.isDownHeld, 'isDownHeld', false),
        isA<StartAttack>()
            .having((c) => c.isUpHeld, 'isUpHeld', false)
            .having((c) => c.isDownHeld, 'isDownHeld', true),
        isA<StartAttack>()
            .having((c) => c.isUpHeld, 'isUpHeld', false)
            .having((c) => c.isDownHeld, 'isDownHeld', false),
      ]);
    });

    test('releasing the left click releases the attack at the pointer', () {
      when(() => reading.aim).thenReturn(const Vec2(100, 50));
      when(() => reading.pointerStillFor).thenReturn(const Seconds(0.5));

      context.translate(
        const ButtonUp(PointerButton.primary),
        reading,
        commands,
      );

      final captured = verify(
        () => commands.publish(captureAny()),
      ).captured.single;
      expect(
        captured,
        isA<ReleaseAttack>()
            .having((c) => c.aim, 'aim', const Vec2(100, 50))
            .having(
              (c) => c.pointerStillFor,
              'pointerStillFor',
              const Seconds(0.5),
            ),
      );
    });

    test('a right click raises the shield until released', () {
      when(() => reading.aim).thenReturn(const Vec2(10, 20));
      when(() => reading.pointerStillFor).thenReturn(const Seconds(1));

      context.translate(
        const ButtonDown(PointerButton.secondary),
        reading,
        commands,
      );
      context.translate(
        const ButtonUp(PointerButton.secondary),
        reading,
        commands,
      );

      final captured = verify(
        () => commands.publish(captureAny()),
      ).captured;
      expect(
        captured[0],
        isA<RaiseShield>()
            .having((c) => c.aim, 'aim', const Vec2(10, 20))
            .having(
              (c) => c.pointerStillFor,
              'pointerStillFor',
              const Seconds(1),
            ),
      );
      expect(captured[1], const LowerShield());
    });

    test('Q, E and R use the abilities in slots 0, 1 and 2', () {
      context.translate(const KeyDown(InputKey.q), reading, commands);
      context.translate(const KeyDown(InputKey.e), reading, commands);
      context.translate(const KeyDown(InputKey.r), reading, commands);

      verify(
        () => commands.publish(const UseAbility(slotIndex: 0)),
      ).called(1);
      verify(
        () => commands.publish(const UseAbility(slotIndex: 1)),
      ).called(1);
      verify(
        () => commands.publish(const UseAbility(slotIndex: 2)),
      ).called(1);
    });

    test('F drinks until released', () {
      context.translate(const KeyDown(InputKey.f), reading, commands);
      context.translate(const KeyUp(InputKey.f), reading, commands);

      verify(() => commands.publish(const StartDrinking())).called(1);
      verify(() => commands.publish(const StopDrinking())).called(1);
    });

    test('the wheel cycles the weapons by its steps', () {
      context.translate(const Scrolled(steps: 1), reading, commands);
      context.translate(const Scrolled(steps: -1), reading, commands);

      final captured = verify(
        () => commands.publish(captureAny()),
      ).captured;
      expect(captured, [
        isA<CycleWeapon>().having((c) => c.steps, 'steps', 1),
        isA<CycleWeapon>().having((c) => c.steps, 'steps', -1),
      ]);
    });

    test('1 to 5 pick the weapon slots 0 to 4', () {
      context.translate(const KeyDown(InputKey.digit1), reading, commands);
      context.translate(const KeyDown(InputKey.digit2), reading, commands);
      context.translate(const KeyDown(InputKey.digit3), reading, commands);
      context.translate(const KeyDown(InputKey.digit4), reading, commands);
      context.translate(const KeyDown(InputKey.digit5), reading, commands);

      verify(
        () => commands.publish(const PickWeapon(slotIndex: 0)),
      ).called(1);
      verify(
        () => commands.publish(const PickWeapon(slotIndex: 1)),
      ).called(1);
      verify(
        () => commands.publish(const PickWeapon(slotIndex: 2)),
      ).called(1);
      verify(
        () => commands.publish(const PickWeapon(slotIndex: 3)),
      ).called(1);
      verify(
        () => commands.publish(const PickWeapon(slotIndex: 4)),
      ).called(1);
    });

    test('G takes, H talks, M toggles the map', () {
      context.translate(const KeyDown(InputKey.g), reading, commands);
      context.translate(const KeyDown(InputKey.h), reading, commands);
      context.translate(const KeyDown(InputKey.m), reading, commands);

      verify(() => commands.publish(const Take())).called(1);
      verify(() => commands.publish(const Talk())).called(1);
      verify(() => commands.publish(const ToggleMap())).called(1);
    });

    test('Esc is pressed then released as a command', () {
      context.translate(const KeyDown(InputKey.escape), reading, commands);
      context.translate(const KeyUp(InputKey.escape), reading, commands);

      verify(() => commands.publish(const PressEscape())).called(1);
      verify(() => commands.publish(const ReleaseEscape())).called(1);
    });

    test('W, Enter, the arrows and pointer moves publish nothing', () {
      context.translate(const KeyDown(InputKey.w), reading, commands);
      context.translate(const KeyDown(InputKey.enter), reading, commands);
      context.translate(const KeyDown(InputKey.arrowUp), reading, commands);
      context.translate(const KeyDown(InputKey.arrowDown), reading, commands);
      context.translate(const KeyDown(InputKey.arrowLeft), reading, commands);
      context.translate(
        const KeyDown(InputKey.arrowRight),
        reading,
        commands,
      );
      context.translate(
        const PointerMoved(position: ScreenVec2.zero, delta: ScreenVec2.zero),
        reading,
        commands,
      );

      verifyNever(() => commands.publish(any()));
    });
  });
}
