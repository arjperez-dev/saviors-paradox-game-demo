import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/input/application/input_context.dart';
import 'package:saviors_paradox/core/input/application/input_reading.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

/// What the keys and the pointer mean while Akeris plays
/// (00-game/controls.md §1–§4).
final class PlayingContext implements InputContext {
  const PlayingContext();

  @override
  void translate(RawInput input, InputReading reading, EventSink commands) {
    final command = switch (input) {
      KeyDown(:final key) => _pressed(key),
      KeyUp(:final key) => _released(key, reading),
      ButtonDown(:final button) => _buttonPressed(button, reading),
      ButtonUp(:final button) => _buttonReleased(button, reading),
      Scrolled(:final steps) => CycleWeapon(steps: steps),
      PointerMoved() => null,
    };
    if (command != null) {
      commands.publish(command);
    }
  }

  static PlayerCommand? _pressed(InputKey key) => switch (key) {
    InputKey.a => const StartMoving(direction: Facing.left),
    InputKey.d => const StartMoving(direction: Facing.right),
    InputKey.space => const StartJump(),
    InputKey.s => const Descend(),
    InputKey.shift => const Roll(),
    InputKey.controlLeft => const StartCrouch(),
    InputKey.q => const UseAbility(slotIndex: 0),
    InputKey.e => const UseAbility(slotIndex: 1),
    InputKey.r => const UseAbility(slotIndex: 2),
    InputKey.f => const StartDrinking(),
    InputKey.g => const Take(),
    InputKey.h => const Talk(),
    InputKey.m => const ToggleMap(),
    InputKey.escape => const PressEscape(),
    InputKey.digit1 => const PickWeapon(slotIndex: 0),
    InputKey.digit2 => const PickWeapon(slotIndex: 1),
    InputKey.digit3 => const PickWeapon(slotIndex: 2),
    InputKey.digit4 => const PickWeapon(slotIndex: 3),
    InputKey.digit5 => const PickWeapon(slotIndex: 4),
    InputKey.w ||
    InputKey.enter ||
    InputKey.arrowUp ||
    InputKey.arrowDown ||
    InputKey.arrowLeft ||
    InputKey.arrowRight => null,
  };

  // A/D: the key still held takes over when the other is released.
  static PlayerCommand? _released(InputKey key, InputReading reading) =>
      switch (key) {
        InputKey.a => _moveOrStop(reading, InputKey.d, Facing.right),
        InputKey.d => _moveOrStop(reading, InputKey.a, Facing.left),
        InputKey.space => const ReleaseJump(),
        InputKey.controlLeft => const StopCrouch(),
        InputKey.f => const StopDrinking(),
        InputKey.escape => const ReleaseEscape(),
        InputKey.w ||
        InputKey.s ||
        InputKey.shift ||
        InputKey.q ||
        InputKey.e ||
        InputKey.r ||
        InputKey.g ||
        InputKey.h ||
        InputKey.m ||
        InputKey.enter ||
        InputKey.digit1 ||
        InputKey.digit2 ||
        InputKey.digit3 ||
        InputKey.digit4 ||
        InputKey.digit5 ||
        InputKey.arrowUp ||
        InputKey.arrowDown ||
        InputKey.arrowLeft ||
        InputKey.arrowRight => null,
      };

  static PlayerCommand _moveOrStop(
    InputReading reading,
    InputKey other,
    Facing toward,
  ) => reading.isHeld(other)
      ? StartMoving(direction: toward)
      : const StopMoving();

  static PlayerCommand _buttonPressed(
    PointerButton button,
    InputReading reading,
  ) => switch (button) {
    PointerButton.primary => StartAttack(
      aim: reading.aim,
      pointerStillFor: reading.pointerStillFor,
      isUpHeld: reading.isHeld(InputKey.w),
      isDownHeld: reading.isHeld(InputKey.s),
    ),
    PointerButton.secondary => RaiseShield(
      aim: reading.aim,
      pointerStillFor: reading.pointerStillFor,
    ),
  };

  static PlayerCommand _buttonReleased(
    PointerButton button,
    InputReading reading,
  ) => switch (button) {
    PointerButton.primary => ReleaseAttack(
      aim: reading.aim,
      pointerStillFor: reading.pointerStillFor,
    ),
    PointerButton.secondary => const LowerShield(),
  };
}
