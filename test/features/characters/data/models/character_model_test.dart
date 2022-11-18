import 'package:flutter_films/core/extensions/character_model_ext.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/data/models/properties_model.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  late CharacterModel characterModel;

  setUp(
    () {
      characterModel = CharacterModel(
          properties: PropertiesModel(
              height: "172",
              mass: "77",
              hairColor: "blond",
              skinColor: "fair",
              eyeColor: "blue",
              birthYear: "19BBY",
              gender: "male",
              created: DateTime.parse("2022-11-17T17:04:18.963Z"),
              edited: DateTime.parse("2022-11-17T17:04:18.963Z"),
              name: "Luke Skywalker",
              homeworld: "https://www.swapi.tech/api/planets/1",
              url: "https://www.swapi.tech/api/people/1"),
          uid: "1");
    },
  );

  group(
    'Model mapping',
    () {
      test(
        'Should successfully convert to a Character entity',
        () {
          final character = characterModel.toCharacter;
          expect(character, isA<Character>());
          expect(character.uid, characterModel.uid);
          expect(character.properties.birthYear,
              characterModel.properties.birthYear);
          expect(
              character.properties.created, characterModel.properties.created);
          expect(character.properties.edited, characterModel.properties.edited);
          expect(character.properties.eyeColor,
              characterModel.properties.eyeColor);
          expect(character.properties.hairColor,
              characterModel.properties.hairColor);
          expect(character.properties.height, characterModel.properties.height);
          expect(character.properties.homeworld,
              characterModel.properties.homeworld);
          expect(character.properties.mass, characterModel.properties.mass);
          expect(character.properties.name, characterModel.properties.name);
          expect(character.properties.skinColor,
              characterModel.properties.skinColor);
          expect(character.properties.url, characterModel.properties.url);
        },
      );
      test(
        'Model should successfully deserialize from JSON',
        () {
          final characterModelFromJson = getMockCharacter();
          expect(characterModel, isA<CharacterModel>());
          expect(characterModel, equals(characterModelFromJson));
        },
      );
    },
  );
}
