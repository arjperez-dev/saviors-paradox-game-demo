import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';

/// How a box's frame is drawn: its seed, its paper, and whether it holds
/// the focus or the mouse; each is a look, never a behaviour.
final class FrameStyle {
  const FrameStyle({
    required this.seed,
    this.look = FrameLook.paper,
    this.focused = false,
    this.hovered = false,
  });

  final Seed seed;
  final FrameLook look;
  final bool focused;
  final bool hovered;

  @override
  bool operator ==(Object other) =>
      other is FrameStyle &&
      other.seed == seed &&
      other.look == look &&
      other.focused == focused &&
      other.hovered == hovered;

  @override
  int get hashCode => Object.hash(seed, look, focused, hovered);
}
