import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';
import 'package:saviors_paradox/core/rendering/presentation/stroke_paths.dart';
import 'package:saviors_paradox/core/ui/domain/sheet_outline.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';

/// A sheet of paper, [size] in hu, in a seeded pencil border with a faint
/// inner line, a soft light in its middle and a shadow under it: what every
/// menu is drawn on (06-ui/pause-menu/pause-menu.md §3; the 06-ui
/// sandbox's `sheetAt`).
final class PaperSheet extends StatefulWidget {
  const PaperSheet({
    required this.size,
    required this.seed,
    this.child,
    super.key,
  });

  final UiVec2 size;
  final Seed seed;
  final Widget? child;

  @override
  State<PaperSheet> createState() => _PaperSheetState();
}

final class _PaperSheetState extends State<PaperSheet> {
  late SheetOutline _outline;

  @override
  void initState() {
    super.initState();
    _outline = SheetOutline.generate(widget.size, seed: widget.seed);
  }

  @override
  void didUpdateWidget(PaperSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.size != oldWidget.size || widget.seed != oldWidget.seed) {
      _outline = SheetOutline.generate(widget.size, seed: widget.seed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = InkTheme.of(context);
    return SizedBox(
      width: theme.pixels(widget.size.x),
      height: theme.pixels(widget.size.y),
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _PaperSheetPainter(
            outline: _outline,
            size: widget.size,
            pixelsPerHu: theme.pixels(1),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

final class _PaperSheetPainter extends CustomPainter {
  _PaperSheetPainter({
    required this.outline,
    required this.size,
    required this.pixelsPerHu,
  });

  final SheetOutline outline;
  final UiVec2 size;
  final double pixelsPerHu;
  final Pencil _pencil = Pencil();
  final Path _path = Path();
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size _) {
    canvas
      ..save()
      ..scale(pixelsPerHu);
    _paintPaper(canvas);
    _pencil
      ..outlinePolygon(
        canvas,
        outline.border,
        InkThemeData.sheetBorderWidth,
        Palette.ink,
      )
      ..outlinePolygon(
        canvas,
        outline.inner,
        InkThemeData.sheetInnerWidth,
        InkThemeData.sheetInnerColour,
      );
    canvas.restore();
  }

  /// The shadow under the sheet, its paper, and the light on it, clipped
  /// to its border.
  void _paintPaper(Canvas canvas) {
    _paintShadow(canvas);
    _pencil
      ..fillPolygon(canvas, outline.border, Palette.paper)
      ..clipToPolygon(canvas, outline.border);
    _paintLight(canvas);
    canvas.restore();
  }

  void _paintShadow(Canvas canvas) {
    StrokePaths.tracePolygon(_path, outline.border);
    _paint
      ..color = InkThemeData.sheetShadowColour
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        InkThemeData.sheetShadowSigma,
      );
    canvas.drawPath(_path, _paint);
    _paint.maskFilter = null;
  }

  /// sheetAt: a radial light from min(w, h) × .35 to max(w, h) round the
  /// middle.
  void _paintLight(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final outer = w > h ? w : h;
    final inner = (w < h ? w : h) * 0.35;
    _paint.shader = ui.Gradient.radial(
      Offset(w / 2, h / 2),
      outer,
      const [InkThemeData.sheetLight, InkThemeData.sheetShade],
      [inner / outer, 1],
    );
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), _paint);
    _paint.shader = null;
  }

  @override
  bool shouldRepaint(_PaperSheetPainter oldDelegate) =>
      !identical(oldDelegate.outline, outline) ||
      oldDelegate.pixelsPerHu != pixelsPerHu;
}
