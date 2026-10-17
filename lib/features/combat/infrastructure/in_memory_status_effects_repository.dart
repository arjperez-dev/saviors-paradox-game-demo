import 'package:saviors_paradox/features/combat/application/ports/status_effects_repository.dart';
import 'package:saviors_paradox/features/combat/domain/status_effects.dart';

/// The status effects, held in memory for the zone.
final class InMemoryStatusEffectsRepository implements StatusEffectsRepository {
  InMemoryStatusEffectsRepository([StatusEffects? effects])
    : _effects = effects ?? StatusEffects();

  StatusEffects _effects;

  @override
  StatusEffects load() => _effects;

  @override
  void save(StatusEffects effects) => _effects = effects;
}
