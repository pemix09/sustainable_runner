import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<SustainableRunner> {
  Vector2 _moveVector = Vector2.zero();
  double _playerSpeed = 300;

  Player({
    super.sprite,
    super.position,
    super.size,
  });

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveVector.normalized() * _playerSpeed * dt;
    position.clamp(Vector2.zero() + size / 2, game.canvasSize - size / 2);
  }

  void moveLeft() {
    _moveVector = Vector2(-20, 0);
  }

  void moveRight() {
    _moveVector = Vector2(20, 0);
  }
}
