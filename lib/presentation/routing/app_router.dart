import 'package:flutter/material.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/presentation/routing/slide_page_route_builder.dart';
import 'package:posts_app/presentation/screens/posts/create_upadte_post_screen.dart';
import 'package:posts_app/presentation/screens/posts/posts_screen.dart';

class AppRouter {
  const AppRouter._();

  static const String initial = '/';
  static const String posts = initial;
  static const String createPost = '/createPost';
  static const String postDetails = '/postDetails';

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case posts:
        return SlidePageRouteBuilder(
          builder: (context) => const PostsScreen(),
          settings: settings,
        );
      case createPost:
        return SlidePageRouteBuilder(
          builder: (context) => const CreateUpdatePostScreen(),
          settings: settings,
        );
      default:
        return _undefinedRoute;
    }
  }

  static Route<dynamic> get _undefinedRoute => SlidePageRouteBuilder(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text(Strings.noRouteFound)),
          body: const Center(child: Text(Strings.noRouteFound)),
        ),
      );
}
