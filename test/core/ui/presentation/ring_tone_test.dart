import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/ring_tone.dart';

void main() {
  group('RingTone', () {
    test('each tone carries its arc and its circle', () {
      // 01-story/cinematics/sandbox/sandbox.html skipOverlay.
      expect(RingTone.onPaper.arc, Palette.ink);
      expect(RingTone.onPaper.base, const Color.fromRGBO(26, 23, 21, 0.3));
      expect(
        RingTone.onDark.arc,
        const Color.fromRGBO(239, 230, 214, 0.9),
      );
      expect(
        RingTone.onDark.base,
        const Color.fromRGBO(239, 230, 214, 0.3),
      );
    });
  });
}
