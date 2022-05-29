import 'package:flutter/material.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/presentation/routing/app_router.dart';

class UpdatePostButtonWidget extends StatelessWidget {
  final PostEntity post;

  const UpdatePostButtonWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.edit),
      label: const Text(Strings.update),
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppRouter.createUpdatePost,
          arguments: {'post': post, 'isUpdatePost': true},
        );
      },
    );
  }
}
