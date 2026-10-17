import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/status_effects.dart';
import 'package:saviors_paradox/features/combat/infrastructure/in_memory_status_effects_repository.dart';

void main() {
  group('InMemoryStatusEffectsRepository', () {
    test('loads the effects it was given', () {
      final effects = StatusEffects();
      final repository = InMemoryStatusEffectsRepository(effects);

      expect(repository.load(), same(effects));
    });

    test('loads what was saved last', () {
      final repository = InMemoryStatusEffectsRepository(StatusEffects());
      final other = StatusEffects();

      repository.save(other);

      expect(repository.load(), same(other));
    });

    test('starts with no effects', () {
      final repository = InMemoryStatusEffectsRepository();

      expect(
        repository.load().has(const EntityId(1), StatusEffectKind.frozen),
        isFalse,
      );
    });
  });
}
