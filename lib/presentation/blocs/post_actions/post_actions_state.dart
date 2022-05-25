part of 'post_actions_bloc.dart';

abstract class PostActionsState extends Equatable {
  const PostActionsState();
}

class PostActionsInitial extends PostActionsState {
  @override
  List<Object> get props => [];
}

class PostActionsLoadingState extends PostActionsState {
  @override
  List<Object> get props => [];
}

class PostActionsSuccessState extends PostActionsState {
  final String message;

  const PostActionsSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

class PostActionsFailureState extends PostActionsState {
  final Failure failure;

  const PostActionsFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
