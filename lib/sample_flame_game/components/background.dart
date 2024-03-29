import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef<SustainableRunner> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await game.images.load("Insert your background here");
    size = gameRef.size;
    sprite = Sprite(background);
  }
}