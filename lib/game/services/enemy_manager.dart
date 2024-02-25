import 'dart:math';
import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class EnemyManager extends Component with HasGameRef<SustainableRunner> {
  late Timer _timer;
  final Random random = Random();
  late SpriteSheet _enemySpriteSheet;
  Iterable<Enemy> get enemies => children.whereType<Enemy>();

  @override
  Future<void> onLoad() async {
    _timer = Timer(1, onTick: _spawnEnemy, repeat: true);

    const spriteSheetFileName = 'simpleSpace_sheet@2.png';
    await game.images.load(spriteSheetFileName);

    _enemySpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: game.images.fromCache(spriteSheetFileName),
      columns: 9,
      rows: 5,
    );
  }

  void _spawnEnemy() {
      final initialSize = Vector2(64, 64);
      final position = Vector2(random.nextInt(5) * game.canvasSize.x / 5, 0);
      position.clamp(Vector2.zero() + initialSize / 2, game.canvasSize - initialSize / 2);
      add(
        Enemy(
          sprite: _enemySpriteSheet.getSpriteById(2),
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
