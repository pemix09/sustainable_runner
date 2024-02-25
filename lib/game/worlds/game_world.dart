import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

class GameWorld extends World with TapCallbacks, HasGameReference {
  late final SpriteComponent player;
  late final DateTime timeStarted;

  /// The gravity is defined in virtual pixels per second squared.
  /// These pixels are in relation to how big the [FixedResolutionViewport] is.
  final double gravity = 30;

  /// Where the ground is located in the world and things should stop falling.
  late final double groundLevel = (size.y / 2) - (size.y / 5);

  Vector2 get size => game.size;

  @override
  Future<void> onLoad() async {
    timeStarted = DateTime.now();
  }
}