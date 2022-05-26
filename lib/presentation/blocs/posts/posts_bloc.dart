import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/usecases/get_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;

  PostsBloc(this.getAllPosts) : super(PostsInitial()) {
    on<PostsEvent>(_handleGetAllPostsEvent);
  }

  void _handleGetAllPostsEvent(
    PostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    if (event is GetAllPostsEvent) emit(PostsLoadingState());
    if (event is RefreshPostsEvent) emit(PostsRefreshingState());

    final postsEither = await getAllPosts(params: unit);

    postsEither.fold(
      (failure) {
        emit(PostsErrorState(failure));
      },
      (posts) {
        emit(PostsLoadedState(posts));
      },
    );
  }
}
