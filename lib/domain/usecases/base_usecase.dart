import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';

abstract class BaseUsecase<Output, InputParams> {
  const BaseUsecase();

  Future<Either<Failure, Output>> call({required InputParams params});
}
