import 'dart:math';

import 'package:endless_runner/game/objects/bullet.dart';
import 'package:endless_runner/game/services/enemy_manager.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:endless_runner/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

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

    if (other is Bullet && parent != null && parent is EnemyManager) {
      (parent as EnemyManager).enemyHit();
    }

    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          speed: (Vector2.random(Random()) - Vector2.random(Random())) * 500,
          acceleration: (Vector2.random(Random()) - Vector2.random(Random())) * 500,
          position: position.clone(),
          child: CircleParticle(
            radius: 1.5,
            lifespan: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );
    parent?.add(particleComponent);
    parent?.remove(this);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;

    if (position.y > game.canvasSize.y) {
      removeFromParent();
    }
  }
}