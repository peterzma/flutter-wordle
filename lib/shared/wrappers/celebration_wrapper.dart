import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CelebrationWrapper extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final Duration duration;

  const CelebrationWrapper({
    super.key,
    required this.child,
    this.colors,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<CelebrationWrapper> createState() => _CelebrationWrapperState();
}

class _CelebrationWrapperState extends State<CelebrationWrapper> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: widget.duration);
    // Start the party immediately
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        widget.child,
        ConfettiWidget(
          confettiController: _controller,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors:
              widget.colors ??
              [
                Colors.orange,
                Colors.blue,
                Colors.white,
                Colors.red,
                Colors.purple,
              ],
          minimumSize: const Size(5, 5),
          maximumSize: const Size(10, 10),
          gravity: 0.2,
        ),
      ],
    );
  }
}
