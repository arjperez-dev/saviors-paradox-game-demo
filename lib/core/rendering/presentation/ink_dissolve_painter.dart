import 'dart:ui';

import 'package:saviors_paradox/core/rendering/domain/ink_dissolve.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_puff.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';

/// Paints an [InkDissolve]: the body's frozen drawing filled with ink and
/// eaten by its holes, then its puffs
/// (02-art-direction/fx/ink-smoke/ink-smoke.md; the sandbox's
/// `drawDummyDissolving` and its `ink` particles).
final class InkDissolvePainter {
  InkDissolvePainter(this._pencil);

  final Pencil _pencil;
  final Paint _layer = Paint();
  final Paint _paint = Paint();

  /// The box the body is drawn in, around its feet: 300 su wide, from 280
  /// above the feet to 40 below them (the sandbox's dissolve canvas).
  static const Rect bodyBox = Rect.fromLTRB(-150, -280, 150, 40);

  /// A puff's hatching: `paper` at 0.28 (ink-smoke.md §2).
  static const double puffHatchAlpha = 0.28;

  /// A puff's wisp: `ink` at 0.7 (the sandbox's `ink` particle).
  static const double wispAlpha = 0.7;

  /// A puff fades from 0.85 to 0 over its life (the sandbox's `ink`
  /// particle).
  static double puffAlpha(double progress) => (1 - progress) * 0.85;

  /// The body: [drawBody] draws its pose at the dissolve's feet.
  void paintBody(
    Canvas canvas,
    InkDissolve dissolve,
    void Function(Canvas canvas) drawBody,
  ) {
    final feet = Offset(dissolve.feet.x, dissolve.feet.y);
    final box = bodyBox.shift(feet);
    canvas.saveLayer(
      box,
      _layer..color = Palette.ink.withValues(alpha: dissolve.bodyAlpha),
    );
    drawBody(canvas);
    canvas.drawRect(
      box,
      _paint
        ..blendMode = BlendMode.srcATop
        ..color = Palette.ink.withValues(alpha: dissolve.inkAlpha),
    );
    _holes(canvas, dissolve, feet);
    canvas.restore();
    _paint.blendMode = BlendMode.srcOver;
  }

  void paintPuffs(Canvas canvas, InkDissolve dissolve) {
    for (var i = 0; i < dissolve.holes.length; i++) {
      final puff = dissolve.puffAt(i);
      if (puff != null) {
        _puff(canvas, puff);
      }
    }
  }

  void _holes(Canvas canvas, InkDissolve dissolve, Offset feet) {
    _paint.blendMode = BlendMode.dstOut;
    final holes = dissolve.holes;
    for (var i = 0; i < holes.length; i++) {
      final hole = holes[i];
      final radius = hole.radiusAt(dissolve.elapsed);
      if (radius > 0) {
        canvas.drawCircle(
          feet + Offset(hole.centre.x, hole.centre.y),
          radius,
          _paint..color = Palette.ink,
        );
      }
    }
  }

  void _puff(Canvas canvas, InkPuff puff) {
    final shape = puff.shape;
    if (shape == null) {
      return;
    }
    final alpha = puffAlpha(puff.progress);
    final scale = puff.growth;
    canvas
      ..save()
      ..translate(puff.position.x, puff.position.y)
      ..scale(scale);
    _pencil
      ..fillCurve(canvas, shape.outline, _ink(Palette.inkSmoke.a * alpha))
      ..clipToCurve(canvas, shape.outline)
      ..hatch(
        canvas,
        shape.hatching,
        Palette.paper.withValues(alpha: puffHatchAlpha * alpha),
        1 / scale,
      );
    canvas.restore();
    _pencil.line(
      canvas,
      shape.wisp,
      _ink(wispAlpha * alpha),
      widthScale: 1 / scale,
    );
    canvas.restore();
  }

  static Color _ink(double alpha) => Palette.ink.withValues(alpha: alpha);
}
