import 'package:uniordle/shared/exports/game_screen_exports.dart';


class DialogHeader extends StatelessWidget {
  final bool won;

  const DialogHeader({super.key, required this.won});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFF1B2E1D),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.stars_rounded, color: Color(0xFF55B725), size: 60),
        ),
        const SizedBox(height: 16),
        Text(
          won ? 'YOU WIN!' : 'GAME OVER',
          style: GameFonts.infoBarText.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}