import 'package:equatable/equatable.dart';

abstract class DataException extends Equatable implements Exception {}

class ServerException extends DataException {
  final String message;

  ServerException({required this.message});

  @override
  List<Object?> get props => [message];
}

class CastException extends DataException {
  final String message;

  CastException({required this.message});

  @override
  List<Object?> get props => [message];
}

class CacheException extends DataException {
  final String message;

  CacheException({required this.message});

  @override
  List<Object?> get props => [message];
}
