import 'package:endless_runner/game/objects/background.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class GameWorld extends World with TapCallbacks, HasGameReference {
  late final DateTime timeStarted;
  final double gravity = 30;
  late final double groundLevel;

  @override
  Future<void> onLoad() async {
    groundLevel = game.size.y - 20;
    timeStarted = DateTime.now();
    add(Background());
  }
}
