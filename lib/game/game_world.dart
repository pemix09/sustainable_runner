import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

class GameWorld extends World with TapCallbacks, HasGameReference {
  late final SpriteComponent player;
  late final DateTime timeStarted;

  @override
  Future<void> onLoad() async {
    timeStarted = DateTime.now();
  }
}