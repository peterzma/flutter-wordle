class SettingsState {
  final bool soundsEnabled;
  final bool musicEnabled;
  final double soundVolume;
  final double musicVolume;
  final bool darkModeEnabled;

  SettingsState({
    this.soundsEnabled = true,
    this.musicEnabled = true,
    this.soundVolume = 0.5,
    this.musicVolume = 0.5,
    this.darkModeEnabled = true,
  });

  SettingsState copyWith({
    bool? soundsEnabled,
    bool? musicEnabled,
    double? soundVolume,
    double? musicVolume,
    bool? darkModeEnabled,
  }) {
    return SettingsState(
      soundsEnabled: soundsEnabled ?? this.soundsEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      soundVolume: soundVolume ?? this.soundVolume,
      musicVolume: musicVolume ?? this.musicVolume,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }
}