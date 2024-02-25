import 'dart:math';

import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef<SustainableRunner> {
  Background() : super() {
    angle = pi / 2;
  }

  @override
  Future<void> onLoad() async {
    final background = await game.images.load("scenery/Bmrfloor009.png");
    size = game.canvasSize;
    sprite = Sprite(background);
  }
}