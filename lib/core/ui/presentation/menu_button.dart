import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/ui/presentation/button_content.dart';
import 'package:saviors_paradox/core/ui/presentation/button_shape.dart';
import 'package:saviors_paradox/core/ui/presentation/button_state.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_style.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_frame.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap.dart';
import 'package:saviors_paradox/core/ui/presentation/label_placement.dart';

/// A menu's button: a framed label, and a key cap after it if it carries
/// one. The mouse over it shows the hand and brightens its paper; a click
/// calls [onPressed]; the focus is the screen's (06-ui/ui.md §3; the 06-ui
/// sandbox's `ttBox`, `pmFooter`). With no [onPressed] the press is left
/// to whoever wraps it.
final class MenuButton extends StatefulWidget {
  const MenuButton({
    required this.content,
    required this.shape,
    required this.state,
    this.onPressed,
    super.key,
  });

  final ButtonContent content;
  final ButtonShape shape;
  final ButtonState state;
  final VoidCallback? onPressed;

  // pmFooter: the label 28 in; with a key cap, 6 to the cap and 22 after it.
  static const double padding = 28;
  static const double capGap = 6;
  static const double capMargin = 22;

  /// The width [content] needs, in hu: the label plus 56, or plus 104 with
  /// a 48-wide key cap (the sandbox's `pmFooter`).
  static double widthOf(ButtonContent content) {
    final label = InkThemeData.widthOf(content.label, InkLettering.button);
    final keyLabel = content.keyLabel;
    return keyLabel == null
        ? padding + label + padding
        : padding + label + capGap + KeyCap.widthOf(keyLabel) + capMargin;
  }

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

final class _MenuButtonState extends State<MenuButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      child: InkFrame(
        size: _size(),
        style: _style(),
        flash: widget.state.flash,
        child: _ButtonFace(
          content: widget.content,
          placement: widget.shape.placement,
          lettering: widget.state.look.lettering,
          seed: widget.state.seed,
        ),
      ),
    ),
  );

  UiVec2 _size() => UiVec2(
    Vec2(
      widget.shape.width ?? MenuButton.widthOf(widget.content),
      widget.shape.height,
    ),
  );

  FrameStyle _style() => FrameStyle(
    seed: widget.state.seed,
    look: widget.state.look.frame,
    focused: widget.state.focused,
    hovered: _hovered,
  );
}

/// The label and the key cap inside the frame.
final class _ButtonFace extends StatelessWidget {
  const _ButtonFace({
    required this.content,
    required this.placement,
    required this.lettering,
    required this.seed,
  });

  final ButtonContent content;
  final LabelPlacement placement;
  final InkLettering lettering;
  final Seed seed;

  @override
  Widget build(BuildContext context) {
    final theme = InkTheme.of(context);
    final keyLabel = content.keyLabel;
    return Padding(
      padding: EdgeInsets.only(
        left: theme.pixels(MenuButton.padding),
        right: theme.pixels(
          keyLabel == null ? MenuButton.padding : MenuButton.capMargin,
        ),
      ),
      child: Row(
        spacing: theme.pixels(MenuButton.capGap),
        children: [
          Expanded(
            child: _Label(content.label, placement, theme.lettering(lettering)),
          ),
          // ttSlots, ttSettings: the cap's seed is the button's + 10.
          if (keyLabel != null)
            KeyCap(label: keyLabel, seed: Seed(seed.value + 10)),
        ],
      ),
    );
  }
}

/// The button's label, on one line, at its place.
final class _Label extends StatelessWidget {
  const _Label(this.text, this.placement, this.style);

  final String text;
  final LabelPlacement placement;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: 1,
    softWrap: false,
    textAlign: switch (placement) {
      LabelPlacement.start => TextAlign.left,
      LabelPlacement.centre => TextAlign.center,
    },
    style: style,
  );
}
