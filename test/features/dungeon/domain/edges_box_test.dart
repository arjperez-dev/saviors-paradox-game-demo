import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';

void main() {
  group('edgesBox', () {
    test('a box between its edges has their centre and half sizes', () {
      final box = edgesBox(100, 200, 300, 260);

      expect(
        box,
        const WorldBox(centre: Vec2(200, 230), halfWidth: 100, halfHeight: 30),
      );
    });
  });
}
