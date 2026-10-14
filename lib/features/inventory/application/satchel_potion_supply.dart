// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/potion_supply.dart';

final class SatchelPotionSupply implements PotionSupply {
  @override
  bool get hasPotion => false;

  @override
  double get healing => 0;

  @override
  Seconds get drinkTime => Seconds.zero;
}
