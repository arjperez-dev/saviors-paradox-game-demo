import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';

final class RaisedShield {
  const RaisedShield({
    required this.shield,
    required this.raisedFor,
  });

  final ShieldId shield;
  final Seconds raisedFor;
}
