import 'package:saviors_paradox/features/combat/domain/engagement.dart';

/// The engagements struck and not yet resolved.
abstract interface class EngagementRepository {
  /// Keeps [engagement] until it is taken.
  void add(Engagement engagement);

  /// Takes the oldest pending engagement, or null when none waits.
  Engagement? next();
}
