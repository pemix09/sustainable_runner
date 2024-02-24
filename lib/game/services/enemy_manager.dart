import 'dart:math';
import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/services/component_manager.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class EnemyManager extends Component with HasGameRef<SustainableRunner> {
  late Timer _timer;
  final SpriteSheet spriteSheet;
  final Random random = Random();
  Iterable<Enemy> get enemies => children.whereType<Enemy>();

  EnemyManager({required this.spriteSheet}) : super() {
    _timer = Timer(1, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
      final initialSize = Vector2(64, 64);
      final position = Vector2(random.nextDouble() * game.canvasSize.x, 0);
      position.clamp(Vector2.zero() + initialSize / 2, game.canvasSize - initialSize / 2);
      add(
        Enemy(
          sprite: spriteSheet.getSpriteById(2),
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

  void enemyHit() {
    if (parent != null && parent is ComponentManager) {
      (parent as ComponentManager).enemyHit();
    }
  }
}
