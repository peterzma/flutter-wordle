import 'package:flutter/material.dart';

class EndGameDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final VoidCallback onRestart;

  const EndGameDialog({
    required this.won,
    required this.solution,
    required this.attempts,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      // bottom of dialog corners
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: won ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
              ),
            ),
            child: Text(
              won ? 'YOU WON' : 'YOU LOST',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // top left label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${solution.length} letters',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // two boxes
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        title: 'THE WORD WAS',
                        value: solution,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatBox(
                        title: 'ATTEMPTS', 
                        value: '$attempts',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onRestart,
                    child: const Text('NEW GAME'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// two centre buttons
class _StatBox extends StatelessWidget {
  final String title;
  final String value;

  const _StatBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0XFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
          value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}