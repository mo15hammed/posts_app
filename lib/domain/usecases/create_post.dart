import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';

import '../entities/post_entity.dart';

class CreatePost {
  final PostsRepository _repository;

  const CreatePost(this._repository);

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await _repository.createPost(post);
  }
}
