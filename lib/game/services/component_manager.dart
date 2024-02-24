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

  void shoot() {
    bulletManager?.add(
      Bullet(
        sprite: spriteSheet.getSpriteById(28),
        size: Vector2(64, 64),
        position: playerManager!.player!.position.clone(),
      )..anchor = Anchor.center,
    );
  }

  void enemyHit() {
    playerManager?.player?.score++;
  }
}
