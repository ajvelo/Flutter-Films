import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';

extension PropertyModelExtension on PropertiesModel {
  Properties get toProperties => Properties(
      height: height,
      mass: mass,
      hairColor: hairColor,
      skinColor: skinColor,
      eyeColor: eyeColor,
      birthYear: birthYear,
      gender: gender,
      created: created,
      edited: edited,
      name: name,
      homeworld: homeworld,
      url: url);
}

extension CharacterModelExtension on CharacterModel {
  Character get toCharacter =>
      Character(properties: properties.toProperties, uid: uid);
}
