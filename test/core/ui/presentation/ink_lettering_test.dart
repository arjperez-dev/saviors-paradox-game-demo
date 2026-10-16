import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';

void main() {
  group('InkLettering', () {
    test("each lettering role has the sandbox's size", () {
      // 06-ui/sandbox/sandbox.html pmFooter, ttMain, keyCap, ttConfirm.
      expect(InkLettering.button.size, 30);
      expect(InkLettering.buttonFaint.size, 30);
      expect(InkLettering.hint.size, 24);
      expect(InkLettering.keyCap.size, 20);
      expect(InkLettering.question.size, 42);
      expect(InkLettering.questionNote.size, 28);
    });

    test('each lettering role has its ink', () {
      // 06-ui/sandbox/sandbox.html ttMain, pmFooter, ttConfirm.
      expect(InkLettering.button.colour, Palette.ink);
      expect(InkLettering.keyCap.colour, Palette.ink);
      expect(InkLettering.question.colour, Palette.ink);
      expect(
        InkLettering.buttonFaint.colour,
        const Color.fromRGBO(26, 23, 21, 0.45),
      );
      expect(InkLettering.hint.colour, const Color.fromRGBO(26, 23, 21, 0.7));
      expect(
        InkLettering.questionNote.colour,
        const Color.fromRGBO(26, 23, 21, 0.8),
      );
    });
  });
}
