import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/world_camera.dart';
import 'package:saviors_paradox/core/input/application/input_context.dart';
import 'package:saviors_paradox/core/input/application/input_reading.dart';

class MockInputContext extends Mock implements InputContext {}

class MockInputReading extends Mock implements InputReading {}

class MockEventSink extends Mock implements EventSink {}

class MockWorldCamera extends Mock implements WorldCamera {}
