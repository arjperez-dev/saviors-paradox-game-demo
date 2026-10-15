import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_dissolve.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_puff.dart';
import 'package:saviors_paradox/core/rendering/domain/pool.dart';
import 'package:saviors_paradox/core/rendering/presentation/ink_dissolve_painter.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';

void main() {
  group('InkDissolvePainter', () {
    InkDissolve buildDissolve() => InkDissolve.prepare(
      seed: const Seed(6600),
      puffs: Pool<InkPuff>(size: 30, create: InkPuff.new),
    )..start(Vec2.zero);

    test('fades a puff from 0.85 to nothing', () {
      expect(InkDissolvePainter.puffAlpha(0), 0.85);
      expect(InkDissolvePainter.puffAlpha(1), 0);
      expect(InkDissolvePainter.puffAlpha(0.5), closeTo(0.425, 1e-9));
    });

    test('draws the body once a frame while it dissolves', () {
      final canvas = Canvas(PictureRecorder());
      final dissolve = buildDissolve();
      var calls = 0;

      InkDissolvePainter(Pencil()).paintBody(
        canvas,
        dissolve,
        (canvas) => calls++,
      );

      expect(calls, 1);
    });

    test('paints the puffs of a dissolve in flight', () {
      final dissolve = buildDissolve();
      final painter = InkDissolvePainter(Pencil());

      final beforeRecorder = PictureRecorder();
      painter.paintPuffs(Canvas(beforeRecorder), dissolve);
      final before = beforeRecorder.endRecording();

      for (var i = 0; i < 40; i++) {
        dissolve.step(const Seconds(1 / 60));
      }

      final afterRecorder = PictureRecorder();
      painter.paintPuffs(Canvas(afterRecorder), dissolve);
      final after = afterRecorder.endRecording();

      expect(
        after.approximateBytesUsed,
        greaterThan(before.approximateBytesUsed),
      );
    });

    test('leaves the canvas as it found it', () {
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      final before = canvas.getSaveCount();
      final dissolve = buildDissolve();
      for (var i = 0; i < 40; i++) {
        dissolve.step(const Seconds(1 / 60));
      }
      final painter = InkDissolvePainter(Pencil());

      painter.paintBody(canvas, dissolve, (canvas) {});
      painter.paintPuffs(canvas, dissolve);

      expect(canvas.getSaveCount(), before);
    });
  });
}
