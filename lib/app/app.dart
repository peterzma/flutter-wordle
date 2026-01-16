import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/home/views/home_screen.dart';
import 'package:uniordle/uniordle/views/uniordle_screen.dart';

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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.homeScreenBackground,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const MaxWidthLayout(
          child: HomeScreen(),
        ),
        '/uniordle': (context) => const MaxWidthLayout(
          child: UniordleScreen(),
        ),
      },
    );
  }
}

class MaxWidthLayout extends StatelessWidget {
  const MaxWidthLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 540,
          ),
          child: child,
        ),
      ),
    );
  }
}
