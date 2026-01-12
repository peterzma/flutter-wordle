import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';
import 'package:flutter_wordle/app/app_colors.dart';


class BoardTile extends StatefulWidget {
  const BoardTile({
    Key? key,
    required this.letter,
    this.initialBorderColor = tileBackground, 
  }) : super (key: key);

  final Letter letter;
  final Color initialBorderColor;

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 320),
      vsync: this,
    );

    // pump effect
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.02), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.02, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: _controller, 
        curve: Curves.bounceInOut));
  }

  @override
  void didUpdateWidget(covariant BoardTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // plays pump effect when added letter or removed
    if (oldWidget.letter.val != widget.letter.val) {
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
    return ScaleTransition(
      scale: _animation,
      child: Container(
        margin: const EdgeInsets.all(3),
        height: 62,
        width: 62,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.letter.val.isEmpty
          ? tileBackground
          : widget.letter.backgroundColor,
          border: Border.all(
            color: widget.letter.val.isEmpty 
            ? widget.initialBorderColor 
            : widget.letter.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        // display letter values
        child: Align(
          child: Text(
            widget.letter.val,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}