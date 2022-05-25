import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:posts_app/presentation/themes/app_theme.dart';
import 'package:posts_app/dependencies/get_it.dart' as get_it;
import 'package:posts_app/presentation/blocs/post_actions/post_actions_bloc.dart';
import 'package:posts_app/presentation/blocs/posts/posts_bloc.dart';
import 'package:posts_app/presentation/routing/app_router.dart';
import 'package:posts_app/presentation/themes/custom_scroll_behavior.dart';

var logger = Logger();

void main() async {
  await Hive.initFlutter();
  get_it.setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (_) => get_it.getItInstance()..add(GetAllPostsEvent()),
        ),
        BlocProvider<PostActionsBloc>(
          create: (_) => get_it.getItInstance(),
        ),
      ],
      child: MaterialApp(
        title: 'Posts App',
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, widget) {
          return ScrollConfiguration(
            behavior: const CustomScrollBehavior(),
            child: widget!,
          );
        },
      ),
    );
  }
}
