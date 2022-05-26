import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';
import 'package:posts_app/domain/usecases/base_usecase.dart';

class DeletePostUsecase extends BaseUsecase<int, Unit> {
  final PostsRepository _repository;

  const DeletePostUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call({required int params}) async {
    return await _repository.deletePost(params);
  }
}
