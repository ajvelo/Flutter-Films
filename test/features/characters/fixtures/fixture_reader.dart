import 'dart:convert';
import 'dart:io';

import 'package:flutter_films/features/characters/data/models/character_model.dart';

String fixtureCharacters(String name) =>
    File('test/features/characters/fixtures/$name').readAsStringSync();

CharacterModel getMockCharacter() {
  final response = json.decode(fixtureCharacters('character_model.json'));
  final result = response['result'];
  return CharacterModel.fromJson(result);
}
