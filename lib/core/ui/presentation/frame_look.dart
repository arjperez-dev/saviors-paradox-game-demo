import 'dart:ui';

import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';

/// The paper under a box's frame, at rest and under the mouse (the 06-ui
/// sandbox's `ttBox`, `ttMain`, `hudBox`, `keyCap`, `ttConfirm`).
enum FrameLook {
  paper(InkThemeData.paperFill, InkThemeData.paperFillHovered),
  faint(InkThemeData.faintFill, InkThemeData.faintFillHovered),
  dashed(InkThemeData.dashedFill, InkThemeData.dashedFillHovered),
  keyCap(InkThemeData.keyCapFill, InkThemeData.keyCapFill),
  question(InkThemeData.questionFill, InkThemeData.questionFill);

  const FrameLook(this.fill, this.hoveredFill);

  final Color fill;
  final Color hoveredFill;
}
