import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/language.dart';
import 'package:saviors_paradox/core/localization/domain/localized_text.dart';

void main() {
  group('LocalizedText', () {
    test('gives its English text in English', () {
      const text = LocalizedText(
        english: 'Rage {time}',
        spanish: 'Furia {time}',
      );

      expect(text.inLanguage(Language.english), 'Rage {time}');
    });

    test('gives its Spanish text in Spanish', () {
      const text = LocalizedText(
        english: 'Rage {time}',
        spanish: 'Furia {time}',
      );

      expect(text.inLanguage(Language.spanish), 'Furia {time}');
    });

    test('equals another text with the same words', () {
      const a = LocalizedText(english: 'Rage {time}', spanish: 'Furia {time}');
      const b = LocalizedText(english: 'Rage {time}', spanish: 'Furia {time}');
      const c = LocalizedText(english: 'Rage {time}', spanish: 'Otra {time}');

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a == c, isFalse);
    });
  });
}
