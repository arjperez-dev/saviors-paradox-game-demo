import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';

/// One thing the keyboard or the mouse did, before any context gives it a
/// meaning.
sealed class RawInput {
  const RawInput();
}

final class KeyDown extends RawInput {
  const KeyDown(this.key);

  final InputKey key;

  @override
  bool operator ==(Object other) => other is KeyDown && other.key == key;

  @override
  int get hashCode => Object.hash(KeyDown, key);
}

final class KeyUp extends RawInput {
  const KeyUp(this.key);

  final InputKey key;

  @override
  bool operator ==(Object other) => other is KeyUp && other.key == key;

  @override
  int get hashCode => Object.hash(KeyUp, key);
}

final class ButtonDown extends RawInput {
  const ButtonDown(this.button);

  final PointerButton button;

  @override
  bool operator ==(Object other) =>
      other is ButtonDown && other.button == button;

  @override
  int get hashCode => Object.hash(ButtonDown, button);
}

final class ButtonUp extends RawInput {
  const ButtonUp(this.button);

  final PointerButton button;

  @override
  bool operator ==(Object other) => other is ButtonUp && other.button == button;

  @override
  int get hashCode => Object.hash(ButtonUp, button);
}

/// The pointer now at [position], moved by [delta], in logical pixels.
final class PointerMoved extends RawInput {
  const PointerMoved({required this.position, required this.delta});

  final ScreenVec2 position;
  final ScreenVec2 delta;

  @override
  bool operator ==(Object other) =>
      other is PointerMoved &&
      other.position == position &&
      other.delta == delta;

  @override
  int get hashCode => Object.hash(PointerMoved, position, delta);
}

/// The wheel turned [steps] notches; down is positive.
final class Scrolled extends RawInput {
  const Scrolled({required this.steps});

  final int steps;

  @override
  bool operator ==(Object other) => other is Scrolled && other.steps == steps;

  @override
  int get hashCode => Object.hash(Scrolled, steps);
}
