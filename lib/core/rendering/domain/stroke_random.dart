import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/seed.dart';

/// The random numbers of a stroke, drawn from its fixed seed: the same seed
/// gives the same numbers, so the same stroke in every frame
/// (02-art-direction/strokes/strokes.md §4).
final class StrokeRandom {
  StrokeRandom(Seed seed) : _random = math.Random(seed.value);

  final math.Random _random;

  /// A number in [0, 1).
  double unit() => _random.nextDouble();

  /// A number in [-1, 1).
  double signed() => _random.nextDouble() * 2 - 1;

  /// A number in [min, max).
  double between(double min, double max) =>
      min + (max - min) * _random.nextDouble();

  /// True with the given [probability].
  bool chance(double probability) => _random.nextDouble() < probability;
}
