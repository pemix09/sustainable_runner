import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<SustainableRunner>, CollisionCallbacks {
  Vector2 _moveVector = Vector2.zero();
  double _playerSpeed = 300;

  Player({
    super.sprite,
    super.position,
    super.size,
  });

  @override
  void onMount() {
    super.onMount();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveVector.normalized() * _playerSpeed * dt;
    position.clamp(Vector2.zero() + size / 2, game.canvasSize - size / 2);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      print('Player hit!');
    }
  }

  void moveLeft() {
    _moveVector = Vector2(-20, 0);
  }

  void moveRight() {
    _moveVector = Vector2(20, 0);
  }
}
