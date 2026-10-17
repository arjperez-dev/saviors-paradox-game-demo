import 'package:saviors_paradox/features/combat/domain/status_effects.dart';

/// Where the status effects of every body are kept.
abstract interface class StatusEffectsRepository {
  /// The status effects, whole.
  StatusEffects load();

  /// Keeps [effects] as the status effects of every body.
  void save(StatusEffects effects);
}
