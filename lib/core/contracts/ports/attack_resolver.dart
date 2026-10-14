import 'package:saviors_paradox/core/contracts/ports/attack.dart';
import 'package:saviors_paradox/core/contracts/ports/projectile.dart';

abstract interface class AttackResolver {
  void strike(Attack attack);

  void launch(Projectile projectile);
}
