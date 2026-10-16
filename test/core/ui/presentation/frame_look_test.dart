import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';

void main() {
  group('FrameLook', () {
    test('each look carries its paper at rest and under the mouse', () {
      // 06-ui/sandbox/sandbox.html ttBox, ttMain, hudBox, keyCap, ttConfirm.
      expect(FrameLook.paper.fill, InkThemeData.paperFill);
      expect(FrameLook.paper.hoveredFill, InkThemeData.paperFillHovered);
      expect(FrameLook.faint.fill, InkThemeData.faintFill);
      expect(FrameLook.faint.hoveredFill, InkThemeData.faintFillHovered);
      expect(FrameLook.dashed.fill, InkThemeData.dashedFill);
      expect(FrameLook.dashed.hoveredFill, InkThemeData.dashedFillHovered);
      expect(FrameLook.keyCap.fill, InkThemeData.keyCapFill);
      expect(FrameLook.keyCap.hoveredFill, InkThemeData.keyCapFill);
      expect(FrameLook.question.fill, InkThemeData.questionFill);
      expect(FrameLook.question.hoveredFill, InkThemeData.questionFill);
    });
  });
}
