import 'dart:collection';

import 'package:saviors_paradox/features/combat/application/ports/engagement_repository.dart';
import 'package:saviors_paradox/features/combat/domain/engagement.dart';

/// The pending engagements, held in memory for the zone.
final class InMemoryEngagementRepository implements EngagementRepository {
  final ListQueue<Engagement> _pending = ListQueue<Engagement>();

  @override
  void add(Engagement engagement) => _pending.addLast(engagement);

  @override
  Engagement? next() => _pending.isEmpty ? null : _pending.removeFirst();
}
