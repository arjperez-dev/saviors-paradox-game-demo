import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';

abstract interface class PotionSupply {
  bool get hasPotion;

  double get healing;

  Seconds get drinkTime;
}
