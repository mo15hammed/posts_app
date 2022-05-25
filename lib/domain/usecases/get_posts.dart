import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';


class GetAllPosts {

  final PostsRepository _repository;

  const GetAllPosts(this._repository);

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await _repository.getPosts();
  }
}