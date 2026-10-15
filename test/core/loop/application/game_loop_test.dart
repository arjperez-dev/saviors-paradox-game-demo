import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/ability_chosen.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/map_closed.dart';
import 'package:saviors_paradox/core/contracts/events/map_opened.dart';
import 'package:saviors_paradox/core/contracts/events/pause_closed.dart';
import 'package:saviors_paradox/core/contracts/events/pause_opened.dart';
import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';

final class _Ping implements GameEvent {
  const _Ping();
}

void main() {
  group('GameLoop', () {
    late EventQueue queue;
    late StepClock clock;

    setUp(() {
      queue = EventQueue();
      clock = StepClock();
    });

    test(
      'steps every system in the order given with the clamped step',
      () {
        final order = <String>[];
        final steps = <Seconds>[];
        void stepA(Seconds dt) {
          order.add('a');
          steps.add(dt);
        }

        void stepB(Seconds dt) {
          order.add('b');
          steps.add(dt);
        }

        void stepC(Seconds dt) {
          order.add('c');
          steps.add(dt);
        }

        final loop = GameLoop(
          queue: queue,
          clock: clock,
          systems: [stepA, stepB, stepC],
        );

        loop.advance(const Seconds(0.5));

        expect(order, ['a', 'b', 'c']);
        for (final dt in steps) {
          expect(dt.value, closeTo(1 / 30, 1e-9));
        }
      },
    );

    test(
      'delivers what a system publishes before the next system steps',
      () {
        final order = <String>[];
        void stepA(Seconds dt) {
          order.add('a');
          queue.publish(const _Ping());
        }

        void stepB(Seconds dt) => order.add('b');

        final loop = GameLoop(
          queue: queue,
          clock: clock,
          systems: [stepA, stepB],
        );
        queue.subscribe<_Ping>((event) => order.add('ping'));

        loop.advance(const Seconds(1 / 60));

        expect(order, ['a', 'ping', 'b']);
      },
    );

    test('steps no system while the pause menu is open', () {
      final stepped = <String>[];
      void stepA(Seconds dt) => stepped.add('a');

      final loop = GameLoop(
        queue: queue,
        clock: clock,
        systems: [stepA],
      );
      queue.publish(const PauseOpened());

      loop.advance(const Seconds(1 / 60));

      expect(stepped, isEmpty);
    });

    test('steps again once the pause menu closes', () {
      final steps = <Seconds>[];
      void stepA(Seconds dt) => steps.add(dt);

      final loop = GameLoop(
        queue: queue,
        clock: clock,
        systems: [stepA],
      );
      queue.publish(const PauseOpened());
      loop.advance(const Seconds(1 / 60));

      queue.publish(const PauseClosed());
      loop.advance(const Seconds(1 / 60));

      expect(steps.length, 1);
      expect(steps.single.value, closeTo(1 / 60, 1e-9));
    });

    test('holds every system for a hitstop a system raised', () {
      final stepped = <String>[];
      var callCount = 0;
      void stepA(Seconds dt) {
        stepped.add('a');
        callCount++;
        if (callCount == 1) {
          queue.publish(const HitstopStarted(duration: Seconds(0.05)));
        }
      }

      final loop = GameLoop(
        queue: queue,
        clock: clock,
        systems: [stepA],
      );

      loop.advance(const Seconds(1 / 60));
      loop.advance(const Seconds(1 / 60));

      expect(stepped, ['a']);
    });

    test('delivers events while the systems are held', () {
      final stepped = <String>[];
      void stepA(Seconds dt) => stepped.add('a');

      final loop = GameLoop(
        queue: queue,
        clock: clock,
        systems: [stepA],
      );
      var pingReceived = false;
      queue.subscribe<_Ping>((event) => pingReceived = true);
      queue.publish(const PauseOpened());
      loop.advance(const Seconds(1 / 60));

      queue.publish(const _Ping());
      loop.advance(const Seconds(1 / 60));

      expect(pingReceived, isTrue);
      expect(stepped, isEmpty);
    });

    test('holds the world while any halt cause stands', () {
      final stepped = <String>[];
      void stepA(Seconds dt) => stepped.add('a');

      final loop = GameLoop(
        queue: queue,
        clock: clock,
        systems: [stepA],
      );
      queue.publish(const PauseOpened());
      queue.publish(const MapOpened());
      loop.advance(const Seconds(1 / 60));

      queue.publish(const PauseClosed());
      loop.advance(const Seconds(1 / 60));

      expect(stepped, isEmpty);

      queue.publish(const MapClosed());
      loop.advance(const Seconds(1 / 60));

      expect(stepped, ['a']);
    });

    test('a resume with no matching halt leaves the world halted', () {
      final stepped = <String>[];
      void stepA(Seconds dt) => stepped.add('a');

      final loop = GameLoop(
        queue: queue,
        clock: clock,
        systems: [stepA],
      );
      queue.publish(const MapOpened());
      queue.publish(
        const AbilityChosen(ability: AbilityId.web, slotIndex: 0),
      );

      loop.advance(const Seconds(1 / 60));

      expect(stepped, isEmpty);
    });

    test('a repeated halt is ended by one resume', () {
      final stepped = <String>[];
      void stepA(Seconds dt) => stepped.add('a');

      final loop = GameLoop(
        queue: queue,
        clock: clock,
        systems: [stepA],
      );
      queue.publish(const PauseOpened());
      queue.publish(const PauseOpened());
      queue.publish(const PauseClosed());

      loop.advance(const Seconds(1 / 60));

      expect(stepped, ['a']);
    });
  });
}
