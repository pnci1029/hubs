import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();
  
  bool _soundEnabled = true;
  bool _bgmEnabled = true;
  
  bool get soundEnabled => _soundEnabled;
  bool get bgmEnabled => _bgmEnabled;

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
  }

  void toggleBGM() {
    _bgmEnabled = !_bgmEnabled;
    if (!_bgmEnabled) {
      _bgmPlayer.stop();
    }
  }

  // BGM 재생
  Future<void> playBGM() async {
    if (!_bgmEnabled) return;
    
    try {
      await _bgmPlayer.play(AssetSource('sounds/bgm.mp3'));
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.setVolume(0.3);
    } catch (e) {
      // 파일이 없는 경우 무시
    }
  }

  // 효과음 재생
  Future<void> playSFX(String soundName) async {
    if (!_soundEnabled) return;
    
    try {
      await _sfxPlayer.play(AssetSource('sounds/$soundName.mp3'));
      await _sfxPlayer.setVolume(0.7);
    } catch (e) {
      // 파일이 없는 경우 무시
    }
  }

  // 카드 관련 사운드
  Future<void> playCardPlay() => playSFX('card_play');
  Future<void> playCardBuy() => playSFX('card_buy');
  Future<void> playCardDraw() => playSFX('card_draw');

  // 전투 관련 사운드
  Future<void> playAttack() => playSFX('attack');
  Future<void> playEnemyHit() => playSFX('enemy_hit');
  Future<void> playEnemyDeath() => playSFX('enemy_death');

  // 게임 관련 사운드
  Future<void> playRoundStart() => playSFX('round_start');
  Future<void> playRoundEnd() => playSFX('round_end');
  Future<void> playBossWarning() => playSFX('boss_warning');
  Future<void> playVictory() => playSFX('victory');
  Future<void> playGameOver() => playSFX('game_over');

  // UI 사운드
  Future<void> playButtonClick() => playSFX('button_click');
  Future<void> playError() => playSFX('error');

  void dispose() {
    _bgmPlayer.dispose();
    _sfxPlayer.dispose();
  }
}