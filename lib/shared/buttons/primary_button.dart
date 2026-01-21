import 'package:flutter/material.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final bool isLoading;
  final IconData? icon;
  final double height;
  final double borderRadius;
  final bool showShadow;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
    this.isLoading = false,
    this.icon,
    this.height = 60,
    this.borderRadius = 16,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return PumpButtonWrapper(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: showShadow
            ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ]
            : null,
        ),
        child: Center(
          child: isLoading
              ? _buildLoader()
              : _buildContent(),
        ),
      )
    );
  }

  Widget _buildLoader() {
    return const SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 28, color: Colors.white),
          const SizedBox(width: 8),
        ],
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}