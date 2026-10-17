import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';

/// A defender's raised shield, and how long it has been up.
final class Guard {
  Guard({required this.shield, required this.raisedFor})
    : assert(raisedFor.value >= 0, 'a shield is raised for no negative time');

  final ShieldId shield;
  final Seconds raisedFor;

  @override
  bool operator ==(Object other) =>
      other is Guard && other.shield == shield && other.raisedFor == raisedFor;

  @override
  int get hashCode => Object.hash(shield, raisedFor);
}
