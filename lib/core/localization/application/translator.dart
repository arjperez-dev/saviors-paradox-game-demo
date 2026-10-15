import 'package:saviors_paradox/core/contracts/kernel/language.dart';
import 'package:saviors_paradox/core/contracts/state/settings_state.dart';
import 'package:saviors_paradox/core/localization/domain/localized_text.dart';
import 'package:saviors_paradox/core/localization/domain/text_catalog.dart';
import 'package:saviors_paradox/core/localization/domain/text_key.dart';

/// Every player-visible string, by key, in the language of the settings
/// (coding-standards.md §8).
final class Translator {
  Translator({
    required List<TextCatalog> catalogs,
    required this._settings,
  }) : _texts = _merge(catalogs);

  final Map<TextKey, LocalizedText> _texts;
  final SettingsState Function() _settings;

  /// The language the settings hold now.
  Language get language => _settings().language;

  /// The text of [key] in the current language.
  String text(TextKey key) => _find(key).inLanguage(language);

  /// The text of [key] with each `{name}` replaced by `values[name]`.
  String format(TextKey key, Map<String, String> values) {
    var result = text(key);
    for (final MapEntry(key: name, :value) in values.entries) {
      result = result.replaceAll('{$name}', value);
    }
    return result;
  }

  LocalizedText _find(TextKey key) =>
      _texts[key] ??
      (throw ArgumentError.value(key.value, 'key', 'has no text'));

  static Map<TextKey, LocalizedText> _merge(List<TextCatalog> catalogs) {
    final merged = <TextKey, LocalizedText>{};
    for (final catalog in catalogs) {
      _addAll(merged, catalog);
    }
    return Map.unmodifiable(merged);
  }

  static void _addAll(
    Map<TextKey, LocalizedText> merged,
    TextCatalog catalog,
  ) {
    for (final MapEntry(:key, :value) in catalog.entries) {
      if (merged.containsKey(key)) {
        throw ArgumentError.value(key.value, 'catalogs', 'repeat a key');
      }
      merged[key] = value;
    }
  }
}
