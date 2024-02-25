import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class TrashBag extends SpriteComponent with HasGameRef<SustainableRunner> {
  final double _speed = 250;

  TrashBag({
    super.position,
    super.size,
  });

  @override
  void onMount() {
    super.onMount();
    add(CircleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    const spriteSheetFileName = 'simpleSpace_sheet@2.png';
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: game.images.fromCache(spriteSheetFileName),
      columns: 9,
      rows: 5,
    );

    sprite = spriteSheet.getSpriteById(2);
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
