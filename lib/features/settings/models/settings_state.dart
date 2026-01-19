class SettingsState {
  final bool soundsEnabled;
  final bool darkModeEnabled;

  SettingsState({
    this.soundsEnabled = true,
    this.darkModeEnabled = true,
  });

  SettingsState copyWith({
    bool? soundsEnabled,
    bool? darkModeEnabled,
  }) {
    return SettingsState(
      soundsEnabled: soundsEnabled ?? this.soundsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }
}