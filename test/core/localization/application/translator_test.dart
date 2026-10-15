import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/language.dart';
import 'package:saviors_paradox/core/contracts/state/settings_state.dart';
import 'package:saviors_paradox/core/localization/application/translator.dart';
import 'package:saviors_paradox/core/localization/domain/localized_text.dart';
import 'package:saviors_paradox/core/localization/domain/text_catalog.dart';
import 'package:saviors_paradox/core/localization/domain/text_key.dart';

SettingsState _settingsIn(Language language) => SettingsState(
  musicVolume: 0,
  soundEffectVolume: 0,
  language: language,
);

void main() {
  group('Translator', () {
    test(
      'translates a key into English when the settings hold English',
      () {
        const key = TextKey('ui.hud.rage');
        // 06-ui/hud/hud.md §6: ui.hud.rage -> Rage {time} / Furia {time}
        final catalog = TextCatalog({
          key: const LocalizedText(
            english: 'Rage {time}',
            spanish: 'Furia {time}',
          ),
        });
        final translator = Translator(
          catalogs: [catalog],
          settings: () => _settingsIn(Language.english),
        );

        expect(translator.text(key), 'Rage {time}');
      },
    );

    test(
      'translates a key into Spanish when the settings hold Spanish',
      () {
        const key = TextKey('ui.hud.rage');
        // 06-ui/hud/hud.md §6: ui.hud.rage -> Rage {time} / Furia {time}
        final catalog = TextCatalog({
          key: const LocalizedText(
            english: 'Rage {time}',
            spanish: 'Furia {time}',
          ),
        });
        final translator = Translator(
          catalogs: [catalog],
          settings: () => _settingsIn(Language.spanish),
        );

        expect(translator.text(key), 'Furia {time}');
      },
    );

    test('follows a change of language in the settings', () {
      const key = TextKey('ui.hud.rage');
      // 06-ui/hud/hud.md §6: ui.hud.rage -> Rage {time} / Furia {time}
      final catalog = TextCatalog({
        key: const LocalizedText(
          english: 'Rage {time}',
          spanish: 'Furia {time}',
        ),
      });
      var language = Language.english;
      final translator = Translator(
        catalogs: [catalog],
        settings: () => _settingsIn(language),
      );

      expect(translator.text(key), 'Rage {time}');
      expect(translator.language, Language.english);

      language = Language.spanish;

      expect(translator.text(key), 'Furia {time}');
      expect(translator.language, Language.spanish);
    });

    test('fills each placeholder with its value', () {
      const key = TextKey('ui.hud.health');
      // 06-ui/hud/hud.md §6: ui.hud.health -> {hp}/{max} / {hp}/{max}
      final catalog = TextCatalog({
        key: const LocalizedText(english: '{hp}/{max}', spanish: '{hp}/{max}'),
      });
      final translator = Translator(
        catalogs: [catalog],
        settings: () => _settingsIn(Language.english),
      );

      expect(
        translator.format(key, {'hp': '30', 'max': '100'}),
        '30/100',
      );
    });

    test('translates the keys of every catalog it was given', () {
      const rage = TextKey('ui.hud.rage');
      const health = TextKey('ui.hud.health');
      // 06-ui/hud/hud.md §6: ui.hud.rage -> Rage {time} / Furia {time}
      final rageCatalog = TextCatalog({
        rage: const LocalizedText(
          english: 'Rage {time}',
          spanish: 'Furia {time}',
        ),
      });
      // 06-ui/hud/hud.md §6: ui.hud.health -> {hp}/{max} / {hp}/{max}
      final healthCatalog = TextCatalog({
        health: const LocalizedText(
          english: '{hp}/{max}',
          spanish: '{hp}/{max}',
        ),
      });
      final translator = Translator(
        catalogs: [rageCatalog, healthCatalog],
        settings: () => _settingsIn(Language.english),
      );

      expect(translator.text(rage), 'Rage {time}');
      expect(translator.text(health), '{hp}/{max}');
    });

    test('rejects a key no catalog holds', () {
      final translator = Translator(
        catalogs: [TextCatalog({})],
        settings: () => _settingsIn(Language.english),
      );

      expect(
        () => translator.text(const TextKey('ui.hud.xp')),
        throwsArgumentError,
      );
    });

    test('rejects two catalogs that hold the same key', () {
      const key = TextKey('ui.hud.rage');
      // 06-ui/hud/hud.md §6: ui.hud.rage -> Rage {time} / Furia {time}
      const text = LocalizedText(
        english: 'Rage {time}',
        spanish: 'Furia {time}',
      );
      final first = TextCatalog({key: text});
      final second = TextCatalog({key: text});

      expect(
        () => Translator(
          catalogs: [first, second],
          settings: () => _settingsIn(Language.english),
        ),
        throwsArgumentError,
      );
    });
  });
}
