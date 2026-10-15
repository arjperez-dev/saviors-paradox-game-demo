import 'package:flame/components.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';

/// The one clock of the game: Flame's `dt`, handed to the loop as
/// [Seconds] (architecture.md §5).
final class LoopComponent extends Component {
  LoopComponent(this._loop);

  final GameLoop _loop;

  @override
  void update(double dt) => _loop.advance(Seconds(dt));
}
