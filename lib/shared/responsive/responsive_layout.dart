import 'package:uniordle/core/app_layout.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget smallScreen;
  final Widget largeScreen;

  const ResponsiveLayout({
    super.key,
    required this.smallScreen,
    required this.largeScreen,
  });

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < AppLayout.breakpoint;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AppLayout.breakpoint) {
          return smallScreen;
        }
        return largeScreen;
      },
    );
  }
}