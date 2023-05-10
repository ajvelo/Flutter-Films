import 'package:dio/dio.dart';
import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

abstract class CharacterRemoteDatasource {
  Stream<CharacterModel> getCharacters({required CharacterParams params});
}

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final Dio dio;

  CharacterRemoteDatasourceImpl({required this.dio});

  @override
  Stream<CharacterModel> getCharacters(
      {required CharacterParams params}) async* {
    for (var url in params.path) {
      try {
        final response = await dio.get(url);
        switch (response.statusCode) {
          case 200:
            final result = (response.data["result"]);
            final CharacterModel character = CharacterModel.fromJson(result);
            yield character;
            break;
        }
      } catch (e) {
        throw ServerException(message: 'Server Error');
      }
    }
  }
}
