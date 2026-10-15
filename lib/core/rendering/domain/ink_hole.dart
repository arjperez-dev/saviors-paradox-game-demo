import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/puff_shape.dart';
import 'package:saviors_paradox/core/rendering/domain/smoothstep.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// One hole that opens in a dissolving body, and the puff it lets out
/// (02-art-direction/fx/ink-smoke/ink-smoke.md §1). Its centre is relative
/// to the body's feet, for a body about 200 su tall.
final class InkHole {
  InkHole._({
    required this.centre,
    required this.radius,
    required this.opensAt,
    required this.puff,
  });

  /// Placed over the body: up to 60 su to either side, 10 to 200 su above
  /// the feet. Upper holes open first, with a seeded spread, between 0.12
  /// and 0.82 s (the sandbox's `HOLES_D`).
  factory InkHole.generate(StrokeRandom random) {
    final centre = Vec2(random.signed() * 60, -10 - random.unit() * 190);
    final radius = random.between(20, 42);
    final spread = random.unit();
    return InkHole._(
      centre: centre,
      radius: radius,
      opensAt: Seconds(
        _inkFill * 0.6 +
            (1 + centre.y / 200) * _spread * 0.55 +
            spread * _spread * 0.45,
      ),
      puff: PuffShape.generate(random),
    );
  }

  /// How long a hole takes to reach its full radius.
  static const Seconds growth = Seconds(0.45);

  static const double _inkFill = 0.2;
  static const double _spread = 0.7;

  final Vec2 centre;
  final double radius;
  final Seconds opensAt;
  final PuffShape puff;

  /// Its radius [elapsed] seconds into the dissolve: 0 until it opens.
  double radiusAt(Seconds elapsed) =>
      radius * smoothstep((elapsed - opensAt).value / growth.value);
}
