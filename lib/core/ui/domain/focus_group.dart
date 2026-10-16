import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/events/player_command.dart';

/// Where the focus goes among a screen's choices, laid out in rows: a
/// move goes along a row or to the next row, keeping the column as far as
/// the row reaches, and stops at the edges (06-ui/ui.md §3; the 06-ui
/// sandbox's `ttMove`).
final class FocusGroup<T extends Object> {
  FocusGroup(List<List<T>> rows)
    : assert(rows.isNotEmpty, 'a group has a row'),
      assert(rows.every((row) => row.isNotEmpty), 'a row has a choice'),
      _rows = List.unmodifiable([
        for (final row in rows) List<T>.unmodifiable(row),
      ]);

  final List<List<T>> _rows;

  /// The first choice of the first row.
  T get first => _rows.first.first;

  /// The choice [move] takes the focus to from [current]; a choice not in
  /// the group moves as the first one.
  T moved(T current, MoveFocus move) {
    final found = _rows.indexWhere((row) => row.contains(current));
    final row = math.max(found, 0);
    final column = math.max(_rows[row].indexOf(current), 0);
    final toRow = (row + move.rows).clamp(0, _rows.length - 1);
    final toColumn = (column + move.columns).clamp(0, _rows[row].length - 1);
    return _rows[toRow][math.min(toColumn, _rows[toRow].length - 1)];
  }
}
