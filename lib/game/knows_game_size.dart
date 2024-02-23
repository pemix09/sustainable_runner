import 'package:flame/components.dart';

mixin KnowsGameSize on Component {
  Vector2? gameSize = null;

  void onResize(Vector2 newGameSize) {
    gameSize = newGameSize;
  }
}