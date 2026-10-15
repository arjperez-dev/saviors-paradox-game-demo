import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/loop/domain/world_halts.dart';

void main() {
  group('WorldHalts', () {
    test('is not halted before any cause halts it', () {
      final halts = WorldHalts();

      expect(halts.isHalted, isFalse);
    });

    test('is halted once a cause halts it', () {
      final halts = WorldHalts();

      halts.halt(HaltCause.map);

      expect(halts.isHalted, isTrue);
    });

    test('is free again once that cause resumes', () {
      final halts = WorldHalts();

      halts.halt(HaltCause.map);
      halts.resume(HaltCause.map);

      expect(halts.isHalted, isFalse);
    });

    test('a repeated halt is ended by one resume', () {
      final halts = WorldHalts();

      halts.halt(HaltCause.pauseMenu);
      halts.halt(HaltCause.pauseMenu);
      halts.resume(HaltCause.pauseMenu);

      expect(halts.isHalted, isFalse);
    });

    test('a resume with no matching halt changes nothing', () {
      final halts = WorldHalts();

      halts.halt(HaltCause.map);
      halts.resume(HaltCause.abilityChoice);

      expect(halts.isHalted, isTrue);

      final fresh = WorldHalts();

      fresh.resume(HaltCause.cinematic);

      expect(fresh.isHalted, isFalse);
    });

    test('stays halted until every cause has resumed', () {
      final halts = WorldHalts();

      halts.halt(HaltCause.pauseMenu);
      halts.halt(HaltCause.dialogue);
      halts.resume(HaltCause.pauseMenu);

      expect(halts.isHalted, isTrue);

      halts.resume(HaltCause.dialogue);

      expect(halts.isHalted, isFalse);
    });
  });
}
