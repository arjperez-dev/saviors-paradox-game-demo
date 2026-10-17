import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/features/dungeon/domain/biome_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_builder.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_validator.dart';

/// Builds a playable zone from a kit and a seed (design-patterns.md §10):
/// a layout that fails is rebuilt from the next seed.
final class ZoneFactory {
  const ZoneFactory();

  /// The sandbox's `zoneGen`: at most 600 attempts.
  static const int attempts = 600;

  Result<Zone, ZoneFailure> create(ZoneNumber number, BiomeKit kit, Seed seed) {
    final validator = ZoneValidator(
      fewestRooms: kit.fewestRooms,
      fewestDeadEnds: kit.altarCount + 1,
    );
    for (var attempt = 0; attempt < attempts; attempt++) {
      final layout = const ZoneBuilder().build(kit, Seed(seed.value + attempt));
      if (layout != null && validator.isSatisfiedBy(layout)) {
        return Success(
          Zone.of(number: number, kit: kit, seed: seed, layout: layout),
        );
      }
    }
    return const Failure(ZoneFailure.noAttemptFits);
  }
}
