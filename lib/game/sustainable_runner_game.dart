import 'package:endless_runner/game/screens/game_screen.dart';
import 'package:endless_runner/game/services/enemy_manager.dart';
import 'package:endless_runner/game/services/player_manager.dart';
import 'package:endless_runner/game/services/trash_manager.dart';
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
  late TextComponent _playerScore;
  final scoreNotifier = ValueNotifier(0);
  late final DateTime timeStarted;
  late final EnemyManager enemyManager;
  late final PlayerManager playerManager;
  late final TrashManager trashManager;

  SustainableRunner()
      : super(
          world: GameWorld(),
          camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
        ) {}

  @override
  Future<void> onLoad() async {
    timeStarted = DateTime.now();
    initializeManagers();
    addManagers();

    _playerScore = TextComponent(
      text: 'Score: 0',
      position: Vector2(canvasSize.x - 100, 50),
    );

    add(_playerScore);
    //camera.backdrop.add(Background(speed: 200));

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
    if (info.velocity.x < 0) {
      playerManager.movePlayerLeft();
    } else {
      playerManager.movePlayerRight();
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    playerManager.playerJump();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _playerScore.text = 'Score: 0';
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

  void initializeManagers() {
    enemyManager = EnemyManager();
    playerManager = PlayerManager();
    trashManager = TrashManager();
  }
  void addManagers() {
    add(enemyManager);
    add(playerManager);
    add(trashManager);
  }
}
