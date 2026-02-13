import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent with CollisionCallbacks {
  Basket({super.position}) : super(size: Vector2(110, 32));

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    final shadow = Paint()
      ..color = Colors.black26
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final paint = Paint()..color = Colors.orangeAccent;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2, 4, size.x, size.y),
        const Radius.circular(16),
      ),
      shadow,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        const Radius.circular(16),
      ),
      paint,
    );
  }
}
