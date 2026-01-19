import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/settings/screens/settings_screen.dart';

/// Root widget of Uniordle
/// 
/// Sets up theme, routes, and initial home screen
class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uniordle',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppTextStyles.uiFont,
      ).copyWith(
        scaffoldBackgroundColor: AppColors.mainBackground,
      ),

      builder: (context, child) {
        return ResponsiveWrapper(child: child!);
      },

      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/uniordle': (context) => const UniordleScreen(),
        '/setup': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Discipline;
          return GameSettingsScreen(discipline: args);
        },
        '/settings': (context) => SettingsScreen(
          onClose: () => Navigator.of(context).pop(), 
        ),
      },
    );
  }
}

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.mainBackground, 
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}