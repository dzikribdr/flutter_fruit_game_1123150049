import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FloatingText extends TextComponent {
  double life = 1.0;

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
             fontSize: 22,
             fontWeight: FontWeight.bold,
             color: color,
             shadows: const [Shadow(color: Colors.black45, blurRadius: 4)],
           ),
         ),
       );

  @override
  void update(double dt) {
    super.update(dt);

    life -= dt;
    position.y -= 40 * dt;

    final alpha = (life * 255).clamp(0, 255).toInt();

    textRenderer = TextPaint(
      style: (textRenderer as TextPaint).style.copyWith(
        color: (textRenderer as TextPaint).style.color!.withAlpha(alpha),
      ),
    );

    if (life <= 0) removeFromParent();
  }
}
