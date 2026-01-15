import 'package:flutter/material.dart';
import 'package:uniordle/uniordle/data/university_data.dart';

class CampusCard extends StatelessWidget {
  final University university;
  final VoidCallback onTap;

  const CampusCard({
    super.key,
    required this.university,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F2B),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageHeader(),
            _buildCardFooter(),
          ],
        ),
      ),
    ),
  );
  }

  Widget _buildImageHeader() {
    return Expanded(
      flex: 3,
      child: ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
            stops: [0.6, 1.0],
          ).createShader(rect),
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          university.path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCardFooter() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              university.shortName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.circle, 
                  size: 8, 
                  color: Colors.blue
                ),
                const SizedBox(width: 6),
                Text(
                  'NEW CODE',
                  style: TextStyle(
                    color: Colors.blue.withValues(alpha: 0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}