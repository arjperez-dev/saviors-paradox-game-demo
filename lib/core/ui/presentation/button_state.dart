import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/ui/presentation/button_look.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';

/// What the screen shows of a button: its seed, its look, whether it holds
/// the focus, and the flash it last asked for.
final class ButtonState {
  const ButtonState({
    required this.seed,
    this.look = ButtonLook.plain,
    this.focused = false,
    this.flash,
  });

  final Seed seed;
  final ButtonLook look;
  final bool focused;
  final InkFlash? flash;

  @override
  bool operator ==(Object other) =>
      other is ButtonState &&
      other.seed == seed &&
      other.look == look &&
      other.focused == focused &&
      other.flash == flash;

  @override
  int get hashCode => Object.hash(seed, look, focused, flash);
}
