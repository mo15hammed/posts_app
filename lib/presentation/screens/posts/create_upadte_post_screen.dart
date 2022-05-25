import 'package:flutter/material.dart';
import 'package:posts_app/domain/entities/post_entity.dart';

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
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
      ),
      body: Container(),
    );
  }
}
