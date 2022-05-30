import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/data/data_sources/local_data_source.dart';
import 'package:posts_app/data/data_sources/remote_data_source.dart';
import 'package:posts_app/data/models/post_model.dart';
import 'package:posts_app/data/repositories/posts_repository_impl.dart';
import 'package:posts_app/data/tables/post_table.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';

import 'posts_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalDataSource, NetworkInfo])
void main() {
  late final RemoteDataSource remoteDataSource;
  late final LocalDataSource localDataSource;
  late final NetworkInfo networkInfo;
  late final PostsRepository postsRepository;

  setUpAll(() {
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    networkInfo = MockNetworkInfo();

    postsRepository = PostsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  });

  test(
    'getPosts should return a list of PostModel without any exceptions',
    () async {
      // arrange
      when(networkInfo.isConnected).thenAnswer(
        (_) {
          return Future.value(true);
        },
      );

      final posts = List.generate(
        5,
        (index) => PostModel(
          id: index,
          title: 'Title $index',
          body: 'Body $index',
        ),
      );

      when(remoteDataSource.getPosts()).thenAnswer(
        (realInvocation) {
          return Future.value(posts);
        },
      );

      when(localDataSource.cachePosts(posts)).thenAnswer(
        (realInvocation) {
          return Future.value();
        },
      );

      // act
      final either = await postsRepository.getPosts();

      // assert
      either.fold(
        (failure) {
          fail('test failed');
        },
        (result) {
          expect(result, posts);
        },
      );
    },
  );

  test(
    'getPosts should return a list of cached PostTable when there is no internet connection',
    () async {
      // arrange
      when(networkInfo.isConnected).thenAnswer(
        (_) {
          return Future.value(false);
        },
      );

      final postTables = List.generate(
        5,
        (index) => PostTable(
          tId: index,
          tTitle: 'Title $index',
          tBody: 'Body $index',
        ),
      );

      when(localDataSource.getCachedPosts()).thenAnswer(
        (realInvocation) {
          return Future.value(postTables);
        },
      );

      // act
      final either = await postsRepository.getPosts();

      // assert
      either.fold(
        (failure) {
          fail('test failed');
        },
        (result) {
          expect(result, postTables);
        },
      );
    },
  );

  test(
    'getPosts should return a Failure of type FailureType.server remote data source throws a DioError',
    () async {
      // arrange
      final failure = Failure(
        FailureType.api,
        FailureType.api.message,
      );

      when(networkInfo.isConnected).thenAnswer(
        (_) {
          return Future.value(true);
        },
      );

      when(remoteDataSource.getPosts()).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          error: FailureType.api.message,
        ),
      );

      // act
      final either = await postsRepository.getPosts();

      // assert
      either.fold(
        (result) {
          expect(result, failure);
        },
        (_) {
          fail('test failed');
        },
      );
    },
  );
}
