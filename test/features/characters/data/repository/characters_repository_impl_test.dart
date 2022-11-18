import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/core/extensions/character_model_ext.dart';
import 'package:flutter_films/features/characters/data/datasources/character_local_datasource.dart';
import 'package:flutter_films/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/data/repository/character_repository_impl.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/features/characters/domain/repository/character_repository.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockCharacterRemoteDataSource extends Mock
    implements CharacterRemoteDatasource {}

class MockCharacterLocalDataSource extends Mock
    implements CharacterLocalDataSource {}

void main() {
  late MockCharacterLocalDataSource mockCharacterLocalDataSource;
  late MockCharacterRemoteDataSource mockCharacterRemoteDataSource;
  late CharacterRepository characterRepository;
  late CharacterParams characterParams;
  late List<CharacterModel> characterModels;
  late List<Character> characters;

  setUp(
    () {
      characterParams = CharacterParams(path: ["/test"], uid: "1");
      characterModels = [getMockCharacter()];
      characters = characterModels
          .map((characterModel) => characterModel.toCharacter)
          .toList();
      mockCharacterLocalDataSource = MockCharacterLocalDataSource();
      mockCharacterRemoteDataSource = MockCharacterRemoteDataSource();
      characterRepository = CharacterRepositoryImpl(
          remoteDataSource: mockCharacterRemoteDataSource,
          localDataSource: mockCharacterLocalDataSource);
    },
  );

  group(
    'GET Character',
    () {
      test(
        'Repository returns characters when characters found in cache',
        () async {
          // Arrange
          when((() => mockCharacterLocalDataSource.getCharacters(
                  params: characterParams)))
              .thenAnswer((invocation) async => characterModels);
          // Act
          final result =
              await characterRepository.getCharacters(params: characterParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          verify(
            () => mockCharacterLocalDataSource.getCharacters(
                params: characterParams),
          ).called(1);
          expect(result.isRight(), true);
          expect(resultFolded, characters);
          expect(resultFolded, equals(characters));
        },
      );

      test(
        'Repository returns characters when call to remote data is successful and saves to cache',
        () async {
          // Arrange
          when((() => mockCharacterLocalDataSource.getCharacters(
                  params: characterParams)))
              .thenThrow(CacheException(message: 'Error'));
          when((() => mockCharacterRemoteDataSource.getCharacters(
                  params: characterParams)))
              .thenAnswer((invocation) async => characterModels);
          // Act
          final result =
              await characterRepository.getCharacters(params: characterParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          verify(
            () => mockCharacterLocalDataSource.getCharacters(
                params: characterParams),
          ).called(1);
          verify(
            () => mockCharacterLocalDataSource.saveCharacters(
                characterModels: characterModels, params: characterParams),
          ).called(1);
          verify(
            () => mockCharacterRemoteDataSource.getCharacters(
                params: characterParams),
          ).called(1);
          expect(result.isRight(), true);
          expect(resultFolded, characters);
          expect(resultFolded, equals(characters));
        },
      );
    },
  );
}
