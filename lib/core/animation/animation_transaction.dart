import 'package:flutter/cupertino.dart';

class AnimationTransitions extends PageRouteBuilder {
  final Widget? page;
  final Widget? route;

  AnimationTransitions({this.page, this.route})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page!,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => FadeTransition(opacity: animation, child: route),
      );
}

class FirstSizeTransition extends PageRouteBuilder {
  final Widget page;

  FirstSizeTransition(this.page)
    : super(
        pageBuilder: (context, animation, anotherAnimation) => page,
        transitionDuration: const Duration(milliseconds: 2000),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
            curve: Curves.fastLinearToSlowEaseIn,
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
          );
          return Align(
            alignment: Alignment.bottomCenter,
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0,
              child: page,
            ),
          );
        },
      );
}

class ScaleTransitionPage extends PageRouteBuilder {
  final Widget page;

  ScaleTransitionPage({required this.page})
    : super(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(scale: animation, child: child);
        },
      );
}
