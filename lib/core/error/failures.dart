import 'package:equatable/equatable.dart';
import 'package:posts_app/core/constants/strings.dart';

class Failure extends Equatable {
  final FailureType errorType;
  final String message;

  const Failure(
    this.errorType,
    this.message,
  );

  @override
  List<Object?> get props => [errorType, message];

  @override
  bool? get stringify => true;
}

enum FailureType {
  server(Strings.apiFailure),
  connection(Strings.noInternetConnection),
  emptyCache(Strings.noCachedData),
  unknown(Strings.unknownError);

  final String message;
  const FailureType(this.message);
}
