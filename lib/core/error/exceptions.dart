class ConnectionException implements Exception {
  final String message;
  const ConnectionException(this.message);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class EmptyCacheException implements Exception {
  final String message;
  const EmptyCacheException(this.message);
}
