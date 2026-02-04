import 'package:uniordle/shared/exports/home_exports.dart';
import 'dart:math';

class WiggleButtonWrapper extends StatefulWidget {
  final Widget child;

  const WiggleButtonWrapper({
    super.key, required this.child
  });

  @override
  State<WiggleButtonWrapper> createState() => WiggleButtonWrapperState();
}

class WiggleButtonWrapperState extends State<WiggleButtonWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

 void wiggle() {
    if (!_controller.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double offset = sin(_controller.value * 4 * pi) * 4 * (1 - _controller.value);
        
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}