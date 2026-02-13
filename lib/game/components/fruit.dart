import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:fruit/game/fruit.catcher_game.dart';
import 'basket.dart';

class Fruit extends PositionComponent
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
  final double speed = 250;

  Fruit({super.position}) : super(size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    position.y += speed * dt;

    if (position.y > gameRef.size.y + 50) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Basket) {
      gameRef.incrementScore();
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
