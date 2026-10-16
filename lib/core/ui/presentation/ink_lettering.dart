import 'dart:ui';

import 'package:saviors_paradox/core/rendering/presentation/palette.dart';

/// The kit's lettering roles: each a size in hu and a colour, as the 06-ui
/// sandbox letters them (`hudText`, `keyCap`, `pmFooter`, `ttMain`,
/// `ttConfirm`).
enum InkLettering {
  // pmFooter: 30, ink.
  button(30, Palette.ink),
  // a faint button's label: button's own size, ink at .45 (ttMain's own
  // disabled menu text is 34, a separate, larger role this enum does not
  // cover).
  buttonFaint(30, Color.fromRGBO(26, 23, 21, 0.45)),
  // pmFooter, ttSlots, ttSettings: 24, ink at .7.
  hint(24, Color.fromRGBO(26, 23, 21, 0.7)),
  // keyCap: 20, ink.
  keyCap(20, Palette.ink),
  // ttConfirm: the question, 42, ink.
  question(42, Palette.ink),
  // ttConfirm: the note under it, 28, ink at .8.
  questionNote(28, Color.fromRGBO(26, 23, 21, 0.8));

  const InkLettering(this.size, this.colour);

  /// The size, in hu.
  final double size;

  final Color colour;
}
