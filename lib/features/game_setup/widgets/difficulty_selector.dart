import 'package:auto_size_text/auto_size_text.dart';
import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/services/models/difficulty_config.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';

class DifficultySelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final Discipline discipline;

  const DifficultySelector({
    super.key, 
    required this.value, 
    required this.onChanged,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    final levels = DifficultyConfig.levels.entries.toList();
    final bool mobileMode = AppLayout.mobileMode(context);
    return Column(
      children: [
        Text(
          'YEAR LEVEL',
          style: AppFonts.displayMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.attempts,
              size: 12,
              color: discipline.color,
            ),
            const SizedBox(width: 8),
            Text(
              'ATTEMPTS ALLOWED',
              style: AppFonts.labelMedium.copyWith(color: discipline.color),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: discipline.color,
            inactiveTrackColor: Colors.white24,
            thumbColor: discipline.color,
            overlayColor: Colors.transparent,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 3.0),
            activeTickMarkColor: discipline.color,
            inactiveTickMarkColor: AppColors.onSurfaceVariant,
          ),
          child: SizedBox(
            height: 20,
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              onChanged: (v) {
                final newValue = v.round();
                
                if (newValue != value) {
                  SoundManager().play(SoundType.settings, volumeOverride: 0.5);
                  
                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: levels.map((e) {    
              final active = e.key == value;
              final isFirst = e.key == 1;
              final isLast = e.key == 4;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isFirst 
                  ? CrossAxisAlignment.start 
                  : isLast 
                      ? CrossAxisAlignment.end 
                      : CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    child: AutoSizeText(
                      mobileMode 
                        ? e.value.$1.replaceAll(' Year', '').trim() 
                        : e.value.$1,
                      textAlign: isFirst ? TextAlign.left : (isLast ? TextAlign.right : TextAlign.center),
                      minFontSize: 8,
                      maxLines: 1,
                      style: active
                          ? AppFonts.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
                          : AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        e.value.$2.toString(),
                        style: active
                            ? AppFonts.labelMedium.copyWith(color: discipline.color, fontWeight: FontWeight.w600)
                            : AppFonts.labelMedium,
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        AppIcons.attempts,
                        size: 12,
                        color: active
                            ? discipline.color
                            : AppColors.onSurfaceVariant,
                      )
                    ],
                  )
                ],
              );
            }).toList()
          ),
        )
      ],
    );
  }
}