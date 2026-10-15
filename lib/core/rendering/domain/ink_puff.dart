import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/pool.dart';
import 'package:saviors_paradox/core/rendering/domain/puff_shape.dart';

/// A puff of ink smoke in flight: it rises, drifts, grows to 2.3× and fades;
/// its shape never changes (02-art-direction/fx/ink-smoke/ink-smoke.md §2).
/// Puffs come from a [Pool].
final class InkPuff implements Poolable {
  Vec2 _position = Vec2.zero;
  Vec2 _velocity = Vec2.zero;
  Seconds _age = Seconds.zero;
  PuffShape? _shape;

  Vec2 get position => _position;

  /// The shape it was launched with; null before its first launch.
  PuffShape? get shape => _shape;

  /// From 0 when it leaves to 1 when it is gone.
  double get progress => switch (_shape) {
    null => 1,
    final shape => math.min(1, _age.value / shape.life.value),
  };

  bool get isSpent => progress >= 1;

  /// How much its radius has grown: from 1 to 2.3.
  double get growth => 1 + 1.3 * progress;

  @override
  void reset() {
    _position = Vec2.zero;
    _velocity = Vec2.zero;
    _age = Seconds.zero;
    _shape = null;
  }

  /// Sends the puff off from [from] with [shape].
  void launch(Vec2 from, PuffShape shape) {
    _position = from;
    _velocity = shape.velocity;
    _age = Seconds.zero;
    _shape = shape;
  }

  /// Moves it, then slows its drift at 4/s and its rise at 3/s.
  void step(Seconds dt) {
    _age = _age + dt;
    _position = _position + _velocity.scaled(dt.value);
    _velocity = Vec2(
      _velocity.x * math.exp(-dt.value * 4),
      _velocity.y * math.exp(-dt.value * 3),
    );
  }
}
