import 'package:flutter/material.dart';
import 'package:posts_app/core/constants/sizes.dart';
import 'package:posts_app/domain/entities/post_entity.dart';

class PostsListWidget extends StatelessWidget {
  final List<PostEntity> posts;
  const PostsListWidget({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Sizes.s16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          leading: Text(
            '${post.id}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          title: Text(
            post.title,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            post.body,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
