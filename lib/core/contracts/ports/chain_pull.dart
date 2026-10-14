import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point.dart';

sealed class ChainPull {
  const ChainPull();
}

final class NoPull extends ChainPull {
  const NoPull();
}

final class PullToward extends ChainPull {
  const PullToward({
    required this.point,
  });

  final Vec2 point;
}

final class HangFrom extends ChainPull {
  const HangFrom({
    required this.hookPoint,
    required this.length,
  });

  final HookPoint hookPoint;
  final double length;
}

final class ClimbTo extends ChainPull {
  const ClimbTo({
    required this.point,
  });

  final Vec2 point;
}
