import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/zone_state.dart';

abstract interface class ZoneGenerator {
  ZoneState generate(ZoneNumber zone, Seed seed);
}
