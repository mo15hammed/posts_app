import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/presentation/blocs/post_actions/post_actions_bloc.dart';
import 'package:posts_app/presentation/routing/app_router.dart';
import 'package:posts_app/presentation/screens/posts/post_details/delete_dialog_widget.dart';
import 'package:posts_app/presentation/utils/snackbar_manager.dart';
import 'package:posts_app/presentation/widgets/loading_widget.dart';

class DeletePostButtonWidget extends StatelessWidget {
  final int postId;

  const DeletePostButtonWidget({
    super.key,
    required this.postId,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocConsumer<PostActionsBloc, PostActionsState>(
          listener: (context, state) {
            if (state is PostActionsSuccessState) {
              SnackBarManager.showSuccessSnackBar(context, state.message);
              Navigator.popUntil(
                context,
                ModalRoute.withName(AppRouter.posts),
              );
            } else if (state is PostActionsFailureState) {
              Navigator.pop(context);

              SnackBarManager.showFailureSnackBar(
                context,
                state.failure.message,
              );
            }
          },
          builder: (context, state) {
            if (state is PostActionsLoadingState) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: const AlertDialog(
                  title: LoadingWidget(),
                ),
              );
            }

            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.delete),
      label: const Text(Strings.delete),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      onPressed: () {
        _showDeleteDialog(context);
      },
    );
  }
}
