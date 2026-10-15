import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/line_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/quadratic_pass.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';

void main() {
  group('Pencil', () {
    test('colours a pass by its alpha', () {
      const pass = QuadraticPass(
        start: Vec2(0, 0),
        control: Vec2(50, 0),
        end: Vec2(100, 0),
        width: 1,
        alpha: 0.3,
      );

      final colour = Pencil.passColor(const Color(0xFF112233), pass);

      expect(colour.a, closeTo(0.3, 1e-3));
    });

    test('keeps an opaque pass opaque', () {
      const pass = QuadraticPass(
        start: Vec2(0, 0),
        control: Vec2(50, 0),
        end: Vec2(100, 0),
        width: 1,
        alpha: 1,
      );

      final colour = Pencil.passColor(const Color(0xFF112233), pass);

      expect(colour.a, 1);
    });

    test('draws a line into a picture', () {
      final emptyRecorder = PictureRecorder();
      Canvas(emptyRecorder);
      final empty = emptyRecorder.endRecording();
      final stroke = LineStroke.generate(
        const Vec2(0, 0),
        const Vec2(100, 0),
        width: 2.9,
        random: StrokeRandom(const Seed(1)),
      );
      final recorder = PictureRecorder();

      Pencil().line(
        Canvas(recorder),
        stroke,
        const Color(0xFF112233),
      );
      final picture = recorder.endRecording();

      expect(
        picture.approximateBytesUsed,
        greaterThan(empty.approximateBytesUsed),
      );
    });

    test('restores the canvas after a clip it was asked to save', () {
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      final before = canvas.getSaveCount();

      Pencil().clipToPolygon(canvas, const [
        Vec2(0, 0),
        Vec2(10, 0),
        Vec2(10, 10),
      ]);
      canvas.restore();

      expect(canvas.getSaveCount(), before);
    });
  });
}
