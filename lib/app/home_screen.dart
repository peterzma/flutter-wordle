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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 128,
        title: const Text(
            'Uniordle',
            style: TextStyle(
              fontSize: 72,
              fontFamily: 'clashdisplay',
              fontWeight: FontWeight.w600,
            ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _showSettingsDialog(context),
        )
      )
    );
  }

  void _showSettingsDialog(BuildContext context) {
    
  }
}