import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onClose;
  final SettingsController controller = SettingsController();

  SettingsScreen({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SettingsState>(
      valueListenable: controller.state,
      builder: (context, state, _) {
        return Scaffold(
          backgroundColor: AppColorsDark.surface,
          body: SafeArea(
            child: Column(
              children: [
                BaseHeader(
                  title: 'Settings',
                  leftIcon: AppIcons.navBack,
                  onLeftTap: onClose,
                  actions: [
                    NavigationItem(
                      icon: state.darkModeEnabled
                          ? AppIcons.sysDark
                          : AppIcons.sysLight,
                      onTap: () =>
                          controller.setDarkMode(!state.darkModeEnabled),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.pagePadding,
                    ),
                    children: [
                      const SettingsHeader(title: 'PREFERENCES'),
                      SettingsSliderTile(
                        icon: AppIcons.sysMusicOn,
                        muteIcon: AppIcons.sysMusicOff,
                        label: 'Background Music',
                        value: state.musicVolume,
                        onChanged: controller.setMusicVolume,
                        onMuteToggle: controller.toggleMusicMute,
                      ),
                      const SizedBox(height: 8),
                      SettingsSliderTile(
                        icon: AppIcons.sysVolumeOn,
                        muteIcon: AppIcons.sysVolumeOff,
                        label: 'Sound Effects',
                        value: state.soundVolume,
                        onChanged: controller.setSoundVolume,
                        onMuteToggle: controller.toggleSoundMute,
                      ),
                      const SettingsHeader(title: 'SOCIALS'),
                      SettingsActionTile(
                        icon: AppIcons.linkProfile,
                        label: 'LinkedIn (Let\'s connect!)',
                        onTap: () => LinkService.launch(LinkService.linkedin),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: AppIcons.linkSource,
                        label: 'GitHub',
                        onTap: () => LinkService.launch(LinkService.github),
                      ),
                      const SizedBox(height: 8),

                      const SettingsHeader(title: 'SUPPORT'),
                      SettingsActionTile(
                        icon: AppIcons.linkBug,
                        label: 'Report a Bug',
                        onTap: () => LinkService.launch(LinkService.bugReport),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: AppIcons.linkIdea,
                        label: 'Feedback',
                        onTap: () => LinkService.launch(LinkService.feedback),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: AppIcons.linkAbout,
                        label: 'About Uniordle',
                        value: 'v1.0.0',
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) => const AboutGameDialog(),
                          );
                        },
                      ),
                      const SettingsHeader(title: 'DANGER ZONE'),
                      SettingsActionTile(
                        icon: AppIcons.sysDelete,
                        label: 'Clear All Data',
                        onTap: () => DataResetService.showDialog(context),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                SettingsSignOutButton(onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}
