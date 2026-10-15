import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_dissolve.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_puff.dart';
import 'package:saviors_paradox/core/rendering/domain/pool.dart';

void main() {
  group('InkDissolve', () {
    InkDissolve build({int size = 30}) => InkDissolve.prepare(
      seed: const Seed(6600),
      puffs: Pool<InkPuff>(size: size, create: InkPuff.new),
    );

    test('prepares 30 holes', () {
      final dissolve = build();

      expect(dissolve.holes, hasLength(30));
    });

    test('fills the body with ink up to 0.88 over 0.2 s', () {
      final dissolve = build();
      dissolve.start(Vec2.zero);

      expect(dissolve.inkAlpha, 0);

      for (var i = 0; i < 12; i++) {
        dissolve.step(const Seconds(1 / 60));
      }

      expect(dissolve.inkAlpha, closeTo(0.88, 1e-6));
    });

    test('lets a puff out of each hole as it opens', () {
      final pool = Pool<InkPuff>(size: 30, create: InkPuff.new);
      final dissolve = InkDissolve.prepare(seed: const Seed(6600), puffs: pool);
      dissolve.start(Vec2.zero);

      for (var i = 0; i < 60; i++) {
        dissolve.step(const Seconds(1 / 60));
      }

      expect(pool.activeCount, 30);
      for (var i = 0; i < dissolve.holes.length; i++) {
        expect(dissolve.puffAt(i), isNotNull);
      }
    });

    test('fades the body out by 1.3 s', () {
      final dissolve = build();
      dissolve.start(Vec2.zero);

      for (var i = 0; i < 78; i++) {
        dissolve.step(const Seconds(1 / 60));
      }

      expect(dissolve.bodyAlpha, closeTo(0, 1e-6));
    });

    test('finishes once the last puff has faded', () {
      final pool = Pool<InkPuff>(size: 30, create: InkPuff.new);
      final dissolve = InkDissolve.prepare(seed: const Seed(6600), puffs: pool);
      dissolve.start(Vec2.zero);

      for (var i = 0; i < 78; i++) {
        dissolve.step(const Seconds(1 / 60));
      }
      expect(dissolve.isFinished, isFalse);

      for (var i = 0; i < 120; i++) {
        dissolve.step(const Seconds(1 / 60));
      }

      expect(dissolve.isFinished, isTrue);
      expect(pool.activeCount, 0);
    });

    test('prepares the same holes from the same seed', () {
      final first = build();
      final second = build();

      for (var i = 0; i < first.holes.length; i++) {
        expect(first.holes[i].centre, second.holes[i].centre);
        expect(first.holes[i].radius, second.holes[i].radius);
        expect(first.holes[i].opensAt, second.holes[i].opensAt);
      }
    });

    test('prepares different holes from a different seed', () {
      final first = InkDissolve.prepare(
        seed: const Seed(6600),
        puffs: Pool<InkPuff>(size: 30, create: InkPuff.new),
      );
      final second = InkDissolve.prepare(
        seed: const Seed(6601),
        puffs: Pool<InkPuff>(size: 30, create: InkPuff.new),
      );

      expect(first.holes[0].centre, isNot(second.holes[0].centre));
    });
  });
}
