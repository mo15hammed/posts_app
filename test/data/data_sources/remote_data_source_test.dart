import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_app/core/constants/api_constants.dart';
import 'package:posts_app/data/core/dio_helper.dart';
import 'package:posts_app/data/data_sources/remote_data_source.dart';
import 'package:posts_app/data/models/post_model.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([DioHelper])
void main() {
  late final RemoteDataSource remoteDataSource;
  late final DioHelper dioHelper;

  setUpAll(() {
    dioHelper = MockDioHelper();
    remoteDataSource = RemoteDataSourceImpl(dioHelper);
  });

  test('getPosts should return posts without any exception', () async {
    // arrange
    final posts = List.generate(
      5,
      (index) => PostModel(
        id: index,
        title: 'Title $index',
        body: 'Body $index',
      ),
    );

    final postsMap = posts.map((post) => post.toJson()).toList();
    when(
      dioHelper.request(
        endpoint: ApiConstants.posts,
        method: Method.get,
      ),
    ).thenAnswer(
      (_) {
        return Future.value(
          Response(
            data: postsMap,
            requestOptions: RequestOptions(path: ApiConstants.posts),
          ).data,
        );
      },
    );

    // act
    final result = await remoteDataSource.getPosts();

    // assert
    expect(result, posts);
  });

  test(
    'getPosts should throw a DioError if the status code is not 200',
    () async {
      // arrange
      final expectedException = DioError(
        requestOptions: RequestOptions(path: ApiConstants.posts),
      );

      final expectedResult = throwsA(expectedException);

      when(
        dioHelper.request(
          endpoint: ApiConstants.posts,
          method: Method.get,
        ),
      ).thenThrow(expectedException);

      // act
      result() async => await remoteDataSource.getPosts();

      // assert

      expect(result, expectedResult);
    },
  );
}
