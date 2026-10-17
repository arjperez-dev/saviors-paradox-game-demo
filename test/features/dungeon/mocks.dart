import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/features/dungeon/application/ports/zone_repository.dart';

class MockZoneRepository extends Mock implements ZoneRepository {}

class MockEventSink extends Mock implements EventSink {}
