import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import '../fruit.catcher_game.dart';
import 'basket.dart';

class Fruit extends PositionComponent
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
  late final double speed;
  late final Paint paint;

  Fruit({super.position}) : super(size: Vector2.all(42)) {
    speed = 200 + Random().nextDouble() * 160;
    paint = Paint()
      ..color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    position.y += speed * dt;

    if (position.y > gameRef.size.y + 60) {
      gameRef.minusScore(position.clone());
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

  @override
  void render(Canvas canvas) {
    final glow = Paint()
      ..color = paint.color!.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2 + 3, glow);

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
