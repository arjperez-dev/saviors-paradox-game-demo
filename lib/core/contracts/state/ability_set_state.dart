import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';
import 'package:saviors_paradox/core/contracts/state/ability_slot_snapshot.dart';

final class AbilitySetState {
  const AbilitySetState({
    required this.slots,
    required this.offered,
  });

  final List<AbilitySlotSnapshot> slots;
  final List<AbilityId> offered;
}
