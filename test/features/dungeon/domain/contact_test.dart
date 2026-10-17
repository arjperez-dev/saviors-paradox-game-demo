import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/contact.dart';

void main() {
  group('Contact', () {
    test('contacts are equal by value and lie on their move', () {
      const a = Contact(
        point: Vec2(100, 30),
        normal: Vec2(0, -1),
        fraction: 0.3,
      );
      const b = Contact(
        point: Vec2(100, 30),
        normal: Vec2(0, -1),
        fraction: 0.3,
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(
        () => Contact(
          point: Vec2.zero,
          normal: const Vec2(0, -1),
          fraction: 1.5,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
