import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_world.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_control.dart';
import 'package:saviors_paradox/features/combat/application/ports/engagement_repository.dart';
import 'package:saviors_paradox/features/combat/application/ports/flights_repository.dart';
import 'package:saviors_paradox/features/combat/application/ports/status_effects_repository.dart';

class MockCombatant extends Mock implements Combatant {}

class MockEventSink extends Mock implements EventSink {}

class MockCollisionWorld extends Mock implements CollisionWorld {}

class MockStatusEffectControl extends Mock implements StatusEffectControl {}

class MockEngagementRepository extends Mock implements EngagementRepository {}

class MockStatusEffectsRepository extends Mock
    implements StatusEffectsRepository {}

class MockFlightsRepository extends Mock implements FlightsRepository {}
