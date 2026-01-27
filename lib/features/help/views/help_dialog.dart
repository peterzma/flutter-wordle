import 'package:uniordle/shared/exports/help_exports.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 320,
                  child: PageView(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    children: [
                      const HowToPlay(),
                      const LevelUp(),
                      const ReachTop(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PageIndicator(
                  totalPages: _totalPages,
                  currentPage: _currentPage,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Got it!',
                  onPressed: () => Navigator.pop(context),
                  height: 48,
                  width: 300
                ),
              ],
            ),
          ),
      
          // Left Arrow
          if (_currentPage > 0)
            NavArrow(
              isLeft: true,
              onTap: () => _pageController.jumpToPage(_currentPage - 1),
            ),
      
          // Right Arrow
          if (_currentPage < _totalPages - 1)
            NavArrow(
              isLeft: false,
              onTap: () => _pageController.jumpToPage(_currentPage + 1),
            ),
        ],
      ),
    );
  }
}

class NavArrow extends StatelessWidget {
  final bool isLeft;
  final VoidCallback onTap;

  const NavArrow({
    super.key,
    required this.isLeft,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -24,
      bottom: -24,
      left: isLeft ? -25 : null,
      right: !isLeft ? -25 : null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? const Radius.circular(32) : Radius.zero,
              bottomLeft: isLeft ? const Radius.circular(32) : Radius.zero,
              topRight: !isLeft ? const Radius.circular(32) : Radius.zero,
              bottomRight: !isLeft ? const Radius.circular(32) : Radius.zero,
            ),
          ),
          child: Center(
            child: Icon(
              isLeft ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
              color: AppColors.outline,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}