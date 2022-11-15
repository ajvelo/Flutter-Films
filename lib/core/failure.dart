import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CastFailure extends Failure {
  final String message;

  CastFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
