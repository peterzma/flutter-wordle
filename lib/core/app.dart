import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/shared/navigation/main_navigation_screen.dart';
import 'package:uniordle/shared/responsive/responsive_wrapper.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uniordle',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      builder: (context, child) {
        return ResponsiveWrapper(child: child!);
      },

      initialRoute: '/',

      onGenerateRoute: (settings) {
        return InstantPageRoute(
          settings: settings,
          page: _getPage(settings),
        );
      },
    );
  }

  Widget _getPage(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return const MainNavigationScreen();
      case '/uniordle':
        return const GameScreen();
      case '/setup':
        final args = settings.arguments as Discipline;
        return GameSetupScreen(discipline: args);
      case '/settings':
        return Builder(builder: (context) {
          return SettingsScreen(
            onClose: () => Navigator.of(context).pop(),
          );
        });
      default:
        return const HomeScreen();
    }
  }
}

class InstantPageRoute extends PageRouteBuilder {
  final Widget page;

  InstantPageRoute({
    required this.page, super.settings
  }): super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
    );
}