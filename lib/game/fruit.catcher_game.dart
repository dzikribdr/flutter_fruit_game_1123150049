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
  int highScore = 0;
  int level = 1;
  int life = 3;

  double spawnRate = 1;
  double fruitSpeed = 200;

  late TextComponent hudText;

  @override
  Future<void> onLoad() async {
    add(Basket(position: Vector2(size.x / 2, size.y - 70)));

    hudText = TextComponent(
      text: hudString,
      position: Vector2(12, 12),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
        ),
      ),
    );

    add(hudText);

    add(TimerComponent(period: spawnRate, repeat: true, onTick: spawnFruit));

    AudioManager().playBackgroundMusic();
  }

  String get hudString =>
      'Score: $score   ❤️ $life   Lv: $level   🏆 $highScore';

  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    add(Fruit(position: Vector2(x, -40), speed: fruitSpeed));
  }

  void addScore(Vector2 pos) {
    score++;
    if (score > highScore) highScore = score;

    add(FloatingText(text: '+1', position: pos, color: Colors.greenAccent));
    AudioManager().playSfx('collect.mp3');

    if (score % 10 == 0) nextLevel();

    updateHud();
  }

  void missFruit(Vector2 pos) {
    life--;

    add(FloatingText(text: '-1', position: pos, color: Colors.redAccent));

    if (life <= 0) gameOver();

    updateHud();
  }

  void nextLevel() {
    level++;
    fruitSpeed += 60;

    spawnRate = max(0.35, spawnRate - 0.08);

    children.whereType<TimerComponent>().forEach((t) {
      t.timer.stop();
      t.timer.start();
      t.timer.limit = spawnRate;
    });
  }

  void updateHud() {
    hudText.text = hudString;
  }

  void gameOver() {
    pauseEngine();

    add(
      TextComponent(
        text: 'GAME OVER',
        anchor: Anchor.center,
        position: size / 2,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
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
