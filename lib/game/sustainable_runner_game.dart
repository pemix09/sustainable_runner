import 'package:endless_runner/game/objects/bullet.dart';
import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/services/component_manager.dart';
import 'package:endless_runner/game/services/enemy_manager.dart';
import 'package:endless_runner/game/worlds/game_world.dart';
import 'package:endless_runner/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

class SustainableRunner extends FlameGame<GameWorld>
    with HasCollisionDetection, HorizontalDragDetector, TapDetector {
  late SpriteSheet _spriteSheet;

  ComponentManager? get componentManager =>
      children.whereType<ComponentManager>().firstOrNull;

  SustainableRunner()
      : super(
          world: GameWorld(),
          camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
        );

  @override
  Future<void> onLoad() async {
    const spriteSheetFileName = 'simpleSpace_sheet@2.png';
    await images.load(spriteSheetFileName);

    _spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache(spriteSheetFileName),
      columns: 9,
      rows: 5,
    );

    var componentManager = ComponentManager(spriteSheet: _spriteSheet);
    add(componentManager);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (componentManager != null && componentManager!.isLoaded) {
      componentManager!.checkEnemyHits();
    }
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    if (componentManager != null) {
      if (info.velocity.x < 0) {
        componentManager!.playerManager?.player?.moveLeft();
      } else {
        componentManager!.playerManager?.player?.moveRight();
      }
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    if (componentManager != null && componentManager!.isLoaded) {
      componentManager!.shoot();
    }
  }
}
