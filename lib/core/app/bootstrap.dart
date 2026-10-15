import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/app/saviors_paradox_game.dart';
import 'package:window_manager/window_manager.dart';

/// Opens the window fullscreen and runs the game (VISION.md §Target platform).
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.waitUntilReadyToShow(
    const WindowOptions(fullScreen: true),
  );
  await windowManager.show();
  await windowManager.focus();
  runApp(GameWidget(game: SaviorsParadoxGame()));
}
