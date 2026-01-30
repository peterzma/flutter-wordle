import 'package:uniordle/shared/exports/game_exports.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < AppLayout.breakpoint;

        return Material(
          color: AppColors.surface, 
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isSmall ? double.infinity : AppLayout.minAppWidth,
              ),
              child: ClipRect(child: child),
            ),
          ),
        );
      },
    );
  }
}