import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';

class Bullet extends SpriteComponent with HasGameRef<SustainableRunner>{
  final double _speed = 450;

  Bullet({super.sprite, super.position, super.size,});

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;

    if (position.y < 0) {
      parent?.remove(this);
    }
  }
}