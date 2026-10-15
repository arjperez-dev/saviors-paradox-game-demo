import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/chain_links.dart';

void main() {
  group('ChainLinks', () {
    test('lays one link every 7 su', () {
      final links = ChainLinks(16);

      links.layOut(const Vec2(0, 0), const Vec2(70, 0));

      expect(links.count, 10);
    });

    test('alternates face-on and edge-on links starting face-on', () {
      final links = ChainLinks(16);

      links.layOut(const Vec2(0, 0), const Vec2(70, 0));

      expect(links.isFaceOnAt(0), isTrue);
      expect(links.isFaceOnAt(2), isTrue);
      expect(links.isFaceOnAt(1), isFalse);
      expect(links.isFaceOnAt(3), isFalse);
    });

    test('places each link between two points of its curve', () {
      final links = ChainLinks(16);

      links.layOut(const Vec2(0, 0), const Vec2(70, 0));

      expect(links.xAt(0), closeTo(3.5, 1e-9));
      expect(links.yAt(0), closeTo(0, 1e-9));
      for (var i = 0; i < links.count; i++) {
        expect(links.angleAt(i), closeTo(0, 1e-9));
      }
    });

    test('lays no link on a chain shorter than 5', () {
      final links = ChainLinks(16);

      links.layOut(const Vec2(0, 0), const Vec2(4, 0));

      expect(links.count, 0);
    });

    test('lays at least two links on a short chain', () {
      final links = ChainLinks(16);

      links.layOut(const Vec2(0, 0), const Vec2(6, 0));

      expect(links.count, 2);
    });

    test('sags below the straight line when slack', () {
      final links = ChainLinks(16);

      links.layOut(const Vec2(0, 0), const Vec2(70, 0), tension: 0);

      expect(links.yAt(4), greaterThan(0));
    });

    test('refuses a chain longer than its capacity', () {
      final links = ChainLinks(3);

      expect(
        () => links.layOut(const Vec2(0, 0), const Vec2(70, 0)),
        throwsStateError,
      );
    });

    test('sizes a face-on link as the ellipse strokes.md §1 fixes', () {
      expect(ChainLinks.faceOnRadii, const Vec2(4.6, 2.4));
    });

    test('sizes an edge-on link as the line strokes.md §1 fixes', () {
      expect(ChainLinks.edgeOnHalfLength, 4.4);
    });
  });
}
