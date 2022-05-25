import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/data/data_sources/posts_local_data_source.dart';
import 'package:posts_app/data/data_sources/posts_remote_data_source.dart';
import 'package:posts_app/data/models/post_model.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        await localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException catch (e) {
        return Left(Failure(FailureType.api, e.message));
      } on ConnectionException catch (e) {
        return Left(Failure(FailureType.network, e.message));
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(Failure(
          FailureType.emptyCache,
          FailureType.emptyCache.message,
        ));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createPost(PostEntity post) async {
    final postModel = PostModel.fromEntity(post);

    return await _catchExceptions(() {
      return remoteDataSource.createPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    final postModel = PostModel.fromEntity(post);

    return await _catchExceptions(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _catchExceptions(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  Future<Either<Failure, Unit>> _catchExceptions(Future Function() func) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        await func();
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(Failure(FailureType.api, e.message));
      } on ConnectionException catch (e) {
        return Left(Failure(FailureType.network, e.message));
      }
    } else {
      return Left(Failure(FailureType.network, FailureType.network.message));
    }
  }
}
