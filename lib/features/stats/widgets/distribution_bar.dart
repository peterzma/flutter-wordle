import 'package:uniordle/shared/exports/stats_exports.dart';

class DistributionBar extends StatelessWidget {
  final String label;
  final int count;
  final double progress;
  final bool isHighest;

  const DistributionBar({
    super.key,
    required this.label,
    required this.count,
    required this.progress,
    required this.isHighest,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.r(4)),
      child: Row(
        children: [
          SizedBox(width: 20, child: Text(label, style: context.labelMedium)),
          SizedBox(width: context.r(8)),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barWidth = (constraints.maxWidth * progress).clamp(
                  24.0,
                  constraints.maxWidth,
                );

                final isWideEnough = barWidth > 48;

                return Stack(
                  children: [
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: context.surfaceVariant,
                        borderRadius: BorderRadius.circular(64),
                      ),
                    ),
                    // Animated bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutQuart,
                      height: 24,
                      width: barWidth,
                      alignment: isWideEnough
                          ? Alignment.centerRight
                          : Alignment.center,
                      padding: EdgeInsets.only(right: isWideEnough ? 12 : 0),
                      decoration: BoxDecoration(
                        color: isHighest
                            ? context.colorScheme.primary
                            : context.colorScheme.outline,
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Text(
                        "$count",
                        style: context.labelSmall.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
