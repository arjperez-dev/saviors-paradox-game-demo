import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';

/// The sounds of what combat resolves (07-audio/sfx/sfx.md).
final class CombatSounds {
  const CombatSounds();

  static const SoundEffectId perfectBlock = SoundEffectId('sfx.shield.just');
  static const SoundEffectId reflect = SoundEffectId('sfx.fx.reflect');

  SoundEffectId block(ShieldId shield) => switch (shield) {
    ShieldId.sacred => const SoundEffectId('sfx.shield.sacred'),
    ShieldId.ice => const SoundEffectId('sfx.shield.ice'),
    ShieldId.fire => const SoundEffectId('sfx.shield.fire'),
  };

  SoundEffectId? affliction(StatusEffectKind kind) => switch (kind) {
    StatusEffectKind.frozen => const SoundEffectId('sfx.fx.freeze'),
    StatusEffectKind.burning => const SoundEffectId('sfx.fx.burn'),
    StatusEffectKind.levitating ||
    StatusEffectKind.slowed ||
    StatusEffectKind.poisoned ||
    StatusEffectKind.stunned ||
    StatusEffectKind.held ||
    StatusEffectKind.pushed => null,
  };

  SoundEffectId? impact(Element element) => switch (element) {
    Element.plain => null,
    Element.fire => const SoundEffectId('sfx.fire.impact'),
    Element.ice => const SoundEffectId('sfx.ice.impact'),
  };
}
