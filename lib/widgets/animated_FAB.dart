
import 'package:flutter/material.dart';

import '../screens/calculate_pace.dart';

class FloatingActionAnimation extends StatefulWidget {
  @override
  _FloatingActionAnimationState createState() => _FloatingActionAnimationState();
}

class _FloatingActionAnimationState extends State<FloatingActionAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation!.value),
          child: FloatingActionButton(
            backgroundColor: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xffe01312)),
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatePace()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/images/throw.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
        );
      },
    );
  }
}
