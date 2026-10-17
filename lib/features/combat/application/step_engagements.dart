import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/features/combat/application/ports/engagement_repository.dart';
import 'package:saviors_paradox/features/combat/application/report_exchange.dart';

/// Resolves the engagements struck since the last step, oldest first.
final class StepEngagements {
  StepEngagements(this._engagements, this._report);

  final EngagementRepository _engagements;
  final ReportExchange _report;

  void step(Seconds dt) {
    for (
      var engagement = _engagements.next();
      engagement != null;
      engagement = _engagements.next()
    ) {
      final resolved = engagement.resolve();
      if (resolved != null) {
        _report.engagement(resolved);
      }
    }
  }
}
