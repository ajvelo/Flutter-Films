import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

abstract class CharacterRemoteDatasource {
  Future<List<CharacterModel>> getCharacters({required CharacterParams params});
}

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final Dio dio;

  CharacterRemoteDatasourceImpl({required this.dio});
  @override
  Future<List<CharacterModel>> getCharacters(
      {required CharacterParams params}) async {
    List<CharacterModel> characterList = [];

    params.path.forEach((url) async {
      try {
        final response = await dio.get(url);
        switch (response.statusCode) {
          case 200:
            final result = (response.data["result"]);
            final CharacterModel character = CharacterModel.fromJson(result);
            characterList.add(character);
        }
      } catch (e) {
        log(e.toString());
      }
    });

    if (characterList.isEmpty) {
      throw ServerException(message: 'Server Error');
    } else {
      return characterList;
    }
  }
}
