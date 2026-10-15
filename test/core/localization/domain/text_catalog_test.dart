import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/localization/domain/localized_text.dart';
import 'package:saviors_paradox/core/localization/domain/text_catalog.dart';
import 'package:saviors_paradox/core/localization/domain/text_key.dart';

void main() {
  group('TextCatalog', () {
    test('finds the text it holds for a key', () {
      const key = TextKey('ui.hud.rage');
      const text = LocalizedText(
        english: 'Rage {time}',
        spanish: 'Furia {time}',
      );
      final catalog = TextCatalog({key: text});

      expect(catalog[key], text);
    });

    test('answers null for a key it does not hold', () {
      const key = TextKey('ui.hud.rage');
      const text = LocalizedText(
        english: 'Rage {time}',
        spanish: 'Furia {time}',
      );
      final catalog = TextCatalog({key: text});

      expect(catalog[const TextKey('ui.hud.xp')], isNull);
    });

    test('lists every text it holds', () {
      const rage = TextKey('ui.hud.rage');
      const rageText = LocalizedText(
        english: 'Rage {time}',
        spanish: 'Furia {time}',
      );
      const xp = TextKey('ui.hud.xp');
      const xpText = LocalizedText(
        english: 'XP {amount}',
        spanish: 'EXP {amount}',
      );
      final catalog = TextCatalog({rage: rageText, xp: xpText});

      expect(
        Map.fromEntries(catalog.entries),
        {rage: rageText, xp: xpText},
      );
    });

    test('keeps its texts when the map it was built from changes', () {
      const key = TextKey('ui.hud.rage');
      const text = LocalizedText(
        english: 'Rage {time}',
        spanish: 'Furia {time}',
      );
      final source = {key: text};
      final catalog = TextCatalog(source);

      source[const TextKey('ui.hud.xp')] = const LocalizedText(
        english: 'XP {amount}',
        spanish: 'EXP {amount}',
      );

      expect(Map.fromEntries(catalog.entries), {key: text});
    });
  });
}
