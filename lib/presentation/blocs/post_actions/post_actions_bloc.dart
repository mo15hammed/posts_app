import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/usecases/create_post_usecase.dart';
import 'package:posts_app/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app/domain/usecases/update_post_usecase.dart';

part 'post_actions_event.dart';
part 'post_actions_state.dart';

class PostActionsBloc extends Bloc<PostActionsEvent, PostActionsState> {
  final CreatePostUsecase createPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;

  PostActionsBloc({
    required this.createPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(PostActionsInitial()) {
    on<CreatePostEvent>(_handleCreatePostEvent);
    on<UpdatePostEvent>(_handleUpdatePostEvent);
    on<DeletePostEvent>(_handleDeletePostEvent);
  }

  void _handleCreatePostEvent(
    CreatePostEvent event,
    Emitter<PostActionsState> emit,
  ) async {
    emit(PostActionsLoadingState());

    final either = await createPost.call(params: event.post);

    emit(getFailureOrSuccessState(either, Strings.postsCreatedSuccessfully));
  }

  void _handleUpdatePostEvent(
    UpdatePostEvent event,
    Emitter<PostActionsState> emit,
  ) async {
    emit(PostActionsLoadingState());

    final either = await updatePost.call(params: event.post);

    emit(getFailureOrSuccessState(either, Strings.postsUpdatedSuccessfully));
  }

  void _handleDeletePostEvent(
    DeletePostEvent event,
    Emitter<PostActionsState> emit,
  ) async {
    emit(PostActionsLoadingState());

    final either = await deletePost.call(params: event.postId);

    emit(getFailureOrSuccessState(either, Strings.postsDeletedSuccessfully));
  }

  PostActionsState getFailureOrSuccessState(
    Either<Failure, Unit> either,
    String successMessage,
  ) {
    return either.fold(
      (failure) => PostActionsFailureState(failure),
      (unit) => PostActionsSuccessState(successMessage),
    );
  }
}
