import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bullet extends SpriteComponent with CollisionCallbacks {
  final double _speed = 450;

  Bullet({super.sprite, super.position, super.size,});

  @override
  void onMount() {
    super.onMount();
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;

    if (position.y < 0) {
      parent?.remove(this);
    }
  }
}