import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/paper_overlay.dart';
import 'package:saviors_paradox/core/rendering/presentation/paper_overlay_painter.dart';

void main() {
  group('PaperOverlayPainter', () {
    test('colours a stain by its alpha', () {
      final colour = PaperOverlayPainter.stainColor(0.06);

      expect(colour, const Color.fromRGBO(90, 70, 45, 0.06));
    });

    test('colours a speck of grain by its red, green and alpha', () {
      final colour = PaperOverlayPainter.speckColor(60.7, 50.2, 0.05);

      expect(colour, const Color.fromRGBO(60, 50, 40, 0.05));
    });

    test('records the overlay into a picture', () {
      final overlay = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );

      final picture = PaperOverlayPainter().record(overlay);

      expect(picture.approximateBytesUsed, greaterThan(0));
    });
  });
}
