import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/ui/domain/focus_group.dart';

void main() {
  group('FocusGroup', () {
    // 06-ui/sandbox/sandbox.html `ttMove`: the rows [a, b, c], [d], [e, f].
    late FocusGroup<String> group;
    setUp(() {
      group = FocusGroup<String>([
        ['a', 'b', 'c'],
        ['d'],
        ['e', 'f'],
      ]);
    });

    test('the first choice is the first of the first row', () {
      expect(group.first, 'a');
    });

    test('a move along a row goes to the next choice', () {
      expect(group.moved('a', const MoveFocus(columns: 1, rows: 0)), 'b');
      expect(group.moved('b', const MoveFocus(columns: -1, rows: 0)), 'a');
    });

    test('a move past the end of a row stays', () {
      expect(group.moved('c', const MoveFocus(columns: 1, rows: 0)), 'c');
      expect(group.moved('a', const MoveFocus(columns: -1, rows: 0)), 'a');
    });

    test('a move down keeps the column as far as the row reaches', () {
      expect(group.moved('c', const MoveFocus(columns: 0, rows: 1)), 'd');
      expect(group.moved('d', const MoveFocus(columns: 0, rows: 1)), 'e');
    });

    test('a move down a row of the same length keeps the column', () {
      final sameLength = FocusGroup<String>([
        ['a', 'b'],
        ['c', 'd'],
      ]);

      expect(
        sameLength.moved('b', const MoveFocus(columns: 0, rows: 1)),
        'd',
      );
    });

    test('a move past the first or last row stays', () {
      expect(group.moved('b', const MoveFocus(columns: 0, rows: -1)), 'b');
      expect(group.moved('f', const MoveFocus(columns: 0, rows: 1)), 'f');
    });

    test('a choice not in the group moves as the first one', () {
      expect(group.moved('z', const MoveFocus(columns: 0, rows: 1)), 'd');
    });
  });
}
