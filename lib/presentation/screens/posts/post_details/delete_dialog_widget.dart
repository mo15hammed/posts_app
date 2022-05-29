import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/presentation/blocs/post_actions/post_actions_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;

  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.areYouSure),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(Strings.no),
        ),
        TextButton(
          onPressed: () {
            context.read<PostActionsBloc>().add(DeletePostEvent(postId));
          },
          child: const Text(Strings.yes),
        ),
      ],
    );
  }
}
