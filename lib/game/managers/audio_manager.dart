import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool _music = true;
  bool _sfx = true;

  Future<void> initialize() async {
    await FlameAudio.audioCache.loadAll([
      'music/background_music.mp3',
      'sfx/collect.mp3',
    ]);
    FlameAudio.bgm.initialize();
  }

  void playBackgroundMusic() {
    if (_music && !FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.play('music/background_music.mp3');
    }
  }

  void toggleMusic() {
    _music = !_music;
    _music ? FlameAudio.bgm.resume() : FlameAudio.bgm.pause();
  }

  void toggleSfx() => _sfx = !_sfx;

  void playSfx(String file) {
    if (_sfx) FlameAudio.play('sfx/$file', volume: 0.7);
  }
}
