import 'package:endless_runner/game/objects/player.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class PlayerManager extends Component with HasGameRef<SustainableRunner> {
  final SpriteSheet spriteSheet;
  Player? get player => children.whereType<Player>().firstOrNull;

  PlayerManager({required this.spriteSheet});

  @override
  void onLoad() {
    var playerSize = Vector2(64, 64);
    add(
      Player(
        size: playerSize,
        position: Vector2(game.canvasSize.x / 2, game.groundLevel - playerSize.y / 2),
      )..anchor = Anchor.center,
    );

  }
}