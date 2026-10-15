// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/ui_scale.dart';

final class ScreenUiScale implements UiScale {
  @override
  UiVec2 toUi(ScreenVec2 point) => UiVec2.zero;

  @override
  ScreenVec2 toScreen(UiVec2 point) => ScreenVec2.zero;
}
