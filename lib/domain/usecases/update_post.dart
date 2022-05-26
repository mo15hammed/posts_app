import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';
import 'package:posts_app/domain/usecases/base_usecase.dart';

class UpdatePost extends BaseUsecase<Unit, PostEntity> {
  final PostsRepository _repository;

  const UpdatePost(this._repository);

  @override
  Future<Either<Failure, Unit>> call({required PostEntity params}) async {
    return await _repository.updatePost(params);
  }
}
