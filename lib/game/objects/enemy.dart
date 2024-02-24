import 'dart:math';

import 'package:endless_runner/game/services/enemy_manager.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:endless_runner/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Enemy extends SpriteComponent with HasGameRef<SustainableRunner>, CollisionCallbacks {
  double _speed = 250;

  Enemy({super.sprite, super.position, super.size, }) {
    angle = pi / 4;
  }

  @override
  void onMount() {
    super.onMount();
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    parent?.remove(this);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;

    if (position.y > game.canvasSize.y) {
      parent?.remove(this);
    }
  }

  @override
  void onRemove() {
    print('Removing enemy, $this, on: ${DateTime.now()}');
  }
}