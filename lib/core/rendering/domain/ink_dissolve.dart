import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_hole.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_puff.dart';
import 'package:saviors_paradox/core/rendering/domain/pool.dart';
import 'package:saviors_paradox/core/rendering/domain/smoothstep.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// How a defeated body of about 200 su leaves: it fills with ink, holes open
/// in it from the head down, each letting out a puff, and it is gone by
/// 1.3 s (02-art-direction/fx/ink-smoke/ink-smoke.md §1). Its holes are
/// seeded once; only their size and the puffs move.
final class InkDissolve {
  InkDissolve._(List<InkHole> holes, this._pool)
    : holes = List.unmodifiable(holes),
      _puffs = List.filled(holes.length, null),
      _isLaunched = List.filled(holes.length, false);

  factory InkDissolve.prepare({
    required Seed seed,
    required Pool<InkPuff> puffs,
  }) {
    final random = StrokeRandom(seed);
    return InkDissolve._([
      for (var i = 0; i < holeCount; i++) InkHole.generate(random),
    ], puffs);
  }

  static const int holeCount = 30;
  static const Seconds inkFill = Seconds(0.2);
  static const double fullInk = 0.88;
  static const Seconds fadeStart = Seconds(1);
  static const Seconds fadeLength = Seconds(0.3);

  final List<InkHole> holes;
  final Pool<InkPuff> _pool;
  final List<InkPuff?> _puffs;
  final List<bool> _isLaunched;
  Vec2 _feet = Vec2.zero;
  Seconds _elapsed = Seconds.zero;

  Seconds get elapsed => _elapsed;

  /// Where the body stood when it was defeated.
  Vec2 get feet => _feet;

  /// The ink over the body's drawing: 0 to 0.88 over the first 0.2 s.
  double get inkAlpha => fullInk * smoothstep(_elapsed.value / inkFill.value);

  /// What is left of the body fades out from 1 s to 1.3 s.
  double get bodyAlpha =>
      1 - smoothstep((_elapsed - fadeStart).value / fadeLength.value);

  /// Gone, and every puff faded.
  bool get isFinished => bodyAlpha == 0 && !_puffs.any(_isFlying);

  /// The puff of hole [index], while it flies.
  InkPuff? puffAt(int index) => _puffs[index];

  /// Starts the dissolve of a body standing at [feet].
  void start(Vec2 feet) {
    _feet = feet;
    _elapsed = Seconds.zero;
    for (var i = 0; i < holes.length; i++) {
      _land(i);
      _isLaunched[i] = false;
    }
  }

  void step(Seconds dt) {
    _elapsed = _elapsed + dt;
    for (var i = 0; i < holes.length; i++) {
      _launchIfOpen(i);
      _fly(i, dt);
    }
  }

  void _launchIfOpen(int i) {
    if (_isLaunched[i] || _elapsed < holes[i].opensAt) {
      return;
    }
    _isLaunched[i] = true;
    _puffs[i] = _pool.acquire()..launch(_feet + holes[i].centre, holes[i].puff);
  }

  void _fly(int i, Seconds dt) {
    final puff = _puffs[i];
    if (puff == null) {
      return;
    }
    puff.step(dt);
    if (puff.isSpent) {
      _land(i);
    }
  }

  void _land(int i) {
    final puff = _puffs[i];
    if (puff != null) {
      _pool.release(puff);
      _puffs[i] = null;
    }
  }

  static bool _isFlying(InkPuff? puff) => puff != null;
}
