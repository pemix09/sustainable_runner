import 'package:endless_runner/flame_game/components/player.dart';
import 'package:endless_runner/game/objects/bullet.dart';
import 'package:endless_runner/game/services/bullet_manager.dart';
import 'package:endless_runner/game/services/enemy_manager.dart';
import 'package:endless_runner/game/services/player_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class ComponentManager extends Component {
  final SpriteSheet spriteSheet;

  EnemyManager? get enemyManager =>
      children.whereType<EnemyManager>().firstOrNull;

  BulletManager? get bulletManager =>
      children.whereType<BulletManager>().firstOrNull;

  PlayerManager? get playerManager =>
      children.whereType<PlayerManager>().firstOrNull;

  ComponentManager({required this.spriteSheet}) : super();

  @override
  void onLoad() {
    super.onMount();
    add(EnemyManager(spriteSheet: spriteSheet));
    add(BulletManager());
    add(PlayerManager(spriteSheet: spriteSheet));
  }

  void checkEnemyHits() {
    if (enemyManager == null || enemyManager!.enemies.isEmpty ||
        bulletManager == null || bulletManager!.bullets.isEmpty ||
        playerManager == null || playerManager!.player == null) {
      return;
    }

    for (final enemy in enemyManager!.enemies) {
      if (enemy.isRemoving || enemy.isRemoved) {
        continue;
      }
      if (playerManager!.player != null && playerManager!.player!.containsPoint(enemy.absoluteCenter)) {
        print('Enemy hit us! ${DateTime.now()}');
      }
      for (final bullet in bulletManager!.bullets) {
        if (bullet.isRemoving || bullet.isRemoved) {
          continue;
        }

        if (enemy.containsPoint(bullet.absoluteCenter)) {
          enemyManager!.remove(enemy);
          bulletManager!.remove(bullet);
          break;
        }
      }
    }
  }

  void shoot() {
    bulletManager?.add(
      Bullet(
        sprite: spriteSheet.getSpriteById(28),
        size: Vector2(64, 64),
        position: playerManager!.player!.position.clone(),
      )..anchor = Anchor.center,
    );
  }
}
