part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoadingState extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsRefreshingState extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoadedState extends PostsState {
  final List<PostEntity> posts;

  const PostsLoadedState(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostsErrorState extends PostsState {
  final Failure failure;

  const PostsErrorState(this.failure);

  @override
  List<Object?> get props => [failure];
}
