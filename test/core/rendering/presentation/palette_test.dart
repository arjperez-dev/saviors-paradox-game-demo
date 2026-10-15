import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';

void main() {
  group('Palette', () {
    test('holds the paper and ink colours', () {
      expect(Palette.ink, const Color(0xFF1A1715)); // palette.md §1
      expect(Palette.paper, const Color(0xFFD4CCBE)); // palette.md §1
      expect(Palette.paperLight, const Color(0xFFEFE6D6)); // palette.md §1
      expect(
        Palette.vignette,
        const Color.fromRGBO(14, 11, 9, 0.62), // palette.md §1
      );
    });

    test('holds the dungeon colours', () {
      expect(
        Palette.stone,
        const Color.fromRGBO(200, 192, 179, 1), // palette.md §2
      );
      expect(
        Palette.stoneEdge,
        const Color.fromRGBO(246, 239, 224, 0.5), // palette.md §2
      );
      expect(Palette.mortar, const Color(0xFF35302A)); // palette.md §2
      expect(Palette.pillar, const Color(0xFFBDB3A0)); // palette.md §2
      expect(Palette.hollow, const Color(0xFF231E19)); // palette.md §2
      expect(Palette.bone, const Color(0xFFDDD6C6)); // palette.md §2
      expect(Palette.boneLight, const Color(0xFFE2DCCD)); // palette.md §2
      expect(
        Palette.darkness,
        const Color.fromRGBO(14, 11, 9, 1), // palette.md §2
      );
      expect(
        Palette.farChain,
        const Color.fromRGBO(14, 11, 9, 0.9), // palette.md §2
      );
    });

    test('holds the colours of light', () {
      expect(
        Palette.torchlight,
        const Color.fromRGBO(255, 160, 70, 0.3), // palette.md §3
      );
      expect(Palette.flameOuter, const Color(0xFFE8872E)); // palette.md §3
      expect(Palette.flameInner, const Color(0xFFFFD978)); // palette.md §3
      expect(
        Palette.shadow,
        const Color.fromRGBO(10, 8, 6, 0.28), // palette.md §3
      );
    });

    test('holds the colours of the timelines', () {
      expect(Palette.streakRedWide, const Color(0xFF6E0A10)); // palette.md §4
      expect(Palette.streakRedCore, const Color(0xFFD8141D)); // palette.md §4
      expect(
        Palette.streakRedGlow,
        const Color.fromRGBO(200, 0, 20, 0.8), // palette.md §4
      );
      expect(
        Palette.eyeGlowRed,
        const Color.fromRGBO(120, 0, 10, 0.7), // palette.md §4
      );
      expect(
        Palette.streakPurpleWide,
        const Color(0xFF3A1768), // palette.md §4
      );
      expect(
        Palette.streakPurpleCore,
        const Color(0xFF8A4FE0), // palette.md §4
      );
      expect(
        Palette.streakPurpleGlow,
        const Color.fromRGBO(140, 70, 230, 0.85), // palette.md §4
      );
      expect(
        Palette.eyeGlowPurple,
        const Color.fromRGBO(90, 30, 160, 0.7), // palette.md §4
      );
    });

    test('holds the colours of the characters and their gear', () {
      expect(Palette.cape, const Color(0xFF3D3934)); // palette.md §5
      expect(
        Palette.capeHatch,
        const Color.fromRGBO(8, 6, 5, 0.5), // palette.md §5
      );
      expect(Palette.blade, const Color(0xFFE4E1D9)); // palette.md §5
      expect(Palette.hookBlade, const Color(0xFFD2CDC2)); // palette.md §5
      expect(
        Palette.hookBladeEdge,
        const Color.fromRGBO(245, 240, 228, 0.8), // palette.md §5
      );
      expect(Palette.leather, const Color(0xFFB9AD95)); // palette.md §5
      expect(Palette.rock, const Color(0xFFA39A8A)); // palette.md §5
      expect(Palette.wood, const Color(0xFF6E5F4D)); // palette.md §5
      expect(Palette.iron, const Color(0xFF5A554E)); // palette.md §5
      expect(
        Palette.parchmentDark,
        const Color(0xFFDDD3BF), // palette.md §5
      );
    });

    test('holds the colours of the shields and elements', () {
      expect(Palette.sacredFace, const Color(0xFFDCD5C3)); // palette.md §6
      expect(
        Palette.sacredEffect,
        const Color(0xFFC4A048), // palette.md §6
      );
      expect(Palette.iceFace, const Color(0xFFC3DBE4)); // palette.md §6
      expect(
        Palette.iceFacet,
        const Color.fromRGBO(60, 110, 140, 0.6), // palette.md §6
      );
      expect(
        Palette.iceHighlight,
        const Color.fromRGBO(255, 255, 255, 0.8), // palette.md §6
      );
      expect(
        Palette.iceEffect,
        const Color.fromRGBO(70, 140, 175, 1), // palette.md §6
      );
      expect(Palette.fireIron, const Color(0xFF5D4637)); // palette.md §6
      expect(Palette.fireEmblem, const Color(0xFFE0782C)); // palette.md §6
      expect(
        Palette.fireEmblemLight,
        const Color(0xFFFFD166), // palette.md §6
      );
      expect(
        Palette.fireEffect,
        const Color.fromRGBO(224, 120, 44, 1), // palette.md §6
      );
      expect(
        Palette.ember,
        const Color.fromRGBO(232, 135, 46, 0.75), // palette.md §6
      );
      expect(
        Palette.inkSmoke,
        const Color.fromRGBO(26, 23, 21, 0.72), // palette.md §6
      );
      expect(
        Palette.poisonLiquid,
        const Color(0xFF7A8638), // palette.md §6
      );
      expect(Palette.poisonDeep, const Color(0xFF4D5527)); // palette.md §6
      expect(Palette.poisonDrip, const Color(0xFFA6B04C)); // palette.md §6
      expect(
        Palette.poisonGlow,
        const Color.fromRGBO(150, 170, 60, 0.55), // palette.md §6
      );
    });
  });
}
