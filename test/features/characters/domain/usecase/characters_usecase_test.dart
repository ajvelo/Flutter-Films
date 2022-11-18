import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_films/core/extensions/character_model_ext.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/features/characters/domain/repository/character_repository.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late CharacterUsecase characterUsecase;
  late CharacterParams characterParams;
  late MockCharacterRepository mockCharacterRepository;
  late List<Character> characters;
  late ServerFailure serverFailure;

  setUp(
    () {
      mockCharacterRepository = MockCharacterRepository();
      characterParams = CharacterParams(path: ["/test"], uid: "1");
      characterUsecase = CharacterUsecase(repository: mockCharacterRepository);
      characters = [getMockCharacter().toCharacter];
      serverFailure = ServerFailure(message: 'Error');
    },
  );

  group(
    'GET Characters',
    () {
      test(
        'Should return characters if successful',
        () async {
          // Arrange
          when(() => mockCharacterRepository.getCharacters(
                  params: characterParams))
              .thenAnswer((invocation) async => Right(characters));
          // Act
          final result =
              await characterUsecase.getCharacters(params: characterParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          expect(result.isRight(), true);
          expect(result, Right(characters));
          expect(resultFolded, characters);
          verify(
            () =>
                mockCharacterRepository.getCharacters(params: characterParams),
          ).called(1);
          verifyNoMoreInteractions(mockCharacterRepository);
        },
      );

      test(
        'Should return failure if unsuccessful',
        () async {
          // Arrange

          when(() => mockCharacterRepository.getCharacters(
                  params: characterParams))
              .thenAnswer((invocation) async => Left(serverFailure));
          // Act
          final result =
              await characterUsecase.getCharacters(params: characterParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          expect(result.isLeft(), true);
          expect(result, Left(serverFailure));
          expect(resultFolded, serverFailure);
          verify(
            () =>
                mockCharacterRepository.getCharacters(params: characterParams),
          ).called(1);
          verifyNoMoreInteractions(mockCharacterRepository);
        },
      );
    },
  );
}
