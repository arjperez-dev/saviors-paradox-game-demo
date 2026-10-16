import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';

/// A button's paper and lettering: plain, or faint when it cannot act and
/// only says why (06-ui/title/title.md §4; the 06-ui sandbox's `ttMain`).
enum ButtonLook {
  plain(FrameLook.paper, InkLettering.button),
  faint(FrameLook.faint, InkLettering.buttonFaint);

  const ButtonLook(this.frame, this.lettering);

  final FrameLook frame;
  final InkLettering lettering;
}
