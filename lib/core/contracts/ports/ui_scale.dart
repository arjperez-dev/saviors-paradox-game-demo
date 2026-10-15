import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';

abstract interface class UiScale {
  UiVec2 toUi(ScreenVec2 point);

  ScreenVec2 toScreen(UiVec2 point);
}
