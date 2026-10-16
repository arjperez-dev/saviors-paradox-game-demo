import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';

/// A sheet's footer, [width] hu wide: its buttons from the left, 22 apart,
/// and the hint of the keys right-aligned on the same line, already
/// translated by the screen (06-ui/pause-menu/pause-menu.md §3; the 06-ui
/// sandbox's `pmFooter`, `ttSlots`, `ttSettings`).
final class HintFooter extends StatelessWidget {
  const HintFooter({
    required this.width,
    required this.buttons,
    required this.hint,
    super.key,
  }) : assert(width > 0, 'a footer has a width');

  final double width;
  final List<Widget> buttons;
  final String hint;

  // pmFooter: buttons 56 tall, 22 apart.
  static const double height = 56;
  static const double gap = 22;

  @override
  Widget build(BuildContext context) {
    final theme = InkTheme.of(context);
    return SizedBox(
      width: theme.pixels(width),
      height: theme.pixels(height),
      child: Row(
        spacing: theme.pixels(gap),
        children: [
          ...buttons,
          Expanded(
            child: Text(
              hint,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.right,
              style: theme.lettering(InkLettering.hint),
            ),
          ),
        ],
      ),
    );
  }
}
