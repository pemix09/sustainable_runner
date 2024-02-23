import 'package:endless_runner/game/knows_game_size.dart';
import 'package:flame/components.dart';

class Obstacle extends SpriteComponent with KnowsGameSize {
  double _speed = 250;

  Obstacle({Sprite? sprite, Vector2? position, Vector2? size, })
      : super(sprite: sprite, position: position, size: size,) {
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.position += Vector2(0, 1) * _speed * dt;
  }
}