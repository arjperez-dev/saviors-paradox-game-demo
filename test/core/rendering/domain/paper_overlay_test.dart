import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/paper_overlay.dart';

void main() {
  group('PaperOverlay', () {
    test("scatters 22 stains over the sandbox's view", () {
      final overlay = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );

      expect(overlay.stainCount, 22);
    });

    test("scatters 14000 specks over the sandbox's view", () {
      final overlay = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );

      expect(overlay.speckCount, 14000);
    });

    test('keeps the density on a view of another size', () {
      final overlay = PaperOverlay.scatter(
        size: const Vec2(1066.6667, 600),
        seed: const Seed(99),
      );

      expect(overlay.stainCount, 20);
      expect(overlay.speckCount, 12444);
    });

    test(
      'gives each stain a radius of 40 to 180 and an alpha of 0.04 to 0.09',
      () {
        // 02-art-direction/palette/palette.md §1 `stain`: radius 40–180,
        // alpha 0.04–0.09.
        final overlay = PaperOverlay.scatter(
          size: const Vec2(1200, 600),
          seed: const Seed(99),
        );

        for (var i = 0; i < overlay.stainCount; i++) {
          final radius = overlay.stains[i * 4 + 2];
          final alpha = overlay.stains[i * 4 + 3];
          expect(radius, greaterThanOrEqualTo(40));
          expect(radius, lessThan(180));
          expect(alpha, greaterThanOrEqualTo(0.04));
          expect(alpha, lessThan(0.09));
        }
      },
    );

    test('gives each speck a size up to 2 and an alpha up to 0.09', () {
      // 02-art-direction/palette/palette.md §1 `grain`: size 0–2,
      // red 60–110, green 50–90, alpha 0–0.09.
      final overlay = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );

      for (var i = 0; i < overlay.speckCount; i++) {
        final width = overlay.grain[i * 7 + 2];
        final height = overlay.grain[i * 7 + 3];
        final red = overlay.grain[i * 7 + 4];
        final green = overlay.grain[i * 7 + 5];
        final alpha = overlay.grain[i * 7 + 6];
        expect(width, lessThan(2));
        expect(height, lessThan(2));
        expect(red, greaterThanOrEqualTo(60));
        expect(red, lessThan(110));
        expect(green, greaterThanOrEqualTo(50));
        expect(green, lessThan(90));
        expect(alpha, lessThan(0.09));
      }
    });

    test('centres the vignette 20 su below the middle of the view', () {
      final overlay = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );

      expect(overlay.vignetteCentre, const Vec2(600, 320));
    });

    test('scatters the same paper from the same seed', () {
      final first = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );
      final second = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );

      expect(first.stains, second.stains);
      expect(first.grain, second.grain);
    });

    test('scatters different paper from a different seed', () {
      final first = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(99),
      );
      final second = PaperOverlay.scatter(
        size: const Vec2(1200, 600),
        seed: const Seed(100),
      );

      expect(first.stains, isNot(second.stains));
      expect(first.grain, isNot(second.grain));
    });
  });
}
