import 'dart:math';
import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/objects/trash_bag.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';

class TrashManager extends Component with HasGameRef<SustainableRunner> {
  late Timer _timer;
  final Random random = Random();
  Iterable<Enemy> get enemies => children.whereType<Enemy>();

  TrashManager() : super() {
    _timer = Timer(1, onTick: _spawnTrashBag, repeat: true);
  }

  void _spawnTrashBag() {
    final initialSize = Vector2(64, 64);
    final position = Vector2(random.nextInt(5) * game.canvasSize.x / 5, 0);
    position.clamp(Vector2.zero() + initialSize / 2, game.canvasSize - initialSize / 2);
    add(
      TrashBag(
        size: initialSize,
        position: position,
      )..anchor = Anchor.center,
    );
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
