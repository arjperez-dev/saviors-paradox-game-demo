import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/quadratic_pass.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// A pencil line: one bowed quadratic curve and, from width 2, a thin second
/// pass (02-art-direction/strokes/strokes.md §1; the sandbox's `sline`).
final class LineStroke {
  const LineStroke._(this.main, this.second);

  factory LineStroke.generate(
    Vec2 from,
    Vec2 to, {
    required double width,
    required StrokeRandom random,
  }) {
    final frame = _LineFrame(from, to);
    final bow = random.signed() * math.min(1.3, frame.length * 0.025);
    final slide = random.signed() * 0.06;
    final control =
        from + frame.delta.scaled(0.5 + slide) + frame.normal.scaled(bow);
    final main = QuadraticPass(
      start: from + _endJitter(random),
      control: control,
      end: to + _endJitter(random),
      width: width,
      alpha: 1,
    );
    final second = width >= _secondPassWidth
        ? _secondPass(frame, control, width, random)
        : null;
    return LineStroke._(main, second);
  }

  /// Lines at least this wide get the second pass (the sandbox's `sline`).
  static const double _secondPassWidth = 2;

  final QuadraticPass main;

  /// The thin, pale second pass; null on a line narrower than 2.
  final QuadraticPass? second;

  @override
  bool operator ==(Object other) =>
      other is LineStroke && other.main == main && other.second == second;

  @override
  int get hashCode => Object.hash(main, second);

  static Vec2 _endJitter(StrokeRandom random) =>
      Vec2(random.signed() * 0.3, random.signed() * 0.3);

  static QuadraticPass _secondPass(
    _LineFrame frame,
    Vec2 control,
    double width,
    StrokeRandom random,
  ) {
    final offset = frame.normal.scaled(random.signed() * 1.1);
    final overshoot = random.between(1.5, 4);
    return QuadraticPass(
      start: frame.from - frame.direction.scaled(overshoot) + offset,
      control: control + offset.scaled(0.6),
      end: frame.to + frame.direction.scaled(overshoot * 0.4) + offset,
      width: width * 0.4,
      alpha: 0.3,
    );
  }
}

final class _LineFrame {
  _LineFrame(this.from, this.to)
    : delta = to - from,
      length = (to - from).length == 0 ? 1 : (to - from).length;

  final Vec2 from;
  final Vec2 to;
  final Vec2 delta;
  final double length;

  Vec2 get direction => delta.scaled(1 / length);

  Vec2 get normal => Vec2(-delta.y / length, delta.x / length);
}
