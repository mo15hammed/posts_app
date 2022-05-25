import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';


class UpdatePost {
  final PostsRepository _repository;

  const UpdatePost(this._repository);

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await _repository.updatePost(post);
  }
}
