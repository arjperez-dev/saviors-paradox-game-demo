import 'package:saviors_paradox/core/contracts/kernel/seed.dart';

abstract interface class RunStarter {
  void startNew(int slot, Seed seed);
}
