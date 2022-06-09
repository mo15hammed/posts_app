import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/presentation/blocs/post_actions/post_actions_bloc.dart';
import 'package:posts_app/presentation/screens/posts/create_update_post/post_form_widget.dart';
import 'package:posts_app/presentation/utils/snackbar_manager.dart';
import 'package:posts_app/presentation/widgets/loading_widget.dart';

class CreateUpdatePostScreen extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;

  const CreateUpdatePostScreen({
    super.key,
    this.post,
    this.isUpdatePost = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? Strings.updatePost : Strings.createPost),
      ),
      body: BlocConsumer<PostActionsBloc, PostActionsState>(
        listener: (context, state) {
          if (state is PostActionsSuccessState) {
            SnackBarManager.showSuccessSnackBar(context, state.message);
            Navigator.pop(context);
          } else if (state is PostActionsFailureState) {
            SnackBarManager.showFailureSnackBar(context, state.failure.message);
          }
        },
        builder: (context, state) {
          if (state is PostActionsLoadingState) return const LoadingWidget();

          return PostFormWidget(
            post: post,
            isUpdatePost: isUpdatePost,
          );
        },
      ),
    );
  }
}
