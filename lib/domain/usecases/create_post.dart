import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';
import 'package:posts_app/domain/usecases/base_usecase.dart';

import '../entities/post_entity.dart';

class CreatePost extends BaseUsecase<Unit, PostEntity> {
  final PostsRepository _repository;

  const CreatePost(this._repository);

  @override
  Future<Either<Failure, Unit>> call({required PostEntity params}) async {
    return await _repository.createPost(params);
  }
}
