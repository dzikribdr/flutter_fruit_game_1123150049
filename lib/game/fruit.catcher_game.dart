import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/basket.dart';
import 'components/fruit.dart';
import 'managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame with HasCollisionDetection {
  final ValueNotifier<int> scoreNotifier = ValueNotifier(0);
  final Random random = Random();

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Basket());

    add(TimerComponent(period: 1, repeat: true, onTick: spawnFruit));

    AudioManager().playBackgroundMusic();
  }

  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    add(Fruit(position: Vector2(x, -50)));
  }

  void incrementScore() {
    scoreNotifier.value++;
    AudioManager().playSfx('collect.mp3');
  }
}
