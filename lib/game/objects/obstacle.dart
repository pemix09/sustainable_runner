import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';

class Obstacle extends SpriteComponent with HasGameRef<SustainableRunner> {
  double _speed = 250;

  Obstacle({super.sprite, super.position, super.size, });

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;

    if (position.y > game.size.y) {
      parent?.remove(this);
    }
  }
}