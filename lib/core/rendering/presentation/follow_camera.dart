import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/world_camera.dart';

/// The world camera (02-art-direction/dungeon/dungeon.md §2): it follows a
/// target with an eased look-ahead, keeps it at 60 % of the view's height,
/// stays inside the zone and snaps to the device pixel. It never shakes:
/// only the target moves it.
final class FollowCamera implements WorldCamera {
  /// ART_DIRECTION.md §3: the view is 750 world units tall.
  static const double viewHeight = 750;

  // dungeon.md §2: a look-ahead of 110 in the facing direction, eased at
  // 2/s; the view follows at 5/s across and 3.5/s down.
  static const double _lookAhead = 110;
  static const double _lookRate = 2;
  static const double _rateAcross = 5;
  static const double _rateDown = 3.5;

  // biome.md of zones 1–5, Camera: Akeris at 60 % of the view's height.
  static const double _targetHeight = 0.6;

  // Until the first resize: the 1920 × 1080 reference frame at ratio 1.
  double _screenWidth = UiVec2.referenceWidth;
  double _screenHeight = UiVec2.referenceHeight;
  double _pixelRatio = 1;

  WorldBox? _bounds;
  double _targetX = 0;
  double _targetY = 0;
  int _facingSign = 1;
  double _look = 0;
  double _left = 0;
  double _top = 0;
  double _snappedLeft = 0;
  double _snappedTop = 0;
  bool _isPlaced = false;

  // Logical screen pixels per world unit.
  double get _scale => _screenHeight / viewHeight;

  double get _viewWidth => _screenWidth / _scale;

  /// Fits the view to a screen of [viewport] logical pixels, shown at
  /// [devicePixelRatio] device pixels per logical pixel.
  void resize(ScreenVec2 viewport, double devicePixelRatio) {
    _screenWidth = viewport.x;
    _screenHeight = viewport.y;
    _pixelRatio = devicePixelRatio;
    _snap();
  }

  /// Keeps the view inside [bounds], a new zone's: the next step places
  /// the camera on its target at once.
  void confine(WorldBox bounds) {
    _bounds = bounds;
    _isPlaced = false;
  }

  /// Follows [target], looking ahead toward [facing].
  void track(Vec2 target, Facing facing) {
    _targetX = target.x;
    _targetY = target.y;
    _facingSign = facing.sign;
  }

  /// Moves the view [dt] closer to its goal: one world step.
  void step(Seconds dt) {
    _look += (_facingSign * _lookAhead - _look) * _ease(_lookRate, dt);
    final goalLeft = _goalLeft();
    final goalTop = _goalTop();
    if (_isPlaced) {
      _left += (goalLeft - _left) * _ease(_rateAcross, dt);
      _top += (goalTop - _top) * _ease(_rateDown, dt);
    } else {
      _left = goalLeft;
      _top = goalTop;
      _isPlaced = true;
    }
    _snap();
  }

  @override
  Vec2 toWorld(ScreenVec2 point) => Vec2(
    _snappedLeft + point.x / _scale,
    _snappedTop + point.y / _scale,
  );

  @override
  ScreenVec2 toScreen(Vec2 point) => ScreenVec2(
    Vec2((point.x - _snappedLeft) * _scale, (point.y - _snappedTop) * _scale),
  );

  // dungeon.md §2 (sandbox `updateCamera`): 1 − e^(−rate · dt).
  static double _ease(double rate, Seconds dt) =>
      1 - math.exp(-dt.value * rate);

  double _goalLeft() {
    final width = _viewWidth;
    final left = _targetX + _look - width / 2;
    final bounds = _bounds;
    return bounds == null
        ? left
        : _clamp(left, bounds.left, bounds.right - width);
  }

  double _goalTop() {
    final top = _targetY - viewHeight * _targetHeight;
    final bounds = _bounds;
    return bounds == null
        ? top
        : _clamp(top, bounds.top, bounds.bottom - viewHeight);
  }

  // 02-art-direction/sandbox/sandbox.html `clamp`: the low edge wins when
  // the zone is narrower or shorter than the view.
  static double _clamp(double value, double low, double high) =>
      math.max(low, math.min(high, value));

  // dungeon.md §2: round(cam · k) / k, k in device pixels per world unit.
  void _snap() {
    final k = _scale * _pixelRatio;
    _snappedLeft = (_left * k).roundToDouble() / k;
    _snappedTop = (_top * k).roundToDouble() / k;
  }
}
