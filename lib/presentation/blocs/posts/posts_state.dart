part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsRefreshingState extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<PostEntity> posts;

  const PostsLoadedState(this.posts);

  @override
  List<Object> get props => [posts];

  @override
  bool get stringify => false;
}

class PostsErrorState extends PostsState {
  final Failure failure;

  const PostsErrorState(this.failure);

  @override
  List<Object?> get props => [failure];
}
