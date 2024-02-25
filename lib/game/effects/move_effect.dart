import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

class MoveEffect extends MoveByEffect {
  MoveEffect(Vector2 moveVector)
      : super(moveVector, EffectController(duration: 0.3, curve: Curves.ease));
}