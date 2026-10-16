import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/ui/presentation/hold_ring.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/ring_tone.dart';

// A Paint's strokeWidth round-trips through a single-precision buffer, so
// the width recorded on paint is compared at the same precision.
double _single(double value) => (Float32List(1)..[0] = value).first;

void main() {
  group('HoldRing', () {
    Widget harness(Widget child) => Directionality(
      textDirection: TextDirection.ltr,
      child: InkTheme(
        child: Align(alignment: Alignment.topLeft, child: child),
      ),
    );

    Future<void> setView(WidgetTester tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1920, 1080);
      addTearDown(tester.view.reset);
    }

    testWidgets('the ring is 48 hu across', (tester) async {
      await setView(tester);

      await tester.pumpWidget(
        harness(const HoldRing(fraction: 0.25, seed: Seed(2))),
      );

      // skipOverlay: r = 24, so the ring is 48 across.
      expect(tester.getSize(find.byType(HoldRing)), const Size(48, 48));
    });

    testWidgets(
      'a quarter hold fills a quarter of the ring from the top',
      (tester) async {
        await setView(tester);

        await tester.pumpWidget(
          harness(const HoldRing(fraction: 0.25, seed: Seed(2))),
        );

        // 01-story/cinematics/sandbox/sandbox.html skipOverlay.
        expect(
          find.byType(HoldRing),
          paints
            ..path(
              color: const Color.fromRGBO(26, 23, 21, 0.3),
              strokeWidth: _single(1.4),
            )
            ..arc(
              rect: Rect.fromCircle(
                center: const Offset(HoldRing.radius, HoldRing.radius),
                radius: HoldRing.radius,
              ),
              startAngle: -math.pi / 2,
              sweepAngle: math.pi / 2,
              color: Palette.ink,
              strokeWidth: _single(4.2),
              strokeCap: StrokeCap.round,
            ),
        );
      },
    );

    testWidgets('a full hold closes the ring', (tester) async {
      await setView(tester);

      await tester.pumpWidget(
        harness(const HoldRing(fraction: 1, seed: Seed(2))),
      );

      expect(
        find.byType(HoldRing),
        paints..arc(startAngle: -math.pi / 2, sweepAngle: 2 * math.pi),
      );
    });

    testWidgets('an empty hold draws no arc', (tester) async {
      await setView(tester);

      await tester.pumpWidget(
        harness(const HoldRing(fraction: 0, seed: Seed(2))),
      );

      expect(
        find.byType(HoldRing),
        paints..path(
          color: const Color.fromRGBO(26, 23, 21, 0.3),
          strokeWidth: _single(1.4),
        ),
      );
      expect(find.byType(HoldRing), paintsExactlyCountTimes(#drawArc, 0));
    });

    testWidgets('on a dark picture the ring is light', (tester) async {
      await setView(tester);

      await tester.pumpWidget(
        harness(
          const HoldRing(
            fraction: 0.25,
            seed: Seed(2),
            tone: RingTone.onDark,
          ),
        ),
      );

      expect(
        find.byType(HoldRing),
        paints
          ..path(
            color: const Color.fromRGBO(239, 230, 214, 0.3),
            strokeWidth: _single(1.4),
          )
          ..arc(
            color: const Color.fromRGBO(239, 230, 214, 0.9),
            strokeWidth: _single(4.2),
            strokeCap: StrokeCap.round,
          ),
      );
    });

    testWidgets(
      'the same seed across a fraction change keeps filling from the top',
      (tester) async {
        await setView(tester);
        const seed = Seed(2);

        await tester.pumpWidget(
          harness(const HoldRing(fraction: 0.1, seed: seed)),
        );
        await tester.pumpWidget(
          harness(const HoldRing(fraction: 0.6, seed: seed)),
        );

        expect(
          find.byType(HoldRing),
          paints..arc(
            startAngle: -math.pi / 2,
            sweepAngle: 0.6 * 2 * math.pi,
          ),
        );
      },
    );

    testWidgets('a new seed on update still draws the ring', (tester) async {
      await setView(tester);

      await tester.pumpWidget(
        harness(const HoldRing(fraction: 0.25, seed: Seed(2))),
      );
      await tester.pumpWidget(
        harness(const HoldRing(fraction: 0.25, seed: Seed(9))),
      );

      expect(
        find.byType(HoldRing),
        paints
          ..path(
            color: const Color.fromRGBO(26, 23, 21, 0.3),
            strokeWidth: _single(1.4),
          )
          ..arc(
            startAngle: -math.pi / 2,
            sweepAngle: math.pi / 2,
            color: Palette.ink,
            strokeWidth: _single(4.2),
          ),
      );
    });

    test('a fraction outside the hold is refused', () {
      expect(
        () => HoldRing(fraction: 1.5, seed: const Seed(2)),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
