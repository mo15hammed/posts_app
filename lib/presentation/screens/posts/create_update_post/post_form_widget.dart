import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/constants/sizes.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/presentation/blocs/post_actions/post_actions_bloc.dart';
import 'package:posts_app/presentation/widgets/input_field_widget.dart';

class PostFormWidget extends StatefulWidget {
  final PostEntity? post;
  final bool isUpdatePost;

  const PostFormWidget({
    super.key,
    this.post,
    this.isUpdatePost = false,
  });

  @override
  State<PostFormWidget> createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends State<PostFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdatePost) {
      _titleCtrl.text = widget.post!.title;
      _bodyCtrl.text = widget.post!.body;
    }
  }

  void validateFormThenSubmit() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (isFormValid) {
      final post = PostEntity(
        id: widget.post?.id,
        title: _titleCtrl.text,
        body: _bodyCtrl.text,
      );

      if (widget.isUpdatePost) {
        context.read<PostActionsBloc>().add(UpdatePostEvent(post));
      } else {
        context.read<PostActionsBloc>().add(CreatePostEvent(post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            InputFieldWidget(
              controller: _titleCtrl,
              hint: Strings.title,
              validator: (value) {
                return (value?.isEmpty ?? true)
                    ? Strings.emptyTitleValidation
                    : null;
              },
            ),
            const SizedBox(height: Sizes.s16),
            InputFieldWidget(
              controller: _bodyCtrl,
              hint: Strings.body,
              isMultiLines: true,
              validator: (value) {
                return (value?.isEmpty ?? true)
                    ? Strings.emptyBodyValidation
                    : null;
              },
            ),
            const SizedBox(height: Sizes.s16),
            ElevatedButton.icon(
              icon: Icon(widget.isUpdatePost ? Icons.edit : Icons.add),
              onPressed: validateFormThenSubmit,
              label: Text(
                widget.isUpdatePost ? Strings.updatePost : Strings.createPost,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
