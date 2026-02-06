import 'dart:developer';
import 'package:flutter_soloud/flutter_soloud.dart';

enum SoundType {
  click,
  keyboard,
  delete,
  enter,
  hover,
  win,
  lose,
  levelUp,
  creditEarned,
  rankUp,
  tileFlip,
  gameSettings,
  lockedMajor,
  unlockMajor,
  menuMusic,
  gameMusic,
}

class SoundManager {
  static final SoundManager _instance = SoundManager._internal();
  factory SoundManager() => _instance;
  SoundManager._internal();

  final Map<SoundType, AudioSource> _sources = {};

  // final Map<SoundType, double> _volumes = {
  //   SoundType.click: 0.4,
  //   SoundType.keyboard: 0.4,
  //   SoundType.delete: 0.2,
  //   SoundType.enter: 0.2,
  //   SoundType.hover: 0.4,
  //   SoundType.gameSettings: 0.4,
  //   SoundType.win: 1,
  //   SoundType.lose: 1,
  //   SoundType.levelUp: 1,
  //   SoundType.creditEarned: 1,
  //   SoundType.rankUp: 1,
  //   SoundType.tileFlip: 1,
  // };

  bool _isInitialized = false;
  double _musicVolume = 1.0;
  double _soundVolume = 1.0;

  SoundHandle? _activeMusicHandle;
  bool _musicEnabled = true;

  set musicVolume(double value) {
    _musicVolume = value;
    if (_activeMusicHandle != null) {
      SoLoud.instance.setVolume(_activeMusicHandle!, value);
    }
  }

  set soundVolume(double value) => _soundVolume = value;

  set musicEnabled(bool value) {
    if (_musicEnabled == value) return;
    _musicEnabled = value;
    if (!value) {
      fadeOutAndStop(
        duration: const Duration(milliseconds: 500),
        isMuting: true,
      );
    } else if (_currentlyPlayingType != null) {
      playMusic(_currentlyPlayingType!);
    }
  }

  SoundType? _currentlyPlayingType;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await SoLoud.instance.init();

      _sources[SoundType.click] = await SoLoud.instance.loadAsset(
        'assets/audio/click.mp3',
      );
      _sources[SoundType.keyboard] = await SoLoud.instance.loadAsset(
        'assets/audio/keyboard_tap.mp3',
      );
      _sources[SoundType.delete] = await SoLoud.instance.loadAsset(
        'assets/audio/special_key.mp3',
      );
      _sources[SoundType.enter] = await SoLoud.instance.loadAsset(
        'assets/audio/special_key.mp3',
      );
      _sources[SoundType.hover] = await SoLoud.instance.loadAsset(
        'assets/audio/hover.mp3',
      );
      _sources[SoundType.gameSettings] = await SoLoud.instance.loadAsset(
        'assets/audio/click.mp3',
      );
      _sources[SoundType.win] = await SoLoud.instance.loadAsset(
        'assets/audio/win.mp3',
      );
      _sources[SoundType.lose] = await SoLoud.instance.loadAsset(
        'assets/audio/lose.mp3',
      );
      _sources[SoundType.levelUp] = await SoLoud.instance.loadAsset(
        'assets/audio/level_up.mp3',
      );
      _sources[SoundType.creditEarned] = await SoLoud.instance.loadAsset(
        'assets/audio/credit_earned.mp3',
      );
      _sources[SoundType.rankUp] = await SoLoud.instance.loadAsset(
        'assets/audio/rank_up.mp3',
      );
      _sources[SoundType.tileFlip] = await SoLoud.instance.loadAsset(
        'assets/audio/tile_flip.mp3',
      );
      _sources[SoundType.menuMusic] = await SoLoud.instance.loadAsset(
        'assets/audio/test_music.mp3',
      );
      _sources[SoundType.gameMusic] = await SoLoud.instance.loadAsset(
        'assets/audio/test_music2.mp3',
      );
      _sources[SoundType.lockedMajor] = await SoLoud.instance.loadAsset(
        'assets/audio/locked_major.mp3',
      );
      _sources[SoundType.unlockMajor] = await SoLoud.instance.loadAsset(
        'assets/audio/unlock_major.mp3',
      );

      _isInitialized = true;
    } catch (e) {
      log('Audio Init Error: $e');
    }
  }

  void play(SoundType type) {
    final source = _sources[type];
    if (source != null && _isInitialized) {
      SoLoud.instance.play(source, volume: _soundVolume);
    }
  }

  void dispose() {
    SoLoud.instance.deinit();
  }

  void playMusic(SoundType type) async {
    if (!_isInitialized) return;
    if (_currentlyPlayingType == type && _activeMusicHandle != null) return;

    _currentlyPlayingType = type;
    if (!_musicEnabled) return;

    if (_activeMusicHandle != null) {
      final oldHandle = _activeMusicHandle!;
      SoLoud.instance.fadeVolume(oldHandle, 0, const Duration(seconds: 1));
      Future.delayed(
        const Duration(seconds: 1),
        () => SoLoud.instance.stop(oldHandle),
      );
    }

    final source = _sources[type];
    if (source == null) return;

    _activeMusicHandle = await SoLoud.instance.play(
      source,
      volume: 0,
      looping: true,
    );
    SoLoud.instance.fadeVolume(
      _activeMusicHandle!,
      _musicVolume,
      const Duration(seconds: 1),
    );
  }

  void fadeOutAndStop({
    Duration duration = const Duration(seconds: 2),
    bool isMuting = false,
  }) {
    if (_activeMusicHandle != null) {
      final handleToStop = _activeMusicHandle!;
      SoLoud.instance.fadeVolume(handleToStop, 0, duration);

      _activeMusicHandle = null;

      if (!isMuting) {
        _currentlyPlayingType = null;
      }

      Future.delayed(duration, () => SoLoud.instance.stop(handleToStop));
    }
  }
}
