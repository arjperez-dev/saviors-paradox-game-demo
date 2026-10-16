import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/rendering/presentation/lettering.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';

void main() {
  group('Lettering', () {
    test('the lettering is Patrick Hand', () {
      expect(Lettering.family, 'Patrick Hand'); // strokes.md §3
    });

    test('a lettering style carries the family, size and colour', () {
      final style = Lettering.style(size: 40, color: Palette.ink);

      expect(style.fontFamily, 'Patrick Hand');
      expect(style.fontSize, 40);
      expect(style.color, Palette.ink);
    });
  });
}
