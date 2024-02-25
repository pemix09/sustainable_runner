import 'package:endless_runner/game/objects/bullet.dart';
import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/screens/game_screen.dart';
import 'package:endless_runner/game/services/component_manager.dart';
import 'package:endless_runner/game/services/enemy_manager.dart';
import 'package:endless_runner/game/worlds/game_world.dart';
import 'package:endless_runner/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class SustainableRunner extends FlameGame<GameWorld>
    with HasCollisionDetection, HorizontalDragDetector, TapDetector {
  late SpriteSheet _spriteSheet;
  late TextComponent _playerScore;
  final scoreNotifier = ValueNotifier(0);
  late final DateTime timeStarted;
  final double gravity = 30;
  late final double groundLevel;

  ComponentManager? get componentManager =>
      children.whereType<ComponentManager>().firstOrNull;

  SustainableRunner()
      : super(
          world: GameWorld(),
          camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
        ) {
  }

  @override
  Future<void> onLoad() async {
    groundLevel = size.y - 20;
    timeStarted = DateTime.now();
    const spriteSheetFileName = 'simpleSpace_sheet@2.png';
    await images.load(spriteSheetFileName);

    _spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache(spriteSheetFileName),
      columns: 9,
      rows: 5,
    );

    var componentManager = ComponentManager(spriteSheet: _spriteSheet);
    add(componentManager);

    _playerScore = TextComponent(
      text: 'Score: 0',
      position: Vector2(canvasSize.x - 100, 50),
    );

    add(_playerScore);

    scoreNotifier.addListener(() {
      if (scoreNotifier.value >= 20) {
        final levelTime = (DateTime.now().millisecondsSinceEpoch -
            timeStarted.millisecondsSinceEpoch) /
            1000;

        var levelCompletedIn = levelTime.round();
        print('Level completed in: $levelCompletedIn');

        pauseEngine();
        overlays.add(GameScreen.winDialogKey);
      }
    });
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
    componentManager?.playerManager?.player?.jump(Vector2(0, -150));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _playerScore.text =
        'Score: ${componentManager?.playerManager?.player?.score}';
    overlays.remove(GameScreen.healthBar);
    overlays.add(GameScreen.healthBar);
  }

  @override
  void onMount() {
    super.onMount();
    // When the world is mounted in the game we add a back button widget as an
    // overlay so that the player can go back to the previous screen.
    overlays.add(GameScreen.healthBar);
    overlays.add(GameScreen.pauseButton);
  }

  @override
  void onRemove() {
    overlays.remove(GameScreen.healthBar);
    overlays.remove(GameScreen.pauseButton);
  }
}
