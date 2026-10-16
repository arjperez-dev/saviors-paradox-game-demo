import 'dart:ui';

import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';

/// The hold ring's ink: dark on paper, light on a dark picture (the
/// cinematics sandbox's `skipOverlay`).
enum RingTone {
  onPaper(InkThemeData.ringOnPaper, InkThemeData.ringBaseOnPaper),
  onDark(InkThemeData.ringOnDark, InkThemeData.ringBaseOnDark);

  const RingTone(this.arc, this.base);

  final Color arc;
  final Color base;
}
