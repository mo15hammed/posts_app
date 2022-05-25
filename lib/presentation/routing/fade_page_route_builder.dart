import 'package:flutter/material.dart';

class FadePageRouteBuilder extends PageRouteBuilder {
  static const _transitionDelay = 500;

  final WidgetBuilder builder;

  FadePageRouteBuilder({
    required this.builder,
    RouteSettings? settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.ease;
            const begin = 0.0;
            const end = 1.0;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: _transitionDelay),
          reverseTransitionDuration:
              const Duration(milliseconds: _transitionDelay),
          settings: settings,
        );
}
