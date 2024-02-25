import 'package:endless_runner/game/objects/player.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

class PlayerManager extends Component with HasGameRef<SustainableRunner> {
  late final SpriteSheet _playerSpriteSheet;
  late final Player player;
  final scoreNotifier = ValueNotifier(0);

  @override
  Future<void> onLoad() async {
    const spriteSheetFileName = 'simpleSpace_sheet@2.png';
    await game.images.load(spriteSheetFileName);

    _playerSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: game.images.fromCache(spriteSheetFileName),
      columns: 9,
      rows: 5,
    );

    var playerSize = Vector2(64, 64);
    player = Player(
      size: playerSize,
      position:
          Vector2(game.canvasSize.x / 2, game.world.groundLevel - playerSize.y / 2),
    )..anchor = Anchor.center;

    add(player);
  }

  void movePlayerRight() {
    player.moveRight();
  }

  void movePlayerLeft() {
    player.moveLeft();
  }

  void playerJump() {
    player.jump(Vector2(0, -150));
  }

  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
  }
}
