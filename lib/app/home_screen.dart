import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';

/// The first screen the user sees on opening application
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeScreenBackground,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context, '/wordle'
            );
          },
          child: const Text(
            'Play Uniordle',
          ),
        ),
      ),
    );
  }
}