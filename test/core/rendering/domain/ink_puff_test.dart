import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_puff.dart';
import 'package:saviors_paradox/core/rendering/domain/puff_shape.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('InkPuff', () {
    late PuffShape shape;
    late InkPuff puff;

    setUp(() {
      shape = PuffShape.generate(StrokeRandom(const Seed(1)));
      puff = InkPuff();
    });

    test('grows from its radius to 2.3 times it over its life', () {
      puff.launch(Vec2.zero, shape);
      expect(puff.growth, 1);

      puff.step(shape.life);

      expect(puff.growth, closeTo(2.3, 1e-9));
    });

    test('rises by its velocity in its first step', () {
      puff.launch(Vec2.zero, shape);

      puff.step(const Seconds(0.1));

      expect(puff.position.x, closeTo(shape.velocity.x * 0.1, 1e-9));
      expect(puff.position.y, closeTo(shape.velocity.y * 0.1, 1e-9));
    });

    test('slows its rise at 3/s and its drift at 4/s', () {
      puff.launch(Vec2.zero, shape);
      puff.step(const Seconds(0.1));
      final afterFirst = puff.position;

      puff.step(const Seconds(0.1));

      final expectedX = afterFirst.x + shape.velocity.x * 0.1 * math.exp(-0.4);
      final expectedY = afterFirst.y + shape.velocity.y * 0.1 * math.exp(-0.3);
      expect(puff.position.x, closeTo(expectedX, 1e-9));
      expect(puff.position.y, closeTo(expectedY, 1e-9));
    });

    test('is spent once its life is over', () {
      puff.launch(Vec2.zero, shape);
      expect(puff.isSpent, isFalse);

      final step = Seconds(shape.life.value / 3);
      puff.step(step);
      puff.step(step);
      puff.step(step);

      expect(puff.isSpent, isTrue);
    });

    test('forgets its shape when reset', () {
      puff.launch(const Vec2(5, 5), shape);

      puff.reset();

      expect(puff.shape, isNull);
      expect(puff.position, Vec2.zero);
    });
  });
}
