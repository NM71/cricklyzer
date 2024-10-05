//
// import 'package:flutter/material.dart';
//
// import '../screens/calculate_pace.dart';
//
// class FloatingActionAnimation extends StatefulWidget {
//   @override
//   _FloatingActionAnimationState createState() => _FloatingActionAnimationState();
// }
//
// class _FloatingActionAnimationState extends State<FloatingActionAnimation>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//   Animation<double>? _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     )..repeat(reverse: true);
//
//     _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(
//       parent: _controller!,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation!,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, -_animation!.value),
//           child: FloatingActionButton(
//             backgroundColor: Color(0xffffffff),
//             shape: RoundedRectangleBorder(
//               side: BorderSide(color: Color(0xff000000)),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CalculatePace()),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Image.asset(
//                 'assets/images/Cricklyzer-logo-2-outlined.png',
//                 height: 50,
//                 width: 50,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }









import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../screens/calculate_pace.dart';

class FloatingActionAnimation extends StatefulWidget {
  @override
  _FloatingActionAnimationState createState() => _FloatingActionAnimationState();
}

class _FloatingActionAnimationState extends State<FloatingActionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: Color(0xffcf2e2e),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FloatingActionButton(
            backgroundColor: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xff000000)),
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatePace()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Image.asset(
                  'assets/images/Cricklyzer-logo-2-black.png',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}