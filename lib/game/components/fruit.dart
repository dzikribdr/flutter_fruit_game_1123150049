import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import 'package:fruit/game/fruit.catcher_game.dart';
import 'basket.dart';

class Fruit extends SpriteComponent
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
  final double speed;

  Fruit({required super.position, required this.speed})
    : super(size: Vector2.all(42));

  static final images = [
    'images/apple.png',
    'images/banana.png',
    'images/orange.png',
    'images/strawberry.png',
  ];

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    sprite = await Sprite.load(images[Random().nextInt(images.length)]);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    position.y += speed * dt;

    if (position.y > gameRef.size.y + 60) {
      gameRef.missFruit(position.clone());
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Basket) {
      gameRef.addScore(position.clone());
      removeFromParent();
    }
  }
}
