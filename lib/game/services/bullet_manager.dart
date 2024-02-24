import 'package:endless_runner/game/objects/bullet.dart';
import 'package:flame/components.dart';

class BulletManager extends Component {
  Iterable<Bullet> get bullets => children.whereType<Bullet>();
}