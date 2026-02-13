import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FloatingText extends TextComponent {
  double life = 1;

  FloatingText({
    required String text,
    required Vector2 position,
    required Color color,
  }) : super(
         text: text,
         position: position,
         anchor: Anchor.center,
         textRenderer: TextPaint(
           style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
             color: color,
             shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
           ),
         ),
       );

  @override
  void update(double dt) {
    life -= dt;
    position.y -= 35 * dt;

    if (life <= 0) removeFromParent();
  }
}
