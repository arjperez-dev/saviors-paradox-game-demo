import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/combat_sounds.dart';

void main() {
  group('CombatSounds', () {
    const sounds = CombatSounds();

    test('each shield blocks with its own sound', () {
      expect(
        sounds.block(ShieldId.sacred),
        equals(const SoundEffectId('sfx.shield.sacred')),
      );
      expect(
        sounds.block(ShieldId.ice),
        equals(const SoundEffectId('sfx.shield.ice')),
      );
      expect(
        sounds.block(ShieldId.fire),
        equals(const SoundEffectId('sfx.shield.fire')),
      );
    });

    test('the just block and the reflect have their sounds', () {
      expect(
        CombatSounds.perfectBlock,
        equals(const SoundEffectId('sfx.shield.just')),
      );
      expect(
        CombatSounds.reflect,
        equals(const SoundEffectId('sfx.fx.reflect')),
      );
    });

    test('only freezing and burning sound', () {
      expect(
        sounds.affliction(StatusEffectKind.frozen),
        equals(const SoundEffectId('sfx.fx.freeze')),
      );
      expect(
        sounds.affliction(StatusEffectKind.burning),
        equals(const SoundEffectId('sfx.fx.burn')),
      );
      expect(sounds.affliction(StatusEffectKind.levitating), isNull);
      expect(sounds.affliction(StatusEffectKind.slowed), isNull);
      expect(sounds.affliction(StatusEffectKind.poisoned), isNull);
      expect(sounds.affliction(StatusEffectKind.stunned), isNull);
      expect(sounds.affliction(StatusEffectKind.held), isNull);
      expect(sounds.affliction(StatusEffectKind.pushed), isNull);
    });

    test('fire and ice impacts sound, plain ones do not', () {
      expect(
        sounds.impact(Element.fire),
        equals(const SoundEffectId('sfx.fire.impact')),
      );
      expect(
        sounds.impact(Element.ice),
        equals(const SoundEffectId('sfx.ice.impact')),
      );
      expect(sounds.impact(Element.plain), isNull);
    });
  });
}
