import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/circle_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/ring_tone.dart';

/// A pencil ring that fills clockwise from the top with the [fraction] its
/// owner gives it: how long a hold has lasted (01-story/cinematics/intro.md
/// S4; the cinematics sandbox's `skipOverlay`). How long the hold lasts is
/// the owner's.
final class HoldRing extends StatefulWidget {
  const HoldRing({
    required this.fraction,
    required this.seed,
    this.tone = RingTone.onPaper,
    super.key,
  }) : assert(fraction >= 0 && fraction <= 1, 'a fraction of the hold');

  final double fraction;
  final Seed seed;
  final RingTone tone;

  // skipOverlay: r = 24.
  static const double radius = 24;

  @override
  State<HoldRing> createState() => _HoldRingState();
}

final class _HoldRingState extends State<HoldRing> {
  late CircleStroke _base;

  @override
  void initState() {
    super.initState();
    _base = _generate(widget.seed);
  }

  @override
  void didUpdateWidget(HoldRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.seed != oldWidget.seed) {
      _base = _generate(widget.seed);
    }
  }

  static CircleStroke _generate(Seed seed) => CircleStroke.generate(
    const Vec2(HoldRing.radius, HoldRing.radius),
    HoldRing.radius,
    random: StrokeRandom(seed),
  );

  @override
  Widget build(BuildContext context) {
    final theme = InkTheme.of(context);
    final pixelsPerHu = theme.pixels(1);
    return SizedBox.square(
      dimension: theme.pixels(2 * HoldRing.radius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // The circle is generated once per seed and never changes while a
          // hold fills it; a RepaintBoundary keeps its stroke off the path
          // the arc repaints every frame (checklist F4).
          RepaintBoundary(
            child: CustomPaint(
              painter: _HoldRingBasePainter(
                base: _base,
                tone: widget.tone,
                pixelsPerHu: pixelsPerHu,
              ),
            ),
          ),
          CustomPaint(
            painter: _HoldRingArcPainter(
              fraction: widget.fraction,
              tone: widget.tone,
              pixelsPerHu: pixelsPerHu,
            ),
          ),
        ],
      ),
    );
  }
}

final class _HoldRingBasePainter extends CustomPainter {
  _HoldRingBasePainter({
    required this.base,
    required this.tone,
    required this.pixelsPerHu,
  });

  final CircleStroke base;
  final RingTone tone;
  final double pixelsPerHu;
  final Pencil _pencil = Pencil();

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(pixelsPerHu);
    _pencil.outlineCurve(
      canvas,
      base.points,
      InkThemeData.ringBaseWidth,
      tone.base,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_HoldRingBasePainter oldDelegate) =>
      !identical(oldDelegate.base, base) ||
      oldDelegate.tone != tone ||
      oldDelegate.pixelsPerHu != pixelsPerHu;
}

final class _HoldRingArcPainter extends CustomPainter {
  _HoldRingArcPainter({
    required this.fraction,
    required this.tone,
    required this.pixelsPerHu,
  });

  final double fraction;
  final RingTone tone;
  final double pixelsPerHu;
  final Paint _arc = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = InkThemeData.ringArcWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (fraction <= 0) {
      return;
    }
    canvas
      ..save()
      ..scale(pixelsPerHu);
    // skipOverlay: from the top, clockwise, round-capped.
    canvas.drawArc(
      Rect.fromCircle(
        center: const Offset(HoldRing.radius, HoldRing.radius),
        radius: HoldRing.radius,
      ),
      -math.pi / 2,
      fraction * 2 * math.pi,
      false,
      _arc..color = tone.arc,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_HoldRingArcPainter oldDelegate) =>
      oldDelegate.fraction != fraction ||
      oldDelegate.tone != tone ||
      oldDelegate.pixelsPerHu != pixelsPerHu;
}
