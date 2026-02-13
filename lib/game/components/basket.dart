import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent
    with HasGameRef, CollisionCallbacks, DragCallbacks {
  Basket() : super(size: Vector2(100, 60));

  @override
  Future<void> onLoad() async {
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position.x += event.localDelta.x;

    // Supaya tidak keluar layar
    position.x = position.x.clamp(size.x / 2, gameRef.size.x - size.x / 2);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.brown;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        const Radius.circular(12),
      ),
      paint,
    );
  }
}
