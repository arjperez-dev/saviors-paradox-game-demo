import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

abstract interface class WorldCamera {
  Vec2 toWorld(ScreenVec2 point);

  ScreenVec2 toScreen(Vec2 point);
}
