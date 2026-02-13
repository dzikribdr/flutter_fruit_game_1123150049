import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/managers/audio_manager.dart';
import 'package:fruit/game/fruit.catcher_game.dart';

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
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Fruit Catcher',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                );
              },
              child: const Text('START', style: TextStyle(fontSize: 22)),
            ),
          ],
        ),
      ),
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

  @override
  void initState() {
    super.initState();
    game = FruitCatcherGame(onGameOver: _onGameOver);
  }

  void _onGameOver(int score, int highScore) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Game Over'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Score: $score'), Text('High Score: $highScore')],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GameScreen()),
              );
            },
            child: const Text('RESTART'),
          ),
        ],
      ),
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
                  icon: const Icon(Icons.music_note, color: Colors.white),
                  onPressed: () => AudioManager().toggleMusic(),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.white),
                  onPressed: () => AudioManager().toggleSfx(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
