// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/world_camera.dart';

final class FollowCamera implements WorldCamera {
  @override
  Vec2 toWorld(ScreenVec2 point) => Vec2.zero;

  @override
  ScreenVec2 toScreen(Vec2 point) => ScreenVec2.zero;
}
