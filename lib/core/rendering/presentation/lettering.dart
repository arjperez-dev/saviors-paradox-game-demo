import 'package:flutter/painting.dart';

/// The game's hand lettering (02-art-direction/strokes/strokes.md §3):
/// Patrick Hand, bundled under assets/fonts/ with its SIL Open Font
/// License.
abstract final class Lettering {
  /// The family the manifest declares for the bundled font.
  static const String family = 'Patrick Hand';

  /// The lettering at [size] logical pixels, in [color].
  static TextStyle style({required double size, required Color color}) =>
      TextStyle(fontFamily: family, fontSize: size, color: color);
}
