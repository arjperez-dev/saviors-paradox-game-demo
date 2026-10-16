import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/rendering/presentation/lettering.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';

const _fontAsset = 'assets/fonts/Patrick_Hand/PatrickHand-Regular.ttf';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('the bundled lettering', () {
    test(
      'the bundled Patrick Hand font loads from the asset bundle',
      () async {
        final bytes = await rootBundle.load(_fontAsset);

        expect(bytes.lengthInBytes, 212112);
      },
    );

    test('text in the lettering lays out in Patrick Hand', () async {
      final fontLoader = FontLoader(Lettering.family)
        ..addFont(rootBundle.load(_fontAsset));
      await fontLoader.load();

      final painter = TextPainter(
        text: TextSpan(
          text: 'Akeris',
          style: Lettering.style(size: 40, color: Palette.ink),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // 02-art-direction/strokes/strokes.md §3: Patrick Hand, not the test
      // font's 240 for six glyphs at size 40.
      expect(painter.width, isNot(240));
    });

    test("the font's license ships with it", () async {
      final license = await rootBundle.loadString(
        'assets/fonts/Patrick_Hand/OFL.txt',
      );

      expect(license, contains('SIL OPEN FONT LICENSE'));
    });
  });
}
