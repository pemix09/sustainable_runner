import 'package:endless_runner/game/knows_game_size.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with KnowsGameSize {
  Vector2 _moveDirection = Vector2.zero();
  double _playerSpeed = 300;

  set moveDirection(Vector2 direction) {
    _moveDirection = direction;
  }

  Player({Sprite? sprite, Vector2? position, Vector2? size,})
      : super(sprite: sprite, position: position, size: size,) {
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveDirection.normalized() * _playerSpeed * dt;

    if (gameSize != null) {
      position.clamp(Vector2.zero() + size / 2, gameSize! - size / 2);
    }
  }
}