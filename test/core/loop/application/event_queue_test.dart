import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/pause_closed.dart';
import 'package:saviors_paradox/core/contracts/events/pause_opened.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';

void main() {
  group('EventQueue', () {
    late EventQueue queue;

    setUp(() => queue = EventQueue());

    test('delivers nothing until deliver is called', () {
      var calls = 0;
      queue.subscribe<PauseOpened>((event) => calls++);
      queue.publish(const PauseOpened());

      expect(calls, 0);

      queue.deliver();

      expect(calls, 1);
    });

    test('delivers events in the order they were published', () {
      final received = <GameEvent>[];
      queue.subscribe<GameEvent>(received.add);

      queue.publish(const PauseOpened());
      queue.publish(const HitstopStarted(duration: Seconds(0.1)));
      queue.publish(const PauseClosed());
      queue.deliver();

      expect(received, const [
        PauseOpened(),
        HitstopStarted(duration: Seconds(0.1)),
        PauseClosed(),
      ]);
    });

    test('delivers an event only to the handlers of its type', () {
      var openedCalls = 0;
      var closedCalls = 0;
      queue.subscribe<PauseOpened>((event) => openedCalls++);
      queue.subscribe<PauseClosed>((event) => closedCalls++);

      queue.publish(const PauseOpened());
      queue.deliver();

      expect(openedCalls, 1);
      expect(closedCalls, 0);
    });

    test('delivers an event to the handlers of its supertype', () {
      GameEvent? received;
      queue.subscribe<GameEvent>((event) => received = event);

      queue.publish(const HitstopStarted(duration: Seconds(0.1)));
      queue.deliver();

      expect(received, const HitstopStarted(duration: Seconds(0.1)));
    });

    test('calls the handlers of one event in the order they subscribed', () {
      final order = <int>[];
      queue.subscribe<PauseOpened>((event) => order.add(1));
      queue.subscribe<PauseOpened>((event) => order.add(2));
      queue.subscribe<PauseOpened>((event) => order.add(3));

      queue.publish(const PauseOpened());
      queue.deliver();

      expect(order, [1, 2, 3]);
    });

    test(
      'holds an event published while delivering until the next delivery',
      () {
        var closedCalls = 0;
        queue.subscribe<PauseOpened>(
          (event) => queue.publish(const PauseClosed()),
        );
        queue.subscribe<PauseClosed>((event) => closedCalls++);
        queue.publish(const PauseOpened());

        queue.deliver();

        expect(closedCalls, 0);

        queue.deliver();

        expect(closedCalls, 1);
      },
    );

    test('delivers each event once', () {
      var calls = 0;
      queue.subscribe<PauseOpened>((event) => calls++);
      queue.publish(const PauseOpened());

      queue.deliver();
      queue.deliver();

      expect(calls, 1);
    });
  });
}
