import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/presentation/blocs/posts/posts_bloc.dart';
import 'package:posts_app/presentation/routing/app_router.dart';
import 'package:posts_app/presentation/screens/posts/posts_list_widget.dart';
import 'package:posts_app/presentation/widgets/app_error_widget.dart';
import 'package:posts_app/presentation/widgets/loading_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  _onRefresh(BuildContext context) {
    final postsBloc = context.read<PostsBloc>()..add(RefreshPostsEvent());
    return postsBloc.stream.firstWhere((e) => e is! PostsRefreshingState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        buildWhen: (prevState, currentState) =>
            currentState is! PostsRefreshingState,
        builder: (context, state) {
          if (state is PostsErrorState) {
            return AppErrorWidget(
              failure: state.failure,
            );
          } else if (state is PostsLoadedState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostsListWidget(
                posts: state.posts,
              ),
            );
          }
          return const LoadingWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRouter.createUpdatePost,
          );
        },
      ),
    );
  }
}
