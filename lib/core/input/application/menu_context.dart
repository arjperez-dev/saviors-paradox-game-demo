import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/input/application/input_context.dart';
import 'package:saviors_paradox/core/input/application/input_reading.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

/// What the keys mean in any menu (00-game/controls.md §4, G10): the focus
/// moves, Enter chooses, Esc goes back. The pointer is core/ui's widgets'.
final class MenuContext implements InputContext {
  const MenuContext();

  @override
  void translate(RawInput input, InputReading reading, EventSink commands) {
    final command = switch (input) {
      KeyDown(:final key) => _pressed(key),
      KeyUp(:final key) => _released(key),
      ButtonDown() || ButtonUp() || PointerMoved() || Scrolled() => null,
    };
    if (command != null) {
      commands.publish(command);
    }
  }

  static PlayerCommand? _pressed(InputKey key) => switch (key) {
    InputKey.w || InputKey.arrowUp => const MoveFocus(columns: 0, rows: -1),
    InputKey.s || InputKey.arrowDown => const MoveFocus(columns: 0, rows: 1),
    InputKey.a || InputKey.arrowLeft => const MoveFocus(columns: -1, rows: 0),
    InputKey.d || InputKey.arrowRight => const MoveFocus(columns: 1, rows: 0),
    InputKey.enter => const PressConfirm(),
    InputKey.escape => const PressEscape(),
    InputKey.space ||
    InputKey.shift ||
    InputKey.controlLeft ||
    InputKey.q ||
    InputKey.e ||
    InputKey.r ||
    InputKey.f ||
    InputKey.g ||
    InputKey.h ||
    InputKey.m ||
    InputKey.digit1 ||
    InputKey.digit2 ||
    InputKey.digit3 ||
    InputKey.digit4 ||
    InputKey.digit5 => null,
  };

  static PlayerCommand? _released(InputKey key) => switch (key) {
    InputKey.enter => const ReleaseConfirm(),
    InputKey.escape => const ReleaseEscape(),
    InputKey.a ||
    InputKey.d ||
    InputKey.w ||
    InputKey.s ||
    InputKey.space ||
    InputKey.shift ||
    InputKey.controlLeft ||
    InputKey.q ||
    InputKey.e ||
    InputKey.r ||
    InputKey.f ||
    InputKey.g ||
    InputKey.h ||
    InputKey.m ||
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
}
