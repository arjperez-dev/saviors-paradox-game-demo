import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';
import 'package:saviors_paradox/core/ui/presentation/button_content.dart';
import 'package:saviors_paradox/core/ui/presentation/button_shape.dart';
import 'package:saviors_paradox/core/ui/presentation/button_state.dart';
import 'package:saviors_paradox/core/ui/presentation/cap_key.dart';
import 'package:saviors_paradox/core/ui/presentation/menu_button.dart';

/// A button carrying a key cap, which does exactly what its key does:
/// pressing it with the left button presses the key, letting go releases
/// it, handed to core/input as raw input — clicking *Resume* [`Esc`] is
/// pressing Esc (06-ui/ui.md §3; coding-standards.md §11.9).
final class KeyCapButton extends StatefulWidget {
  const KeyCapButton({
    required this.label,
    required this.capKey,
    required this.state,
    required this.onInput,
    super.key,
  });

  final String label;
  final CapKey capKey;
  final ButtonState state;
  final ValueChanged<RawInput> onInput;

  // pmFooter, ttSlots, ttSettings, map.md §3: the button is 56 tall.
  static const ButtonShape shape = ButtonShape(height: 56);

  @override
  State<KeyCapButton> createState() => _KeyCapButtonState();
}

final class _KeyCapButtonState extends State<KeyCapButton> {
  bool _held = false;

  @override
  void dispose() {
    _release();
    super.dispose();
  }

  void _press(PointerDownEvent event) {
    if (_held || event.buttons & kPrimaryButton == 0) {
      return;
    }
    _held = true;
    widget.onInput(KeyDown(widget.capKey.key));
  }

  // A button that goes away while held lets its key go, so nothing stays
  // pressed.
  void _release() {
    if (!_held) {
      return;
    }
    _held = false;
    widget.onInput(KeyUp(widget.capKey.key));
  }

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: _press,
    onPointerUp: (_) => _release(),
    onPointerCancel: (_) => _release(),
    child: MenuButton(
      content: ButtonContent(
        label: widget.label,
        keyLabel: widget.capKey.label,
      ),
      shape: KeyCapButton.shape,
      state: widget.state,
    ),
  );
}
