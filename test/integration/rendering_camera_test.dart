import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/map_closed.dart';
import 'package:saviors_paradox/core/contracts/events/map_opened.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/core/rendering/presentation/follow_camera.dart';

const Seconds _frame = Seconds(1 / 60);
const Vec2 _start = Vec2(1000, 500);
const Vec2 _moved = Vec2(1300, 500);

/// A [FollowCamera] placed on [_start], stepped by a real [GameLoop] whose
/// one world system is its `step`.
({FollowCamera camera, EventSink sink, GameLoop loop}) _placedRig() {
  final camera = FollowCamera()..resize(const ScreenVec2(Vec2(1920, 1080)), 1);
  final queue = EventQueue();
  final loop = GameLoop(
    queue: queue,
    clock: StepClock(),
    systems: [camera.step],
  );
  camera.track(_start, Facing.right);
  loop.advance(_frame);
  return (camera: camera, sink: queue, loop: loop);
}

void _advanceFrames(GameLoop loop, int frames) {
  for (var i = 0; i < frames; i++) {
    loop.advance(_frame);
  }
}

void main() {
  group('the world camera stepped by the real loop', () {
    test('the camera follows its target while the world steps', () {
      final rig = _placedRig();
      final before = rig.camera.toWorld(ScreenVec2.zero).x;

      rig.camera.track(_moved, Facing.right);
      _advanceFrames(rig.loop, 30);

      expect(rig.camera.toWorld(ScreenVec2.zero).x, greaterThan(before));
    });

    test('the camera holds still while the map halts the world', () {
      final rig = _placedRig();
      rig.sink.publish(const MapOpened());
      rig.loop.advance(_frame);
      final before = rig.camera.toWorld(ScreenVec2.zero);

      rig.camera.track(_moved, Facing.right);
      _advanceFrames(rig.loop, 30);

      expect(rig.camera.toWorld(ScreenVec2.zero), before);
    });

    test('the camera follows again once the map closes', () {
      final rig = _placedRig();
      rig.sink.publish(const MapOpened());
      rig.loop.advance(_frame);
      rig.camera.track(_moved, Facing.right);
      _advanceFrames(rig.loop, 30);
      final whileHalted = rig.camera.toWorld(ScreenVec2.zero);

      rig.sink.publish(const MapClosed());
      _advanceFrames(rig.loop, 30);

      final distanceBefore = (_moved.x - whileHalted.x).abs();
      final distanceAfter = (_moved.x - rig.camera.toWorld(ScreenVec2.zero).x)
          .abs();
      expect(distanceAfter, lessThan(distanceBefore));
    });
  });
}
