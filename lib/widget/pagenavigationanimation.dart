// import 'package:flutter/material.dart';
//
// class ZoomPageRoute extends PageRouteBuilder {
//   final Widget page;
//
//   ZoomPageRoute({required this.page})
//       : super(
//     transitionDuration: const Duration(milliseconds: 350),
//     reverseTransitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder:
//         (context, animation, secondaryAnimation, child) {
//       final curvedAnimation = CurvedAnimation(
//         parent: animation,
//         curve: Curves.easeOutExpo,
//         reverseCurve: Curves.easeInExpo,
//       );
//
//       return ScaleTransition(
//         scale: Tween<double>(
//           begin: 0.80, // zoom start
//           end: 1.0,  // zoom end
//         ).animate(curvedAnimation),
//         child: FadeTransition(
//           opacity: animation,
//           child: child,
//         ),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  SlidePageRoute({required this.page}) : super(
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {

      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeIn,
      );

      final tween = Tween<Offset>(
        begin: const Offset(0.8, 0.0),
        end: Offset.zero,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

