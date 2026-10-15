import 'dart:typed_data';

import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// The paper over everything, in screen space: stains, grain and the edge
/// vignette, scattered once for a view of [size] su
/// (02-art-direction/palette/palette.md §1; the sandbox's `buildLayers`).
/// The sandbox's view is 1200 × 600 su; another view keeps the same density.
final class PaperOverlay {
  PaperOverlay._(this.size, this.stains, this.grain);

  factory PaperOverlay.scatter({required Vec2 size, required Seed seed}) {
    final random = StrokeRandom(seed);
    final area = size.x * size.y / referenceArea;
    final stains = _scatter(
      (referenceStains * area).round(),
      _stainFields,
      (into, at) => _stain(into, at, size, random),
    );
    final grain = _scatter(
      (referenceGrain * area).round(),
      _grainFields,
      (into, at) => _speck(into, at, size, random),
    );
    return PaperOverlay._(size, stains, grain);
  }

  /// The sandbox's view, 1200 × 600 su.
  static const double referenceArea = 1200.0 * 600.0;
  static const int referenceStains = 22;
  static const int referenceGrain = 14000;

  /// The vignette is clear within this radius of its centre…
  static const double vignetteInner = 190;

  /// …and reaches `vignette` (0.62) at this one.
  static const double vignetteOuter = 720;

  final Vec2 size;

  /// Per stain: x, y, radius (40–180), alpha (0.04–0.09).
  final Float32List stains;

  /// Per speck: x, y, width and height (0–2), red (60–110), green (50–90),
  /// alpha (0–0.09); blue is always 40.
  final Float32List grain;

  int get stainCount => stains.length ~/ _stainFields;

  int get speckCount => grain.length ~/ _grainFields;

  /// The vignette's inner centre: 20 su below the middle of the view.
  Vec2 get vignetteCentre => Vec2(size.x / 2, size.y / 2 + 20);

  static const int _stainFields = 4;
  static const int _grainFields = 7;

  static Float32List _scatter(
    int count,
    int fields,
    void Function(Float32List into, int at) fill,
  ) {
    final values = Float32List(count * fields);
    for (var i = 0; i < count; i++) {
      fill(values, i * fields);
    }
    return values;
  }

  static void _stain(Float32List into, int at, Vec2 size, StrokeRandom r) {
    into
      ..[at] = r.unit() * size.x
      ..[at + 1] = r.unit() * size.y
      ..[at + 2] = r.between(40, 180)
      ..[at + 3] = r.between(0.04, 0.09);
  }

  static void _speck(Float32List into, int at, Vec2 size, StrokeRandom r) {
    into
      ..[at] = r.unit() * size.x
      ..[at + 1] = r.unit() * size.y
      ..[at + 2] = r.unit() * 2
      ..[at + 3] = r.unit() * 2
      ..[at + 4] = r.between(60, 110)
      ..[at + 5] = r.between(50, 90)
      ..[at + 6] = r.unit() * 0.09;
  }
}
