import 'dart:math';
import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/screens/game_screen.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';

class Player extends SpriteComponent
    with HasGameRef<SustainableRunner>, CollisionCallbacks {
  Vector2 _moveVector = Vector2.zero();
  double _playerSpeed = 300;
  int score = 0;
  int health = 3;

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

    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          speed: (Vector2.random(Random()) - Vector2(0.5, -1)) * 500,
          acceleration: (Vector2.random(Random()) - Vector2(0.5, -1)) * 500,
          position: position.clone() + Vector2(0, size.y / 3),
          child: CircleParticle(
            radius: 1,
            lifespan: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );

    game.add(particleComponent);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      health--;

      if (health == 0) {
        game.pauseEngine();
        game.overlays.add(GameScreen.lostDialogKey);
      }
    }

    if (score > 20) {
      game.pauseEngine();
      game.overlays.add(GameScreen.winDialogKey);
    }
  }

  void moveLeft() {
    _moveVector = Vector2(-20, 0);
  }

  void moveRight() {
    _moveVector = Vector2(20, 0);
  }
}
