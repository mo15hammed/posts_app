part of 'post_actions_bloc.dart';

abstract class PostActionsEvent extends Equatable {
  const PostActionsEvent();
}

class CreatePostEvent extends PostActionsEvent {
  final PostEntity post;
  const CreatePostEvent(this.post);

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends PostActionsEvent {
  final PostEntity post;
  const UpdatePostEvent(this.post);

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends PostActionsEvent {
  final int postId;

  const DeletePostEvent(this.postId);

  @override
  List<Object> get props => [postId];
}
