import 'package:saviors_paradox/core/localization/domain/localized_text.dart';
import 'package:saviors_paradox/core/localization/domain/text_key.dart';

/// The texts one part of the game owns, by key.
final class TextCatalog {
  TextCatalog(Map<TextKey, LocalizedText> texts)
    : _texts = Map.unmodifiable(texts);

  final Map<TextKey, LocalizedText> _texts;

  Iterable<MapEntry<TextKey, LocalizedText>> get entries => _texts.entries;

  /// The text of [key], or null when this catalog does not hold it.
  LocalizedText? operator [](TextKey key) => _texts[key];
}
