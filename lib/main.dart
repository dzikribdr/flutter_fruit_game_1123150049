import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/fruit.catcher_game.dart';
import 'game/managers/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late FruitCatcherGame game;
  bool isGameOver = false;
  int lastScore = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    isGameOver = false;
    game = FruitCatcherGame(
      onGameOver: (score) {
        setState(() {
          isGameOver = true;
          lastScore = score;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),

          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.music_note),
                  color: Colors.white,
                  onPressed: () => AudioManager().toggleMusic(),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  color: Colors.white,
                  onPressed: () => AudioManager().toggleSfx(),
                ),
              ],
            ),
          ),

          if (isGameOver)
            Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'GAME OVER',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Score: $lastScore',
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => setState(startGame),
                      child: const Text('Restart'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
