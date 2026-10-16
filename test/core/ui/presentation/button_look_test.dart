import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/button_look.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';

void main() {
  group('ButtonLook', () {
    test('each look carries its paper and its lettering', () {
      // 06-ui/sandbox/sandbox.html ttMain.
      expect(ButtonLook.plain.frame, FrameLook.paper);
      expect(ButtonLook.plain.lettering, InkLettering.button);
      expect(ButtonLook.faint.frame, FrameLook.faint);
      expect(ButtonLook.faint.lettering, InkLettering.buttonFaint);
    });
  });
}
