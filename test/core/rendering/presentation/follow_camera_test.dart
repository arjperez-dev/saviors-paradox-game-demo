import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/rendering/presentation/follow_camera.dart';

const Seconds _sixtiethSecond = Seconds(1 / 60);

FollowCamera _settledCamera({required Vec2 target, required Facing facing}) {
  final camera = FollowCamera()..resize(const ScreenVec2(Vec2(1920, 1080)), 1);
  camera.track(target, facing);
  for (var i = 0; i < 600; i++) {
    camera.step(_sixtiethSecond);
  }
  return camera;
}

void main() {
  group('FollowCamera', () {
    test('the view is 750 world units tall at any screen size', () {
      final camera = FollowCamera();

      camera.resize(const ScreenVec2(Vec2(1920, 1080)), 1);
      final tallHeight =
          camera.toWorld(const ScreenVec2(Vec2(0, 1080))).y -
          camera.toWorld(ScreenVec2.zero).y;
      camera.resize(const ScreenVec2(Vec2(1536, 864)), 1.25);
      final wideHeight =
          camera.toWorld(const ScreenVec2(Vec2(0, 864))).y -
          camera.toWorld(ScreenVec2.zero).y;

      // 02-art-direction/ART_DIRECTION.md §3: the view is 750 world units
      // tall at any screen size, k = 1.
      expect(tallHeight, closeTo(750, 1e-9));
      expect(wideHeight, closeTo(750, 1e-9));
    });

    test("the view's width follows the screen's aspect", () {
      final camera = FollowCamera();

      camera.resize(const ScreenVec2(Vec2(1920, 1080)), 1);
      final widthAt16by9 =
          camera.toWorld(const ScreenVec2(Vec2(1920, 0))).x -
          camera.toWorld(ScreenVec2.zero).x;
      camera.resize(const ScreenVec2(Vec2(2560, 1080)), 1);
      final widthAtUltrawide =
          camera.toWorld(const ScreenVec2(Vec2(2560, 0))).x -
          camera.toWorld(ScreenVec2.zero).x;

      // 02-art-direction/ART_DIRECTION.md §3: the width follows the
      // screen's aspect, no letterbox — 1920×1080 ≈ 1333.333, 2560×1080 ≈
      // 1777.778 world units wide at the fixed 750-tall view.
      expect(widthAt16by9, closeTo(1333.333333333, 1e-9));
      expect(widthAtUltrawide, closeTo(1777.777777778, 1e-9));
    });

    test('before any resize the view is the 1920 by 1080 frame', () {
      final camera = FollowCamera();

      final corner = camera.toWorld(const ScreenVec2(Vec2(1920, 1080)));
      final origin = camera.toWorld(ScreenVec2.zero);

      // kernel/ui_vec2.dart's reference frame is 1920×1080 at ratio 1;
      // 02-art-direction/ART_DIRECTION.md §3 gives the 750-tall, 1333.333-
      // wide view that frame maps to before any resize call.
      expect(corner.x - origin.x, closeTo(1333.333333333, 1e-9));
      expect(corner.y - origin.y, closeTo(750, 1e-9));
    });

    test("the first step places the target at 60 % of the view's height", () {
      final camera = FollowCamera()
        ..resize(const ScreenVec2(Vec2(1920, 1080)), 1);
      const target = Vec2(5000, 3000);

      camera.track(target, Facing.right);
      camera.step(_sixtiethSecond);

      // 04-zones/*/biome.md "Camera": Akeris at 60 % of the view's height,
      // overriding dungeon.md §2's 70 % — 0.6 × 1080 = 648.
      expect(camera.toScreen(target).y, closeTo(648, 1));
    });

    test('the look-ahead settles 110 world units ahead of the facing', () {
      const target = Vec2(1000, 1000);

      final facingRight = _settledCamera(target: target, facing: Facing.right);
      final facingLeft = _settledCamera(target: target, facing: Facing.left);

      // 02-art-direction/dungeon/dungeon.md §2: a look-ahead of 110 world
      // units; at k = 1.44 device pixels per unit that is 110 × 1.44 =
      // 158.4 logical pixels either side of the view's centre (960).
      expect(facingRight.toScreen(target).x, closeTo(801.6, 1));
      expect(facingLeft.toScreen(target).x, closeTo(1118.4, 1));
    });

    test('the view eases across at 5 per second', () {
      const start = Vec2(1000, 1000);
      final camera = _settledCamera(target: start, facing: Facing.right);
      final before = camera.toWorld(ScreenVec2.zero).x;

      camera.track(const Vec2(1100, 1000), Facing.right);
      camera.step(const Seconds(0.1));
      final after = camera.toWorld(ScreenVec2.zero).x;

      // 02-art-direction/dungeon/dungeon.md §2: the view eases across at
      // 5/s — 100 × (1 − e^(−5×0.1)) = 39.347.
      expect(after - before, closeTo(39.347, 1 / 1.44));
    });

    test('the view eases down at 3.5 per second', () {
      const start = Vec2(1000, 1000);
      final camera = _settledCamera(target: start, facing: Facing.right);
      final before = camera.toWorld(ScreenVec2.zero).y;

      camera.track(const Vec2(1000, 1100), Facing.right);
      camera.step(const Seconds(0.1));
      final after = camera.toWorld(ScreenVec2.zero).y;

      // 02-art-direction/dungeon/dungeon.md §2: the view eases down at
      // 3.5/s — 100 × (1 − e^(−3.5×0.1)) = 29.531.
      expect(after - before, closeTo(29.531, 1 / 1.44));
    });

    test('confining keeps the view inside the zone', () {
      final bounds = WorldBox(
        centre: const Vec2(2000, 1000),
        halfWidth: 2000,
        halfHeight: 1000,
      );

      final nearLow = FollowCamera()
        ..resize(const ScreenVec2(Vec2(1920, 1080)), 1)
        ..confine(bounds);
      nearLow.track(const Vec2(10, 10), Facing.right);
      nearLow.step(_sixtiethSecond);

      final nearHigh = FollowCamera()
        ..resize(const ScreenVec2(Vec2(1920, 1080)), 1)
        ..confine(bounds);
      nearHigh.track(const Vec2(3990, 1990), Facing.right);
      nearHigh.step(_sixtiethSecond);

      // 02-art-direction/sandbox/sandbox.html `clamp`: the goal is clamped
      // to the zone's bounds minus the view, so the view's edge never
      // crosses the zone's edge.
      final low = nearLow.toWorld(ScreenVec2.zero);
      expect(low.x, closeTo(0, 1 / 1.44));
      expect(low.y, closeTo(0, 1 / 1.44));

      final high = nearHigh.toWorld(const ScreenVec2(Vec2(1920, 1080)));
      expect(high.x, closeTo(4000, 1 / 1.44));
      expect(high.y, closeTo(2000, 1 / 1.44));
    });

    test(
      "a zone narrower than the view keeps its left edge at the view's left",
      () {
        final bounds = WorldBox(
          centre: const Vec2(500, 500),
          halfWidth: 500,
          halfHeight: 100000,
        );

        for (final trackedX in [-500.0, 0.0, 500.0, 2000.0]) {
          final camera = FollowCamera()
            ..resize(const ScreenVec2(Vec2(1920, 1080)), 1)
            ..confine(bounds);
          camera.track(Vec2(trackedX, 500), Facing.right);
          camera.step(_sixtiethSecond);

          // 02-art-direction/sandbox/sandbox.html `clamp`: the low edge
          // wins when the zone is narrower than the view, for any target.
          expect(camera.toWorld(ScreenVec2.zero).x, closeTo(0, 1 / 1.44));
        }
      },
    );

    test('confining a new zone places the camera at once', () {
      final camera = _settledCamera(
        target: const Vec2(1000, 1000),
        facing: Facing.right,
      );
      final farBounds = WorldBox(
        centre: const Vec2(100000, 100000),
        halfWidth: 200000,
        halfHeight: 200000,
      );
      const newTarget = Vec2(6000, 1000);

      camera.confine(farBounds);
      camera.track(newTarget, Facing.right);
      camera.step(_sixtiethSecond);

      // 04-zones/*/biome.md "Camera": 60 % of the view's height again, now
      // placed at once in the new zone rather than eased toward it.
      expect(camera.toScreen(newTarget).y, closeTo(648, 1));
    });

    test('the view snaps to the device pixel', () {
      final camera = FollowCamera()
        ..resize(const ScreenVec2(Vec2(1536, 864)), 1.25);
      camera.track(const Vec2(1234.56, 789.01), Facing.right);
      camera.step(const Seconds(0.0173));
      camera.track(const Vec2(1250, 800), Facing.left);
      camera.step(const Seconds(0.0091));

      final point = camera.toWorld(ScreenVec2.zero);

      // 02-art-direction/dungeon/dungeon.md §2: the view snaps to
      // round(cam · k) / k, k = device-pixel ratio × screen height ÷ 750 —
      // here 1.25 × 864 ÷ 750 = 1.44 device pixels per world unit.
      const k = 1.44;
      expect(point.x * k, closeTo((point.x * k).roundToDouble(), 1e-6));
      expect(point.y * k, closeTo((point.y * k).roundToDouble(), 1e-6));
    });

    test('a camera tracking a still target comes to rest', () {
      final camera = _settledCamera(
        target: const Vec2(1234, 5678),
        facing: Facing.right,
      );
      final before = camera.toWorld(ScreenVec2.zero);

      for (var i = 0; i < 60; i++) {
        camera.step(_sixtiethSecond);
      }
      final after = camera.toWorld(ScreenVec2.zero);

      // 02-art-direction/ART_DIRECTION.md §2 and dungeon/dungeon.md §2:
      // nothing trembles — a settled view holds its exact value, not just
      // a close one, while its target stays still.
      expect(after, before);
    });

    test('the same tracks and steps give the same view', () {
      void drive(FollowCamera camera) {
        camera.resize(const ScreenVec2(Vec2(1920, 1080)), 1);
        camera.confine(
          WorldBox(
            centre: const Vec2(3000, 2000),
            halfWidth: 5000,
            halfHeight: 4000,
          ),
        );
        camera.track(const Vec2(2000, 1500), Facing.right);
        camera.step(const Seconds(1 / 60));
        camera.track(const Vec2(2200, 1600), Facing.right);
        camera.step(const Seconds(1 / 60));
      }

      final first = FollowCamera();
      final second = FollowCamera();
      drive(first);
      drive(second);

      expect(
        second.toWorld(const ScreenVec2(Vec2(640, 360))),
        first.toWorld(const ScreenVec2(Vec2(640, 360))),
      );
    });

    test('screen and world points convert both ways', () {
      final camera = FollowCamera()
        ..resize(const ScreenVec2(Vec2(1920, 1080)), 1);
      camera.track(const Vec2(3333, 4444), Facing.right);
      camera.step(_sixtiethSecond);

      for (final p in const [
        ScreenVec2(Vec2(0, 0)),
        ScreenVec2(Vec2(960, 540)),
        ScreenVec2(Vec2(1920, 1080)),
        ScreenVec2(Vec2(500, 1000)),
      ]) {
        final roundTripped = camera.toScreen(camera.toWorld(p));

        expect(roundTripped.x, closeTo(p.x, 1e-9));
        expect(roundTripped.y, closeTo(p.y, 1e-9));
      }
    });
  });
}
