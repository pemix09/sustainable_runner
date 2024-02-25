import 'package:endless_runner/game/objects/background.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class GameWorld extends World with TapCallbacks, HasGameRef<SustainableRunner> {
  late final DateTime timeStarted;
  final double gravity = 30;
  double get groundLevel => game.size.y - 20;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    timeStarted = DateTime.now();
    add(Background());
  }
}
