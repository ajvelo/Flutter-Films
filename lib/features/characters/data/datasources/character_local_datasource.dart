import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

import 'character_hive_helper.dart';

abstract class CharacterLocalDataSource {
  Future<List<CharacterModel>> getCharacters();
  saveCharacters(
      {required List<CharacterModel> characterModels,
      required CharacterParams params});
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final CharacterHiveHelper characterHiveHelper;

  CharacterLocalDataSourceImpl({required this.characterHiveHelper});
  @override
  Future<List<CharacterModel>> getCharacters() async {
    final characterModels = await characterHiveHelper.getCharacters();
    if (characterModels.isEmpty) {
      throw CacheException(message: 'No characters found');
    } else {
      return characterModels;
    }
  }

  @override
  saveCharacters(
      {required List<CharacterModel> characterModels,
      required CharacterParams params}) {
    characterHiveHelper.saveCharacters(
        characterModels: characterModels, params: params);
  }
}
