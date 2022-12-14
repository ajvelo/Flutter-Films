import 'package:flutter_films/features/characters/data/datasources/character_local_datasource.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

import 'package:hive_flutter/hive_flutter.dart';

class CharacterHiveHelper implements CharacterLocalDataSource {
  Future<Box<CharacterModel>> _getBox({required CharacterParams params}) async {
    Box<CharacterModel> box;
    box = await Hive.openBox<CharacterModel>('people${params.uid}');
    return box;
  }

  @override
  Future<List<CharacterModel>> getCharacters(
      {required CharacterParams params}) async {
    final box = await _getBox(params: params);
    final characters = box.values.toList();
    return characters;
  }

  @override
  saveCharacters(
      {required List<CharacterModel> characterModels,
      required CharacterParams params}) async {
    final box = await _getBox(params: params);
    await box.clear();
    for (var characterModel in characterModels) {
      box.put(characterModel.uid, characterModel);
    }
  }
}
