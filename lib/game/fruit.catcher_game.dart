import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/basket.dart';
import 'components/fruit.dart';
import 'components/floating_text.dart';
import 'managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame
    with HasCollisionDetection, PanDetector {
  final Random random = Random();
  int score = 0;
  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
    add(Basket(position: Vector2(size.x / 2, size.y - 70)));

    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(16, 16),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 3)],
        ),
      ),
    );

    add(scoreText);

    add(TimerComponent(period: 0.9, repeat: true, onTick: spawnFruit));

    AudioManager().playBackgroundMusic();
  }

  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    add(Fruit(position: Vector2(x, -30)));
  }

  void addScore(Vector2 pos) {
    score++;
    scoreText.text = 'Score: $score';

    add(FloatingText(text: '+1', position: pos, color: Colors.greenAccent));

    AudioManager().playSfx('collect.mp3');
  }

  void minusScore(Vector2 pos) {
    score--;
    scoreText.text = 'Score: $score';

    add(FloatingText(text: '-1', position: pos, color: Colors.redAccent));
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final basket = children.whereType<Basket>().first;

    basket.position.x += info.delta.global.x;

    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF64B5F6), Color(0xFFBBDEFB)],
      ).createShader(rect);

    canvas.drawRect(rect, paint);
    super.render(canvas);
  }
}
