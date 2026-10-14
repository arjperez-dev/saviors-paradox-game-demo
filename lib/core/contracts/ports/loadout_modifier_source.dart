import 'package:saviors_paradox/core/contracts/ports/loadout_modifier.dart';

abstract interface class LoadoutModifierSource {
  Iterable<LoadoutModifier> get modifiers;

  int get revision;
}
