import 'package:saviors_paradox/core/contracts/kernel/language.dart';

/// One text in both languages; neither is a translation of the other
/// (02-art-direction/fx/callouts/callouts.md).
final class LocalizedText {
  const LocalizedText({required this.english, required this.spanish});

  final String english;
  final String spanish;

  String inLanguage(Language language) => switch (language) {
    Language.english => english,
    Language.spanish => spanish,
  };

  @override
  bool operator ==(Object other) =>
      other is LocalizedText &&
      other.english == english &&
      other.spanish == spanish;

  @override
  int get hashCode => Object.hash(english, spanish);
}
