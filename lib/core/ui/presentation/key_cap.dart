import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_style.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_frame.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap_size.dart';

/// A key drawn as a small paper cap with its name on it: `Esc`, `Enter`,
/// `M` (06-ui/ui.md §3; the 06-ui sandbox's `keyCap`, `dlKey`). The name
/// is the key, not a text, so it is not translated
/// (06-ui/dialogue/dialogue.md §6).
final class KeyCap extends StatelessWidget {
  const KeyCap({
    required this.label,
    required this.seed,
    this.size = const KeyCapSize(),
    this.flash,
    super.key,
  });

  final String label;
  final Seed seed;
  final KeyCapSize size;
  final InkFlash? flash;

  // keyCap: 48 wide; dlKey: max(48, the name + 28).
  static const double minWidth = 48;
  static const double padding = 14;

  /// The width of a cap named [label], in hu.
  static double widthOf(String label) => math.max(
    minWidth,
    InkThemeData.widthOf(label, InkLettering.keyCap) + 2 * padding,
  );

  @override
  Widget build(BuildContext context) => InkFrame(
    size: UiVec2(Vec2(widthOf(label), size.height)),
    style: FrameStyle(seed: seed, look: FrameLook.keyCap),
    flash: flash,
    child: Center(
      child: Text(
        label,
        maxLines: 1,
        softWrap: false,
        style: InkTheme.of(context).lettering(InkLettering.keyCap),
      ),
    ),
  );
}
