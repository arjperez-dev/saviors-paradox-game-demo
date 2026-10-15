import 'dart:math' as math;
import 'dart:typed_data';

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// The links of a chain along its sagging curve, alternating a ring seen
/// face-on and one seen edge-on (02-art-direction/strokes/strokes.md §1;
/// the sandbox's `drawChain`). A chain moves, so it is laid out every frame,
/// into buffers allocated once.
final class ChainLinks {
  ChainLinks(this.capacity)
    : _x = Float64List(capacity),
      _y = Float64List(capacity),
      _angle = Float64List(capacity);

  /// One link every 7 su of the chain's length.
  static const double linkSpacing = 7;

  /// Half the size of a face-on link (an ellipse 4.6 × 2.4).
  static const Vec2 faceOnRadii = Vec2(4.6, 2.4);

  /// Half the length of an edge-on link (a line 8.8 long).
  static const double edgeOnHalfLength = 4.4;

  final int capacity;
  final Float64List _x;
  final Float64List _y;
  final Float64List _angle;
  int _count = 0;

  /// How many links the last [layOut] placed.
  int get count => _count;

  double xAt(int index) => _x[index];

  double yAt(int index) => _y[index];

  double angleAt(int index) => _angle[index];

  /// The first link and every second one after it are seen face-on.
  bool isFaceOnAt(int index) => index.isEven;

  /// Places the links from [from] to [to]; a [tension] of 1 is straight,
  /// lower sags by (1 − tension) × 30 % of the length. A chain shorter
  /// than 5 has no links.
  void layOut(Vec2 from, Vec2 to, {double tension = 1}) {
    final length = from.distanceTo(to);
    if (length < 5) {
      _count = 0;
      return;
    }
    final links = math.max(2, (length / linkSpacing).floor());
    if (links > capacity) {
      throw StateError('a chain of $links links exceeds $capacity');
    }
    final sag = Vec2(0, (1 - tension) * length * 0.3);
    _place(from, (from + to).scaled(0.5) + sag, to, links);
  }

  void _place(Vec2 from, Vec2 control, Vec2 to, int links) {
    var previous = from;
    for (var i = 0; i < links; i++) {
      final next = _curve(from, control, to, (i + 1) / links);
      _x[i] = (previous.x + next.x) / 2;
      _y[i] = (previous.y + next.y) / 2;
      _angle[i] = math.atan2(next.y - previous.y, next.x - previous.x);
      previous = next;
    }
    _count = links;
  }

  static Vec2 _curve(Vec2 from, Vec2 control, Vec2 to, double t) {
    final u = 1 - t;
    return from.scaled(u * u) + control.scaled(2 * u * t) + to.scaled(t * t);
  }
}
