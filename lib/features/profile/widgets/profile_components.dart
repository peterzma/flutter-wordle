import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String label, value;
  const SummaryCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(), 
            style: const TextStyle(
              color: Colors.orange, 
            )
          ),
          const SizedBox(height: 8),
          Text(
            value, 
            style: const TextStyle(
              color: Colors.redAccent, 
            )
          ),
        ],
      ),
    );
  }
}