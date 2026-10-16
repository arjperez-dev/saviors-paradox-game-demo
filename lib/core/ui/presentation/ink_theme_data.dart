import 'package:flutter/painting.dart';
import 'package:saviors_paradox/core/contracts/ports/ui_scale.dart';
import 'package:saviors_paradox/core/rendering/presentation/lettering.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/screen_ui_scale.dart';

/// The look of every screen at the screen's size: the UI scale, the
/// lettering, and the colours and stroke widths the kit draws with, in hu
/// (06-ui/ui.md §3; coding-standards.md §11.6). Colours are palette.md's;
/// the values are the 06-ui sandbox's.
final class InkThemeData {
  const InkThemeData(this._scale);

  final ScreenUiScale _scale;

  /// The UI frame at this screen's size, for hud and map to call.
  UiScale get scale => _scale;

  /// [hu] in logical pixels.
  double pixels(double hu) => hu * _scale.pixelsPerHu;

  /// The lettering of [role], scaled to this screen.
  TextStyle lettering(InkLettering role) =>
      Lettering.style(size: pixels(role.size), color: role.colour);

  /// The width of [text] in [role]'s lettering, in hu: a box sized to its
  /// text, as the sandbox's `measureText`.
  static double widthOf(String text, InkLettering role) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: Lettering.style(size: role.size, color: role.colour),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final width = painter.width;
    painter.dispose();
    return width;
  }

  // The paper sheet: the sandbox's `sheetAt`.
  static const double sheetBorderWidth = 3.2;
  static const double sheetInnerWidth = 1.2;
  static const Color sheetInnerColour = Color.fromRGBO(26, 23, 21, 0.4);
  // `shadowColor rgba(0,0,0,.55)`: darkness, the nearest palette colour.
  static const Color sheetShadowColour = Color.fromRGBO(14, 11, 9, 0.55);
  // `shadowBlur 34`: a canvas blur of 34 is a Gaussian of sigma 17.
  static const double sheetShadowSigma = 17;
  static const Color sheetLight = Color.fromRGBO(239, 230, 214, 0.32);
  static const Color sheetShade = Color.fromRGBO(14, 11, 9, 0.3);

  // A box's pencil frame: the sandbox's `hudBox`.
  static const double frameWidth = 1.7;
  static const Color frameColour = Color.fromRGBO(26, 23, 21, 0.62);
  static const double focusWidth = 3.6;
  static const Color focusColour = Palette.ink;
  static const double focusInnerWidth = 1;
  static const Color focusInnerColour = Color.fromRGBO(26, 23, 21, 0.35);
  static const double dashWidth = 1.4;
  static const Color dashColour = Color.fromRGBO(26, 23, 21, 0.45);
  static const double dashOn = 7;
  static const double dashOff = 6;

  // A box's paper: `ttBox`, `ttMain`'s faint buttons, `hudBox`'s dashed
  // box, `keyCap`, `ttConfirm`.
  static const Color paperFill = Color.fromRGBO(239, 230, 214, 0.78);
  static const Color paperFillHovered = Color.fromRGBO(239, 230, 214, 0.95);
  static const Color faintFill = Color.fromRGBO(212, 204, 190, 0.55);
  static const Color faintFillHovered = Color.fromRGBO(212, 204, 190, 0.75);
  static const Color dashedFill = Color.fromRGBO(239, 230, 214, 0.28);
  static const Color dashedFillHovered = Color.fromRGBO(26, 23, 21, 0.08);
  static const Color keyCapFill = Palette.paperLight;
  static const Color questionFill = Color.fromRGBO(239, 230, 214, 0.97);
  // pmConfirm: the darker wash over the sheet behind a question.
  static const Color questionWash = Color.fromRGBO(14, 11, 9, 0.45);

  // The hold ring: the cinematics sandbox's `skipOverlay`.
  static const double ringBaseWidth = 1.4;
  static const double ringArcWidth = 4.2;
  static const Color ringOnPaper = Palette.ink;
  static const Color ringBaseOnPaper = Color.fromRGBO(26, 23, 21, 0.3);
  static const Color ringOnDark = Color.fromRGBO(239, 230, 214, 0.9);
  static const Color ringBaseOnDark = Color.fromRGBO(239, 230, 214, 0.3);
}
