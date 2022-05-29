import 'package:flutter/material.dart';
import 'package:posts_app/core/constants/sizes.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/presentation/screens/posts/post_details/delete_post_button_widget.dart';
import 'package:posts_app/presentation/screens/posts/post_details/update_post_button_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostEntity post;

  const PostDetailsScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            Text(
              post.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: Sizes.s48),
            Text(
              post.body,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Divider(height: Sizes.s48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UpdatePostButtonWidget(post: post),
                DeletePostButtonWidget(postId: post.id!),
              ],
            )
          ],
        ),
      ),
    );
  }
}
