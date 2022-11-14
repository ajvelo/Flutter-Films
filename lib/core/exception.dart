abstract class DataException implements Exception {}

class ServerException implements DataException {
  final String message;

  ServerException({required this.message});
}

class CastException implements DataException {
  final String message;

  CastException({required this.message});
}

class CacheException implements DataException {
  final String message;

  CacheException({required this.message});
}
