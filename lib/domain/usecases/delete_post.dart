import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';

class DeletePost {

  final PostsRepository _repository;

  const DeletePost(this._repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await _repository.deletePost(postId);
  }
}