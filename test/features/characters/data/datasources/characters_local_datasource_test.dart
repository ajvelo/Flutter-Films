import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/features/characters/data/datasources/character_hive_helper.dart';
import 'package:flutter_films/features/characters/data/datasources/character_local_datasource.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockCharacterHiveHelper extends Mock implements CharacterHiveHelper {}

void main() {
  late CharacterLocalDataSource characterLocalDataSource;
  late CharacterParams params;
  late CharacterModel characterModel;
  late List<CharacterModel> characterModels;
  late MockCharacterHiveHelper mockCharacterHiveHelper;

  setUp(
    () {
      mockCharacterHiveHelper = MockCharacterHiveHelper();
      characterLocalDataSource = CharacterLocalDataSourceImpl(
          characterHiveHelper: mockCharacterHiveHelper);
      characterModel = getMockCharacter();
      characterModels = [characterModel];
      params = CharacterParams(path: ["/test"], uid: "1");
    },
  );

  group('GET Characters', () {
    test('Should return a list of characters when there is data in cache',
        () async {
      // Arrange
      when(() => mockCharacterHiveHelper.getCharacters(params: params))
          .thenAnswer((invocation) => Future.value(characterModels));
      // Act
      final result =
          await characterLocalDataSource.getCharacters(params: params);
      // Assert
      expect(result, characterModels);
      verify(() => mockCharacterHiveHelper.getCharacters(params: params))
          .called(1);
      verifyNoMoreInteractions(mockCharacterHiveHelper);
    });

    test('Should throw CacheException when there is no data in cache',
        () async {
      // Arrange
      when(() => mockCharacterHiveHelper.getCharacters(params: params))
          .thenAnswer((invocation) => Future.value(List.empty()));
      // Act
      // Assert
      expect(
          () async => characterLocalDataSource.getCharacters(params: params),
          throwsA(predicate((f) =>
              f is CacheException && f.message == "No characters found")));
      verify(() => mockCharacterHiveHelper.getCharacters(params: params))
          .called(1);
      verifyNoMoreInteractions(mockCharacterHiveHelper);
    });

    test('Should call hive helper to save characters', () async {
      // Arrange
      when(() => mockCharacterHiveHelper.saveCharacters(
          characterModels: characterModels,
          params: params)).thenAnswer((invocation) => Future.value());
      // Act
      await characterLocalDataSource.saveCharacters(
          characterModels: characterModels, params: params);
      // Assert
      verify(() => mockCharacterHiveHelper.saveCharacters(
          characterModels: characterModels, params: params)).called(1);
      verifyNoMoreInteractions(mockCharacterHiveHelper);
    });
  });
}
