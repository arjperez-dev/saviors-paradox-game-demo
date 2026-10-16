import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';
import 'package:saviors_paradox/core/ui/domain/dashed_outline.dart';
import 'package:saviors_paradox/core/ui/domain/pencil_box.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_style.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';

/// A box of paper in a pencil frame, [size] in hu: thin at rest, thick
/// with an inner line when focused, dashed when empty, and flashing when
/// the screen asks (06-ui/ui.md §3; the 06-ui sandbox's `hudBox`, `ttBox`).
final class InkFrame extends StatefulWidget {
  const InkFrame({
    required this.size,
    required this.style,
    this.flash,
    this.child,
    super.key,
  });

  final UiVec2 size;
  final FrameStyle style;
  final InkFlash? flash;
  final Widget? child;

  @override
  State<InkFrame> createState() => _InkFrameState();
}

final class _InkFrameState extends State<InkFrame>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flash;
  late _FrameStrokes _strokes;

  @override
  void initState() {
    super.initState();
    _flash = AnimationController(vsync: this);
    _strokes = _FrameStrokes(widget.size, widget.style.seed);
  }

  @override
  void didUpdateWidget(InkFrame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.size != oldWidget.size ||
        widget.style.seed != oldWidget.style.seed) {
      _strokes = _FrameStrokes(widget.size, widget.style.seed);
    }
    final flash = widget.flash;
    if (flash != null && flash != oldWidget.flash) {
      _flash
        ..duration = flash.kind.duration
        ..forward(from: 0);
    }
  }

  @override
  void dispose() {
    _flash.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = InkTheme.of(context);
    final pixelsPerHu = theme.pixels(1);
    return SizedBox(
      width: theme.pixels(widget.size.x),
      height: theme.pixels(widget.size.y),
      child: Stack(
        children: [
          // The box and its frame repaint only when the strokes or the
          // style change; the flash ticks every frame of its own, so it
          // never forces the paper and the frame to redraw with it.
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _InkFrameBoxPainter(
                  strokes: _strokes,
                  style: widget.style,
                  pixelsPerHu: pixelsPerHu,
                ),
                child: widget.child,
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _InkFrameFlashPainter(
                strokes: _strokes,
                pixelsPerHu: pixelsPerHu,
                flash: _flash,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The frame's strokes, generated once per size and seed: the box from the
/// seed, the dashed focus from seed + 3, the flash, 4 out, from seed + 5
/// (the 06-ui sandbox's `pmBox`).
final class _FrameStrokes {
  _FrameStrokes._(this.box, this.dashedFocus, this.flash, this.dashes);

  factory _FrameStrokes(UiVec2 size, Seed seed) {
    final box = PencilBox.generate(size, seed: seed);
    return _FrameStrokes._(
      box,
      PencilBox.generate(size, seed: Seed(seed.value + 3)),
      PencilBox.generate(
        size + const UiVec2(Vec2(2 * flashOut, 2 * flashOut)),
        seed: Seed(seed.value + 5),
      ),
      DashedOutline.along(
        box.outline,
        on: InkThemeData.dashOn,
        off: InkThemeData.dashOff,
      ),
    );
  }

  // pmBox: the flash is the box 4 out on every side.
  static const double flashOut = 4;

  final PencilBox box;
  final PencilBox dashedFocus;
  final PencilBox flash;
  final DashedOutline dashes;
}

/// The thick frame and its inner line, in [colour] and [innerColour]: the
/// focused look, shared by the box at rest and the fading flash.
void _paintFocusedFrame(
  Pencil pencil,
  Canvas canvas,
  PencilBox box,
  Color colour,
  Color innerColour,
) {
  pencil
    ..outlinePolygon(canvas, box.outline, InkThemeData.focusWidth, colour)
    ..outlinePolygon(
      canvas,
      box.inner,
      InkThemeData.focusInnerWidth,
      innerColour,
    );
}

/// The paper and the frame or the dashes: static once painted, so it sits
/// behind its own [RepaintBoundary] and never redraws for the flash's tick
/// (coding-standards.md §11.4).
final class _InkFrameBoxPainter extends CustomPainter {
  _InkFrameBoxPainter({
    required this.strokes,
    required this.style,
    required this.pixelsPerHu,
  });

  final _FrameStrokes strokes;
  final FrameStyle style;
  final double pixelsPerHu;
  final Pencil _pencil = Pencil();
  final Path _dash = Path();
  final Paint _dashPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = InkThemeData.dashWidth
    ..color = InkThemeData.dashColour;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(pixelsPerHu);
    final look = style.look;
    _pencil.fillPolygon(
      canvas,
      strokes.box.outline,
      style.hovered ? look.hoveredFill : look.fill,
    );
    _paintFrame(canvas);
    canvas.restore();
  }

  void _paintFrame(Canvas canvas) {
    if (style.look == FrameLook.dashed) {
      _paintDashed(canvas);
    } else if (style.focused) {
      _paintFocusedFrame(
        _pencil,
        canvas,
        strokes.box,
        InkThemeData.focusColour,
        InkThemeData.focusInnerColour,
      );
    } else {
      _pencil.outlinePolygon(
        canvas,
        strokes.box.outline,
        InkThemeData.frameWidth,
        InkThemeData.frameColour,
      );
    }
  }

  void _paintDashed(Canvas canvas) {
    for (final dash in strokes.dashes.dashes) {
      _dash
        ..reset()
        ..moveTo(dash.first.x, dash.first.y);
      for (var i = 1; i < dash.length; i++) {
        _dash.lineTo(dash[i].x, dash[i].y);
      }
      canvas.drawPath(_dash, _dashPaint);
    }
    if (style.focused) {
      _pencil.outlinePolygon(
        canvas,
        strokes.dashedFocus.outline,
        InkThemeData.focusWidth,
        InkThemeData.focusColour,
      );
    }
  }

  @override
  bool shouldRepaint(_InkFrameBoxPainter oldDelegate) =>
      !identical(oldDelegate.strokes, strokes) ||
      oldDelegate.style != style ||
      oldDelegate.pixelsPerHu != pixelsPerHu;
}

/// The flash alone, 4 out, fading from full to nothing over its duration: it
/// ticks every frame it runs, so it never shares a repaint with the paper
/// and the frame (coding-standards.md §11.4).
final class _InkFrameFlashPainter extends CustomPainter {
  _InkFrameFlashPainter({
    required this.strokes,
    required this.pixelsPerHu,
    required this.flash,
  }) : super(repaint: flash);

  final _FrameStrokes strokes;
  final double pixelsPerHu;
  final Animation<double> flash;
  final Pencil _pencil = Pencil();

  @override
  void paint(Canvas canvas, Size size) {
    if (flash.status != AnimationStatus.forward) {
      return;
    }
    final strength = 1 - flash.value;
    canvas
      ..save()
      ..scale(pixelsPerHu)
      ..translate(-_FrameStrokes.flashOut, -_FrameStrokes.flashOut);
    _paintFocusedFrame(
      _pencil,
      canvas,
      strokes.flash,
      _faded(InkThemeData.focusColour, strength),
      _faded(InkThemeData.focusInnerColour, strength),
    );
    canvas.restore();
  }

  static Color _faded(Color colour, double strength) =>
      colour.withValues(alpha: colour.a * strength);

  @override
  bool shouldRepaint(_InkFrameFlashPainter oldDelegate) =>
      !identical(oldDelegate.strokes, strokes) ||
      oldDelegate.pixelsPerHu != pixelsPerHu;
}
