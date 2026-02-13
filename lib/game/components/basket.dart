import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent with CollisionCallbacks {
  Basket({super.position}) : super(size: Vector2(100, 30));

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.orangeAccent;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        const Radius.circular(14),
      ),
      paint,
    );
  }
}
