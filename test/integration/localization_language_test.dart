import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/language.dart';
import 'package:saviors_paradox/core/contracts/state/settings_state.dart';
import 'package:saviors_paradox/core/localization/application/translator.dart';
import 'package:saviors_paradox/core/localization/domain/callout_texts.dart';
import 'package:saviors_paradox/core/localization/domain/localized_text.dart';
import 'package:saviors_paradox/core/localization/domain/text_catalog.dart';
import 'package:saviors_paradox/core/localization/domain/text_key.dart';

SettingsState _settingsIn(Language language) => SettingsState(
  musicVolume: 0,
  soundEffectVolume: 0,
  language: language,
);

void main() {
  group('localization', () {
    test('a callout reads in the language the settings hold', () {
      var language = Language.english;
      final translator = Translator(
        catalogs: [calloutTexts],
        settings: () => _settingsIn(language),
      );

      // 02-art-direction/fx/callouts/callouts.md §1: callout.counter -> COUNTER! / ¡CONTRA!
      expect(translator.text(CalloutKeys.counter), 'COUNTER!');

      language = Language.spanish;

      expect(translator.text(CalloutKeys.counter), '¡CONTRA!');
    });

    test(
      "a feature's texts and the callouts translate side by side",
      () {
        const rage = TextKey('ui.hud.rage');
        // 06-ui/hud/hud.md §6: ui.hud.rage -> Rage {time} / Furia {time}
        final hudTexts = TextCatalog({
          rage: const LocalizedText(
            english: 'Rage {time}',
            spanish: 'Furia {time}',
          ),
        });
        final translator = Translator(
          catalogs: [calloutTexts, hudTexts],
          settings: () => _settingsIn(Language.spanish),
        );

        expect(translator.format(rage, {'time': '0:12'}), 'Furia 0:12');
        // 02-art-direction/fx/callouts/callouts.md §1: callout.reflect -> WHOOSH! / ¡FIUU!
        expect(translator.text(CalloutKeys.reflect), '¡FIUU!');
      },
    );
  });
}
