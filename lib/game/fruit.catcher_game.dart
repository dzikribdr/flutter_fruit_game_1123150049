import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FruitCatcherGame extends FlameGame {
  final ValueNotifier<int> scoreNotifier = ValueNotifier(0);

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  void incrementScore() {
    scoreNotifier.value++;
  }
}
