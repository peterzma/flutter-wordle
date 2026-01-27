import 'package:uniordle/shared/exports/end_game_exports.dart';

class LevelUpDialog extends StatefulWidget {
  final int startingLevel;
  final double startingProgress;
  final double gainedXP;
  final Discipline discipline;

  const LevelUpDialog({
    super.key,
    required this.startingLevel,
    required this.startingProgress,
    required this.gainedXP,
    required this.discipline,
  });

  @override
  State<LevelUpDialog> createState() => _LevelUpDialogState();
}

class _LevelUpDialogState extends State<LevelUpDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasLeveledUp = false;
  int _newLevelReached = 0;

  @override
  void initState() {
    super.initState();
    final double startTotal = widget.startingLevel + widget.startingProgress;
    final double levelGain = widget.gainedXP / 100;
    final double endTotal = startTotal + levelGain;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 + (levelGain * 500).toInt()),
    );

    _animation = Tween<double>(begin: startTotal, end: endTotal)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    _controller.addListener(() {
      int currentLevel = _animation.value.floor();
      if (currentLevel > widget.startingLevel && !_hasLeveledUp) {
        setState(() {
          _hasLeveledUp = true;
          _newLevelReached = currentLevel;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () => _controller.forward());
  }

  String _getRankMessage(int level) {
    if (level % 10 == 0) return "NEW ACADEMIC RANK!";
    if (level % 5 == 0 && level <= 70) return "ACADEMIC MILESTONE!";
    return "LEVEL UP!";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("PROGRESS", style: AppFonts.labelMedium),
              const SizedBox(height: 16),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) => LevelCard(
                  level: _animation.value.floor(),
                  progress: _animation.value % 1.0,
                  nextLevel: _animation.value.floor() + 1,
                  progressLabel: _hasLeveledUp ? "GOAL REACHED" : "STUDYING...",
                ),
              ),
              if (_hasLeveledUp) ...[
                const SizedBox(height: 20),
                _buildMilestoneBox(),
              ],

              const SizedBox(height: 36),

              PrimaryButton(
              label: 'NEW GAME',
              color: AppColors.accent,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/setup',
                  (route) => route.isFirst, 
                  arguments: widget.discipline,
                );
              },
              borderRadius: 24,
            ),

              const SizedBox(height: 12),
              
              PrimaryButton(
              label: 'HOME',
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              },
            ),

            ]
          )
        )
      ) 
    );
  } 

  Widget _buildMilestoneBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent),
      ),
      child: Column(
        children: [
          Text(_getRankMessage(_newLevelReached),
              style: AppFonts.labelLarge),
          Text("Level $_newLevelReached attained", style: AppFonts.labelMedium),
        ],
      ),
    );
  }
}



