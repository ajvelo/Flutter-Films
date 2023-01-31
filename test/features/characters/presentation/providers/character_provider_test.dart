import 'package:dartz/dartz.dart';
import 'package:flutter_films/core/extensions/character_model_ext.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:flutter_films/features/characters/data/models/character_model.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_films/features/characters/presentation/providers/character_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockCharacterUsecase extends Mock implements CharacterUsecase {}

class MockCharacterParams extends Mock implements CharacterParams {}

void main() {
  late NotifierProvider<CharacterNotifier, GetCharactersState>
      characterNotifier;
  late MockCharacterUsecase mockCharacterUsecase;
  late MockCharacterParams mockCharacterParams;
  late ProviderContainer providerContainer;
  late List<CharacterModel> characterModels;
  late List<Character> characters;
  late List<GetCharactersState> successOrderOfStates;
  late List<GetCharactersState> errorOrderOfStates;

  setUp(
    () {
      mockCharacterUsecase = MockCharacterUsecase();
      mockCharacterParams = MockCharacterParams();
      providerContainer = ProviderContainer();
      characterModels = [getMockCharacter()];
      characters = characterModels
          .map((characterModel) => characterModel.toCharacter)
          .toList();
      successOrderOfStates = [
        GetCharactersInitial(),
        GetCharactersLoading(),
        GetCharactersSuccess(characters: characters)
      ];
      errorOrderOfStates = [
        GetCharactersInitial(),
        GetCharactersLoading(),
        GetCharactersError(errorMessage: 'Error')
      ];
      characterNotifier =
          NotifierProvider<CharacterNotifier, GetCharactersState>(
        () {
          return CharacterNotifier(usecase: mockCharacterUsecase);
        },
      );
    },
  );

  group(
    'GET Character',
    () {
      test(
        'Initial state should be GetCharactersInitial',
        () {
          // Arrange
          final state = providerContainer.read(characterNotifier);
          // Act
          // Assert
          expect(state, equals(GetCharactersInitial()));
        },
      );

      test(
        'Provider should call character usecase',
        () async {
          // Arrange
          when(
            () =>
                mockCharacterUsecase.getCharacters(params: mockCharacterParams),
          ).thenAnswer((invocation) async => Right(characters));
          // Act
          providerContainer
              .read(characterNotifier.notifier)
              .getCharacters(params: mockCharacterParams);
          await untilCalled(
            () =>
                mockCharacterUsecase.getCharacters(params: mockCharacterParams),
          );
          // Assert
          verify(
            () =>
                mockCharacterUsecase.getCharacters(params: mockCharacterParams),
          );
          verifyNoMoreInteractions(mockCharacterUsecase);
        },
      );

      test(
        'Provider emits correct order of states when get character usecase called with success',
        () async {
          // Arrange
          final state = providerContainer.read(characterNotifier);
          var orderOfStates = [state];
          providerContainer.listen(characterNotifier, (previous, next) {
            orderOfStates.add(next);
          });
          when(
            () =>
                mockCharacterUsecase.getCharacters(params: mockCharacterParams),
          ).thenAnswer((invocation) async => Right(characters));

          // Act
          providerContainer
              .read(characterNotifier.notifier)
              .getCharacters(params: mockCharacterParams);
          await untilCalled(
            () =>
                mockCharacterUsecase.getCharacters(params: mockCharacterParams),
          );

          // Assert
          expect(orderOfStates, successOrderOfStates);
        },
      );

      test(
        'Provider emits correct order of states when get character usecase called with error',
        () async {
          // Arrange
          final state = providerContainer.read(characterNotifier);
          var orderOfStates = [state];
          providerContainer.listen(characterNotifier, (previous, next) {
            orderOfStates.add(next);
          });
          when(
            () =>
                mockCharacterUsecase.getCharacters(params: mockCharacterParams),
          ).thenAnswer(
              (invocation) async => Left(ServerFailure(message: 'Error')));

          // Act
          providerContainer
              .read(characterNotifier.notifier)
              .getCharacters(params: mockCharacterParams);
          await untilCalled(
            () =>
                mockCharacterUsecase.getCharacters(params: mockCharacterParams),
          );

          // Assert
          expect(orderOfStates, errorOrderOfStates);
        },
      );
    },
  );
}
