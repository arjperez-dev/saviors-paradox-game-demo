// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/language.dart';
import 'package:saviors_paradox/core/contracts/state/settings_state.dart';

final class CurrentSettings {
  SettingsState get state => const SettingsState(
    musicVolume: 0,
    soundEffectVolume: 0,
    language: Language.english,
  );
}
