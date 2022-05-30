import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/usecases/get_posts_usecase.dart';
import 'package:posts_app/presentation/blocs/posts/posts_bloc.dart';

import 'posts_bloc_test.mocks.dart';

@GenerateMocks([GetAllPostsUsecase])
void main() {
  late final GetAllPostsUsecase getAllPostsUsecase;
  late final PostsBloc postsBloc;

  setUpAll(() {
    getAllPostsUsecase = MockGetAllPostsUsecase();
    postsBloc = PostsBloc(getAllPostsUsecase);
  });

  test(
    'PostsBloc should emit PostsLoadingState then PostsLoadedState '
    'with a list of PostEntity when adding GetAllPostsEvent',
    () {
      // arrange
      final posts = List.generate(
        5,
        (index) => PostEntity(
          id: index,
          title: 'Title $index',
          body: 'Body $index',
        ),
      );

      when(getAllPostsUsecase(params: unit)).thenAnswer((_) {
        return Future.value(Right(posts));
      });

      // assert
      final expectedStates = [
        PostsLoadingState(),
        PostsLoadedState(posts),
      ];

      expectLater(postsBloc.stream, emitsInOrder(expectedStates));

      // act
      postsBloc.add(GetAllPostsEvent());
    },
  );

  test(
    'PostsBloc should emit PostsLoadingState then PostsErrorState '
    'with a failure when adding GetAllPostsEvent and something goes wrong',
    () {
      // arrange
      final failure = Failure(FailureType.api, FailureType.api.message);

      when(getAllPostsUsecase(params: unit)).thenAnswer((_) {
        return Future.value(Left(failure));
      });

      // assert
      final expectedStates = [
        PostsLoadingState(),
        PostsErrorState(failure),
      ];

      expectLater(postsBloc.stream, emitsInOrder(expectedStates));

      // act
      postsBloc.add(GetAllPostsEvent());
    },
  );
}
