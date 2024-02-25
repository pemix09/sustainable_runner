import 'package:endless_runner/game/effects/move_effect.dart';
import 'package:endless_runner/game/objects/enemy.dart';
import 'package:endless_runner/game/screens/game_screen.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum PlayerState {
  running,
  jumping,
  falling,
  collectingGarbage,
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<SustainableRunner>, CollisionCallbacks {
  final double _playerSpeed = 300;
  final Vector2 _lastPosition = Vector2.zero();
  final double walkingSpeed = 0.1;

  // The current velocity that the player has that comes from being affected by
  // the gravity. Defined in virtual pixels/s².
  double _gravityVelocity = 0;
  int score = 0;
  int health = 3;

  double get playerBottomYPos => position.y + size.y / 2;

  bool get inAir => playerBottomYPos < game.world.groundLevel;

  bool get isFalling => _lastPosition.y < position.y;

  Player({
    super.position,
    super.size,
  }) : super(priority: 1);

  @override
  Future<void> onLoad() async {
    if (position == Vector2.zero()) {
      position = Vector2(game.canvasSize.x / 2, 0);
    }
    if (size == Vector2.zero()) {
      size = Vector2(64, 64);
    }

    final sprites = <Sprite>[];
    sprites.add(await game.loadSprite('tile_0355.png'));
    sprites.add(await game.loadSprite('tile_0356.png'));
    sprites.add(await game.loadSprite('tile_0357.png'));

    animations = {
      PlayerState.running: SpriteAnimation.spriteList(
        sprites,
        stepTime: walkingSpeed,
      ),
      PlayerState.jumping: SpriteAnimation.spriteList(
        sprites,
        stepTime: double.infinity,
      ),
      PlayerState.falling: SpriteAnimation.spriteList(
        sprites,
        stepTime: double.infinity,
      ),
    };
    // The starting state will be that the player is running.
    current = PlayerState.running;
    _lastPosition.setFrom(position);
  }

  @override
  void onMount() {
    super.onMount();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.clamp(Vector2.zero() + size / 2, game.canvasSize - size / 2);

    if (inAir) {
      _gravityVelocity += game.world.gravity * dt;
      position.y += _gravityVelocity;
      if (isFalling) {
        current = PlayerState.falling;
      }
    }

    final belowGround = playerBottomYPos > game.world.groundLevel;
    // If the player's new position would overshoot the ground level after
    // updating its position we need to move the player up to the ground level
    // again.
    if (belowGround) {
      position.y = game.world.groundLevel - size.y / 2;
      _gravityVelocity = 0;
      current = PlayerState.running;
    }

    _lastPosition.setFrom(position);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      health--;

      if (health == 0) {
        game.pauseEngine();
        game.overlays.add(GameScreen.lostDialogKey);
      }
    }
  }

  void moveLeft() {
    if (current != PlayerState.running) {
      current = PlayerState.running;
    }
    final moveVector = game.canvasSize / 5;
    moveVector.y = 0;
    add(MoveEffect(-moveVector));
  }

  void moveRight() {
    if (current != PlayerState.running) {
      current = PlayerState.running;
    }
    final moveVector = game.canvasSize / 5;
    moveVector.y = 0;
    add(MoveEffect(moveVector));
  }

  void jump(Vector2 jumpVector) {
    if (current != PlayerState.jumping) {
      current = PlayerState.jumping;
    }
    // Since `towards` is normalized we need to scale (multiply) that vector by
    // the length that we want the jump to have.
    final moveEffect = MoveEffect(jumpVector);

    // We only allow jumps when the player isn't already in the air.
    if (!inAir) {
      //game.audioController.playSfx(SfxType.jump);
      add(moveEffect);
    }
  }
}
