import 'package:endless_runner/game/game_world.dart';
import 'package:endless_runner/game/knows_game_size.dart';
import 'package:endless_runner/game/move_direction.dart';
import 'package:endless_runner/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

class SustainableRunner extends FlameGame<GameWorld>
    with HasCollisionDetection, HorizontalDragDetector {
  late Player player;
  int numberOfLines = 5;
  int currentLine = 3;

  SustainableRunner()
      : super(
          world: GameWorld(),
          camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
        );

  @override
  Future<void> onLoad() async {
    const spriteSheetFileName = 'simpleSpace_sheet@2.png';
    await images.load(spriteSheetFileName);

    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache(spriteSheetFileName),
      columns: 9,
      rows: 5,
    );

    player = Player(
      sprite: spriteSheet.getSpriteById(2),
      size: Vector2(64, 64),
      position: canvasSize / 2,
    );

    player.anchor = Anchor.center;

    add(player);

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onGameResize(Vector2 size) {
    print('Game resizing');

    for (var child in children.whereType<KnowsGameSize>()) {
      child.onResize(size);
    }
    super.onGameResize(size);
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    print(info.velocity.x < 0 ? 'left swipe' : 'right swipe');
    var playerMoveDirection =
        info.velocity.x < 0 ? MoveDirection.left : MoveDirection.right;
    if (playerMoveDirection == MoveDirection.left) {
      player.moveDirection = moveLeftVector();
    } else {
      player.moveDirection = moveRightVector();
    }
  }

  Vector2 moveLeftVector() {
    if (currentLine > 1) {
      currentLine--;
    }
    return Vector2(-20, 0);
  }

  Vector2 moveRightVector() {
    if (currentLine < 4) {
      currentLine++;
    }
    return Vector2(20, 0);
  }
}
