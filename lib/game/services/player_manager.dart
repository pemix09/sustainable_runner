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
    add(
      Player(
        sprite: spriteSheet.getSpriteById(2),
        size: Vector2(64, 64),
        position: game.canvasSize / 2,
      )..anchor = Anchor.center,
    );
  }
}