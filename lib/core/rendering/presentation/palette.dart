import 'dart:ui';

/// The closed list of the game's colours, as
/// 02-art-direction/palette/palette.md gives them. A colour given as a range
/// (`graphite`, `grain`, `stain`, `depth`, `pit`) is built where it is used,
/// from the base colour here.
abstract final class Palette {
  // §1 Paper and ink.
  // palette.md §1: #1a1715
  static const Color ink = Color(0xFF1A1715);
  // palette.md §1: #d4ccbe
  static const Color paper = Color(0xFFD4CCBE);
  // palette.md §1: #efe6d6
  static const Color paperLight = Color(0xFFEFE6D6);
  // palette.md §1: rgba(14,11,9,.62)
  static const Color vignette = Color.fromRGBO(14, 11, 9, 0.62);

  // §2 The dungeon.
  // palette.md §2: rgb(200,192,179)
  static const Color stone = Color.fromRGBO(200, 192, 179, 1);
  // palette.md §2: rgba(246,239,224,.5)
  static const Color stoneEdge = Color.fromRGBO(246, 239, 224, 0.5);
  // palette.md §2: #35302a
  static const Color mortar = Color(0xFF35302A);
  // palette.md §2: #bdb3a0
  static const Color pillar = Color(0xFFBDB3A0);
  // palette.md §2: #231e19
  static const Color hollow = Color(0xFF231E19);
  // palette.md §2: #ddd6c6
  static const Color bone = Color(0xFFDDD6C6);
  // palette.md §2: #e2dccd
  static const Color boneLight = Color(0xFFE2DCCD);
  // palette.md §2: rgb(14,11,9)
  static const Color darkness = Color.fromRGBO(14, 11, 9, 1);
  // palette.md §2: rgba(14,11,9,.9)
  static const Color farChain = Color.fromRGBO(14, 11, 9, 0.9);

  // §3 Light.
  // palette.md §3: rgba(255,160,70,.3)
  static const Color torchlight = Color.fromRGBO(255, 160, 70, 0.3);
  // palette.md §3: #e8872e
  static const Color flameOuter = Color(0xFFE8872E);
  // palette.md §3: #ffd978
  static const Color flameInner = Color(0xFFFFD978);
  // palette.md §3: rgba(10,8,6,.28)
  static const Color shadow = Color.fromRGBO(10, 8, 6, 0.28);

  // §4 The timelines.
  // palette.md §4: #6e0a10
  static const Color streakRedWide = Color(0xFF6E0A10);
  // palette.md §4: #d8141d
  static const Color streakRedCore = Color(0xFFD8141D);
  // palette.md §4: rgba(200,0,20,.8)
  static const Color streakRedGlow = Color.fromRGBO(200, 0, 20, 0.8);
  // palette.md §4: rgba(120,0,10,.7)
  static const Color eyeGlowRed = Color.fromRGBO(120, 0, 10, 0.7);
  // palette.md §4: #3a1768
  static const Color streakPurpleWide = Color(0xFF3A1768);
  // palette.md §4: #8a4fe0
  static const Color streakPurpleCore = Color(0xFF8A4FE0);
  // palette.md §4: rgba(140,70,230,.85)
  static const Color streakPurpleGlow = Color.fromRGBO(140, 70, 230, 0.85);
  // palette.md §4: rgba(90,30,160,.7)
  static const Color eyeGlowPurple = Color.fromRGBO(90, 30, 160, 0.7);

  // §5 Characters and gear.
  // palette.md §5: #3d3934
  static const Color cape = Color(0xFF3D3934);
  // palette.md §5: rgba(8,6,5,.5)
  static const Color capeHatch = Color.fromRGBO(8, 6, 5, 0.5);
  // palette.md §5: #e4e1d9
  static const Color blade = Color(0xFFE4E1D9);
  // palette.md §5: #d2cdc2
  static const Color hookBlade = Color(0xFFD2CDC2);
  // palette.md §5: rgba(245,240,228,.8)
  static const Color hookBladeEdge = Color.fromRGBO(245, 240, 228, 0.8);
  // palette.md §5: #b9ad95
  static const Color leather = Color(0xFFB9AD95);
  // palette.md §5: #a39a8a
  static const Color rock = Color(0xFFA39A8A);
  // palette.md §5: #6e5f4d
  static const Color wood = Color(0xFF6E5F4D);
  // palette.md §5: #5a554e
  static const Color iron = Color(0xFF5A554E);
  // palette.md §5: #ddd3bf
  static const Color parchmentDark = Color(0xFFDDD3BF);

  // §6 Accents: shields and elements.
  // palette.md §6: #dcd5c3
  static const Color sacredFace = Color(0xFFDCD5C3);
  // palette.md §6: rgba(196,160,72,1)
  static const Color sacredEffect = Color(0xFFC4A048);
  // palette.md §6: #c3dbe4
  static const Color iceFace = Color(0xFFC3DBE4);
  // palette.md §6: rgba(60,110,140,.6)
  static const Color iceFacet = Color.fromRGBO(60, 110, 140, 0.6);
  // palette.md §6: rgba(255,255,255,.8)
  static const Color iceHighlight = Color.fromRGBO(255, 255, 255, 0.8);
  // palette.md §6: rgba(70,140,175,1)
  static const Color iceEffect = Color.fromRGBO(70, 140, 175, 1);
  // palette.md §6: #5d4637
  static const Color fireIron = Color(0xFF5D4637);
  // palette.md §6: #e0782c
  static const Color fireEmblem = Color(0xFFE0782C);
  // palette.md §6: #ffd166
  static const Color fireEmblemLight = Color(0xFFFFD166);
  // palette.md §6: rgba(224,120,44,1)
  static const Color fireEffect = Color.fromRGBO(224, 120, 44, 1);
  // palette.md §6: rgba(232,135,46,.75)
  static const Color ember = Color.fromRGBO(232, 135, 46, 0.75);
  // palette.md §6: ink at .72
  static const Color inkSmoke = Color.fromRGBO(26, 23, 21, 0.72);
  // palette.md §6: #7a8638
  static const Color poisonLiquid = Color(0xFF7A8638);
  // palette.md §6: #4d5527
  static const Color poisonDeep = Color(0xFF4D5527);
  // palette.md §6: #a6b04c
  static const Color poisonDrip = Color(0xFFA6B04C);
  // palette.md §6: rgba(150,170,60,.55)
  static const Color poisonGlow = Color.fromRGBO(150, 170, 60, 0.55);
}
