import 'package:flutter/material.dart';

class SlidePageRouteBuilder extends PageRouteBuilder {
  static const _transitionDelay = 300;

  final WidgetBuilder builder;
  final SlideDirection slideDirection;

  SlidePageRouteBuilder({
    required this.builder,
    this.slideDirection = SlideDirection.rightToLeft,
    RouteSettings? settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeInOut;
            final begin = slideDirection.offset;
            const end = Offset.zero;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: _transitionDelay),
          reverseTransitionDuration:
              const Duration(milliseconds: _transitionDelay),
          settings: settings,
        );
}

enum SlideDirection {
  bottomToTop(offset: Offset(0.0, 1.0)),
  topToBottom(offset: Offset(0.0, -1.0)),
  rightToLeft(offset: Offset(1.0, 0.0)),
  leftToRight(offset: Offset(-1.0, 0.0));

  final Offset offset;

  const SlideDirection({required this.offset});
}
