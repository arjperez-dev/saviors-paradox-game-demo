import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';

/// The keyboard and the pointer as they stand after the input being
/// translated.
abstract interface class InputReading {
  /// Whether [key] is held.
  bool isHeld(InputKey key);

  /// Whether [button] is held.
  bool isPressed(PointerButton button);

  /// Where the pointer is, in logical pixels.
  ScreenVec2 get pointer;

  /// The world point under the pointer, through the world camera.
  Vec2 get aim;

  /// How long the pointer has not moved; infinite before it first moves.
  Seconds get pointerStillFor;
}
