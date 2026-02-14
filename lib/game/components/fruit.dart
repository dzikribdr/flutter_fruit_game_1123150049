import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../fruit.catcher_game.dart';
import 'basket.dart';

class Fruit extends PositionComponent
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
  final double speed;

  late final Paint paint;

  Fruit({required super.position, required this.speed})
    : super(size: Vector2.all(36)) {
    // Warna ditentukan SEKALI saat object dibuat
    paint = Paint()
      ..color = _fruitColors[Random().nextInt(_fruitColors.length)];
  }

  static const List<Color> _fruitColors = [
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
  ];

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    position.y += speed * dt;

    if (position.y > gameRef.size.y + 40) {
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

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
