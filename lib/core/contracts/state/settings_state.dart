import 'package:saviors_paradox/core/contracts/kernel/language.dart';

final class SettingsState {
  const SettingsState({
    required this.musicVolume,
    required this.soundEffectVolume,
    required this.language,
  });

  final int musicVolume;
  final int soundEffectVolume;
  final Language language;
}
