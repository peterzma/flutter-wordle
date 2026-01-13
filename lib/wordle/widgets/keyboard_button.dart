import 'package:flutter/material.dart';
import 'package:flutter_wordle/app/app_colors.dart';

const double _buttonHeight = 64;
const double _buttonWidth = 44;
const double _specialButtonWidth = 66;
const double _padding = 4;
const double _textOffset = -2;
const double _specialOffset = -3;

class KeyboardButton extends StatefulWidget {
  const KeyboardButton({ 
    super.key,
    this.height = _buttonHeight,
    this.width = _buttonWidth,
    required this.onTap,
    required this.backgroundColor,
    this.letter,
    this.child,
    });

    final double height;
    final double width;
    final VoidCallback onTap;
    final Color backgroundColor;
    final String? letter;
    final Widget? child;

    // del and enter keys are special sizes
    factory KeyboardButton.delete({ 
      required VoidCallback onTap 
    }) =>
      KeyboardButton(
        width: _specialButtonWidth,
        onTap: onTap,
        backgroundColor: keyBackground,
        child: Transform.translate(
          offset: const Offset(0, _specialOffset),
          child: const Icon(
            Icons.backspace, 
            color: Colors.white, 
            size: 22,
          ),
        ),
      );

    factory KeyboardButton.enter({ 
      required VoidCallback onTap,
    }) =>
      KeyboardButton(
        width: _specialButtonWidth,
        onTap: onTap,
        backgroundColor: keyBackground,
        letter: 'ENTER',
        child: Transform.translate(
          offset: const Offset(0, _specialOffset),
          child: const Text(
            'ENTER',
            style: TextStyle(
              // smaller text for enter
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );

  @override
  State<KeyboardButton> createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> with SingleTickerProviderStateMixin{
  
  bool _isPressed = false;
  bool _isTapped = false;

  static const Duration _pressSpeed = Duration(milliseconds: 80);
  static const Duration _tapSpeed = Duration(milliseconds: 80); // ms for full animation
  static const int _darkenSpeed = 10; // ms
  static const double _darkenIntensity = 0.2;

  void _handleTap() {
    // trigger tap animation
    setState(() => _isTapped = true);
    Future.delayed(_tapSpeed, () {
      if (mounted) setState(() => _isTapped = false);
    });

    widget.onTap();
  }

    double get _currentScale {
    if (_isTapped) return 0.95; // start of tap animation
    return _isPressed ? 0.95 : 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        _padding,
      ),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _handleTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: _currentScale),
          duration: _isTapped
              ? _tapSpeed
              : _pressSpeed,
          curve: Curves.easeInOut,
          builder: (context, scale, child) => Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: _darkenSpeed),
              height: widget.height,
              width: widget.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isPressed || _isTapped
                    ? Color.alphaBlend(
                      Colors.black.withValues(alpha: _darkenIntensity), 
                        widget.backgroundColor
                      )
                    : widget.backgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: widget.child ?? Transform.translate(
                offset: const Offset(0, _textOffset),
                child: widget.child ?? Text(
                  widget.letter ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'dm-sans',
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}