import 'package:saviors_paradox/core/localization/domain/localized_text.dart';
import 'package:saviors_paradox/core/localization/domain/text_catalog.dart';
import 'package:saviors_paradox/core/localization/domain/text_key.dart';

/// The keys of the closed list of callouts
/// (02-art-direction/fx/callouts/callouts.md §1).
abstract final class CalloutKeys {
  static const TextKey slash = TextKey('callout.slash');
  static const TextKey thud = TextKey('callout.thud');
  static const TextKey chain = TextKey('callout.chain');
  static const TextKey clack = TextKey('callout.clack');
  static const TextKey clang = TextKey('callout.clang');
  static const TextKey crish = TextKey('callout.crish');
  static const TextKey fwoom = TextKey('callout.fwoom');
  static const TextKey crack = TextKey('callout.crack');
  static const TextKey burn = TextKey('callout.burn');
  static const TextKey frost = TextKey('callout.frost');
  static const TextKey counter = TextKey('callout.counter');
  static const TextKey reflect = TextKey('callout.reflect');
}

/// The callouts' texts, each the sound in its own language
/// (02-art-direction/fx/callouts/callouts.md §1).
final TextCatalog calloutTexts = TextCatalog({
  CalloutKeys.slash: const LocalizedText(english: 'SLASH!', spanish: '¡ZAS!'),
  CalloutKeys.thud: const LocalizedText(english: 'THUD!', spanish: '¡PUM!'),
  CalloutKeys.chain: const LocalizedText(
    english: 'CHAIN!',
    spanish: '¡CADENA!',
  ),
  CalloutKeys.clack: const LocalizedText(english: 'CLACK!', spanish: '¡CLAC!'),
  CalloutKeys.clang: const LocalizedText(english: 'CLANG!', spanish: '¡CLANG!'),
  CalloutKeys.crish: const LocalizedText(english: 'CRISH!', spanish: '¡CRIS!'),
  CalloutKeys.fwoom: const LocalizedText(english: 'FWOOM!', spanish: '¡FUUM!'),
  CalloutKeys.crack: const LocalizedText(english: 'CRACK!', spanish: '¡CRAC!'),
  CalloutKeys.burn: const LocalizedText(english: 'FWAAH!', spanish: '¡FUAAH!'),
  CalloutKeys.frost: const LocalizedText(english: 'BRRR!', spanish: '¡BRRR!'),
  CalloutKeys.counter: const LocalizedText(
    english: 'COUNTER!',
    spanish: '¡CONTRA!',
  ),
  CalloutKeys.reflect: const LocalizedText(
    english: 'WHOOSH!',
    spanish: '¡FIUU!',
  ),
});
