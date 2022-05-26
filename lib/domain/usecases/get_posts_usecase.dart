import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/domain/entities/post_entity.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';
import 'package:posts_app/domain/usecases/base_usecase.dart';

class GetAllPostsUsecase extends BaseUsecase<List<PostEntity>, Unit> {
  final PostsRepository _repository;

  const GetAllPostsUsecase(this._repository);

  @override
  Future<Either<Failure, List<PostEntity>>> call({required Unit params}) async {
    return await _repository.getPosts();
  }
}
