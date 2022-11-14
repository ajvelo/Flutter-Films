abstract class Failure {}

class ServerFailure implements Failure {
  final String message;

  ServerFailure({required this.message});
}

class CastFailure implements Failure {
  final String message;

  CastFailure({required this.message});
}

class CacheFailure implements Failure {
  final String message;

  CacheFailure({required this.message});
}
