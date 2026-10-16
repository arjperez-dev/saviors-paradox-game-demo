import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

// LogicalKeyboardKey overrides `==`, so this table cannot be const.
final Map<LogicalKeyboardKey, InputKey> _keys = Map.unmodifiable({
  LogicalKeyboardKey.keyA: InputKey.a,
  LogicalKeyboardKey.keyD: InputKey.d,
  LogicalKeyboardKey.keyW: InputKey.w,
  LogicalKeyboardKey.keyS: InputKey.s,
  LogicalKeyboardKey.space: InputKey.space,
  LogicalKeyboardKey.shiftLeft: InputKey.shift,
  LogicalKeyboardKey.shiftRight: InputKey.shift,
  LogicalKeyboardKey.controlLeft: InputKey.controlLeft,
  LogicalKeyboardKey.keyQ: InputKey.q,
  LogicalKeyboardKey.keyE: InputKey.e,
  LogicalKeyboardKey.keyR: InputKey.r,
  LogicalKeyboardKey.keyF: InputKey.f,
  LogicalKeyboardKey.keyG: InputKey.g,
  LogicalKeyboardKey.keyH: InputKey.h,
  LogicalKeyboardKey.keyM: InputKey.m,
  LogicalKeyboardKey.enter: InputKey.enter,
  LogicalKeyboardKey.escape: InputKey.escape,
  LogicalKeyboardKey.digit1: InputKey.digit1,
  LogicalKeyboardKey.digit2: InputKey.digit2,
  LogicalKeyboardKey.digit3: InputKey.digit3,
  LogicalKeyboardKey.digit4: InputKey.digit4,
  LogicalKeyboardKey.digit5: InputKey.digit5,
  LogicalKeyboardKey.arrowUp: InputKey.arrowUp,
  LogicalKeyboardKey.arrowDown: InputKey.arrowDown,
  LogicalKeyboardKey.arrowLeft: InputKey.arrowLeft,
  LogicalKeyboardKey.arrowRight: InputKey.arrowRight,
});

/// Hands the window's keys and pointer to core/input as raw inputs: the
/// one place Flutter's key and pointer events meet the game
/// (design-patterns.md §5, §13).
final class InputListener extends StatefulWidget {
  const InputListener({required this.onInput, required this.child, super.key});

  final ValueChanged<RawInput> onInput;
  final Widget child;

  @override
  State<InputListener> createState() => _InputListenerState();
}

final class _InputListenerState extends State<InputListener> {
  Offset _position = Offset.zero;
  int _buttons = 0;

  @override
  Widget build(BuildContext context) => Focus(
    autofocus: true,
    onKeyEvent: _onKey,
    child: Listener(
      onPointerDown: _onPointer,
      onPointerMove: _onPointer,
      onPointerHover: _onPointer,
      onPointerUp: _onPointer,
      onPointerSignal: _onSignal,
      child: widget.child,
    ),
  );

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    final key = _keys[event.logicalKey];
    if (key == null) {
      return KeyEventResult.ignored;
    }
    if (event is KeyDownEvent) {
      widget.onInput(KeyDown(key));
    } else if (event is KeyUpEvent) {
      widget.onInput(KeyUp(key));
    }
    return KeyEventResult.handled;
  }

  void _onPointer(PointerEvent event) {
    final delta = event.localPosition - _position;
    if (delta != Offset.zero) {
      _position = event.localPosition;
      widget.onInput(
        PointerMoved(position: _screen(_position), delta: _screen(delta)),
      );
    }
    _compare(event.buttons, kPrimaryButton, PointerButton.primary);
    _compare(event.buttons, kSecondaryButton, PointerButton.secondary);
    _buttons = event.buttons;
  }

  void _compare(int buttons, int mask, PointerButton button) {
    final wasDown = (_buttons & mask) != 0;
    final isDown = (buttons & mask) != 0;
    if (isDown && !wasDown) {
      widget.onInput(ButtonDown(button));
    } else if (wasDown && !isDown) {
      widget.onInput(ButtonUp(button));
    }
  }

  void _onSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent && event.scrollDelta.dy != 0) {
      widget.onInput(Scrolled(steps: event.scrollDelta.dy.sign.toInt()));
    }
  }

  static ScreenVec2 _screen(Offset offset) =>
      ScreenVec2(Vec2(offset.dx, offset.dy));
}
