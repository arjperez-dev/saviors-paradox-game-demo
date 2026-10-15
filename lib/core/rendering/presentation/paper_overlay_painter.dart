import 'dart:ui';

import 'package:saviors_paradox/core/rendering/domain/paper_overlay.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';

/// Paints a [PaperOverlay] once per resize into a picture drawn over every
/// frame (02-art-direction/dungeon/dungeon.md §1, palette.md §1).
final class PaperOverlayPainter {
  final Paint _paint = Paint();

  /// A stain's colour at its centre: `stain` (palette.md §1).
  static Color stainColor(double alpha) => Color.fromRGBO(90, 70, 45, alpha);

  /// A speck's colour: `grain` (palette.md §1).
  static Color speckColor(double red, double green, double alpha) =>
      Color.fromRGBO(red.floor(), green.floor(), 40, alpha);

  Picture record(PaperOverlay overlay) {
    final recorder = PictureRecorder();
    paint(Canvas(recorder), overlay);
    return recorder.endRecording();
  }

  void paint(Canvas canvas, PaperOverlay overlay) {
    for (var i = 0; i < overlay.stainCount; i++) {
      _stain(canvas, overlay, i * 4);
    }
    _paint.shader = null;
    for (var i = 0; i < overlay.speckCount; i++) {
      _speck(canvas, overlay, i * 7);
    }
    _vignette(canvas, overlay);
  }

  void _stain(Canvas canvas, PaperOverlay overlay, int at) {
    final s = overlay.stains;
    final centre = Offset(s[at], s[at + 1]);
    final colour = stainColor(s[at + 3]);
    _paint.shader = Gradient.radial(centre, s[at + 2], [
      colour,
      colour.withValues(alpha: 0),
    ]);
    canvas.drawCircle(centre, s[at + 2], _paint);
  }

  void _speck(Canvas canvas, PaperOverlay overlay, int at) {
    final g = overlay.grain;
    _paint.color = speckColor(g[at + 4], g[at + 5], g[at + 6]);
    canvas.drawRect(
      Rect.fromLTWH(g[at], g[at + 1], g[at + 2], g[at + 3]),
      _paint,
    );
  }

  /// Clear within 190 su of a centre 20 su below the middle, reaching
  /// `vignette` at 720 su from the middle (the sandbox's `buildLayers`).
  void _vignette(Canvas canvas, PaperOverlay overlay) {
    final size = overlay.size;
    final middle = Offset(size.x / 2, size.y / 2);
    final centre = overlay.vignetteCentre;
    _paint.shader = Gradient.radial(
      middle,
      PaperOverlay.vignetteOuter,
      [Palette.vignette.withValues(alpha: 0), Palette.vignette],
      null,
      TileMode.clamp,
      null,
      Offset(centre.x, centre.y),
      PaperOverlay.vignetteInner,
    );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), _paint);
    _paint.shader = null;
  }
}
